Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62808C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FC0222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbfBNGhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:37:19 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405731AbfBNGhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:37:16 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 2B6C4177AAF109FCAA99;
        Thu, 14 Feb 2019 14:37:14 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.222]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 14:37:12 +0800
From:   "liwei (CM)" <liwei213@huawei.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyIDIvM10gYXJtNjQ6IGR0czogaGlzaWxpY29uOiBo?=
 =?gb2312?Q?i3670:_Add_UFS_controller_support?=
Thread-Topic: [PATCH v2 2/3] arm64: dts: hisilicon: hi3670: Add UFS
 controller support
Thread-Index: AQHUpMhqsIxwTfArFk+ccYDgjfW3NqXfFdiw
Date:   Thu, 14 Feb 2019 06:37:11 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F0672AA14@dggemm526-mbx.china.huawei.com>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.189.155.72]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmluZSB0byBtZS4gVGhhbmtzIQ0KQWNrZWQtYnk6IFdlaSBMaSA8bGl3ZWkyMTNAaHVhd2VpLmNv
bT4NCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSBb
bWFpbHRvOm1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnXSANCreiy83KsbzkOiAyMDE5
xOox1MI1yNUgMTU6MjkNCsrVvP7IyzogdmluaG9saWthdHRpQGdtYWlsLmNvbTsgamVqYkBsaW51
eC52bmV0LmlibS5jb207IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBsaXdlaSAoQ00pOyBy
b2JoK2R0QGtlcm5lbC5vcmcNCrOty806IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBqb2huLnN0dWx0ekBsaW5hcm8ub3Jn
OyBhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc7IGd1b2RvbmcueHVAbGluYXJvLm9yZzsgTWFuaXZh
bm5hbiBTYWRoYXNpdmFtDQrW98ziOiBbUEFUQ0ggdjIgMi8zXSBhcm02NDogZHRzOiBoaXNpbGlj
b246IGhpMzY3MDogQWRkIFVGUyBjb250cm9sbGVyIHN1cHBvcnQNCg0KQWRkIFVGUyBjb250cm9s
bGVyIHN1cHBvcnQgZm9yIEhpU2lsaWNvbiBISTM2NzAgU29DLg0KDQpTaWduZWQtb2ZmLWJ5OiBN
YW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0K
LS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjcwLmR0c2kgfCAxOCArKysr
KysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjcwLmR0c2kgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2hpc2lsaWNvbi9oaTM2NzAuZHRzaQ0KaW5kZXggNmNjZGY1MDQwZmZk
Li4yODUyMTlkZDY1N2YgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2hpc2lsaWNv
bi9oaTM2NzAuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjcw
LmR0c2kNCkBAIC02NTQsNiArNjU0LDI0IEBADQogCQkJY2xvY2stbmFtZXMgPSAiYXBiX3BjbGsi
Ow0KIAkJfTsNCiANCisJCS8qIFVGUyAqLw0KKwkJdWZzOiB1ZnNAZmYzYzAwMDAgew0KKwkJCWNv
bXBhdGlibGUgPSAiaGlzaWxpY29uLGhpMzY3MC11ZnMiLCAiamVkZWMsdWZzLTIuMSI7DQorCQkJ
LyogMDogSENJIHN0YW5kYXJkICovDQorCQkJLyogMTogVUZTIFNZUyBDVFJMICovDQorCQkJcmVn
ID0gPDB4MCAweGZmM2MwMDAwIDB4MCAweDEwMDA+LA0KKwkJCQk8MHgwIDB4ZmYzZTAwMDAgMHgw
IDB4MTAwMD47DQorCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ2ljPjsNCisJCQlpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgMjc4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCWNsb2NrcyA9IDwmY3Jn
X2N0cmwgSEkzNjcwX0NMS19HQVRFX1VGU0lPX1JFRj4sDQorCQkJCTwmY3JnX2N0cmwgSEkzNjcw
X0NMS19HQVRFX1VGU19TVUJTWVM+Ow0KKwkJCWNsb2NrLW5hbWVzID0gInJlZl9jbGsiLCAicGh5
X2NsayI7DQorCQkJZnJlcS10YWJsZS1oeiA9IDwwIDA+LCA8MCAwPjsNCisJCQkvKiBvZmZzZXQ6
IDB4ODQ7IGJpdDogMTIgKi8NCisJCQlyZXNldHMgPSA8JmNyZ19yc3QgMHg4NCAxMj47DQorCQkJ
cmVzZXQtbmFtZXMgPSAicnN0IjsNCisJCX07DQorDQogCQkvKiBTRCAqLw0KIAkJZHdtbWMxOiBk
d21tYzFAZmYzN2YwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAiaGlzaWxpY29uLGhpMzY3MC1kdy1t
c2hjIjsNCi0tIA0KMi4xNy4xDQoNCg==
