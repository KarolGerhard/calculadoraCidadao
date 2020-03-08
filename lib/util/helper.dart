bool isNullEmptyFalseOrZero(Object o) =>
    o == null || false == o || 0 == o || "" == o;

bool isNotNullEmptyFalseOrZero(Object o ) => !isNullEmptyFalseOrZero(o);