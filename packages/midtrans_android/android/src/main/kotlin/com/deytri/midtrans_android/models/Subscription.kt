package com.deytri.midtrans_android.models

data class Subscription(
    val required: Boolean,
    val startTime: String,
    val intervalUnit: String,
)
