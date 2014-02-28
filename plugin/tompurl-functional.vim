"-----------------------------------------------------------------------------
" tompurl-functonal.vim - A list of functions that make vim scripting a bit
" more like a functional language. These functions come from Chapter 39 of the
" 'Learn Vimscript The Hard way' book.
"-----------------------------------------------------------------------------

" Sorted - Returns a sorted copy of a list without changing the original ----------- {{{
" list 
"
" l - List that you want to sort
"
" Returns - A new, sorted list
function! Sorted(l)
    let new_list = deepcopy(a:l)
    call sort(new_list)
    return new_list
endfunction
" }}} 

" Reversed - Reverse the order of items in a list without affecting the ----------- {{{
" original list 
"
" l - List that you want to reverse
"
" Returns - A new list that is reversed
function! Reversed(l)
    let new_list = deepcopy(a:l)
    call reverse(new_list)
    return new_list
endfunction
" }}} 

" Append - Create a new list with the new item at the end using an existing ----------- {{{
" list 
"
" l - Existing list
" val - The item that you want to add to this list
"
" Returns - A new list that is a copy of the existing list with the added
" value at the end.
function! Append(l, val)
    let new_list = deepcopy(a:l)
    call add(new_list, a:val)
    return new_list
endfunction
" }}} 
 
" Assoc - Create a new list based on an existing list and edit one of its ----------- {{{
" values.
"
" l - Existing list
" i - Index of the item that you want to replace
" val - The value that will be used with index i
"
" Returns - A new list that is a copy of the existing list with the new value.
function! Assoc(l, i, val)
    let new_list = deepcopy(a:l)
    let new_list[a:i] = a:val
    return new_list
endfunction
" }}} 
 
" Pop - Create a new list based on an existing list and remove one of its ----------- {{{
" items.
"
" l - Existing list
" i - Index of the item that you want to remove
"
" Returns - A new list that is a copy of the existing list minus the value
function! Pop(l, i)
    let new_list = deepcopy(a:l)
    call remove(new_list, a:i)
    return new_list
endfunction
" }}} 

" Mapped - Apply a function to every item in a list ----------- {{{
"
" fn - The function that you want to apply to every item.
" l - The original list
"
" Returns - A new list that contains the newly altered values.
function! Mapped(fn, l)
    let new_list = deepcopy(a:l)
    call map(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction
" }}} 
