Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B394EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82670218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfAYJWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:22:32 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32843 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfAYJWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:22:32 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 0976B46FACFCFDBABD7C;
        Fri, 25 Jan 2019 09:22:31 +0000 (GMT)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.138]) by
 LHREML711-CAH.china.huawei.com ([10.201.108.34]) with mapi id 14.03.0415.000;
 Fri, 25 Jan 2019 09:22:24 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
Thread-Topic: [PATCH v5 2/4] perf: add arm64 smmuv3 pmu driver
Thread-Index: AQHUiMReCYaliznTZUOBIOWTrrVwNqW7zC+AgAEf2sCAACyzAIAB+g2AgAD1H7A=
Date:   Fri, 25 Jan 2019 09:22:23 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83929A9FE@lhreml524-mbs.china.huawei.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
 <20181130154751.28580-3-shameerali.kolothum.thodi@huawei.com>
 <20190122162351.GE8120@e119886-lin.cambridge.arm.com>
 <5FC3163CFD30C246ABAA99954A238FA83929855B@lhreml524-mbs.china.huawei.com>
 <20190123121406.GH8120@e119886-lin.cambridge.arm.com>
 <f83054eb-3fe3-0041-7a9f-6f7e58cea5c8@arm.com>
In-Reply-To: <f83054eb-3fe3-0041-7a9f-6f7e58cea5c8@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDI0IEphbnVhcnkgMjAxOSAxODoy
NQ0KPiBUbzogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11cnJheUBhcm0uY29tPjsgU2hhbWVlcmFs
aSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29t
Pg0KPiBDYzogbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207
DQo+IHZraWxhcmlAY29kZWF1cm9yYS5vcmc7IG5laWwubS5sZWVkZXJAZ21haWwuY29tOw0KPiBq
ZWFuLXBoaWxpcHBlLmJydWNrZXJAYXJtLmNvbTsgcGFiYmFAY29kZWF1cm9yYS5vcmc7IEpvaG4g
R2FycnkNCj4gPGpvaG4uZ2FycnlAaHVhd2VpLmNvbT47IHdpbGwuZGVhY29uQGFybS5jb207IHJy
dWlncm9rQGNvZGVhdXJvcmEub3JnOw0KPiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnOyBHdW9oYW5qdW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY1IDIvNF0gcGVyZjogYWRkIGFybTY0IHNtbXV2MyBwbXUgZHJpdmVyDQo+IA0KPiBPbiAyMy8w
MS8yMDE5IDEyOjE0LCBBbmRyZXcgTXVycmF5IHdyb3RlOg0KPiBbLi4uXQ0KPiA+Pj4+ICtzdGF0
aWMgaW5saW5lIHZvaWQgc21tdV9wbXVfY291bnRlcl9zZXRfdmFsdWUoc3RydWN0IHNtbXVfcG11
DQo+ID4+PiAqc21tdV9wbXUsDQo+ID4+Pj4gKwkJCQkJICAgICAgdTMyIGlkeCwgdTY0IHZhbHVl
KQ0KPiA+Pj4+ICt7DQo+ID4+Pj4gKwlpZiAoc21tdV9wbXUtPmNvdW50ZXJfbWFzayAmIEJJVCgz
MikpDQo+ID4+Pj4gKwkJd3JpdGVxKHZhbHVlLCBzbW11X3BtdS0+cmVsb2NfYmFzZSArDQo+IFNN
TVVfUE1DR19FVkNOVFIoaWR4LA0KPiA+Pj4gOCkpOw0KPiA+Pj4+ICsJZWxzZQ0KPiA+Pj4+ICsJ
CXdyaXRlbCh2YWx1ZSwgc21tdV9wbXUtPnJlbG9jX2Jhc2UgKw0KPiBTTU1VX1BNQ0dfRVZDTlRS
KGlkeCwNCj4gPj4+IDQpKTsNCj4gPj4+DQo+ID4+PiBUaGUgYXJtNjQgSU8gbWFjcm9zIHVzZSBf
X2ZvcmNlIHUzMiBhbmQgc28gaXQncyBwcm9iYWJseSBPSyB0byBwcm92aWRlIGENCj4gNjQNCj4g
Pj4+IGJpdA0KPiA+Pj4gdmFsdWUgdG8gd3JpdGVsLiBCdXQgeW91IGNvdWxkIHVzZSBzb21ldGhp
bmcgbGlrZSBsb3dlcl8zMl9iaXRzIGZvciBjbGFyaXR5Lg0KPiA+Pg0KPiA+PiBZZXMsIG1hY3Jv
IHVzZXMgX19mb3JjZSB1MzIuIEkgd2lsbCBjaGFuZ2UgaXQgdG8gbWFrZSBpdCBtb3JlIGNsZWFy
IHRob3VnaC4NCj4gDQo+IFRvIGJlIHBlZGFudGljLCB0aGUgZmlyc3QgY2FzdCB3aGljaCB0aGUg
dmFsdWUgYWN0dWFsbHkgdW5kZXJnb2VzIGlzIHRvDQo+IChfX3UzMikgOykNCj4gDQo+IFVsdGlt
YXRlbHksIF9fcmF3X3dyaXRlbCgpIHRha2VzIGEgdTMyLCBzbyBpbiB0aGF0IHNlbnNlIGl0J3Mg
bmV2ZXIgYQ0KPiBwcm9ibGVtIHRvIHBhc3MgYSB1NjQsIHNpbmNlIHVuc2lnbmVkIHRydW5jYXRp
b24gaXMgd2VsbC1kZWZpbmVkIGluIHRoZQ0KPiBDIHN0YW5kYXJkLiBUaGUgY2FzdGluZyBpbnZv
bHZlZCBpbiB0aGUgSS9PIGFjY2Vzc29ycyBpcyBtb3N0bHkgYWJvdXQNCj4gZ29pbmcgdG8gYW4g
ZW5kaWFuLXNwZWNpZmljIHR5cGUgYW5kIGJhY2sgYWdhaW4uDQo+IA0KPiBbLi4uXQ0KPiA+Pj4+
ICtzdGF0aWMgdm9pZCBzbW11X3BtdV9ldmVudF9zdGFydChzdHJ1Y3QgcGVyZl9ldmVudCAqZXZl
bnQsIGludCBmbGFncykNCj4gPj4+PiArew0KPiA+Pj4+ICsJc3RydWN0IHNtbXVfcG11ICpzbW11
X3BtdSA9IHRvX3NtbXVfcG11KGV2ZW50LT5wbXUpOw0KPiA+Pj4+ICsJc3RydWN0IGh3X3BlcmZf
ZXZlbnQgKmh3YyA9ICZldmVudC0+aHc7DQo+ID4+Pj4gKwlpbnQgaWR4ID0gaHdjLT5pZHg7DQo+
ID4+Pj4gKwl1MzIgZmlsdGVyX3NwYW4sIGZpbHRlcl9zaWQ7DQo+ID4+Pj4gKwl1MzIgZXZ0eXBl
cjsNCj4gPj4+PiArDQo+ID4+Pj4gKwlod2MtPnN0YXRlID0gMDsNCj4gPj4+PiArDQo+ID4+Pj4g
KwlzbW11X3BtdV9zZXRfcGVyaW9kKHNtbXVfcG11LCBod2MpOw0KPiA+Pj4+ICsNCj4gPj4+PiAr
CXNtbXVfcG11X2dldF9ldmVudF9maWx0ZXIoZXZlbnQsICZmaWx0ZXJfc3BhbiwgJmZpbHRlcl9z
aWQpOw0KPiA+Pj4+ICsNCj4gPj4+PiArCWV2dHlwZXIgPSBnZXRfZXZlbnQoZXZlbnQpIHwNCj4g
Pj4+PiArCQkgIGZpbHRlcl9zcGFuIDw8IFNNTVVfUE1DR19TSURfU1BBTl9TSElGVDsNCj4gPj4+
PiArDQo+ID4+Pj4gKwlzbW11X3BtdV9zZXRfZXZ0eXBlcihzbW11X3BtdSwgaWR4LCBldnR5cGVy
KTsNCj4gPj4+PiArCXNtbXVfcG11X3NldF9zbXIoc21tdV9wbXUsIGlkeCwgZmlsdGVyX3NpZCk7
DQo+ID4+Pj4gKwlzbW11X3BtdV9pbnRlcnJ1cHRfZW5hYmxlKHNtbXVfcG11LCBpZHgpOw0KPiA+
Pj4+ICsJc21tdV9wbXVfY291bnRlcl9lbmFibGUoc21tdV9wbXUsIGlkeCk7DQo+ID4+Pj4gK30N
Cj4gPj4+PiArDQo+ID4+Pj4gK3N0YXRpYyB2b2lkIHNtbXVfcG11X2V2ZW50X3N0b3Aoc3RydWN0
IHBlcmZfZXZlbnQgKmV2ZW50LCBpbnQgZmxhZ3MpDQo+ID4+Pj4gK3sNCj4gPj4+PiArCXN0cnVj
dCBzbW11X3BtdSAqc21tdV9wbXUgPSB0b19zbW11X3BtdShldmVudC0+cG11KTsNCj4gPj4+PiAr
CXN0cnVjdCBod19wZXJmX2V2ZW50ICpod2MgPSAmZXZlbnQtPmh3Ow0KPiA+Pj4+ICsJaW50IGlk
eCA9IGh3Yy0+aWR4Ow0KPiA+Pj4+ICsNCj4gPj4+PiArCWlmIChod2MtPnN0YXRlICYgUEVSRl9I
RVNfU1RPUFBFRCkNCj4gPj4+PiArCQlyZXR1cm47DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJc21tdV9w
bXVfY291bnRlcl9kaXNhYmxlKHNtbXVfcG11LCBpZHgpOw0KPiA+Pj4NCj4gPj4+IElzIGl0IGlu
dGVudGlvbmFsIG5vdCB0byBjYWxsIHNtbXVfcG11X2ludGVycnVwdF9kaXNhYmxlIGhlcmU/DQo+
ID4+DQo+ID4+IFllcywgaXQgaXMuIEVhcmxpZXIgcGF0Y2ggaGFkIHRoZSBpbnRlcnJ1cHQgdG9n
Z2xpbmcgYW5kIFJvYmluIHBvaW50ZWQgb3V0IHRoYXQNCj4gPj4gaXQgaXMgbm90IHJlYWxseSBu
ZWVkZWQgYXMgY291bnRlcnMgYXJlIGFueXdheSBzdG9wcGVkIGFuZCBleHBsaWNpdGx5DQo+IGRp
c2FibGluZw0KPiA+PiBtYXkgbm90IHNvbHZlIHRoZSBzcHVyaW91cyBpbnRlcnJ1cHQgY2FzZSBh
cyB3ZWxsLg0KPiA+Pg0KPiA+DQo+ID4gQWggYXBvbG9naWVzIGZvciBub3Qgc2VlaW5nIHRoYXQg
aW4gZWFybGllciByZXZpZXdzLg0KPiANCj4gSG1tLCBJIGRpZG4ndCBleGFjdGx5IG1lYW4gImtl
ZXAgZW5hYmxpbmcgaXQgZXZlcnkgdGltZSBhbiBldmVudCBpcw0KPiByZXN0YXJ0ZWQgYW5kIG5l
dmVyIGRpc2FibGUgaXQgYW55d2hlcmUiLCB0aG91Z2guIEkgd2FzIHRoaW5raW5nIG1vcmUNCj4g
YWxvbmcgdGhlIGxpbmVzIG9mIGVuYWJsaW5nIGluIGV2ZW50X2FkZCgpIGFuZCBkaXNhYmxpbmcg
aW4gZXZlbnRfZGVsKCkNCj4gKGkuZS4gZWZmZWN0aXZlbHkgdHlpbmcgaXQgdG8gYWxsb2NhdGlv
biBhbmQgZGVhbGxvY2F0aW9uIG9mIHRoZSBjb3VudGVyKS4NCj4gDQoNClJpZ2h0LiBJIG1pc3Nl
ZCB0aGUgcG9pbnQgdGhhdCBpdCB3YXMgbm90IGRpc2FibGVkIGF0IGFsbCEuIEkgd2lsbCByZWFy
cmFuZ2UgaXQgDQp0byBfYWRkL19kZWwgcGF0aC4gDQoNClRoYW5rcyBmb3IgYWxsIHRoZSBjb21t
ZW50cy4gSSBhbSBwbGFubmluZyB0byBzZW5kIG91dCBhIHY2IHNvb24uIA0KQmV0d2VlbiwgZGlk
IHlvdSBnZXQgYSBjaGFuY2UgdG8gdGFrZSBhIGxvb2sgYXQgcGF0Y2ggIzQgKEhpU2lsaWNvbiBl
cnJhdHVtIG9uZSkgPyANCkFwcHJlY2lhdGUgaWYgeW91IGNvdWxkIHRha2UgYSBsb29rIGFuZCBs
ZXQgbWUga25vdyBiZWZvcmUgdjYuDQoNClRoYW5rcywNClNoYW1lZXINCg0KIA0K
