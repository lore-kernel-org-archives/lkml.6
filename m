Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E7AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA255222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405504AbfBNGhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:37:09 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2449 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbfBNGhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:37:08 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 0D362C2A907407CEBDDB;
        Thu, 14 Feb 2019 14:37:06 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.222]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 14:37:01 +0800
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
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyIDEvM10gZHQtYmluZGluZ3M6IHVmczogQWRkIEhJ?=
 =?gb2312?Q?3670_UFS_controller_binding?=
Thread-Topic: [PATCH v2 1/3] dt-bindings: ufs: Add HI3670 UFS controller
 binding
Thread-Index: AQHUpMhoq7jaJXW3zkuiBj2fd4Xl5qXfFZPw
Date:   Thu, 14 Feb 2019 06:37:01 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F0672AA0D@dggemm526-mbx.china.huawei.com>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
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
bm5hbiBTYWRoYXNpdmFtDQrW98ziOiBbUEFUQ0ggdjIgMS8zXSBkdC1iaW5kaW5nczogdWZzOiBB
ZGQgSEkzNjcwIFVGUyBjb250cm9sbGVyIGJpbmRpbmcNCg0KQWRkIGRldmljZXRyZWUgYmluZGlu
ZyBmb3IgSEkzNjcwIFVGUyBjb250cm9sbGVyLiBISTM3NjAgU29DIGlzIHZlcnkNCnNpbWlsYXIg
dG8gSEkzNjYwIFNvQyB3aXRoIGFsbW9zdCBzYW1lIElQcy4gT25seSBtYWpvciBkaWZmZXJlbmNl
IGluIHRlcm1zDQpvZiBVRlMgaXMgdGhlIFBIWS4gSEkzNjcwIGhhcyAxMG5tIFBIWS4gQnV0IHNp
bmNlIHRoZSBvcmlnaW5hbCBkcml2ZXINCihISTM2NjAgVUZTKSBjYW5ub3QgbWFrZSBISTM2NzAg
VUZTIGZ1bmN0aW9uYWwsIGEgc2VwYXJhdGUgY29tcGF0aWJsZQ0KaXMgYWRkZWQgZm9yIEhJMzY3
MCB3aXRob3V0IGFueSBmYWxsYmFjay4NCg0KU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCi0tLQ0KIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91ZnMvdWZzLWhpc2kudHh0IHwgNSArKystLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdWZzL3Vmcy1oaXNpLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91ZnMvdWZzLWhpc2kudHh0DQppbmRl
eCBhNDhjNDQ4MTczNjcuLjBiODNkZjFhNTQxOCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91ZnMvdWZzLWhpc2kudHh0DQorKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdWZzL3Vmcy1oaXNpLnR4dA0KQEAgLTYsOSArNiwxMCBAQCBF
YWNoIFVGUyBIb3N0IENvbnRyb2xsZXIgc2hvdWxkIGhhdmUgaXRzIG93biBub2RlLg0KIFJlcXVp
cmVkIHByb3BlcnRpZXM6DQogLSBjb21wYXRpYmxlICAgICAgICA6IGNvbXBhdGlibGUgbGlzdCwg
Y29udGFpbnMgb25lIG9mIHRoZSBmb2xsb3dpbmcgLQ0KIAkJCQkJImhpc2lsaWNvbixoaTM2NjAt
dWZzIiwgImplZGVjLHVmcy0xLjEiIGZvciBoaXNpIHVmcw0KLQkJCQkJaG9zdCBjb250cm9sbGVy
IHByZXNlbnQgb24gSGkzNnh4IGNoaXBzZXQuDQorCQkJCQlob3N0IGNvbnRyb2xsZXIgcHJlc2Vu
dCBvbiBIaTM2NjAgY2hpcHNldC4NCisJCQkJCSJoaXNpbGljb24saGkzNjcwLXVmcyIsICJqZWRl
Yyx1ZnMtMi4xIiBmb3IgaGlzaSB1ZnMNCisJCQkJCWhvc3QgY29udHJvbGxlciBwcmVzZW50IG9u
IEhpMzY3MCBjaGlwc2V0Lg0KIC0gcmVnICAgICAgICAgICAgICAgOiBzaG91bGQgY29udGFpbiBV
RlMgcmVnaXN0ZXIgYWRkcmVzcyBzcGFjZSAmIFVGUyBTWVMgQ1RSTCByZWdpc3RlciBhZGRyZXNz
LA0KLS0gaW50ZXJydXB0LXBhcmVudCAgOiBpbnRlcnJ1cHQgZGV2aWNlDQogLSBpbnRlcnJ1cHRz
ICAgICAgICA6IGludGVycnVwdCBudW1iZXINCiAtIGNsb2NrcwkgICAgICAgIDogTGlzdCBvZiBw
aGFuZGxlIGFuZCBjbG9jayBzcGVjaWZpZXIgcGFpcnMNCiAtIGNsb2NrLW5hbWVzICAgICAgIDog
TGlzdCBvZiBjbG9jayBpbnB1dCBuYW1lIHN0cmluZ3Mgc29ydGVkIGluIHRoZSBzYW1lDQotLSAN
CjIuMTcuMQ0KDQo=
