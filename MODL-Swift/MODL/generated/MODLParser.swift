// Generated from MODLParser.g4 by ANTLR 4.7.2
import Antlr4

open class MODLParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = MODLParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(MODLParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	enum Tokens: Int {
		case EOF = -1, WS = 1, NULL = 2, TRUE = 3, FALSE = 4, NEWLINE = 5, COLON = 6, 
                 EQUALS = 7, SC = 8, LBRAC = 9, RBRAC = 10, LSBRAC = 11, 
                 RSBRAC = 12, NUMBER = 13, COMMENT = 14, STRING = 15, HASH_PREFIX = 16, 
                 QUOTED = 17, GRAVED = 18, LCBRAC = 19, CWS = 20, QMARK = 21, 
                 FSLASH = 22, GTHAN = 23, LTHAN = 24, ASTERISK = 25, AMP = 26, 
                 PIPE = 27, EXCLAM = 28, CCOMMENT = 29, RCBRAC = 30
	}

	public
	static let RULE_modl = 0, RULE_modl_structure = 1, RULE_modl_map = 2, RULE_modl_array = 3, 
            RULE_modl_nb_array = 4, RULE_modl_pair = 5, RULE_modl_value_item = 6, 
            RULE_modl_top_level_conditional = 7, RULE_modl_top_level_conditional_return = 8, 
            RULE_modl_map_conditional = 9, RULE_modl_map_conditional_return = 10, 
            RULE_modl_map_item = 11, RULE_modl_array_conditional = 12, RULE_modl_array_conditional_return = 13, 
            RULE_modl_array_item = 14, RULE_modl_value_conditional = 15, 
            RULE_modl_value_conditional_return = 16, RULE_modl_condition_test = 17, 
            RULE_modl_operator = 18, RULE_modl_condition = 19, RULE_modl_condition_group = 20, 
            RULE_modl_value = 21, RULE_modl_array_value_item = 22

	public
	static let ruleNames: [String] = [
		"modl", "modl_structure", "modl_map", "modl_array", "modl_nb_array", "modl_pair", 
		"modl_value_item", "modl_top_level_conditional", "modl_top_level_conditional_return", 
		"modl_map_conditional", "modl_map_conditional_return", "modl_map_item", 
		"modl_array_conditional", "modl_array_conditional_return", "modl_array_item", 
		"modl_value_conditional", "modl_value_conditional_return", "modl_condition_test", 
		"modl_operator", "modl_condition", "modl_condition_group", "modl_value", 
		"modl_array_value_item"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 
		nil, nil, nil, nil, nil, "'{'", nil, "'?'", "'/'", "'>'", "'<'", "'*'", 
		"'&'", "'|'", "'!'", nil, "'}'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "WS", "NULL", "TRUE", "FALSE", "NEWLINE", "COLON", "EQUALS", "SC", 
		"LBRAC", "RBRAC", "LSBRAC", "RSBRAC", "NUMBER", "COMMENT", "STRING", "HASH_PREFIX", 
		"QUOTED", "GRAVED", "LCBRAC", "CWS", "QMARK", "FSLASH", "GTHAN", "LTHAN", 
		"ASTERISK", "AMP", "PIPE", "EXCLAM", "CCOMMENT", "RCBRAC"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	override open
	func getGrammarFileName() -> String { return "MODLParser.g4" }

	override open
	func getRuleNames() -> [String] { return MODLParser.ruleNames }

	override open
	func getSerializedATN() -> String { return MODLParser._serializedATN }

	override open
	func getATN() -> ATN { return MODLParser._ATN }


	override open
	func getVocabulary() -> Vocabulary {
	    return MODLParser.VOCABULARY
	}

	override public
	init(_ input:TokenStream) throws {
	    RuntimeMetaData.checkVersion("4.7.2", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,MODLParser._ATN,MODLParser._decisionToDFA, MODLParser._sharedContextCache)
	}


	public class ModlContext: ParserRuleContext {
			open
			func EOF() -> TerminalNode? {
				return getToken(MODLParser.Tokens.EOF.rawValue, 0)
			}
			open
			func modl_structure() -> [Modl_structureContext] {
				return getRuleContexts(Modl_structureContext.self)
			}
			open
			func modl_structure(_ i: Int) -> Modl_structureContext? {
				return getRuleContext(Modl_structureContext.self, i)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func SC() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.SC.rawValue)
			}
			open
			func SC(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.SC.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl(self)
			}
		}
	}
	@discardableResult
	 open func modl() throws -> ModlContext {
		var _localctx: ModlContext = ModlContext(_ctx, getState())
		try enterRule(_localctx, 0, MODLParser.RULE_modl)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(80)
		 	try _errHandler.sync(self)
		 	switch (try getInterpreter().adaptivePredict(_input,6,_ctx)) {
		 	case 1:
		 		setState(49)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(46)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(51)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(52)
		 		try modl_structure()
		 		setState(77)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,5,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(56)
		 				try _errHandler.sync(self)
		 				_alt = try getInterpreter().adaptivePredict(_input,1,_ctx)
		 				while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 					if ( _alt==1 ) {
		 						setState(53)
		 						try match(MODLParser.Tokens.NEWLINE.rawValue)

		 				 
		 					}
		 					setState(58)
		 					try _errHandler.sync(self)
		 					_alt = try getInterpreter().adaptivePredict(_input,1,_ctx)
		 				}
		 				setState(60)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				if (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.SC.rawValue
		 				      return testSet
		 				 }()) {
		 					setState(59)
		 					try match(MODLParser.Tokens.SC.rawValue)

		 				}

		 				setState(65)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				while (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 				      return testSet
		 				 }()) {
		 					setState(62)
		 					try match(MODLParser.Tokens.NEWLINE.rawValue)


		 					setState(67)
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 				}
		 				setState(68)
		 				try modl_structure()
		 				setState(72)
		 				try _errHandler.sync(self)
		 				_alt = try getInterpreter().adaptivePredict(_input,4,_ctx)
		 				while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 					if ( _alt==1 ) {
		 						setState(69)
		 						try match(MODLParser.Tokens.NEWLINE.rawValue)

		 				 
		 					}
		 					setState(74)
		 					try _errHandler.sync(self)
		 					_alt = try getInterpreter().adaptivePredict(_input,4,_ctx)
		 				}

		 		 
		 			}
		 			setState(79)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,5,_ctx)
		 		}

		 		break
		 	default: break
		 	}
		 	setState(85)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,7,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(82)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(87)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,7,_ctx)
		 	}
		 	setState(89)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.SC.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(88)
		 		try match(MODLParser.Tokens.SC.rawValue)

		 	}

		 	setState(94)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(91)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(96)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(97)
		 	try match(MODLParser.Tokens.EOF.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_structureContext: ParserRuleContext {
			open
			func modl_map() -> Modl_mapContext? {
				return getRuleContext(Modl_mapContext.self, 0)
			}
			open
			func modl_array() -> Modl_arrayContext? {
				return getRuleContext(Modl_arrayContext.self, 0)
			}
			open
			func modl_top_level_conditional() -> Modl_top_level_conditionalContext? {
				return getRuleContext(Modl_top_level_conditionalContext.self, 0)
			}
			open
			func modl_pair() -> Modl_pairContext? {
				return getRuleContext(Modl_pairContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_structure
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_structure(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_structure(self)
			}
		}
	}
	@discardableResult
	 open func modl_structure() throws -> Modl_structureContext {
		var _localctx: Modl_structureContext = Modl_structureContext(_ctx, getState())
		try enterRule(_localctx, 2, MODLParser.RULE_modl_structure)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(103)
		 	try _errHandler.sync(self)
		 	switch (MODLParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .LBRAC:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(99)
		 		try modl_map()

		 		break

		 	case .LSBRAC:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(100)
		 		try modl_array()

		 		break

		 	case .LCBRAC:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(101)
		 		try modl_top_level_conditional()

		 		break
		 	case .STRING:fallthrough
		 	case .QUOTED:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(102)
		 		try modl_pair()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_mapContext: ParserRuleContext {
			open
			func LBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LBRAC.rawValue, 0)
			}
			open
			func RBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RBRAC.rawValue, 0)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func modl_map_item() -> [Modl_map_itemContext] {
				return getRuleContexts(Modl_map_itemContext.self)
			}
			open
			func modl_map_item(_ i: Int) -> Modl_map_itemContext? {
				return getRuleContext(Modl_map_itemContext.self, i)
			}
			open
			func SC() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.SC.rawValue)
			}
			open
			func SC(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.SC.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_map
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_map(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_map(self)
			}
		}
	}
	@discardableResult
	 open func modl_map() throws -> Modl_mapContext {
		var _localctx: Modl_mapContext = Modl_mapContext(_ctx, getState())
		try enterRule(_localctx, 4, MODLParser.RULE_modl_map)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(105)
		 	try match(MODLParser.Tokens.LBRAC.rawValue)
		 	setState(109)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(106)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(111)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(134)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(112)
		 		try modl_map_item()
		 		setState(125)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,14,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(114)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				if (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.SC.rawValue
		 				      return testSet
		 				 }()) {
		 					setState(113)
		 					try match(MODLParser.Tokens.SC.rawValue)

		 				}

		 				setState(119)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				while (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 				      return testSet
		 				 }()) {
		 					setState(116)
		 					try match(MODLParser.Tokens.NEWLINE.rawValue)


		 					setState(121)
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 				}
		 				setState(122)
		 				try modl_map_item()

		 		 
		 			}
		 			setState(127)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,14,_ctx)
		 		}
		 		setState(131)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(128)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(133)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}

		 	}

		 	setState(136)
		 	try match(MODLParser.Tokens.RBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_arrayContext: ParserRuleContext {
			open
			func LSBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LSBRAC.rawValue, 0)
			}
			open
			func RSBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RSBRAC.rawValue, 0)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func modl_array_item() -> [Modl_array_itemContext] {
				return getRuleContexts(Modl_array_itemContext.self)
			}
			open
			func modl_array_item(_ i: Int) -> Modl_array_itemContext? {
				return getRuleContext(Modl_array_itemContext.self, i)
			}
			open
			func modl_nb_array() -> [Modl_nb_arrayContext] {
				return getRuleContexts(Modl_nb_arrayContext.self)
			}
			open
			func modl_nb_array(_ i: Int) -> Modl_nb_arrayContext? {
				return getRuleContext(Modl_nb_arrayContext.self, i)
			}
			open
			func SC() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.SC.rawValue)
			}
			open
			func SC(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.SC.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array(self)
			}
		}
	}
	@discardableResult
	 open func modl_array() throws -> Modl_arrayContext {
		var _localctx: Modl_arrayContext = Modl_arrayContext(_ctx, getState())
		try enterRule(_localctx, 6, MODLParser.RULE_modl_array)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(138)
		 	try match(MODLParser.Tokens.LSBRAC.rawValue)
		 	setState(142)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(139)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(144)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(176)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(147)
		 		try _errHandler.sync(self)
		 		switch(try getInterpreter().adaptivePredict(_input,18, _ctx)) {
		 		case 1:
		 			setState(145)
		 			try modl_array_item()

		 			break
		 		case 2:
		 			setState(146)
		 			try modl_nb_array()

		 			break
		 		default: break
		 		}
		 		setState(167)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,23,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(159)
		 				try _errHandler.sync(self)
		 				switch (MODLParser.Tokens(rawValue: try _input.LA(1))!) {
		 				case .SC:
		 					setState(150) 
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 					repeat {
		 						setState(149)
		 						try match(MODLParser.Tokens.SC.rawValue)


		 						setState(152); 
		 						try _errHandler.sync(self)
		 						_la = try _input.LA(1)
		 					} while (//closure
		 					 { () -> Bool in
		 					      let testSet: Bool = _la == MODLParser.Tokens.SC.rawValue
		 					      return testSet
		 					 }())

		 					break

		 				case .NEWLINE:
		 					setState(155) 
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 					repeat {
		 						setState(154)
		 						try match(MODLParser.Tokens.NEWLINE.rawValue)


		 						setState(157); 
		 						try _errHandler.sync(self)
		 						_la = try _input.LA(1)
		 					} while (//closure
		 					 { () -> Bool in
		 					      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 					      return testSet
		 					 }())

		 					break
		 				default:
		 					throw ANTLRException.recognition(e: NoViableAltException(self))
		 				}
		 				setState(163)
		 				try _errHandler.sync(self)
		 				switch(try getInterpreter().adaptivePredict(_input,22, _ctx)) {
		 				case 1:
		 					setState(161)
		 					try modl_array_item()

		 					break
		 				case 2:
		 					setState(162)
		 					try modl_nb_array()

		 					break
		 				default: break
		 				}

		 		 
		 			}
		 			setState(169)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,23,_ctx)
		 		}
		 		setState(173)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(170)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(175)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}

		 	}

		 	setState(178)
		 	try match(MODLParser.Tokens.RSBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_nb_arrayContext: ParserRuleContext {
			open
			func modl_array_item() -> [Modl_array_itemContext] {
				return getRuleContexts(Modl_array_itemContext.self)
			}
			open
			func modl_array_item(_ i: Int) -> Modl_array_itemContext? {
				return getRuleContext(Modl_array_itemContext.self, i)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func COLON() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.COLON.rawValue)
			}
			open
			func COLON(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.COLON.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_nb_array
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_nb_array(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_nb_array(self)
			}
		}
	}
	@discardableResult
	 open func modl_nb_array() throws -> Modl_nb_arrayContext {
		var _localctx: Modl_nb_arrayContext = Modl_nb_arrayContext(_ctx, getState())
		try enterRule(_localctx, 8, MODLParser.RULE_modl_nb_array)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(180)
		 	try modl_array_item()
		 	setState(199); 
		 	try _errHandler.sync(self)
		 	_alt = 1;
		 	repeat {
		 		switch (_alt) {
		 		case 1:
		 			setState(184)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 			while (//closure
		 			 { () -> Bool in
		 			      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 			      return testSet
		 			 }()) {
		 				setState(181)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)


		 				setState(186)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 			}
		 			setState(188) 
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 			repeat {
		 				setState(187)
		 				try match(MODLParser.Tokens.COLON.rawValue)


		 				setState(190); 
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 			} while (//closure
		 			 { () -> Bool in
		 			      let testSet: Bool = _la == MODLParser.Tokens.COLON.rawValue
		 			      return testSet
		 			 }())
		 			setState(195)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 			while (//closure
		 			 { () -> Bool in
		 			      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 			      return testSet
		 			 }()) {
		 				setState(192)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)


		 				setState(197)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 			}
		 			setState(198)
		 			try modl_array_item()


		 			break
		 		default:
		 			throw ANTLRException.recognition(e: NoViableAltException(self))
		 		}
		 		setState(201); 
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,29,_ctx)
		 	} while (_alt != 2 && _alt !=  ATN.INVALID_ALT_NUMBER)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_pairContext: ParserRuleContext {
			open
			func EQUALS() -> TerminalNode? {
				return getToken(MODLParser.Tokens.EQUALS.rawValue, 0)
			}
			open
			func modl_value_item() -> Modl_value_itemContext? {
				return getRuleContext(Modl_value_itemContext.self, 0)
			}
			open
			func STRING() -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRING.rawValue, 0)
			}
			open
			func QUOTED() -> TerminalNode? {
				return getToken(MODLParser.Tokens.QUOTED.rawValue, 0)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func modl_map() -> Modl_mapContext? {
				return getRuleContext(Modl_mapContext.self, 0)
			}
			open
			func modl_array() -> Modl_arrayContext? {
				return getRuleContext(Modl_arrayContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_pair
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_pair(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_pair(self)
			}
		}
	}
	@discardableResult
	 open func modl_pair() throws -> Modl_pairContext {
		var _localctx: Modl_pairContext = Modl_pairContext(_ctx, getState())
		try enterRule(_localctx, 10, MODLParser.RULE_modl_pair)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(222)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,32, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(203)
		 		_la = try _input.LA(1)
		 		if (!(//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.STRING.rawValue || _la == MODLParser.Tokens.QUOTED.rawValue
		 		      return testSet
		 		 }())) {
		 		try _errHandler.recoverInline(self)
		 		}
		 		else {
		 			_errHandler.reportMatch(self)
		 			try consume()
		 		}
		 		setState(207)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(204)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(209)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(210)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)
		 		setState(214)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(211)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(216)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(217)
		 		try modl_value_item()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(218)
		 		try match(MODLParser.Tokens.STRING.rawValue)
		 		setState(219)
		 		try modl_map()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(220)
		 		try match(MODLParser.Tokens.STRING.rawValue)
		 		setState(221)
		 		try modl_array()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_value_itemContext: ParserRuleContext {
			open
			func modl_value() -> Modl_valueContext? {
				return getRuleContext(Modl_valueContext.self, 0)
			}
			open
			func modl_value_conditional() -> Modl_value_conditionalContext? {
				return getRuleContext(Modl_value_conditionalContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_value_item
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_value_item(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_value_item(self)
			}
		}
	}
	@discardableResult
	 open func modl_value_item() throws -> Modl_value_itemContext {
		var _localctx: Modl_value_itemContext = Modl_value_itemContext(_ctx, getState())
		try enterRule(_localctx, 12, MODLParser.RULE_modl_value_item)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(226)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,33, _ctx)) {
		 	case 1:
		 		setState(224)
		 		try modl_value()

		 		break
		 	case 2:
		 		setState(225)
		 		try modl_value_conditional()

		 		break
		 	default: break
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_top_level_conditionalContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func QMARK() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.QMARK.rawValue)
			}
			open
			func QMARK(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.QMARK.rawValue, i)
			}
			open
			func modl_top_level_conditional_return() -> [Modl_top_level_conditional_returnContext] {
				return getRuleContexts(Modl_top_level_conditional_returnContext.self)
			}
			open
			func modl_top_level_conditional_return(_ i: Int) -> Modl_top_level_conditional_returnContext? {
				return getRuleContext(Modl_top_level_conditional_returnContext.self, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_top_level_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_top_level_conditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_top_level_conditional(self)
			}
		}
	}
	@discardableResult
	 open func modl_top_level_conditional() throws -> Modl_top_level_conditionalContext {
		var _localctx: Modl_top_level_conditionalContext = Modl_top_level_conditionalContext(_ctx, getState())
		try enterRule(_localctx, 14, MODLParser.RULE_modl_top_level_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(228)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(232)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,34,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(229)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(234)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,34,_ctx)
		 	}
		 	setState(235)
		 	try modl_condition_test()
		 	setState(236)
		 	try match(MODLParser.Tokens.QMARK.rawValue)
		 	setState(240)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(237)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(242)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(243)
		 	try modl_top_level_conditional_return()
		 	setState(247)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,36,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(244)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(249)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,36,_ctx)
		 	}
		 	setState(270)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.FSLASH.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(250)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(254)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,37,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(251)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)

		 		 
		 			}
		 			setState(256)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,37,_ctx)
		 		}
		 		setState(258)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.NEWLINE.rawValue,MODLParser.Tokens.EQUALS.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue,MODLParser.Tokens.GTHAN.rawValue,MODLParser.Tokens.LTHAN.rawValue,MODLParser.Tokens.EXCLAM.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }()) {
		 			setState(257)
		 			try modl_condition_test()

		 		}

		 		setState(260)
		 		try match(MODLParser.Tokens.QMARK.rawValue)
		 		setState(264)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(261)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(266)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(267)
		 		try modl_top_level_conditional_return()


		 		setState(272)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(276)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(273)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(278)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(279)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_top_level_conditional_returnContext: ParserRuleContext {
			open
			func modl_structure() -> [Modl_structureContext] {
				return getRuleContexts(Modl_structureContext.self)
			}
			open
			func modl_structure(_ i: Int) -> Modl_structureContext? {
				return getRuleContext(Modl_structureContext.self, i)
			}
			open
			func SC() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.SC.rawValue)
			}
			open
			func SC(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.SC.rawValue, i)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_top_level_conditional_return
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_top_level_conditional_return(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_top_level_conditional_return(self)
			}
		}
	}
	@discardableResult
	 open func modl_top_level_conditional_return() throws -> Modl_top_level_conditional_returnContext {
		var _localctx: Modl_top_level_conditional_returnContext = Modl_top_level_conditional_returnContext(_ctx, getState())
		try enterRule(_localctx, 16, MODLParser.RULE_modl_top_level_conditional_return)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(281)
		 	try modl_structure()
		 	setState(291)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,43,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(286)
		 			try _errHandler.sync(self)
		 			switch(try getInterpreter().adaptivePredict(_input,42, _ctx)) {
		 			case 1:
		 				setState(282)
		 				try match(MODLParser.Tokens.SC.rawValue)

		 				break
		 			case 2:
		 				setState(283)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)

		 				break
		 			case 3:
		 				setState(284)
		 				try match(MODLParser.Tokens.SC.rawValue)
		 				setState(285)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)

		 				break
		 			default: break
		 			}
		 			setState(288)
		 			try modl_structure()

		 	 
		 		}
		 		setState(293)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,43,_ctx)
		 	}
		 	setState(295)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.SC.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(294)
		 		try match(MODLParser.Tokens.SC.rawValue)

		 	}

		 	setState(300)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,45,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(297)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(302)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,45,_ctx)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_map_conditionalContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func QMARK() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.QMARK.rawValue)
			}
			open
			func QMARK(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.QMARK.rawValue, i)
			}
			open
			func modl_map_conditional_return() -> [Modl_map_conditional_returnContext] {
				return getRuleContexts(Modl_map_conditional_returnContext.self)
			}
			open
			func modl_map_conditional_return(_ i: Int) -> Modl_map_conditional_returnContext? {
				return getRuleContext(Modl_map_conditional_returnContext.self, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_map_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_map_conditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_map_conditional(self)
			}
		}
	}
	@discardableResult
	 open func modl_map_conditional() throws -> Modl_map_conditionalContext {
		var _localctx: Modl_map_conditionalContext = Modl_map_conditionalContext(_ctx, getState())
		try enterRule(_localctx, 18, MODLParser.RULE_modl_map_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(303)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(307)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,46,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(304)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(309)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,46,_ctx)
		 	}
		 	setState(310)
		 	try modl_condition_test()
		 	setState(311)
		 	try match(MODLParser.Tokens.QMARK.rawValue)
		 	setState(315)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(312)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(317)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(318)
		 	try modl_map_conditional_return()
		 	setState(322)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,48,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(319)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(324)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,48,_ctx)
		 	}
		 	setState(345)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.FSLASH.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(325)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(329)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,49,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(326)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)

		 		 
		 			}
		 			setState(331)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,49,_ctx)
		 		}
		 		setState(333)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.NEWLINE.rawValue,MODLParser.Tokens.EQUALS.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue,MODLParser.Tokens.GTHAN.rawValue,MODLParser.Tokens.LTHAN.rawValue,MODLParser.Tokens.EXCLAM.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }()) {
		 			setState(332)
		 			try modl_condition_test()

		 		}

		 		setState(335)
		 		try match(MODLParser.Tokens.QMARK.rawValue)
		 		setState(339)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(336)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(341)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(342)
		 		try modl_map_conditional_return()


		 		setState(347)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(351)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(348)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(353)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(354)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_map_conditional_returnContext: ParserRuleContext {
			open
			func modl_map_item() -> [Modl_map_itemContext] {
				return getRuleContexts(Modl_map_itemContext.self)
			}
			open
			func modl_map_item(_ i: Int) -> Modl_map_itemContext? {
				return getRuleContext(Modl_map_itemContext.self, i)
			}
			open
			func SC() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.SC.rawValue)
			}
			open
			func SC(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.SC.rawValue, i)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_map_conditional_return
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_map_conditional_return(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_map_conditional_return(self)
			}
		}
	}
	@discardableResult
	 open func modl_map_conditional_return() throws -> Modl_map_conditional_returnContext {
		var _localctx: Modl_map_conditional_returnContext = Modl_map_conditional_returnContext(_ctx, getState())
		try enterRule(_localctx, 20, MODLParser.RULE_modl_map_conditional_return)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(356)
		 	try modl_map_item()
		 	setState(376)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,57,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(371)
		 			try _errHandler.sync(self)
		 			switch(try getInterpreter().adaptivePredict(_input,56, _ctx)) {
		 			case 1:
		 				setState(357)
		 				try match(MODLParser.Tokens.SC.rawValue)

		 				break
		 			case 2:
		 				setState(361)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				while (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 				      return testSet
		 				 }()) {
		 					setState(358)
		 					try match(MODLParser.Tokens.NEWLINE.rawValue)


		 					setState(363)
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 				}

		 				break
		 			case 3:
		 				setState(364)
		 				try match(MODLParser.Tokens.SC.rawValue)
		 				setState(368)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				while (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 				      return testSet
		 				 }()) {
		 					setState(365)
		 					try match(MODLParser.Tokens.NEWLINE.rawValue)


		 					setState(370)
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 				}

		 				break
		 			default: break
		 			}
		 			setState(373)
		 			try modl_map_item()

		 	 
		 		}
		 		setState(378)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,57,_ctx)
		 	}
		 	setState(380)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.SC.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(379)
		 		try match(MODLParser.Tokens.SC.rawValue)

		 	}

		 	setState(385)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,59,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(382)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(387)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,59,_ctx)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_map_itemContext: ParserRuleContext {
			open
			func modl_pair() -> Modl_pairContext? {
				return getRuleContext(Modl_pairContext.self, 0)
			}
			open
			func modl_map_conditional() -> Modl_map_conditionalContext? {
				return getRuleContext(Modl_map_conditionalContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_map_item
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_map_item(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_map_item(self)
			}
		}
	}
	@discardableResult
	 open func modl_map_item() throws -> Modl_map_itemContext {
		var _localctx: Modl_map_itemContext = Modl_map_itemContext(_ctx, getState())
		try enterRule(_localctx, 22, MODLParser.RULE_modl_map_item)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(390)
		 	try _errHandler.sync(self)
		 	switch (MODLParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .STRING:fallthrough
		 	case .QUOTED:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(388)
		 		try modl_pair()

		 		break

		 	case .LCBRAC:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(389)
		 		try modl_map_conditional()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_array_conditionalContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func QMARK() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.QMARK.rawValue)
			}
			open
			func QMARK(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.QMARK.rawValue, i)
			}
			open
			func modl_array_conditional_return() -> [Modl_array_conditional_returnContext] {
				return getRuleContexts(Modl_array_conditional_returnContext.self)
			}
			open
			func modl_array_conditional_return(_ i: Int) -> Modl_array_conditional_returnContext? {
				return getRuleContext(Modl_array_conditional_returnContext.self, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array_conditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array_conditional(self)
			}
		}
	}
	@discardableResult
	 open func modl_array_conditional() throws -> Modl_array_conditionalContext {
		var _localctx: Modl_array_conditionalContext = Modl_array_conditionalContext(_ctx, getState())
		try enterRule(_localctx, 24, MODLParser.RULE_modl_array_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(392)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(396)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,61,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(393)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(398)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,61,_ctx)
		 	}
		 	setState(399)
		 	try modl_condition_test()
		 	setState(400)
		 	try match(MODLParser.Tokens.QMARK.rawValue)
		 	setState(404)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(401)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(406)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(407)
		 	try modl_array_conditional_return()
		 	setState(411)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,63,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(408)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(413)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,63,_ctx)
		 	}
		 	setState(434)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.FSLASH.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(414)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(418)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,64,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(415)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)

		 		 
		 			}
		 			setState(420)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,64,_ctx)
		 		}
		 		setState(422)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = {  () -> Bool in
		 		   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.NEWLINE.rawValue,MODLParser.Tokens.EQUALS.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue,MODLParser.Tokens.GTHAN.rawValue,MODLParser.Tokens.LTHAN.rawValue,MODLParser.Tokens.EXCLAM.rawValue]
		 		    return  Utils.testBitLeftShiftArray(testArray, 0)
		 		}()
		 		      return testSet
		 		 }()) {
		 			setState(421)
		 			try modl_condition_test()

		 		}

		 		setState(424)
		 		try match(MODLParser.Tokens.QMARK.rawValue)
		 		setState(428)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(425)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(430)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(431)
		 		try modl_array_conditional_return()


		 		setState(436)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(440)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(437)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(442)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(443)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_array_conditional_returnContext: ParserRuleContext {
			open
			func modl_array_item() -> [Modl_array_itemContext] {
				return getRuleContexts(Modl_array_itemContext.self)
			}
			open
			func modl_array_item(_ i: Int) -> Modl_array_itemContext? {
				return getRuleContext(Modl_array_itemContext.self, i)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func SC() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.SC.rawValue)
			}
			open
			func SC(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.SC.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array_conditional_return
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array_conditional_return(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array_conditional_return(self)
			}
		}
	}
	@discardableResult
	 open func modl_array_conditional_return() throws -> Modl_array_conditional_returnContext {
		var _localctx: Modl_array_conditional_returnContext = Modl_array_conditional_returnContext(_ctx, getState())
		try enterRule(_localctx, 26, MODLParser.RULE_modl_array_conditional_return)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(445)
		 	try modl_array_item()
		 	setState(464)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,72,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(459)
		 			try _errHandler.sync(self)
		 			switch(try getInterpreter().adaptivePredict(_input,71, _ctx)) {
		 			case 1:
		 				setState(446)
		 				try match(MODLParser.Tokens.SC.rawValue)

		 				break
		 			case 2:
		 				setState(448) 
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				repeat {
		 					setState(447)
		 					try match(MODLParser.Tokens.NEWLINE.rawValue)


		 					setState(450); 
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 				} while (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 				      return testSet
		 				 }())

		 				break
		 			case 3:
		 				setState(452)
		 				try match(MODLParser.Tokens.SC.rawValue)
		 				setState(456)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				while (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 				      return testSet
		 				 }()) {
		 					setState(453)
		 					try match(MODLParser.Tokens.NEWLINE.rawValue)


		 					setState(458)
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 				}

		 				break
		 			default: break
		 			}
		 			setState(461)
		 			try modl_array_item()

		 	 
		 		}
		 		setState(466)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,72,_ctx)
		 	}
		 	setState(470)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,73,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(467)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(472)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,73,_ctx)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_array_itemContext: ParserRuleContext {
			open
			func modl_array_value_item() -> Modl_array_value_itemContext? {
				return getRuleContext(Modl_array_value_itemContext.self, 0)
			}
			open
			func modl_array_conditional() -> Modl_array_conditionalContext? {
				return getRuleContext(Modl_array_conditionalContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array_item
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array_item(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array_item(self)
			}
		}
	}
	@discardableResult
	 open func modl_array_item() throws -> Modl_array_itemContext {
		var _localctx: Modl_array_itemContext = Modl_array_itemContext(_ctx, getState())
		try enterRule(_localctx, 28, MODLParser.RULE_modl_array_item)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(475)
		 	try _errHandler.sync(self)
		 	switch (MODLParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .NULL:fallthrough
		 	case .TRUE:fallthrough
		 	case .FALSE:fallthrough
		 	case .LBRAC:fallthrough
		 	case .LSBRAC:fallthrough
		 	case .NUMBER:fallthrough
		 	case .STRING:fallthrough
		 	case .QUOTED:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(473)
		 		try modl_array_value_item()

		 		break

		 	case .LCBRAC:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(474)
		 		try modl_array_conditional()

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_value_conditionalContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func QMARK() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.QMARK.rawValue)
			}
			open
			func QMARK(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.QMARK.rawValue, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func modl_value_conditional_return() -> [Modl_value_conditional_returnContext] {
				return getRuleContexts(Modl_value_conditional_returnContext.self)
			}
			open
			func modl_value_conditional_return(_ i: Int) -> Modl_value_conditional_returnContext? {
				return getRuleContext(Modl_value_conditional_returnContext.self, i)
			}
			open
			func FSLASH() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.FSLASH.rawValue)
			}
			open
			func FSLASH(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.FSLASH.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_value_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_value_conditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_value_conditional(self)
			}
		}
	}
	@discardableResult
	 open func modl_value_conditional() throws -> Modl_value_conditionalContext {
		var _localctx: Modl_value_conditionalContext = Modl_value_conditionalContext(_ctx, getState())
		try enterRule(_localctx, 30, MODLParser.RULE_modl_value_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(477)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(481)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,75,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(478)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)

		 	 
		 		}
		 		setState(483)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,75,_ctx)
		 	}
		 	setState(484)
		 	try modl_condition_test()
		 	setState(485)
		 	try match(MODLParser.Tokens.QMARK.rawValue)
		 	setState(549)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.NULL.rawValue,MODLParser.Tokens.TRUE.rawValue,MODLParser.Tokens.FALSE.rawValue,MODLParser.Tokens.NEWLINE.rawValue,MODLParser.Tokens.LBRAC.rawValue,MODLParser.Tokens.LSBRAC.rawValue,MODLParser.Tokens.NUMBER.rawValue,MODLParser.Tokens.STRING.rawValue,MODLParser.Tokens.QUOTED.rawValue,MODLParser.Tokens.LCBRAC.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(489)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(486)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(491)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(492)
		 		try modl_value_conditional_return()
		 		setState(496)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,77,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(493)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)

		 		 
		 			}
		 			setState(498)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,77,_ctx)
		 		}
		 		setState(518)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,80,_ctx)
		 		while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 			if ( _alt==1 ) {
		 				setState(499)
		 				try match(MODLParser.Tokens.FSLASH.rawValue)
		 				setState(503)
		 				try _errHandler.sync(self)
		 				_alt = try getInterpreter().adaptivePredict(_input,78,_ctx)
		 				while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 					if ( _alt==1 ) {
		 						setState(500)
		 						try match(MODLParser.Tokens.NEWLINE.rawValue)

		 				 
		 					}
		 					setState(505)
		 					try _errHandler.sync(self)
		 					_alt = try getInterpreter().adaptivePredict(_input,78,_ctx)
		 				}
		 				setState(506)
		 				try modl_condition_test()
		 				setState(507)
		 				try match(MODLParser.Tokens.QMARK.rawValue)
		 				setState(511)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 				while (//closure
		 				 { () -> Bool in
		 				      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 				      return testSet
		 				 }()) {
		 					setState(508)
		 					try match(MODLParser.Tokens.NEWLINE.rawValue)


		 					setState(513)
		 					try _errHandler.sync(self)
		 					_la = try _input.LA(1)
		 				}
		 				setState(514)
		 				try modl_value_conditional_return()

		 		 
		 			}
		 			setState(520)
		 			try _errHandler.sync(self)
		 			_alt = try getInterpreter().adaptivePredict(_input,80,_ctx)
		 		}
		 		setState(524)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(521)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(526)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}

		 		setState(527)
		 		try match(MODLParser.Tokens.FSLASH.rawValue)
		 		setState(531)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(528)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(533)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(534)
		 		try match(MODLParser.Tokens.QMARK.rawValue)
		 		setState(538)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(535)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(540)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(541)
		 		try modl_value_conditional_return()

		 		setState(546)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while (//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 		      return testSet
		 		 }()) {
		 			setState(543)
		 			try match(MODLParser.Tokens.NEWLINE.rawValue)


		 			setState(548)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}

		 	}

		 	setState(551)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_value_conditional_returnContext: ParserRuleContext {
			open
			func modl_value_item() -> [Modl_value_itemContext] {
				return getRuleContexts(Modl_value_itemContext.self)
			}
			open
			func modl_value_item(_ i: Int) -> Modl_value_itemContext? {
				return getRuleContext(Modl_value_itemContext.self, i)
			}
			open
			func COLON() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.COLON.rawValue)
			}
			open
			func COLON(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.COLON.rawValue, i)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_value_conditional_return
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_value_conditional_return(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_value_conditional_return(self)
			}
		}
	}
	@discardableResult
	 open func modl_value_conditional_return() throws -> Modl_value_conditional_returnContext {
		var _localctx: Modl_value_conditional_returnContext = Modl_value_conditional_returnContext(_ctx, getState())
		try enterRule(_localctx, 32, MODLParser.RULE_modl_value_conditional_return)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(553)
		 	try modl_value_item()
		 	setState(564)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,87,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(557)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 			while (//closure
		 			 { () -> Bool in
		 			      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 			      return testSet
		 			 }()) {
		 				setState(554)
		 				try match(MODLParser.Tokens.NEWLINE.rawValue)


		 				setState(559)
		 				try _errHandler.sync(self)
		 				_la = try _input.LA(1)
		 			}
		 			setState(560)
		 			try match(MODLParser.Tokens.COLON.rawValue)
		 			setState(561)
		 			try modl_value_item()

		 	 
		 		}
		 		setState(566)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,87,_ctx)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_condition_testContext: ParserRuleContext {
			open
			func modl_condition() -> [Modl_conditionContext] {
				return getRuleContexts(Modl_conditionContext.self)
			}
			open
			func modl_condition(_ i: Int) -> Modl_conditionContext? {
				return getRuleContext(Modl_conditionContext.self, i)
			}
			open
			func modl_condition_group() -> [Modl_condition_groupContext] {
				return getRuleContexts(Modl_condition_groupContext.self)
			}
			open
			func modl_condition_group(_ i: Int) -> Modl_condition_groupContext? {
				return getRuleContext(Modl_condition_groupContext.self, i)
			}
			open
			func EXCLAM() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.EXCLAM.rawValue)
			}
			open
			func EXCLAM(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.EXCLAM.rawValue, i)
			}
			open
			func AMP() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.AMP.rawValue)
			}
			open
			func AMP(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.AMP.rawValue, i)
			}
			open
			func PIPE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.PIPE.rawValue)
			}
			open
			func PIPE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.PIPE.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_condition_test
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_condition_test(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_condition_test(self)
			}
		}
	}
	@discardableResult
	 open func modl_condition_test() throws -> Modl_condition_testContext {
		var _localctx: Modl_condition_testContext = Modl_condition_testContext(_ctx, getState())
		try enterRule(_localctx, 34, MODLParser.RULE_modl_condition_test)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(568)
		 	try _errHandler.sync(self)
		 	switch (try getInterpreter().adaptivePredict(_input,88,_ctx)) {
		 	case 1:
		 		setState(567)
		 		try match(MODLParser.Tokens.EXCLAM.rawValue)

		 		break
		 	default: break
		 	}
		 	setState(572)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,89, _ctx)) {
		 	case 1:
		 		setState(570)
		 		try modl_condition()

		 		break
		 	case 2:
		 		setState(571)
		 		try modl_condition_group()

		 		break
		 	default: break
		 	}
		 	setState(584)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,92,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(574)
		 			_la = try _input.LA(1)
		 			if (!(//closure
		 			 { () -> Bool in
		 			      let testSet: Bool = _la == MODLParser.Tokens.AMP.rawValue || _la == MODLParser.Tokens.PIPE.rawValue
		 			      return testSet
		 			 }())) {
		 			try _errHandler.recoverInline(self)
		 			}
		 			else {
		 				_errHandler.reportMatch(self)
		 				try consume()
		 			}
		 			setState(576)
		 			try _errHandler.sync(self)
		 			switch (try getInterpreter().adaptivePredict(_input,90,_ctx)) {
		 			case 1:
		 				setState(575)
		 				try match(MODLParser.Tokens.EXCLAM.rawValue)

		 				break
		 			default: break
		 			}
		 			setState(580)
		 			try _errHandler.sync(self)
		 			switch(try getInterpreter().adaptivePredict(_input,91, _ctx)) {
		 			case 1:
		 				setState(578)
		 				try modl_condition()

		 				break
		 			case 2:
		 				setState(579)
		 				try modl_condition_group()

		 				break
		 			default: break
		 			}

		 	 
		 		}
		 		setState(586)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,92,_ctx)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_operatorContext: ParserRuleContext {
			open
			func EQUALS() -> TerminalNode? {
				return getToken(MODLParser.Tokens.EQUALS.rawValue, 0)
			}
			open
			func GTHAN() -> TerminalNode? {
				return getToken(MODLParser.Tokens.GTHAN.rawValue, 0)
			}
			open
			func LTHAN() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LTHAN.rawValue, 0)
			}
			open
			func EXCLAM() -> TerminalNode? {
				return getToken(MODLParser.Tokens.EXCLAM.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_operator
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_operator(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_operator(self)
			}
		}
	}
	@discardableResult
	 open func modl_operator() throws -> Modl_operatorContext {
		var _localctx: Modl_operatorContext = Modl_operatorContext(_ctx, getState())
		try enterRule(_localctx, 36, MODLParser.RULE_modl_operator)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(596)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,93, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(587)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(588)
		 		try match(MODLParser.Tokens.GTHAN.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(589)
		 		try match(MODLParser.Tokens.GTHAN.rawValue)
		 		setState(590)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(591)
		 		try match(MODLParser.Tokens.LTHAN.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(592)
		 		try match(MODLParser.Tokens.LTHAN.rawValue)
		 		setState(593)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(594)
		 		try match(MODLParser.Tokens.EXCLAM.rawValue)
		 		setState(595)
		 		try match(MODLParser.Tokens.EQUALS.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_conditionContext: ParserRuleContext {
			open
			func modl_value() -> [Modl_valueContext] {
				return getRuleContexts(Modl_valueContext.self)
			}
			open
			func modl_value(_ i: Int) -> Modl_valueContext? {
				return getRuleContext(Modl_valueContext.self, i)
			}
			open
			func NEWLINE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.NEWLINE.rawValue)
			}
			open
			func NEWLINE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.NEWLINE.rawValue, i)
			}
			open
			func STRING() -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRING.rawValue, 0)
			}
			open
			func modl_operator() -> Modl_operatorContext? {
				return getRuleContext(Modl_operatorContext.self, 0)
			}
			open
			func PIPE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.PIPE.rawValue)
			}
			open
			func PIPE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.PIPE.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_condition
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_condition(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_condition(self)
			}
		}
	}
	@discardableResult
	 open func modl_condition() throws -> Modl_conditionContext {
		var _localctx: Modl_conditionContext = Modl_conditionContext(_ctx, getState())
		try enterRule(_localctx, 38, MODLParser.RULE_modl_condition)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(601)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(598)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(603)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(605)
		 	try _errHandler.sync(self)
		 	switch (try getInterpreter().adaptivePredict(_input,95,_ctx)) {
		 	case 1:
		 		setState(604)
		 		try match(MODLParser.Tokens.STRING.rawValue)

		 		break
		 	default: break
		 	}
		 	setState(608)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = {  () -> Bool in
		 	   let testArray: [Int] = [_la, MODLParser.Tokens.EQUALS.rawValue,MODLParser.Tokens.GTHAN.rawValue,MODLParser.Tokens.LTHAN.rawValue,MODLParser.Tokens.EXCLAM.rawValue]
		 	    return  Utils.testBitLeftShiftArray(testArray, 0)
		 	}()
		 	      return testSet
		 	 }()) {
		 		setState(607)
		 		try modl_operator()

		 	}

		 	setState(610)
		 	try modl_value()
		 	setState(615)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,97,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(611)
		 			try match(MODLParser.Tokens.PIPE.rawValue)
		 			setState(612)
		 			try modl_value()

		 	 
		 		}
		 		setState(617)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,97,_ctx)
		 	}
		 	setState(621)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.NEWLINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(618)
		 		try match(MODLParser.Tokens.NEWLINE.rawValue)


		 		setState(623)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_condition_groupContext: ParserRuleContext {
			open
			func LCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.LCBRAC.rawValue, 0)
			}
			open
			func modl_condition_test() -> [Modl_condition_testContext] {
				return getRuleContexts(Modl_condition_testContext.self)
			}
			open
			func modl_condition_test(_ i: Int) -> Modl_condition_testContext? {
				return getRuleContext(Modl_condition_testContext.self, i)
			}
			open
			func RCBRAC() -> TerminalNode? {
				return getToken(MODLParser.Tokens.RCBRAC.rawValue, 0)
			}
			open
			func AMP() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.AMP.rawValue)
			}
			open
			func AMP(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.AMP.rawValue, i)
			}
			open
			func PIPE() -> [TerminalNode] {
				return getTokens(MODLParser.Tokens.PIPE.rawValue)
			}
			open
			func PIPE(_ i:Int) -> TerminalNode? {
				return getToken(MODLParser.Tokens.PIPE.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_condition_group
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_condition_group(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_condition_group(self)
			}
		}
	}
	@discardableResult
	 open func modl_condition_group() throws -> Modl_condition_groupContext {
		var _localctx: Modl_condition_groupContext = Modl_condition_groupContext(_ctx, getState())
		try enterRule(_localctx, 40, MODLParser.RULE_modl_condition_group)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(624)
		 	try match(MODLParser.Tokens.LCBRAC.rawValue)
		 	setState(625)
		 	try modl_condition_test()
		 	setState(630)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == MODLParser.Tokens.AMP.rawValue || _la == MODLParser.Tokens.PIPE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(626)
		 		_la = try _input.LA(1)
		 		if (!(//closure
		 		 { () -> Bool in
		 		      let testSet: Bool = _la == MODLParser.Tokens.AMP.rawValue || _la == MODLParser.Tokens.PIPE.rawValue
		 		      return testSet
		 		 }())) {
		 		try _errHandler.recoverInline(self)
		 		}
		 		else {
		 			_errHandler.reportMatch(self)
		 			try consume()
		 		}
		 		setState(627)
		 		try modl_condition_test()


		 		setState(632)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}
		 	setState(633)
		 	try match(MODLParser.Tokens.RCBRAC.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_valueContext: ParserRuleContext {
			open
			func modl_map() -> Modl_mapContext? {
				return getRuleContext(Modl_mapContext.self, 0)
			}
			open
			func modl_array() -> Modl_arrayContext? {
				return getRuleContext(Modl_arrayContext.self, 0)
			}
			open
			func modl_nb_array() -> Modl_nb_arrayContext? {
				return getRuleContext(Modl_nb_arrayContext.self, 0)
			}
			open
			func modl_pair() -> Modl_pairContext? {
				return getRuleContext(Modl_pairContext.self, 0)
			}
			open
			func QUOTED() -> TerminalNode? {
				return getToken(MODLParser.Tokens.QUOTED.rawValue, 0)
			}
			open
			func NUMBER() -> TerminalNode? {
				return getToken(MODLParser.Tokens.NUMBER.rawValue, 0)
			}
			open
			func STRING() -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRING.rawValue, 0)
			}
			open
			func TRUE() -> TerminalNode? {
				return getToken(MODLParser.Tokens.TRUE.rawValue, 0)
			}
			open
			func FALSE() -> TerminalNode? {
				return getToken(MODLParser.Tokens.FALSE.rawValue, 0)
			}
			open
			func NULL() -> TerminalNode? {
				return getToken(MODLParser.Tokens.NULL.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_value
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_value(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_value(self)
			}
		}
	}
	@discardableResult
	 open func modl_value() throws -> Modl_valueContext {
		var _localctx: Modl_valueContext = Modl_valueContext(_ctx, getState())
		try enterRule(_localctx, 42, MODLParser.RULE_modl_value)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(645)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,100, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(635)
		 		try modl_map()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(636)
		 		try modl_array()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(637)
		 		try modl_nb_array()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(638)
		 		try modl_pair()

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(639)
		 		try match(MODLParser.Tokens.QUOTED.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(640)
		 		try match(MODLParser.Tokens.NUMBER.rawValue)

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(641)
		 		try match(MODLParser.Tokens.STRING.rawValue)

		 		break
		 	case 8:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(642)
		 		try match(MODLParser.Tokens.TRUE.rawValue)

		 		break
		 	case 9:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(643)
		 		try match(MODLParser.Tokens.FALSE.rawValue)

		 		break
		 	case 10:
		 		try enterOuterAlt(_localctx, 10)
		 		setState(644)
		 		try match(MODLParser.Tokens.NULL.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Modl_array_value_itemContext: ParserRuleContext {
			open
			func modl_map() -> Modl_mapContext? {
				return getRuleContext(Modl_mapContext.self, 0)
			}
			open
			func modl_pair() -> Modl_pairContext? {
				return getRuleContext(Modl_pairContext.self, 0)
			}
			open
			func modl_array() -> Modl_arrayContext? {
				return getRuleContext(Modl_arrayContext.self, 0)
			}
			open
			func QUOTED() -> TerminalNode? {
				return getToken(MODLParser.Tokens.QUOTED.rawValue, 0)
			}
			open
			func NUMBER() -> TerminalNode? {
				return getToken(MODLParser.Tokens.NUMBER.rawValue, 0)
			}
			open
			func STRING() -> TerminalNode? {
				return getToken(MODLParser.Tokens.STRING.rawValue, 0)
			}
			open
			func TRUE() -> TerminalNode? {
				return getToken(MODLParser.Tokens.TRUE.rawValue, 0)
			}
			open
			func FALSE() -> TerminalNode? {
				return getToken(MODLParser.Tokens.FALSE.rawValue, 0)
			}
			open
			func NULL() -> TerminalNode? {
				return getToken(MODLParser.Tokens.NULL.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return MODLParser.RULE_modl_array_value_item
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.enterModl_array_value_item(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? MODLParserListener {
				listener.exitModl_array_value_item(self)
			}
		}
	}
	@discardableResult
	 open func modl_array_value_item() throws -> Modl_array_value_itemContext {
		var _localctx: Modl_array_value_itemContext = Modl_array_value_itemContext(_ctx, getState())
		try enterRule(_localctx, 44, MODLParser.RULE_modl_array_value_item)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(656)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,101, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(647)
		 		try modl_map()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(648)
		 		try modl_pair()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(649)
		 		try modl_array()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(650)
		 		try match(MODLParser.Tokens.QUOTED.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(651)
		 		try match(MODLParser.Tokens.NUMBER.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(652)
		 		try match(MODLParser.Tokens.STRING.rawValue)

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(653)
		 		try match(MODLParser.Tokens.TRUE.rawValue)

		 		break
		 	case 8:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(654)
		 		try match(MODLParser.Tokens.FALSE.rawValue)

		 		break
		 	case 9:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(655)
		 		try match(MODLParser.Tokens.NULL.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}


	public
	static let _serializedATN = MODLParserATN().jsonString

	public
	static let _ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}