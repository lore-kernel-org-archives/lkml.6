Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E80EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C4D208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C4D208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeGKCYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732357AbeGKCYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:23 -0400
Received: from DGGEMA406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 580BAB6916D90;
        Wed, 11 Jul 2018 10:22:24 +0800 (CST)
Received: from DGGEMA525-MBX.china.huawei.com ([169.254.6.69]) by
 DGGEMA406-HUB.china.huawei.com ([10.3.20.47]) with mapi id 14.03.0382.000;
 Wed, 11 Jul 2018 10:22:16 +0800
From:   "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenyao (F)" <chenyao11@huawei.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2NSAxLzFdIFBDSToga2lyaW46IEFk?=
 =?utf-8?Q?d_MSI_support?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjUgMS8xXSBQQ0k6IGtpcmluOiBBZGQgTVNJIHN1?=
 =?utf-8?Q?pport?=
Thread-Index: AQHUDt5H/LVbU24kr06E1Y+CfLvSSaSGL5zQgAH1JYCAATjbwA==
Date:   Wed, 11 Jul 2018 02:22:16 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C5412D7B26@dggema525-mbx.china.huawei.com>
References: <20180628124803.110315-1-songxiaowei@hisilicon.com>
 <20180628124803.110315-2-songxiaowei@hisilicon.com>
 <99B4C6BADD9E3241B25E52B02BA737C5412D2511@dggema525-mbx.china.huawei.com>
 <20180710154017.GA16825@red-moon>
