Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5060AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D917205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfAQBWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:22:23 -0500
Received: from smtpbg328.qq.com ([14.17.43.160]:53335 "EHLO smtpbg328.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfAQBWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:22:23 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2019 20:22:21 EST
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: j5Y3lWpKjFaXQ3w8AIuavJT2VQtyufaBlDjXRqYCcCNoVmPUD68JzY7LxmWI5
        ZXupOoSnrPLiV2sfmG82clpXq/IKjmr0hscTrd+4Td3+tAKy3CprhHgLQAV/xEO8QKWHhQ3
        3XqU4rD4TVtyTPs/xk3WnB7ng/lQMkFBc1affLkWBD9zLmB5IWfMXH6HIPduaFQhBGrwDgL
        qFvWl+s80e9tHVqnhwpWNTtN8Dj3mlpVNCeVHALSKyAhiXg8ukPxBrveP2m/cnwaadLEqpF
        DRVCV9GHZWJCIeqeJ65+LYhC0=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1547687690t58572
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?VGhvbWFzIEdsZWl4bmVy?=" <tglx@linutronix.de>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?Q2hyaXN0b3BoIEhlbGx3aWc=?=" <hch@lst.de>,
        "=?utf-8?B?TWljaGFlbCBIZXJuYW5kZXo=?=" <michael.hernandez@cavium.com>,
        "=?utf-8?B?SHVhY2FpIENoZW4=?=" <chenhuacai@gmail.com>
Subject: Re: [PATCH] genirq/affinity: Assign default affinity to pre/post vectors
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 17 Jan 2019 09:14:50 +0800
X-Priority: 3
Message-ID: <tencent_0985E6EE28C337614825A2C1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1546225404-6775-1-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.21.1901151959060.1655@nanos.tec.linutronix.de>
        <tencent_7CB943266ADCFDB06DDDE6EF@qq.com>
        <alpine.DEB.2.21.1901161016270.1655@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1901161016270.1655@nanos.tec.linutronix.de>
X-QQ-ReplyHash: 1872063528
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Thu, 17 Jan 2019 09:14:52 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb19
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6ZmI5Y2O5omNDQrmsZ/oi4/kuK3np5HmoqblhbDnlLXlrZDnp5HmioDmnInpmZDlhazlj7gv
6Ieq5Li75a6J5YWo5LqL5Lia6YOoL+i9r+S7tumDqA0K5rGf6IuP5bi454af6Jme5bGx6ZWH
5qKm5YWw5p2RDQogDQogDQogDQotLS0tLS0tLS0tLS0tLS0tLS0gT3JpZ2luYWwgLS0tLS0t
LS0tLS0tLS0tLS0tDQpGcm9tOiAgIlRob21hcyBHbGVpeG5lciI8dGdseEBsaW51dHJvbml4
LmRlPjsNCkRhdGU6ICBXZWQsIEphbiAxNiwgMjAxOSAwNToyNiBQTQ0KVG86ICAi6ZmI5Y2O
5omNIjxjaGVuaGNAbGVtb3RlLmNvbT47DQpDYzogICJsaW51eC1rZXJuZWwiPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyAiRnV4aW4gWmhhbmciPHpoYW5nZnhAbGVtb3RlLmNv
bT47ICJ3dXpoYW5namluIjx3dXpoYW5namluQGdtYWlsLmNvbT47ICJzdGFibGUiPHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmc+OyAiQ2hyaXN0b3BoIEhlbGx3aWciPGhjaEBsc3QuZGU+OyAi
TWljaGFlbCBIZXJuYW5kZXoiPG1pY2hhZWwuaGVybmFuZGV6QGNhdml1bS5jb20+Ow0KU3Vi
amVjdDogIFJlOiBbUEFUQ0hdIGdlbmlycS9hZmZpbml0eTogQXNzaWduIGRlZmF1bHQgYWZm
aW5pdHkgdG8gcHJlL3Bvc3QgdmVjdG9ycw0KIA0KQ2hlbiwNCg0KT24gV2VkLCAxNiBKYW4g
MjAxOSwg6ZmI5Y2O5omNIHdyb3RlOg0KDQo+IHBsZWFzZSBkbyBub3QgdG9wLXBvc3QgYW5k
IHVzZSBsaW5lIGJyZWFrcyBhcm91bmQgNzggY2hhci4NCg0KPiBJJ20gbm90IHJlbW92aW5n
IGFsbCByZXR1cm4gTlVMTCBvZiBpcnFfY3JlYXRlX2FmZmluaXR5X21hc2tzKCksIHNvIHRo
ZSAuLi4uLi4NCg0KPiA+IE1vdmVkIGNvbnRlbnQgdG8gdGhlIHBsYWNlIHdoZXJlIGl0IGJl
bG9uZ3Mgc28gdGhlIGNvbnRleHQgaXMgcHJlc2VydmVkLg0KDQo+IC0tLS0tLS0tLS0tLS0t
LS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gRnJvbTogICJUaG9tYXMgR2xl
aXhuZXIiPHRnbHhAbGludXRyb25peC5kZT47DQo+IERhdGU6ICBXZWQsIEphbiAxNiwgMjAx
OSAwMzoxMCBBTQ0KPiBUbzogICJIdWFjYWkgQ2hlbiI8Y2hlbmhjQGxlbW90ZS5jb20+Ow0K
PiBDYzogICJsaW51eC1rZXJuZWwiPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyAi
RnV4aW4gWmhhbmciPHpoYW5nZnhAbGVtb3RlLmNvbT47ICJ3dXpoYW5namluIjx3dXpoYW5n
amluQGdtYWlsLmNvbT47ICJzdGFibGUiPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+OyAiQ2hy
aXN0b3BoIEhlbGx3aWciPGhjaEBsc3QuZGU+OyAiTWljaGFlbCBIZXJuYW5kZXoiPG1pY2hh
ZWwuaGVybmFuZGV6QGNhdml1bS5jb20+Ow0KPiBTdWJqZWN0OiAgUmU6IFtQQVRDSF0gZ2Vu
aXJxL2FmZmluaXR5OiBBc3NpZ24gZGVmYXVsdCBhZmZpbml0eSB0byBwcmUvcG9zdCB2ZWN0
b3JzDQoNCj4gQW5kIHBsZWFzZSBjb25maWd1cmUgeW91ciBlLW1haWwgY2xpZW50IHRvIE5P
VCBjb3B5IHRoZSBmdWxsIGhlYWRlcnMgaW50bw0KPiB0aGUgcmVwbHkuDQoNCj4gPiA+IE9u
IE1vbiwgMzEgRGVjIDIwMTgsIEh1YWNhaSBDaGVuIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+
IEdlbmVyYWxseSwgaXJxX2NyZWF0ZV9hZmZpbml0eV9tYXNrcygpIGFzc2lnbiBkZWZhdWx0
IGFmZmluaXR5IHRvIHByZS8NCj4gPiA+ID4gcG9zdCB2ZWN0b3JzIGNvcnJlY3RseS4gSG93
ZXZlciwgaXQgaWdub3JlIHRoZSBjYXNlIHRoYXQgdGhlcmUgYXJlIG9ubHkNCj4gPiA+ID4g
cHJlL3Bvc3QgdmVjdG9ycyAod2hlbiBudmVjcyA9PSBhZmZkLT5wcmVfdmVjdG9ycyArIGFm
ZmQtPnBvc3RfdmVjdG9ycykNCj4gPiA+ID4gYW5kIHJldHVybiBOVUxMLiBUaGlzIGNhc2Ug
dXN1YWxseSBoYXBwZW5zIHdoZW4gbnZlY3MgPSAxIChlLmcuIGluIG52bWUNCj4gPiA+ID4g
ZHJpdmVyIHdoZW4gTVNJLVggaXMgdW5hdmFpbGFibGUgYW5kIGZhbGxiYWNrIHRvIE1TSSkg
YW5kIHdpbGwgdHJpZ2dlcg0KPiA+ID4gPiB0aGUgd2FybmluZyBpbiBwY2lfaXJxX2dldF9h
ZmZpbml0eSgpLiBUaGlzIHBhdGNoIGZpeCB0aGUgY29ybmVyIGNhc2UuDQo+ID4gPiANCj4g
PiA+IEVycm0uIFRoaXMgaXMganVzdCB3cm9uZy4gV2hlbiB0aGlzIGZ1bmN0aW9uIHJldHVy
bnMgTlVMTCwgdGhlbiBpdCBoYXMNCj4gPiA+IGZhaWxlZCBhbmQgdGhlIGNhbGxlciBvciBh
bnkgc3Vic2VxdWVudCBjb2RlIGlzIG5vdCBzdXBwb3NlZCB0byB1c2UgdGhlDQo+ID4gPiBy
ZXN1bHQuDQo+ID4gPiANCj4gPiA+IFRoZSBmdW5jdGlvbiBjYW4gcmV0dXJuIE5VTEwgZm9y
IG90aGVyIHJlYXNvbnMsIGUuZy4gd2hlbiB0aGUgbWVtb3J5DQo+ID4gPiBhbGxvY2F0aW9u
IGZhaWxlZC4gSG93IGFyZSB5b3UgZ29pbmcgdG8gZHVjdCB0YXBlIHRoYXQgb25lPw0KPiA+
DQo+ID4gSSdtIG5vdCByZW1vdmluZyBhbGwgcmV0dXJuIE5VTEwgb2YgaXJxX2NyZWF0ZV9h
ZmZpbml0eV9tYXNrcygpLCBzbyB0aGUgDQo+ID4gbWVtb3J5IGFsbG9jYXRpb24gZmFpbHVy
ZSBzdGlsbCByZXR1cm4gTlVMTC4gSSBqdXN0IGhhbmRsZSB0aGUgY2FzZSB0aGF0DQo+ID4g
dGhlcmUgYXJlIG5vdCBlbm91Z2ggaXJxIHZlY3RvcnMuIEUuZy4gaW4gbnZtZSBkcml2ZXIs
IHRoZSBjYWxsZXIgbWF5IGNhbGwNCj4gPiBpcnFfY3JlYXRlX2FmZmluaXR5X21hc2tzKCkg
d2l0aCBudmVjcz0xLHByZV92ZWN0b3JzPTEscG9zdF92ZWN0b3JzPTAuIEluDQo+ID4gdGhp
cyBjYXNlLCB0aGUgb25seSBvbmUgdmVjdG9yJ3MgZGVmYXVsdCBhZmZpbml0eSBhc3NpZ25p
bmcgaXMgc2tpcHBlZC4NCj4gDQo+IEkgZGlkIG5vdCBzYXkgdGhhdCB5b3UgcmVtb3ZlZCBh
bGwgTlVMTCByZXR1cm5zLiBJIHNhaWQgdGhhdCB0aGlzIGZ1bmN0aW9uDQo+IGNhbiByZXR1
cm4gTlVMTCBmb3Igb3RoZXIgcmVhc29ucyBhbmQgdGhlbiB0aGUgc2FtZSBzaXR1YXRpb24g
d2lsbCBoYXBwZW4uDQo+IA0KPiBJZiB0aGUgbWFza3MgcG9pbnRlciByZXR1cm5lZCBpcyBO
VUxMIHRoZW4gdGhlIGNhbGxpbmcgY29kZSBvciBhbnkNCj4gc3Vic2VxdWVudCB1c2FnZSBu
ZWVkcyB0byBoYW5kbGUgaXQgcHJvcGVybHkuIFllcywgSSB1bmRlcnN0YW5kIHRoYXQgdGhp
cw0KPiBjaGFuZ2UgbWFrZXMgdGhlIHdhcm5pbmcgZ28gYXdheSBmb3IgdGhhdCBwYXJ0aWN1
bGFyIGNhc2UsIGJ1dCB0aGF0J3Mgbm90DQo+IG1ha2luZyBpdCBhbnkgbW9yZSBjb3JyZWN0
Lg0KDQpIaSwgVGhvbWFzLA0KDQpJIGRvbid0IHRoaW5rICJudmVjcyA9PSBhZmZkLT5wcmVf
dmVjdG9ycyArIGFmZmQtPnBvc3RfdmVjdG9ycyIgaXMgYW4gRVJST1IsDQpzbyBpdCBzaG91
bGQgYmUgZGlmZmVyZW50IHdpdGggInJldHVybiBOVUxMIGZvciBvdGhlciByZWFzb25zIiB0
byB0aGUgY2FsbGVyLiBJZg0KdGhlIGNhbGxlciBmYWxsYmFjayBmcm9tIE1TSS1YIHRvIE1T
SSwgaXQgaXMgcHJvYmFibHkgIm52ZWNzPTEscHJlX3ZlY3RvcnM9MSwNCnBvc3RfdmVjdG9y
cz0wIi4gVGhlIGNhbGxlciBjYW4gd29yayBwZXJmZWN0bHksIGlmIHByZS9wb3N0IHZlY3Rv
cnMgYXJlIGZpbGxlZA0Kd2l0aCB0aGUgZGVmYXVsdCBhZmZpbml0eS4NCg0KPiBUaGFua3Ms
DQoNCj4gdGdseA==

