/**
*  MacEditorTextView
*  Copyright (c) Thiago Holanda 2020
*  https://twitter.com/tholanda
*
*  MIT license
*/

import Combine
import SwiftUI

struct MacEditorTextView: NSViewRepresentable {
    @Binding var text: String
    @Binding var isEditable: Bool
    
    var onEditingChanged    : () -> Void           = {}
    var onCommit            : (String) -> Void    = { _ in }
    var onTextChange        : (String) -> Void   = { _ in }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> CustomTextView {
      
        let textView = CustomTextView(text: self.text, isEditable: self.isEditable, font: NSFont(name: "Helvetica", size: 18) ?? NSFont.systemFont(ofSize: 18))
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateNSView(_ view: CustomTextView, context: Context) {
        view.text = text
        view.selectedRanges = context.coordinator.selectedRanges
    }
    
    init(text: Binding<String>, isEditable: Binding<Bool> = .constant(true)) {
        self._text = text
        self._isEditable = isEditable
    }
    
    init(text: Binding<String>, isEditable: Binding<Bool> = .constant(true), onEditingChanged: (() -> Void)? = nil, onCommit: ((String) -> Void)? = nil, onTextChange: ((String) -> Void)? = nil) {
        self._text = text
        self._isEditable = isEditable
        if let changed = onEditingChanged {
            self.onEditingChanged = changed
        }
        if let commit = onCommit {
            self.onCommit = commit
        }
        if let change = onTextChange {
            self.onTextChange = change
        }
    }
}

#if DEBUG
struct MacEditorTextView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            MacEditorTextView(text: .constant("{ \n    planets { \n        name \n    }\n}"))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
            
            MacEditorTextView(text: .constant("{ \n    planets { \n        name \n    }\n}"))
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light Mode")
        }
    }
}
#endif

extension MacEditorTextView {
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: MacEditorTextView
        var selectedRanges: [NSValue] = []
        
        init(_ parent: MacEditorTextView) {
            self.parent = parent
        }
        
        func textDidBeginEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.string
            self.parent.onEditingChanged()
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.string
            self.selectedRanges = textView.selectedRanges
            self.parent.onTextChange(textView.string)
        }
        
        func textDidEndEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            
            self.parent.text = textView.string
            self.parent.onCommit(textView.string)
        }
    }
}

final class CustomTextView: NSView {
    private var isEditable: Bool
    private var font: NSFont
    
    weak var delegate: NSTextViewDelegate?
    
    var text: String {
        didSet {
            textView.string = text
        }
    }
    
    var selectedRanges: [NSValue] = [] {
        didSet {
            guard selectedRanges.count > 0 else {
                return
            }
            
            textView.selectedRanges = selectedRanges
        }
    }
    
    private lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.drawsBackground = true
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalRuler = false
        scrollView.autoresizingMask = [.width, .height]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var textView: NSTextView = {
        let contentSize = scrollView.contentSize
        let textStorage = NSTextStorage()
        
        
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        
        let textContainer = NSTextContainer(containerSize: scrollView.frame.size)
        textContainer.widthTracksTextView = true
        textContainer.containerSize = NSSize(
            width: contentSize.width,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        layoutManager.addTextContainer(textContainer)
        
        
        let textView                     = NSTextView(frame: .zero, textContainer: textContainer)
        textView.autoresizingMask        = .width
        textView.backgroundColor         = NSColor.textBackgroundColor
        textView.delegate                = self.delegate
        textView.drawsBackground         = true
        textView.font                    = self.font
        textView.isEditable              = self.isEditable
        textView.isHorizontallyResizable = false
        textView.isVerticallyResizable   = true
        textView.maxSize                 = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.minSize                 = NSSize(width: 0, height: contentSize.height)
        textView.textColor               = NSColor.labelColor
        textView.enabledTextCheckingTypes = 0
        return textView
    }()
    
    // MARK: - Init
    init(text: String, isEditable: Bool = true, font: NSFont = NSFont.systemFont(ofSize: 32, weight: .ultraLight)) {
        self.font       = font
        self.isEditable = isEditable
        self.text       = text

        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewWillDraw() {
        super.viewWillDraw()
        
        setupScrollViewConstraints()
        setupTextView()
    }
    
    func setupScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func setupTextView() {
        scrollView.documentView = textView
    }
}
