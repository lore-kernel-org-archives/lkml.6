Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC04C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315F620844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315F620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeKGKVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:21:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:49678 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388174AbeKGKVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:21:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 16:53:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,473,1534834800"; 
   d="scan'208";a="87228430"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2018 16:53:31 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.174]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.81]) with mapi id 14.03.0415.000;
 Tue, 6 Nov 2018 16:53:31 -0800
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Joshua Lock <joshua.g.lock@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "Alexander.Levin@microsoft.com" <Alexander.Levin@microsoft.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Thread-Topic: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Thread-Index: AQHUdenxzBU/KTVxKkS71zvOm1NWzqVDcgEAgAAKFBA=
Date:   Wed, 7 Nov 2018 00:53:30 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649C7AF69@ORSMSX101.amr.corp.intel.com>
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
         <20181105204215.hw6vme5epxcc3nch@cantor>
         <20181106160058.5ov7yhzq6mbrg6yn@cantor>
 <6c4576c012fca40a08e6db394b4c3620a2879aa8.camel@linux.intel.com>
In-Reply-To: <6c4576c012fca40a08e6db394b4c3620a2879aa8.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9zaHVhIExvY2sgW21h
aWx0bzpqb3NodWEuZy5sb2NrQGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogVHVlc2RheSwgTm92
ZW1iZXIgNiwgMjAxOCA4OjE1IEFNDQo+IFRvOiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEBy
ZWRoYXQuY29tPjsgU3RlZmFuIEJlcmdlcg0KPiA8c3RlZmFuYkBsaW51eC5pYm0uY29tPjsga2V5
cmluZ3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaW50ZWdyaXR5QHZnZXIua2VybmVsLm9y
Zzsgem9oYXJAbGludXguaWJtLmNvbTsgamVqYkBsaW51eC5pYm0uY29tOw0KPiBBbGV4YW5kZXIu
TGV2aW5AbWljcm9zb2Z0LmNvbTsgam1vcnJpc0BuYW1laS5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IENjOiBSb2JlcnRzLCBXaWxsaWFtIEMgPHdpbGxpYW0uYy5yb2Jl
cnRzQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZG9jczogRXh0ZW5kIHRydXN0
ZWQga2V5cyBkb2N1bWVudGF0aW9uIGZvciBUUE0gMi4wDQo+IA0KPiBPbiBUdWUsIDIwMTgtMTEt
MDYgYXQgMDk6MDAgLTA3MDAsIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6DQo+ID4gT24gTW9uIE5v
diAwNSAxOCwgSmVycnkgU25pdHNlbGFhciB3cm90ZToNCj4gPiA+IE9uIEZyaSBPY3QgMTkgMTgs
IFN0ZWZhbiBCZXJnZXIgd3JvdGU6DQo+ID4gPiA+IEV4dGVuZCB0aGUgZG9jdW1lbnRhdGlvbiBm
b3IgdHJ1c3RlZCBrZXlzIHdpdGggZG9jdW1lbnRhdGlvbiBmb3INCj4gPiA+ID4gaG93IHRvIHNl
dCB1cCBhIGtleSBmb3IgYSBUUE0gMi4wIHNvIGl0IGNhbiBiZSB1c2VkIHdpdGggYSBUUE0gMi4w
DQo+ID4gPiA+IGFzIHdlbGwuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZh
biBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IE1p
bWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAuLi4v
c2VjdXJpdHkva2V5cy90cnVzdGVkLWVuY3J5cHRlZC5yc3QgICAgICAgfCAzMQ0KPiA+ID4gPiAr
KysrKysrKysrKysrKysrKystDQo+ID4gPiA+IDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1lbmNyeXB0ZWQucnN0DQo+ID4gPiA+IGIvRG9j
dW1lbnRhdGlvbi9zZWN1cml0eS9rZXlzL3RydXN0ZWQtZW5jcnlwdGVkLnJzdA0KPiA+ID4gPiBp
bmRleCAzYmIyNGUwOWEzMzIuLjZlYzZiYjJhYzQ5NyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9zZWN1cml0eS9rZXlzL3RydXN0ZWQtZW5jcnlwdGVkLnJzdA0KPiA+ID4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1lbmNyeXB0ZWQucnN0DQo+
ID4gPiA+IEBAIC0xOCwxMCArMTgsMzMgQEAgaW50ZWdyaXR5IHZlcmlmaWNhdGlvbnMgbWF0Y2gu
ICBBIGxvYWRlZA0KPiA+ID4gPiBUcnVzdGVkIEtleSBjYW4gYmUgdXBkYXRlZCB3aXRoIG5ldyB3
aGVuIHRoZSBrZXJuZWwgYW5kIGluaXRyYW1mcw0KPiA+ID4gPiBhcmUgdXBkYXRlZC4gIFRoZSBz
YW1lIGtleSBjYW4gaGF2ZSBtYW55IHNhdmVkIGJsb2JzIHVuZGVyDQo+ID4gPiA+IGRpZmZlcmVu
dCBQQ1IgdmFsdWVzLCBzbyBtdWx0aXBsZSBib290cyBhcmUgZWFzaWx5IHN1cHBvcnRlZC4NCj4g
PiA+ID4NCj4gPiA+ID4gK1RQTSAxLjINCj4gPiA+ID4gKy0tLS0tLS0NCj4gPiA+ID4gKw0KPiA+
ID4gPiBCeSBkZWZhdWx0LCB0cnVzdGVkIGtleXMgYXJlIHNlYWxlZCB1bmRlciB0aGUgU1JLLCB3
aGljaCBoYXMgdGhlDQo+ID4gPiA+IGRlZmF1bHQgYXV0aG9yaXphdGlvbiB2YWx1ZSAoMjAgemVy
b3MpLiAgVGhpcyBjYW4gYmUgc2V0IGF0DQo+ID4gPiA+IHRha2Vvd25lcnNoaXAgdGltZSB3aXRo
IHRoZSB0cm91c2VyJ3MgdXRpbGl0eTogInRwbV90YWtlb3duZXJzaGlwDQo+ID4gPiA+IC11IC16
Ii4NCj4gPiA+ID4NCj4gPiA+ID4gK1RQTSAyLjANCj4gPiA+ID4gKy0tLS0tLS0NCj4gPiA+ID4g
Kw0KPiA+ID4gPiArVGhlIHVzZXIgbXVzdCBmaXJzdCBjcmVhdGUgYSBzdG9yYWdlIGtleSBhbmQg
bWFrZSBpdCBwZXJzaXN0ZW50LA0KPiA+ID4gPiBzbyB0aGUga2V5IGlzDQo+ID4gPiA+ICthdmFp
bGFibGUgYWZ0ZXIgcmVib290LiBUaGlzIGNhbiBiZSBkb25lIHVzaW5nIHRoZSBmb2xsb3dpbmcN
Cj4gPiA+ID4gY29tbWFuZHMuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK1dpdGggdGhlIElCTSBUU1Mg
MiBzdGFjazo6DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgIz4gdHNzY3JlYXRlcHJpbWFyeSAtaGkg
byAtc3QNCj4gPiA+ID4gKyAgSGFuZGxlIDgwMDAwMDAwDQo+ID4gPiA+ICsgICM+IHRzc2V2aWN0
Y29udHJvbCAtaGkgbyAtaG8gODAwMDAwMDAgLWhwIDgxMDAwMDAxDQo+ID4gPiA+ICsNCj4gPiA+
ID4gK09yIHdpdGggdGhlIEludGVsIFRTUyAyIHN0YWNrOjoNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
ICAjPiB0cG0yX2NyZWF0ZXByaW1hcnkgLS1oaWVyYXJjaHkgbyAtRyByc2EyMDQ4IC1vIGtleS5j
dHh0DQo+ID4gPiA+ICsgWy4uLl0NCj4gPiA+ID4gKyAgaGFuZGxlOiAweDgwMDAwMEZGDQo+ID4g
PiA+ICsgICM+IHRwbTJfZXZpY3Rjb250cm9sIC1jIGtleS5jdHh0IC1wIDB4ODEwMDAwMDENCj4g
PiA+ID4gKyAgcGVyc2lzdGVudEhhbmRsZTogMHg4MTAwMDAwMQ0KPiA+ID4gPiArDQo+ID4gPg0K
PiA+ID4gSXMgdGhhdCB0aGUgY29ycmVjdCBvcHRpb24gZm9yIHRwbTJfZXZpY3Rjb250cm9sPyBX
aGF0IEknbSBzZWVpbmcgaW4NCj4gPiA+IHRoZSB2ZXJzaW9ucyBJIGhhdmUgaXMgLVMgb3IgLXBl
cnNpc3RlbnQ9IGZvciBzcGVjaWZ5aW5nIHRoZQ0KPiA+ID4gcGVyc2lzdGVudCBoYW5kbGUuDQo+
ID4gPg0KPiA+ID4gT3RoZXIgdGhhbiB0aGF0IGxvb2tzIGdvb2QgdG8gbWUuDQo+ID4NCj4gPiBX
aWxsaWFtLCBpcyB0aGUgYWJvdmUgY29ycmVjdD8NCj4gDQo+IFdlJ3JlIGNoYW5naW5nIHNvbWUg
b2YgdGhlIG9wdGlvbnMgaW4gbWFzdGVyIGFoZWFkIG9mIG91ciBuZXh0IG1ham9yIHJlbGVhc2Us
DQo+IHRoZSAtcC8tLXBlcnNpc3RlbnQgb3B0aW9uIGlzIGNvcnJlY3QgZm9yIHRoYXQgYnJhbmNo
IGFuZCB0aGUgZXZlbnR1YWwgNC5YIHNlcmllcy4NCg0KTEdUTS4NCg0KQWxzbyBpZiB5b3Ugc3Bl
Y2lmeSAtLWhlbHA9bm8tbWFuIGl0IHdpbGwgZHVtcCBhIHNob3J0IHN1bW1hcnkgdG8gc3Rkb3V0
IChtYXN0ZXIgb25seSkgd2hpY2ggaXMgdXNlZnVsLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBKb3No
dWENCj4gDQo+ID4gPg0KPiA+ID4gPiBVc2FnZTo6DQo+ID4gPiA+DQo+ID4gPiA+ICAgIGtleWN0
bCBhZGQgdHJ1c3RlZCBuYW1lICJuZXcga2V5bGVuIFtvcHRpb25zXSIgcmluZyBAQCAtMzAsNw0K
PiA+ID4gPiArNTMsOSBAQCBVc2FnZTo6DQo+ID4gPiA+ICAgIGtleWN0bCBwcmludCBrZXlpZA0K
PiA+ID4gPg0KPiA+ID4gPiAgICBvcHRpb25zOg0KPiA+ID4gPiAtICAgICAgIGtleWhhbmRsZT0g
ICAgYXNjaWkgaGV4IHZhbHVlIG9mIHNlYWxpbmcga2V5IGRlZmF1bHQNCj4gPiA+ID4gMHg0MDAw
MDAwMCAoU1JLKQ0KPiA+ID4gPiArICAgICAgIGtleWhhbmRsZT0gICAgYXNjaWkgaGV4IHZhbHVl
IG9mIHNlYWxpbmcga2V5DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIFRQTSAxLjI6
IGRlZmF1bHQgMHg0MDAwMDAwMCAoU1JLKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBUUE0gMi4wOiBubyBkZWZhdWx0OyBtdXN0IGJlIHBhc3NlZCBldmVyeQ0KPiA+ID4gPiB0aW1l
DQo+ID4gPiA+ICAgICAgIGtleWF1dGg9CSAgICAgYXNjaWkgaGV4IGF1dGggZm9yIHNlYWxpbmcg
a2V5IGRlZmF1bHQNCj4gPiA+ID4gMHgwMC4uLmkNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAoNDAgYXNjaWkgemVyb3MpDQo+ID4gPiA+ICAgICAgIGJsb2JhdXRoPSAgICAgYXNjaWkgaGV4
IGF1dGggZm9yIHNlYWxlZCBkYXRhIGRlZmF1bHQNCj4gPiA+ID4gMHgwMC4uLg0KPiA+ID4gPiBA
QCAtODQsNiArMTA5LDEwIEBAIEV4YW1wbGVzIG9mIHRydXN0ZWQgYW5kIGVuY3J5cHRlZCBrZXkg
dXNhZ2U6DQo+ID4gPiA+DQo+ID4gPiA+IENyZWF0ZSBhbmQgc2F2ZSBhIHRydXN0ZWQga2V5IG5h
bWVkICJrbWsiIG9mIGxlbmd0aCAzMiBieXRlczo6DQo+ID4gPiA+DQo+ID4gPiA+ICtOb3RlOiBX
aGVuIHVzaW5nIGEgVFBNIDIuMCB3aXRoIGEgcGVyc2lzdGVudCBrZXkgd2l0aCBoYW5kbGUNCj4g
PiA+ID4gMHg4MTAwMDAwMSwNCj4gPiA+ID4gK2FwcGVuZCAna2V5aGFuZGxlPTB4ODEwMDAwMDEn
IHRvIHN0YXRlbWVudHMgYmV0d2VlbiBxdW90ZXMsIHN1Y2gNCj4gPiA+ID4gYXMNCj4gPiA+ID4g
KyJuZXcgMzIga2V5aGFuZGxlPTB4ODEwMDAwMDEiLg0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICQg
a2V5Y3RsIGFkZCB0cnVzdGVkIGttayAibmV3IDMyIiBAdQ0KPiA+ID4gPiAgICA0NDA1MDI4NDgN
Cj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4xNy4yDQo+ID4gPiA+DQoNCg==
