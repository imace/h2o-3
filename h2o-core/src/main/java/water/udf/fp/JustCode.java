package water.udf.fp;

import java.io.Serializable;

/**
 * An abstraction for the entities that don't have any data,
 * so they are equal if they are of the same class.
 * 
 * Comparison is done by comparing canonical class names. This ensures that
 * classes loaded by different classloaders still are comparable.
 */
public abstract class JustCode implements Serializable {
  @Override public int hashCode() {
    return getClass().getCanonicalName().hashCode();
  }

  @Override public boolean equals(Object other) { 
    return other != null && getClass().getCanonicalName().equals(other.getClass().getCanonicalName());
  }
}
