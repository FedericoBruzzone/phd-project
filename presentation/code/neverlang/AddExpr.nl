module AddExpr {
    reference syntax {
        provides { AddExpr: expression, numbers, sum, sub; }
        requires { MulExpr; }
        [ADD_0] AddExpr <- MulExpr;
        [ADD_1] AddExpr <- AddExpr "+" MulExpr;
        [ADD_2] AddExpr <- AddExpr "-" MulExpr;
    }
    role(evaluation) {
        [ADD_0] @{ $ADD_0[0].value = $ADD_0[1].value; }
        [ADD_1] .{ /*...*/ }.
        [ADD_2] .{ /*...*/ }.
    }
}
slice AddExprSlice {
    concrete syntax from AddExpr
    module AddExpr with role evaluation
}
language ExprLang {
    slices AddExprSlice UnaryExprSlice
           /* ... */
    roles syntax < evaluation
    rename { MulExpr -> UnaryExpr; }
}

