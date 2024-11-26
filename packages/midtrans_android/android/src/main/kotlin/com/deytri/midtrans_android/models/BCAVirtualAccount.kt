package com.deytri.midtrans_android.models

data class BCAVirtualAccount(
    val vaNumber: String?,
    val subCompanyCode: String?,
    val freeText: FreeText?,
)


data class FreeText(
    val inquiry: List<FreeTextItem>?,
    val payment: List<FreeTextItem>?,
)

data class FreeTextItem(
    val en: String,
    val id: String,
)