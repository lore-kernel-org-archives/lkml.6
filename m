Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8385C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AB6218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfAZDjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:39:20 -0500
Received: from mail-oln040092005021.outbound.protection.outlook.com ([40.92.5.21]:25600
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfAZDjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:39:19 -0500
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (10.152.76.51) by BL2NAM02HT120.eop-nam02.prod.protection.outlook.com
 (10.152.76.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 26 Jan
 2019 03:39:17 +0000
Received: from BYAPR02MB5495.namprd02.prod.outlook.com (10.152.76.57) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 26 Jan 2019 03:39:17 +0000
Received: from BYAPR02MB5495.namprd02.prod.outlook.com
 ([fe80::b889:1a99:77fa:d4fe]) by BYAPR02MB5495.namprd02.prod.outlook.com
 ([fe80::b889:1a99:77fa:d4fe%2]) with mapi id 15.20.1558.021; Sat, 26 Jan 2019
 03:39:17 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?utf-8?B?UGF3ZcWCIENobWllbA==?= <pawel.mikolaj.chmiel@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] input: dt-bindings: Add binding for bma150 sensor
Thread-Topic: [PATCH 3/3] input: dt-bindings: Add binding for bma150 sensor
Thread-Index: AQHUtN31Pp2wqt5z3ESXULecqgcK06XAwwUAgAAkqQA=
Date:   Sat, 26 Jan 2019 03:39:17 +0000
Message-ID: <BYAPR02MB54950EDEEE82D5F06C7131CEA3940@BYAPR02MB5495.namprd02.prod.outlook.com>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
 <20190126012802.GD212026@dtor-ws>
In-Reply-To: <20190126012802.GD212026@dtor-ws>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:104:4::24) To BYAPR02MB5495.namprd02.prod.outlook.com
 (2603:10b6:a03:9a::25)
