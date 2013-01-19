library AIDS uses UnitIndexer
    function GetIndexUnit takes integer id returns unit
        return GetUnitById(id)
    endfunction
    
    // A delegate struct is needed because a lot of scripts have the
    //textmacro at the top of the struct.
    private struct Dummy extends array
        static method AIDS_filter takes unit u returns boolean
            return true
        endmethod
        static method AIDS_onInit takes nothing returns nothing
        endmethod
        method AIDS_onCreate takes nothing returns nothing
        endmethod
        method AIDS_onDestroy takes nothing returns nothing
        endmethod
    endstruct
    
    module AIDS
        private static delegate Dummy d = 0
        
        method AIDS_addLock takes nothing returns nothing
            call UnitIndex(this).lock()
        endmethod
        
        method AIDS_removeLock takes nothing returns nothing
            call UnitIndex(this).unlock()
        endmethod
        
        private static method filter takes unit u returns boolean
            return thistype.AIDS_filter(u)
        endmethod
        
        private method index takes nothing returns nothing
            call this.AIDS_onCreate()
        endmethod
        
        private method deindex takes nothing returns nothing
            call this.AIDS_onDestroy()
        endmethod
        
        implement UnitIndexStruct
    endmodule
    
    //! textmacro AIDS
        private static method onInit takes nothing returns nothing
            call thistype.AIDS_onInit()
        endmethod
        
        implement AIDS
    //! endtextmacro

    //! textmacro AIDSZinc
        static method onInit () {
            thistype.AIDS_onInit();
        }
        
        module AIDS;
    //! endtextmacro
endlibrary