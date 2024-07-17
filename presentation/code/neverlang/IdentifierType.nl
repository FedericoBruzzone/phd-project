module neverlang.core.typelang.types.IdentifierType {
    imports {
        neverlang.core.typelang.Formatting;
    }

    reference syntax {
        Identifier <-- /[a-zA-Z][a-zA-Z0-9]+/;
        SI: ScopeIdentifier <-- Identifier;
        CF: ScopeIdentifier <-- "(" "$file" "??" /[a-zA-Z][a-zA-Z0-9]+/ ")";
        NT: ScopeIdentifier <-- NonTerminal;
        TI: TokenIdentifier <-- Identifier;
        TINT: TokenIdentifier <-- NonTerminal;
    }

    role(translate){
        0<template> .{{{#0.text}}}.
        SI: .{
            $$Formatting.withIdentifier($n, $SI[0].Text, false);
        }.
        CF: .{
            $$Formatting.withIdentifier($n, #3.text, true);
        }.

        NT: .{
            $$Formatting.withToken($n, 0);
        }.

        TI: .{
            $$Formatting.tokenFromIdentifier($n, 0);
        }.

        TINT: .{
            $$Formatting.readAttribute($TINT[0], $TINT[1], "token");
        }.
    }
}

