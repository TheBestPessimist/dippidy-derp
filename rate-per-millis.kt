package tbp

import java.time.Duration
import java.time.Instant

/**
 * Calculate the rate per millisecond
 */
class RatePerMillis(private val arrayCapacity: Int) {
    private var insertIndex = -1
    private var arraySize = 0

    // used as a circular list
    private val values = Array(arrayCapacity) { _ -> Pair(Instant.now(), 0) }

    fun insertValue(value: Int) {
        synchronized(this) {
            insertIndex = (insertIndex + 1) % arrayCapacity
            arraySize = if (arraySize < arrayCapacity) (arraySize + 1) else arrayCapacity

            values[insertIndex % arrayCapacity] = Pair(Instant.now(), value)
        }
    }

    fun getAverage(): Double {
        synchronized(this) {
            val current = values[insertIndex].first
            val first = values[(insertIndex + arraySize + 1) % arraySize].first
            val delta = Duration.between(first, current).toMillis()
            val sum = values.sumBy { it -> it.second }

            val ratePerMillis = sum / delta.toDouble()
            return ratePerMillis
        }
    }
}
