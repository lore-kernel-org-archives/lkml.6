Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4BC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4290C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfAaCPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:15:42 -0500
Received: from mx21.baidu.com ([220.181.3.85]:52783 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfAaCPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:15:42 -0500
Received: from M1-MAIL-EX03.internal.baidu.com (unknown [10.44.83.52])
        by Forcepoint Email with ESMTPS id D06A17861FBB8;
        Thu, 31 Jan 2019 10:15:34 +0800 (CST)
Received: from BC-Mail-Ex15.internal.baidu.com (172.31.40.51) by
 M1-MAIL-EX03.internal.baidu.com (10.44.83.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Thu, 31 Jan 2019 10:15:35 +0800
Received: from BC-Mail-Ex13.internal.baidu.com (172.31.40.49) by
 BC-Mail-Ex15.internal.baidu.com (172.31.40.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Thu, 31 Jan 2019 10:15:35 +0800
Received: from BC-Mail-Ex13.internal.baidu.com ([172.31.40.49]) by
 Bc-Mail-Ex13.internal.baidu.com ([172.31.40.49]) with mapi id 15.01.1531.010;
 Thu, 31 Jan 2019 10:15:35 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gkohli@codeaurora.org" <gkohli@codeaurora.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF1bdjRdIHR0eTogZml4IHJhY2UgYmV0?=
 =?utf-8?B?d2VlbiBmbHVzaF90b19sZGlzYyBhbmQgdHR5X29wZW4=?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW3Y0XSB0dHk6IGZpeCByYWNlIGJldHdlZW4gZmx1?=
 =?utf-8?B?c2hfdG9fbGRpc2MgYW5kIHR0eV9vcGVu?=
Thread-Index: AQHUrx28V3uRZzwha06OB03mJmgPUKXHJicAgACqo5D//4bxgIABUlsw
Date:   Thu, 31 Jan 2019 02:15:35 +0000
Message-ID: <b1388c835686492fbbfa91e9711470d4@baidu.com>
References: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
 <20190130101914.GA30587@kroah.com>
 <f13cb07ed77d428b8b43459ff71adcae@baidu.com>
 <20190130131641.GA10795@kroah.com>
In-Reply-To: <20190130131641.GA10795@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.150.64]
x-baidu-bdmsfe-datecheck: 1_BC-Mail-Ex15_2019-01-31 10:15:35:800
x-baidu-bdmsfe-viruscheck: BC-Mail-Ex15_GRAY_Inside_WithoutAtta_2019-01-31
 10:15:35:784
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_M1-MAIL-EX03_2019-01-31 10:15:35:743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEdyZWcgS0ggW21haWx0
bzpncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZ10NCj4g5Y+R6YCB5pe26Ze0OiAyMDE55bm0Meac
iDMw5pelIDIxOjE3DQo+IOaUtuS7tuS6ujogTGksUm9uZ3FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUu
Y29tPg0KPiDmioTpgIE6IGpzbGFieUBzdXNlLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgZ2tvaGxpQGNvZGVhdXJvcmEub3JnOw0KPiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwu
b3JnDQo+IOS4u+mimDogUmU6IOetlOWkjTogW1BBVENIXVt2NF0gdHR5OiBmaXggcmFjZSBiZXR3
ZWVuIGZsdXNoX3RvX2xkaXNjIGFuZCB0dHlfb3Blbg0KPiANCj4gT24gV2VkLCBKYW4gMzAsIDIw
MTkgYXQgMTI6NDg6NDJQTSArMDAwMCwgTGksUm9uZ3Fpbmcgd3JvdGU6DQo+ID4NCj4gPg0KPiA+
ID4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiA+ID4g5Y+R5Lu25Lq6OiBsaW51eC1rZXJuZWwt
b3duZXJAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2
Z2VyLmtlcm5lbC5vcmddIOS7o+ihqCBHcmVnIEtIDQo+ID4gPiDlj5HpgIHml7bpl7Q6IDIwMTnl
ubQx5pyIMzDml6UgMTg6MTkNCj4gPiA+IOaUtuS7tuS6ujogTGksUm9uZ3FpbmcgPGxpcm9uZ3Fp
bmdAYmFpZHUuY29tPg0KPiA+ID4g5oqE6YCBOiBqc2xhYnlAc3VzZS5jb207IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBna29obGlAY29kZWF1cm9yYS5vcmcNCj4gPiA+IOS4
u+mimDogUmU6IFtQQVRDSF1bdjRdIHR0eTogZml4IHJhY2UgYmV0d2VlbiBmbHVzaF90b19sZGlz
YyBhbmQNCj4gPiA+IHR0eV9vcGVuDQo+ID4gPg0KPiA+ID4gT24gRnJpLCBKYW4gMTgsIDIwMTkg
YXQgMDU6Mjc6MTdQTSArMDgwMCwgTGkgUm9uZ1Fpbmcgd3JvdGU6DQo+ID4gPiA+IFRoZXJlIHN0
aWxsIGlzIGEgcmFjZSB3aW5kb3cgYWZ0ZXIgdGhlIGNvbW1pdCBiMDI3ZTIyOThiZDU4OA0KPiA+
ID4gPiAoInR0eTogZml4IGRhdGEgcmFjZSBiZXR3ZWVuIHR0eV9pbml0X2RldiBhbmQgZmx1c2gg
b2YgYnVmIiksIGFuZA0KPiA+ID4gPiB3ZSBlbmNvdW50ZXJlZCB0aGlzIGNyYXNoIGlzc3VlIGlm
IHJlY2VpdmVfYnVmIGNhbGwgY29tZXMgYmVmb3JlDQo+ID4gPiA+IHR0eSBpbml0aWFsaXphdGlv
biBjb21wbGV0ZXMgaW4gbl90dHlfb3BlbiBhbmQNCj4gPiA+ID4gdHR5LT5kcml2ZXJfZGF0YSBt
YXkgYmUgTlVMTC4NCj4gPiA+ID4NCj4gPiA+ID4gQ1BVMCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIENQVTENCj4gPiA+ID4gLS0tLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC0tLS0NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bl90dHlfb3Blbg0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR0
eV9pbml0X2Rldg0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dHR5X2xkaXNjX3VubG9jaw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzY2hlZHVsZSBmbHVzaF90b19sZGlzYw0KPiA+ID4gPiByZWNlaXZlX2J1Zg0KPiA+
ID4gPiAgIHR0eV9wb3J0X2RlZmF1bHRfcmVjZWl2ZV9idWYNCj4gPiA+ID4gICAgdHR5X2xkaXNj
X3JlY2VpdmVfYnVmDQo+ID4gPiA+ICAgICBuX3R0eV9yZWNlaXZlX2J1Zl9jb21tb24NCj4gPiA+
ID4gICAgICAgX19yZWNlaXZlX2J1Zg0KPiA+ID4gPiAgICAgICAgdWFydF9mbHVzaF9jaGFycw0K
PiA+ID4gPiAgICAgICAgIHVhcnRfc3RhcnQNCj4gPiA+ID4gICAgICAgICAvKnR0eS0+ZHJpdmVy
X2RhdGEgaXMgTlVMTCovDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdHR5LT5vcHMtPm9wZW4NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAvKmluaXQgdHR5LT5kcml2ZXJfZGF0YSovDQo+ID4gPiA+DQo+ID4gPiA+IGl0IGNhbiBi
ZSBmaXhlZCBieSBleHRlbmRpbmcgbGRpc2Mgc2VtYXBob3JlIGxvY2sgaW4gdHR5X2luaXRfZGV2
DQo+ID4gPiA+IHRvIGRyaXZlcl9kYXRhIGluaXRpYWxpemVkIGNvbXBsZXRlbHkgYWZ0ZXIgdHR5
LT5vcHMtPm9wZW4oKSwgYnV0DQo+ID4gPiA+IHRoaXMgd2lsbCBsZWFkIHRvIHB1dCBsb2NrIG9u
IG9uZSBmdW5jdGlvbiBhbmQgdW5sb2NrIGluIHNvbWUNCj4gPiA+ID4gb3RoZXIgZnVuY3Rpb24s
IGFuZCBoYXJkIHRvIG1haW50YWluLCBzbyBmaXggdGhpcyByYWNlIG9ubHkgYnkNCj4gPiA+ID4g
Y2hlY2tpbmcNCj4gPiA+ID4gdHR5LT5kcml2ZXJfZGF0YSB3aGVuIHJlY2VpdmluZywgYW5kIHJl
dHVybiBpZiB0dHktPmRyaXZlcl9kYXRhDQo+ID4gPiA+IGlzIE5VTEwNCj4gPiA+ID4NCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogV2FuZyBMaSA8d2FuZ2xpMzlAYmFpZHUuY29tPg0KPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBaaGFuZyBZdSA8emhhbmd5dTMxQGJhaWR1LmNvbT4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gVjQ6IGFkZCB2ZXJzaW9uIGluZm9ybWF0aW9uDQo+ID4gPiA+IFYzOiBub3Qg
dXNlZCBsZGlzYyBzZW1hcGhvcmUgbG9jaywgb25seSBjaGVja2luZyB0dHktPmRyaXZlcl9kYXRh
DQo+ID4gPiA+IHdpdGggTlVMTA0KPiA+ID4gPiBWMjogZml4IGJ1aWxkaW5nIGVycm9yIGJ5IEVY
UE9SVF9TWU1CT0wgdHR5X2xkaXNjX3VubG9jaw0KPiA+ID4gPiBWMTogZXh0ZW5kIGxkaXNjIGxv
Y2sgdG8gcHJvdGVjdCB0aGF0IHR0eS0+ZHJpdmVyX2RhdGEgaXMgaW5pdGVkDQo+ID4gPiA+DQo+
ID4gPiA+IGRyaXZlcnMvdHR5L3R0eV9wb3J0LmMgfCAzICsrKw0KPiA+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvdHR5X3BvcnQuYyBiL2RyaXZlcnMvdHR5L3R0eV9wb3J0LmMgaW5kZXgNCj4gPiA+
ID4gMDQ0YzNjYmRjZmE0Li44NmQwYmVjMzgzMjIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvdHR5L3R0eV9wb3J0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy90dHkvdHR5X3BvcnQuYw0K
PiA+ID4gPiBAQCAtMzEsNiArMzEsOSBAQCBzdGF0aWMgaW50IHR0eV9wb3J0X2RlZmF1bHRfcmVj
ZWl2ZV9idWYoc3RydWN0DQo+ID4gPiA+IHR0eV9wb3J0DQo+ID4gPiAqcG9ydCwNCj4gPiA+ID4g
IAlpZiAoIXR0eSkNCj4gPiA+ID4gIAkJcmV0dXJuIDA7DQo+ID4gPiA+DQo+ID4gPiA+ICsJaWYg
KCF0dHktPmRyaXZlcl9kYXRhKQ0KPiA+ID4gPiArCQlyZXR1cm4gMDsNCj4gPiA+ID4gKw0KPiA+
ID4NCj4gPiA+IEhvdyBpcyB0aGlzIHdvcmtpbmc/ICBXaGF0IGlzIHNldHRpbmcgZHJpdmVyX2Rh
dGEgdG8gTlVMTCB0byAic3RvcCIgdGhpcw0KPiByYWNlPw0KPiA+ID4NCj4gPg0KPiA+DQo+ID4g
aWYgdHR5LT5kcml2ZXJfZGF0YSBpcyBOVUxMIGFuZCByZXR1cm4sICB0dHlfcG9ydF9kZWZhdWx0
X3JlY2VpdmVfYnVmDQo+ID4gd2lsbCBub3Qgc3RlcCB0byB1YXJ0X3N0YXJ0IHdoaWNoIGFjY2Vz
cyB0dHktPmRyaXZlcl9kYXRhIGFuZCB0cmlnZ2VyDQo+ID4gcGFuaWMgYmVmb3JlIHR0eV9vcGVu
LCBzbyBpdCBjYW4gZml4IHRoZSBzeXN0ZW0gcGFuaWMNCj4gPg0KPiA+ID4gVGhlcmUncyBubyBy
ZXF1aXJlbWVudCB0aGF0IGEgdHR5IGRyaXZlciBzZXQgdGhpcyBmaWVsZCB0byBOVUxMIHdoZW4g
aXQgaXMNCj4gImRvbmUiDQo+ID4gPiB3aXRoIHRoZSB0dHkgZGV2aWNlLCBzbyBJIHRoaW5rIHlv
dSBhcmUganVzdCBnZXR0aW5nIGx1Y2t5IGluIHRoYXQNCj4gPiA+IHlvdXIgc3BlY2lmaWMgZHJp
dmVyIGhhcHBlbnMgdG8gYmUgZG9pbmcgdGhpcy4NCj4gPiA+DQo+ID4NCj4gPiB3aGVuIHR0eV9v
cGVuIGlzIHJ1bm5pbmcsIHR0eSBpcyBhbGxvY2F0ZWQgYnkga3phbGxvYyBpbiB0dHlfaW5pdF9k
ZXYNCj4gPiB3aGljaCBjYWxsZWQgYnkgdHR5X29wZW5fYnlfZHJpdmVyLCB0dHkgaXMgaW5pdGVk
IHRvIDANCj4gPg0KPiA+ID4gV2hhdCBkcml2ZXIgYXJlIHlvdSB0ZXN0aW5nIHRoaXMgYWdhaW5z
dD8NCj4gPiA+DQo+ID4NCj4gPiA4MjUwDQo+IA0KPiBPaywgYXMgdGhpcyBpcyBzcGVjaWZpYyB0
byB0aGUgdWFydCBjb3JlLCBob3cgYWJvdXQgdGhpcyBwYXRjaCBpbnN0ZWFkOg0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkv
c2VyaWFsL3NlcmlhbF9jb3JlLmMNCj4gaW5kZXggNWMwMWJiNmQxYzI0Li5iNTZhNjI1MGRmM2Yg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jDQo+ICsrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jDQo+IEBAIC0xMzAsNiArMTMwLDkgQEAg
c3RhdGljIHZvaWQgdWFydF9zdGFydChzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5KQ0KPiAgCXN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQ7DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gDQo+ICsJaWYg
KCFzdGF0ZSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICAJcG9ydCA9IHVhcnRfcG9ydF9sb2NrKHN0
YXRlLCBmbGFncyk7DQo+ICAJX191YXJ0X3N0YXJ0KHR0eSk7DQo+ICAJdWFydF9wb3J0X3VubG9j
ayhwb3J0LCBmbGFncyk7DQoNCg0KSWYgbW92ZSB0aGUgY2hlY2sgaW50byB1YXJ0X3N0YXJ0LCBp
IGFtIGFmcmFpZCB0aGF0IGl0IG1heWJlIG5vdCBmdWxseSBmaXggdGhpcyBpc3N1ZSwNClNpbmNl
IG5fdHR5X3JlY2VpdmVfYnVmX2NvbW1vbiBtYXliZSBjYWxsIG5fdHR5X2NoZWNrX3Rocm90dGxl
LyANCnR0eV91bnRocm90dGxlX3NhZmUgd2hpY2ggbWF5YmUgdXNlIHRoZSB0dHktPmRyaXZlcl9k
YXRhDQoNCmlmIHR0eSBpcyBub3QgZnVsbHkgb3BlbmVkLCBJIHRoaW5rIG5vIGdhaW4gdG8gc3Rl
cCBpbnRvIG1vcmUgZnVuY3Rpb24NCg0KdGhhbmtzDQoNCi1Sb25nUWluZw0K
