// SPDX-FileCopyrightText: 2023 Jade Lovelace
//
// SPDX-License-Identifier: MIT

/*
 * Generated AST:
 * (change_indent: int, body: ((ast | content)[] | content | ast)
 */

#let ast_to_content_list(indent, ast) = {
    if type(ast) == "array" {
        ast.map(d => ast_to_content_list(indent, d))
    } else if type(ast) == "content" {
        (pad(left: indent * 0.5em, ast),)
    } else if type(ast) == "dictionary" {
        let new_indent = ast.at("change_indent", default: 0) + indent
        ast_to_content_list(new_indent, ast.body)
    }
}

#let algorithm(..bits) = {
    let content = bits.pos().map(b => ast_to_content_list(0, b)).flatten()
    let table_bits = ()
    let lineno = 1

    while lineno <= content.len() {
        table_bits.push([#lineno:])
        table_bits.push(content.at(lineno - 1))
        lineno = lineno + 1
    }
    table(
        columns: (18pt, 100%),
        // line spacing
        inset: 0.3em,
        stroke: none,
        ..table_bits
    )
}

#let iflike_block(kw1: "", kw2: "", cond: "", ..body) = (
    (strong(kw1) + " " + cond + " " + strong(kw2)),
    // XXX: .pos annoys me here
    (change_indent: 4, body: body.pos())
)

#let function_like(name, kw: "function", arg: "", ..body) = (
    iflike_block(kw1: kw, cond: (smallcaps(name) + "(" + arg + ")"), ..body)
)

#let listify(v) = {
    if type(v) == "list" {
        v
    } else {
        (v,)
    }
}

#let Function = function_like.with(kw: "function")
#let Procedure = function_like.with(kw: "procedure")

#let State(block) = ((body: block),)

/// Inline call
#let CallI(name, args) = smallcaps(name) + "(" + listify(args).join(", ") + ")"
#let Call(..args) = (CallI(..args),)
#let FnI(f, args) = strong(f) + " (" + listify(args).join(", ") + ")"
#let Fn(..args) = (FnI(..args),)
#let Ic(c) = sym.triangle.stroked.r + " " + c
#let Cmt(c) = (Ic(c),)
// It kind of sucks that Else is a separate block but it's fine
#let If = iflike_block.with(kw1: "if", kw2: "then")
#let While = iflike_block.with(kw1: "while", kw2: "do")
#let For = iflike_block.with(kw1: "for", kw2: "do")
#let Assign(var, val) = (var + " " + $<-$ + " " + val,)

#let Else = iflike_block.with(kw1: "else")
#let ElsIf = iflike_block.with(kw1: "else if", kw2: "then")
#let ElseIf = ElsIf
#let Return(arg) = (strong("return") + " " + arg,)

= Supplementary File S1

Pseudocode for a *tidk* algorithm used in `tidk explore`. The algorithm is used to merge k-mers with the same minimal form. It explains the code written in the GitHub repository found #link("https://github.com/tolkit/telomeric-identifier/blob/5159d81062b86471ec670f597c814adf635401a2/src/explore.rs#L384")[*here*].

#algorithm({
    Function("merge_kmers", arg: "hashmap", {
        Assign[merged_hashmap][{}]
    
        For(cond: "kmer, count in hashmap.items", {
            Cmt[Compute the minimal form for this kmer]
            Assign[minimal_form][compute_minimal_form(kmer)]
       
            Cmt[Merge counts using the minimal form as the key]
            If(cond: "minimal_form in merged_hashmap", {
                [merged_hashmap[minimal_form] $+=$ count]
            })
            Else({
                [merged_hashmap[minimal_form] $eq$ count]
            })
        })
        Return[merged_hashmap]
    })
})

#algorithm({
  Function("compute-minimal-form", arg: "kmer", {
  Cmt[Generate all rotations of the kmer]
  Assign[rotations][kmer[i:] + kmer[:i] for i in range(len(kmer))]
  State[]
    
  Cmt[Compute reverse complement of the kmer]
  Assign[reverse_complement][reverse_complement(kmer)]
  State[]
    
  Cmt[Generate all rotations of the reverse complement]
  Assign[reverse_rotations][reverse_complement[i:] + reverse_complement[:i] for i in range(len(reverse_complement))]
  State[]
    
  Cmt[Find the lexicographically minimal rotation (smallest in alphabetical order)]
  Assign[minimal_form][min(rotations + reverse_rotations)]
  State[]

  Return[minimal_form]
 })
})