In-Reply-To: <20180710154017.GA16825@red-moon>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.52.233]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IExvcmVuem8gUGllcmFs
aXNpIFttYWlsdG86bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbV0NCj4g5Y+R6YCB5pe26Ze0OiAy
MDE45bm0N+aciDEw5pelIDIzOjQwDQo+IOaUtuS7tuS6ujogU29uZ3hpYW93ZWkgKEtpcmluX0RS
VikgPHNvbmd4aWFvd2VpQGhpc2lsaWNvbi5jb20+DQo+IOaKhOmAgTogYmhlbGdhYXNAZ29vZ2xl
LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBjaGVueWFvIChGKSA8Y2hlbnlhbzExQGh1YXdl
aS5jb20+DQo+IOS4u+mimDogUmU6IOetlOWkjTogW1BBVENIIHY1IDEvMV0gUENJOiBraXJpbjog
QWRkIE1TSSBzdXBwb3J0DQo+IA0KPiBPbiBNb24sIEp1bCAwOSwgMjAxOCBhdCAwMTo1NDowN0FN
ICswMDAwLCBTb25neGlhb3dlaSAoS2lyaW5fRFJWKSB3cm90ZToNCj4gPiBIaSBCam9ybiBIZWxn
YWFzLA0KPiA+DQo+ID4gV291bGQgeW91IGhlbHAgdG8gcmV2aWV3IHRoaXMgcGF0Y2g/DQo+ID4N
Cj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4NCj4gPiBYaWFvd2VpLg0KPiA+DQo+ID4gPiAtLS0tLemC
ruS7tuWOn+S7ti0tLS0tDQo+ID4gPiDlj5Hku7bkuro6IFNvbmd4aWFvd2VpIChLaXJpbl9EUlYp
DQo+ID4gPiDlj5HpgIHml7bpl7Q6IDIwMTjlubQ25pyIMjjml6UgMjA6NDgNCj4gPiA+IOaUtuS7
tuS6ujogV2FuZ2JpbmdodWkgPHdhbmdiaW5naHVpQGhpc2lsaWNvbi5jb20+Ow0KPiBiaGVsZ2Fh
c0Bnb29nbGUuY29tOw0KPiA+ID4gcm9iaCtkdEBrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOw0KPiA+ID4gcm9iaCtsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+
ID4gZGltaXRyeXNoQGdvb2dsZS5jb20NCj4gPiA+IOaKhOmAgTogY2hlbnlhbyAoRikgPGNoZW55
YW8xMUBodWF3ZWkuY29tPjsgU29uZ3hpYW93ZWkgKEtpcmluX0RSVikNCj4gPiA+IDxzb25neGlh
b3dlaUBoaXNpbGljb24uY29tPg0KPiA+ID4g5Li76aKYOiBbUEFUQ0ggdjUgMS8xXSBQQ0k6IGtp
cmluOiBBZGQgTVNJIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBBZGQgc3VwcG9ydCBmb3IgTVNJLg0K
PiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgU29uZyA8c29uZ3hpYW93ZWlAaGlz
aWxpY29uLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvcGNpL2R3Yy9wY2llLWtpcmlu
LmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDI4IGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvZHdjL3BjaWUta2lyaW4uYw0KPiA+ID4gYi9kcml2ZXJzL3BjaS9kd2MvcGNpZS1raXJpbi5j
IGluZGV4IGQyOTcwYTAwOWViNS4uNjk5NzI3NmViNjljDQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvcGNpL2R3Yy9wY2llLWtpcmluLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNp
L2R3Yy9wY2llLWtpcmluLmMNCj4gPiA+IEBAIC00MzAsNiArNDMwLDkgQEAgc3RhdGljIGludCBr
aXJpbl9wY2llX2hvc3RfaW5pdChzdHJ1Y3QgcGNpZV9wb3J0DQo+ID4gPiAqcHApIHsNCj4gPiA+
ICAJa2lyaW5fcGNpZV9lc3RhYmxpc2hfbGluayhwcCk7DQo+ID4gPg0KPiA+ID4gKwlpZiAoSVNf
RU5BQkxFRChDT05GSUdfUENJX01TSSkpDQo+ID4gPiArCQlkd19wY2llX21zaV9pbml0KHBwKTsN
Cj4gPiA+ICsNCj4gPiA+ICAJcmV0dXJuIDA7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IEBAIC00
NDUsOSArNDQ4LDM0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9ob3N0X29wcw0KPiA+
ID4ga2lyaW5fcGNpZV9ob3N0X29wcyA9IHsNCj4gPiA+ICAJLmhvc3RfaW5pdCA9IGtpcmluX3Bj
aWVfaG9zdF9pbml0LCAgfTsNCj4gPiA+DQo+ID4gPiArc3RhdGljIGludCBraXJpbl9wY2llX2Fk
ZF9tc2koc3RydWN0IGR3X3BjaWUgKnBjaSwNCj4gPiA+ICsJCQkJc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gPiA+ICt7DQo+ID4gPiArCWludCByZXQgPSAwOw0KPiA+ID4gKw0KPiA+
ID4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfUENJX01TSSkpIHsNCj4gPiA+ICsJCXJldCA9IHBs
YXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ID4gPiArCQlpZiAocmV0IDwgMCkgew0KPiA+ID4g
KwkJCWRldl9lcnIoJnBkZXYtPmRldiwNCj4gPiA+ICsJCQkJImZhaWxlZCB0byBnZXQgTVNJIElS
USAoJWQpXG4iLCByZXQpOw0KPiA+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gPiArCQl9DQo+ID4g
PiArDQo+ID4gPiArCQlwY2ktPnBwLm1zaV9pcnEgPSByZXQ7DQo+ID4gPiArCX0NCj4gPiA+ICsN
Cj4gPiA+ICsJcmV0dXJuIHJldDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAgc3RhdGljIGlu
dCBfX2luaXQga2lyaW5fYWRkX3BjaWVfcG9ydChzdHJ1Y3QgZHdfcGNpZSAqcGNpLA0KPiA+ID4g
IAkJCQkgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiA+ID4gKwlpbnQg
cmV0Ow0KPiA+ID4gKw0KPiA+ID4gKwlyZXQgPSBraXJpbl9wY2llX2FkZF9tc2kocGNpLCBwZGV2
KTsNCj4gPiA+ICsJaWYgKHJldCkNCj4gPiA+ICsJCXJldHVybiByZXQ7DQo+IA0KPiBJZiBraXJp
bl9wY2llX2FkZF9tc2koKSByZXR1cm5zIGFuIElSUSBudW1iZXIgd2UgcmV0dXJuIGZyb20gdGhp
cyBmdW5jdGlvbg0KPiBoZXJlLCBpcyB0aGF0IHdoYXQgeW91IHJlYWxseSB3YW50ID8NCltzb25n
eGlhb3dlaV0gIFNvcnJ5IGFib3V0IHRoaXMgaXNzdWUsIEknbGwgY2hlY2sgdGhlIHBhdGNoIGNh
cmVmdWxseSBhbmQgdGVzdCBpdCBvbiBIaWtleTk2MCBCb2FyZC4NCgkJCSBUaGFua3MgYSBsb3Qg
Zm9yIHlvdXIgdGltZS4NCg0KQmVzdCByZWdhcmRzLA0KWGlhb3dlaS4NCj4gDQo+IExvcmVuem8N
Cj4gDQo+ID4gPiArDQo+ID4gPiAgCXBjaS0+cHAub3BzID0gJmtpcmluX3BjaWVfaG9zdF9vcHM7
DQo+ID4gPg0KPiA+ID4gIAlyZXR1cm4gZHdfcGNpZV9ob3N0X2luaXQoJnBjaS0+cHApOw0KPiA+
ID4gLS0NCj4gPiA+IDIuMTEuR0lUDQo+ID4NCg==
