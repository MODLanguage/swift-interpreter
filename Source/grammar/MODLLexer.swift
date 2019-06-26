// Generated from MODLLexer.g4 by ANTLR 4.7.2
import Antlr4

open class MODLLexer: Lexer {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = MODLLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(MODLLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	static let WS=1, NULL=2, TRUE=3, FALSE=4, COLON=5, EQUALS=6, STRUCT_SEP=7, 
            ARR_SEP=8, LBRAC=9, RBRAC=10, LSBRAC=11, RSBRAC=12, NUMBER=13, 
            COMMENT=14, QUOTED=15, STRING=16, HASH_PREFIX=17, LCBRAC=18, 
            CWS=19, QMARK=20, FSLASH=21, GTHAN=22, LTHAN=23, ASTERISK=24, 
            AMP=25, PIPE=26, EXCLAM=27, CCOMMENT=28, RCBRAC=29

	public
	static let CONDITIONAL=1
	public
	static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public
	static let modeNames: [String] = [
		"DEFAULT_MODE", "CONDITIONAL"
	]

	public
	static let ruleNames: [String] = [
		"WS", "NULL", "TRUE", "FALSE", "COLON", "EQUALS", "STRUCT_SEP", "ARR_SEP", 
		"LBRAC", "RBRAC", "LSBRAC", "RSBRAC", "NUMBER", "INT", "EXP", "COMMENT", 
		"INSIDE_COMMENT", "QUOTED", "INSIDE_QUOTES", "INSIDE_GRAVES", "STRING", 
		"UNRESERVED", "RESERVED_CHARS", "ESCAPED", "UNICODE", "HEX", "HASH_PREFIX", 
		"LCBRAC", "CWS", "CNULL", "CTRUE", "CFALSE", "CCOLON", "CEQUALS", "CSTRUCT_SEP", 
		"CLBRAC", "CRBRAC", "CLSBRAC", "CRSBRAC", "CNUMBER", "QMARK", "FSLASH", 
		"GTHAN", "LTHAN", "ASTERISK", "AMP", "PIPE", "EXCLAM", "CLCBRAC", "CQUOTED", 
		"CSTRING", "CUNRESERVED", "CRESERVED_CHARS", "CESCAPED", "CCOMMENT", "RCBRAC"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, nil, nil, nil, nil, nil, nil, "','", nil, nil, nil, nil, nil, 
		nil, nil, nil, nil, "'{'", nil, "'?'", "'/'", "'>'", "'<'", "'*'", "'&'", 
		"'|'", "'!'", nil, "'}'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "WS", "NULL", "TRUE", "FALSE", "COLON", "EQUALS", "STRUCT_SEP", "ARR_SEP", 
		"LBRAC", "RBRAC", "LSBRAC", "RSBRAC", "NUMBER", "COMMENT", "QUOTED", "STRING", 
		"HASH_PREFIX", "LCBRAC", "CWS", "QMARK", "FSLASH", "GTHAN", "LTHAN", "ASTERISK", 
		"AMP", "PIPE", "EXCLAM", "CCOMMENT", "RCBRAC"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)


	override open
	func getVocabulary() -> Vocabulary {
		return MODLLexer.VOCABULARY
	}

	public
	required init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.7.2", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, MODLLexer._ATN, MODLLexer._decisionToDFA, MODLLexer._sharedContextCache)
	}

	override open
	func getGrammarFileName() -> String { return "MODLLexer.g4" }

	override open
	func getRuleNames() -> [String] { return MODLLexer.ruleNames }

	override open
	func getSerializedATN() -> String { return MODLLexer._serializedATN }

	override open
	func getChannelNames() -> [String] { return MODLLexer.channelNames }

	override open
	func getModeNames() -> [String] { return MODLLexer.modeNames }

	override open
	func getATN() -> ATN { return MODLLexer._ATN }


	public
	static let _serializedATN: String = MODLLexerATN().jsonString

	public
	static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}