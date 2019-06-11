// Generated from MODLParser.g4 by ANTLR 4.7.2
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link MODLParser}.
 */
public protocol MODLParserListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl(_ ctx: MODLParser.ModlContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl(_ ctx: MODLParser.ModlContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_structure}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_structure(_ ctx: MODLParser.Modl_structureContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_structure}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_structure(_ ctx: MODLParser.Modl_structureContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_map}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_map(_ ctx: MODLParser.Modl_mapContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_map}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_map(_ ctx: MODLParser.Modl_mapContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_array}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_array(_ ctx: MODLParser.Modl_arrayContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_array}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_array(_ ctx: MODLParser.Modl_arrayContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_nb_array}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_nb_array(_ ctx: MODLParser.Modl_nb_arrayContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_nb_array}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_nb_array(_ ctx: MODLParser.Modl_nb_arrayContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_pair}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_pair(_ ctx: MODLParser.Modl_pairContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_pair}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_pair(_ ctx: MODLParser.Modl_pairContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_value_item}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_value_item(_ ctx: MODLParser.Modl_value_itemContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_value_item}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_value_item(_ ctx: MODLParser.Modl_value_itemContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_top_level_conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_top_level_conditional(_ ctx: MODLParser.Modl_top_level_conditionalContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_top_level_conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_top_level_conditional(_ ctx: MODLParser.Modl_top_level_conditionalContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_top_level_conditional_return}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_top_level_conditional_return(_ ctx: MODLParser.Modl_top_level_conditional_returnContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_top_level_conditional_return}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_top_level_conditional_return(_ ctx: MODLParser.Modl_top_level_conditional_returnContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_map_conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_map_conditional(_ ctx: MODLParser.Modl_map_conditionalContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_map_conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_map_conditional(_ ctx: MODLParser.Modl_map_conditionalContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_map_conditional_return}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_map_conditional_return(_ ctx: MODLParser.Modl_map_conditional_returnContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_map_conditional_return}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_map_conditional_return(_ ctx: MODLParser.Modl_map_conditional_returnContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_map_item}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_map_item(_ ctx: MODLParser.Modl_map_itemContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_map_item}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_map_item(_ ctx: MODLParser.Modl_map_itemContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_array_conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_array_conditional(_ ctx: MODLParser.Modl_array_conditionalContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_array_conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_array_conditional(_ ctx: MODLParser.Modl_array_conditionalContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_array_conditional_return}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_array_conditional_return(_ ctx: MODLParser.Modl_array_conditional_returnContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_array_conditional_return}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_array_conditional_return(_ ctx: MODLParser.Modl_array_conditional_returnContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_array_item}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_array_item(_ ctx: MODLParser.Modl_array_itemContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_array_item}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_array_item(_ ctx: MODLParser.Modl_array_itemContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_value_conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_value_conditional(_ ctx: MODLParser.Modl_value_conditionalContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_value_conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_value_conditional(_ ctx: MODLParser.Modl_value_conditionalContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_value_conditional_return}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_value_conditional_return(_ ctx: MODLParser.Modl_value_conditional_returnContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_value_conditional_return}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_value_conditional_return(_ ctx: MODLParser.Modl_value_conditional_returnContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_condition_test}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_condition_test(_ ctx: MODLParser.Modl_condition_testContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_condition_test}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_condition_test(_ ctx: MODLParser.Modl_condition_testContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_operator}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_operator(_ ctx: MODLParser.Modl_operatorContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_operator}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_operator(_ ctx: MODLParser.Modl_operatorContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_condition}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_condition(_ ctx: MODLParser.Modl_conditionContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_condition}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_condition(_ ctx: MODLParser.Modl_conditionContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_condition_group}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_condition_group(_ ctx: MODLParser.Modl_condition_groupContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_condition_group}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_condition_group(_ ctx: MODLParser.Modl_condition_groupContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_value(_ ctx: MODLParser.Modl_valueContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_value}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_value(_ ctx: MODLParser.Modl_valueContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_array_value_item}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_array_value_item(_ ctx: MODLParser.Modl_array_value_itemContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_array_value_item}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_array_value_item(_ ctx: MODLParser.Modl_array_value_itemContext)
	/**
	 * Enter a parse tree produced by {@link MODLParser#modl_primitive}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterModl_primitive(_ ctx: MODLParser.Modl_primitiveContext)
	/**
	 * Exit a parse tree produced by {@link MODLParser#modl_primitive}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitModl_primitive(_ ctx: MODLParser.Modl_primitiveContext)
}