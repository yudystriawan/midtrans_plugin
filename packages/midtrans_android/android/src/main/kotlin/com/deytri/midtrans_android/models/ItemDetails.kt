package com.deytri.midtrans_android.models

data class ItemDetails(
    val id: String?,
    val price: Double,
    val quantity: Int,
    val name: String,
    val brand: String?,
    val category: String?,
    val merchantName: String?,
    val url: String?,
)