x-incomingtopheadermarker: OriginalChecksum:35BB498FDC0F1D10F3370C7F8EC9BFAAC44C15B3EA2454DDDDDB3533F995896F;UpperCasedChecksum:A93F05DE58BCC614E30A50B260BC4984F229714E8CCF8301E9FAF92983053E89;SizeAsReceived:8962;Count:64
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [T0xTc8VYg35J2dkdW5hjQSfiH9wa8e3j2X+PSTBEfQIwjl/oe/pBSIui6LRFd/AY]
x-microsoft-original-message-id: <cf2b7f7f-872b-c138-9813-cacf05dc101e@live.ca>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2NAM02HT120;6:PuCW2ZY7RNr7sI5HonUFCD9P1V0/ODJhdfB6VSEFqWVw2cxD/2V9kvokJbA+wAUNACVkaZvghZuy8EYPBTMFPja0XEaxfvXbXtMOUBwYe5ifIP/AHirba5bem7o1UKQQckHyj6mjTCxMlDjZxJ/BySjKIR5JuUU4uWSXII5oJK0+Itxq6HXGk2CnZWZaseil5Z4eS/H1ru9qRockt0dH7G+4SNf4xseI8wC1d3ytnZ2IO+ifrbq6OQhSYs9WVoeisFC1NkOtfQhWFqBVO9mwvzNDPnA8o4RlD4V6hBsopxbo4GelPFv5CR0/Xyo7noSsVvEjJI84JybpjTB9tiLWQR+Th6Kq9u+hBMBg3tFXpalkjATzJUsXopQOu/xxmcZB8UQIVH1+Lf7GDlQEGaS0y0sTeUqaSszWg1tFzowKbg6B3HI9EcTVgdjjiSsb2kiCNl0HUhpqsPvNSwWkWHkbgQ==;5:8yHFX+036ByfGdHlUn+QGfF1oS6AEE/jXDOfBDpvy4X+yNDVIHL874gSeozKmsvbfZUBMnO+NBMYHDEGcygu7UFSJn4LIm9aWe8GSEOi4CeIcOp8C6e0T4qVwwdIxPoYJj3y5dpVYOyr+t9a9puNfrusxGKE64NFeZhSLnl10nbQhRCPa/4XP1RlDDF8D/EW4AIUdr+Y+nCYhUdS4YPlCQ==;7:yC+XQopxMPpj18Ye16tdg8zzGKYJo4Clvmf7yQahWvh+muFArX8ppig21pROkuJworZ7oUjUF37f/yQutsaKgceXXC1wBAXuMd3XUtHFwZ7l/lPmj3xvSZFYPc6M4ktelsIED+T8DAKrUQtjz39jxg==
x-incomingheadercount: 64
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:BL2NAM02HT120;
x-ms-traffictypediagnostic: BL2NAM02HT120:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BL2NAM02HT120;BCL:0;PCL:0;RULEID:;SRVR:BL2NAM02HT120;
x-microsoft-antispam-message-info: O0p1nJ/AxfaZ9H61VLRt7KV3CwtjOkA8JJVkvEPvsaZlpMAmo1TTqf841cgrMcRb
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF7D8BCB675CBE438AB653DFCE7CDAA5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9bd8b953-1c55-4da7-b616-8bcad099ae8b
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5c68cd-b1eb-4f97-caf7-08d6833fd8ab
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9bd8b953-1c55-4da7-b616-8bcad099ae8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2019 03:39:15.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMTktMDEtMjUgNToyOCBwLm0uLCBEbWl0cnkgVG9yb2tob3Ygd3JvdGU6DQo+IE9u
IEZyaSwgSmFuIDI1LCAyMDE5IGF0IDA3OjQ0OjAwUE0gKzAxMDAsIFBhd2XFgiBDaG1pZWwgd3Jv
dGU6DQo+PiBGcm9tOiBKb25hdGhhbiBCYWtrZXIgPHhjLXJhY2VyMkBsaXZlLmNhPg0KPj4NCj4+
IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgQm9zY2ggQk1BMTUwIEFjY2VsZXJvbWV0ZXIg
U2Vuc29yDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJA
bGl2ZS5jYT4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWou
Y2htaWVsQGdtYWlsLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9iaW5kaW5ncy9pbnB1dC9ib3NjaCxi
bWExNTAudHh0ICAgICAgICAgICB8IDIwICsrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQvYm9zY2gsYm1hMTUwLnR4dA0KPj4NCj4+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQvYm9z
Y2gsYm1hMTUwLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC9i
b3NjaCxibWExNTAudHh0DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MDAwMDAwLi4yOTBjNjBlMzhjNzANCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC9ib3NjaCxibWExNTAudHh0DQo+PiBAQCAt
MCwwICsxLDIwIEBADQo+PiArKiBCb3NjaCBCTUExNTAgQWNjZWxlcm9tZXRlciBTZW5zb3INCj4+
ICsNCj4+ICtBbHNvIHdvcmtzIGZvciB0aGUgU01CMzgwIGFuZCBCTUEwMjMgYWNjZWxlcm9tZXRl
cnMNCj4+ICsNCj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4gKy0gY29tcGF0aWJsZSA6IFNo
b3VsZCBiZSAiYm9zY2gsYm1hMTUwIg0KPj4gKy0gcmVnIDogVGhlIEkyQyBhZGRyZXNzIG9mIHRo
ZSBzZW5zb3INCj4+ICsNCj4+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4gKy0gaW50ZXJydXB0
LXBhcmVudCA6IHNob3VsZCBiZSB0aGUgcGhhbmRsZSBmb3IgdGhlIGludGVycnVwdCBjb250cm9s
bGVyDQo+PiArLSBpbnRlcnJ1cHRzIDogSW50ZXJydXB0IG1hcHBpbmcgZm9yIElSUS4gIElmIG5v
dCBwcmVzZW50IGRldmljZSB3aWxsIGJlIHBvbGxlZA0KPj4gKw0KPj4gK0V4YW1wbGU6DQo+PiAr
DQo+PiArYm1hMTUwQDM4IHsNCj4+ICsJY29tcGF0aWJsZSA9ICJib3NjaCxibWExNTAiOw0KPj4g
KwlyZWcgPSA8MHgzOD47DQo+PiArCWludGVycnVwdC1wYXJlbnQgPSA8JmdwaDA+Ow0KPj4gKwlp
bnRlcnJ1cHRzID0gPDEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+IA0KPiBIbW0sIGhlcmUgeW91
IHNheSB0aGF0IElSUV9UWVBFX0xFVkVMX0hJR0gsIHNvIGl0IGlzIGxldmVsIGludGVycnVwdHMs
DQo+IGJ1dCB0aGUgZHJpdmVyIG92ZXJyaWRlcyB0byByaXNpbmcgZWRnZSB1bmNvbmRpdGlvbmFs
bHkuIFNpbmNlIHlvdSBhcmUNCj4gdGhlIGZpcnN0IHRvIGFkZCBEVCBzdXBwb3J0IHBsZWFzZSBt
YWtlIHNlcGFyYXRlIHBhdGNoIHRvIGRyaXZlciB0byBkcm9wDQo+IHRoZSBPUlEgdHJpZ2dlciBm
cm9tIHJlcXVlc3RfdGhlcmFkZWRfaXJxKCkgbGVhdmluZyBvbmx5IElSUUZfT05FU0hPVC4NCj4g
DQpUaGlzIHdhcyBzaW1wbHkgYW4gb3ZlcnNpZ2h0IG9uIG15IHBhcnQsIG15IGRldmljZSB3YXMg
dXNpbmcgdGhlIHRoZSBwb2xsZWQgbWV0aG9kIGFzIG9wcG9zZWQgdG8gYW4gaW50ZXJydXB0LiAg
SSdsbCBjb3JyZWN0IHRoaXMgaW4gdjIuDQo+IEFsc28gcGxlYXNlIGNyZWF0ZSBwYXRjaCByZW1v
dmluZyBwbGF0Zm9ybSBkYXRhIHN1cHBvcnQgYXMgbm9vbmUgaXMNCj4gdXNpbmcgaXQgdXBzdHJl
YW0uDQo+IA0KV2lsbCBkby4NCj4gV2hhdCBhYm91dCB0aGUgcmVzdCBvZiBjb25maWcgcGFyYW1l
dGVycyBmcm9tIGJtYTE1MF9jZmc/IFRoZXkgc2hvdWxkIGJlDQo+IGhhbmRsZWQgYXMgZGV2aWNl
IHByb3BlcnRpZXMgdG9vLg0KPiANCk9rLCBJIGNhbiBhZGQgdGhlbSBhcyB3ZWxsLiAgSSBkaWRu
J3QgYm90aGVyIGFzIHRoZSBjb21tZW50IGluIHRoZSBzb3VyY2UgY29kZSBzYXlzIHRoYXQgdGhl
IGRlZmF1bHQgdmFsdWVzIGFyZSB0aGUgb25lcyByZWNvbW1lbmRlZCBieSBCb3NjaC4NCj4gVGhh
bmtzLg0KPiANClRoYW5rcywNCkpvbmF0aGFuDQo=
