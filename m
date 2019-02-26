Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E2AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0710217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ieMYlrOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfBZPIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:08:00 -0500
Received: from mail-eopbgr760078.outbound.protection.outlook.com ([40.107.76.78]:11744
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbfBZPH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFW8s/1ZNaTTCK7ZgKOUwEmGsQiDNlieYQtM8PqAnTc=;
 b=ieMYlrOK7t78ghGeWlEqElLsKPXZ//WYlWsUc334hYQsh8oUq2gwp8TONesz1PT+cDCfW3c6CVXpZfj6nLUnnAO4ahMkcBZYQC3IQON2qWeUzu36YTVItr+aLl1ThJSjv7mYaPySBIFAeDUSF9r1KyDHvifomqzbBdhWz8NtKfM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2733.namprd12.prod.outlook.com (52.135.107.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 15:07:55 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 15:07:55 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] EDAC/amd64: Add Fam17hMod30h PCI IDs
Thread-Topic: [PATCH 1/5] EDAC/amd64: Add Fam17hMod30h PCI IDs
Thread-Index: AQHUyJFO2kTGZslcCUS37hwB/bq0XaXx7oaAgABKS+A=
Date:   Tue, 26 Feb 2019 15:07:55 +0000
Message-ID: <SN6PR12MB2639332D774863EEF8946CCDF87B0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
 <20190226104129.GA14836@zn.tnic>
In-Reply-To: <20190226104129.GA14836@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec41f4ce-ba57-4f27-03c0-08d69bfc2fc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2733;
x-ms-traffictypediagnostic: SN6PR12MB2733:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2733;20:D4V3CxxEVu4VZBEBIYptIuzozkERvdNJrFJrG9/CP9ki8rgRENuOHgDRcqYnPtBat8P13Bx55qyBayeMZmskg7qfiXk83r0RTwXr65uqDkFUNExI1F4yeUzv45q78AV9zly9pPKhiRbQMxcIY1QH3zU1b+eb3/uohB1N7wrkirKWxdSbzAT45eJv1fminaWPKwN9mpZPurFqrxDwo1pcTPsRowbBtUZCWeAFf0asKdvLoa2n8DyZXF3mwk+DiDXW
x-microsoft-antispam-prvs: <SN6PR12MB2733033B101758F06D394A11F87B0@SN6PR12MB2733.namprd12.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(13464003)(68736007)(106356001)(7696005)(25786009)(478600001)(97736004)(316002)(105586002)(6246003)(8936002)(99286004)(6436002)(54906003)(446003)(76176011)(11346002)(5660300002)(486006)(476003)(6916009)(52536013)(72206003)(66066001)(71200400001)(71190400001)(8676002)(305945005)(9686003)(229853002)(55016002)(81166006)(81156014)(53546011)(3846002)(7736002)(26005)(6506007)(186003)(14454004)(86362001)(33656002)(256004)(14444005)(2906002)(74316002)(53936002)(6116002)(102836004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2733;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UcYAWEeKIibu3VJsRSQKXWcqWmlwTPRT2pLtSNlEsaj7IaC3lDBf7DqIHz/wrC5VSNPlSprxTNS56fQhlo+mPFab3kR13G0q8Tu2P9FVhroqAgr70eRq7HPF1iJ7m6b4npAVNYQK8KARwH2V8cuNpK3TSAPgF6bkNB1WcEV3V3hp1MNHk5R+/S6gs6RLTqLiCadqksJv0laycTqcalVFet978V1pmAw/eZlv/zyhc45dzgKndcsH6RATEjlrHjMZDLbdHUDYLn2fxGWaiuH/FyaM+TA5HpBT3GwIdy24mh2gvFmvBMg49as9hsuaP5TQDY4WEJQ+VQxJumIyVoB3vNSNSkmR8EJ3rej8ljRusHptE/OqpWpTaBwi5b5k70FPgbHC6IpvzAaT4gC7uLuDo+F942DQ7vv5qtMbEoYkYjQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec41f4ce-ba57-4f27-03c0-08d69bfc2fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 15:07:55.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjYsIDIwMTkg
NDo0MSBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4g
Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS81XSBFREFDL2FtZDY0OiBBZGQgRmFtMTdoTW9k
MzBoIFBDSSBJRHMNCj4gDQo+IEp1c3Qgbml0cGlja3M6DQo+IA0KPiBPbiBUdWUsIEZlYiAxOSwg
MjAxOSBhdCAwODoyNTo1MVBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gDQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzVdIEVEQUMvYW1kNjQ6IEFkZCBGYW0xN2hNb2QzMGggUENJ
IElEcw0KPiANCj4gV3JpdGUgdGhhdCAiRmFtMTdoTW9kMzBoIiBpbiBhIGh1bWFuIHJlYWRhYmxl
IGZvcm0gcGxzLiBFc3BlY2lhbGx5IGluDQo+IHRoZSBzdWJqZWN0OiAiZmFtaWx5IDB4MTcsIG1v
ZGVscyAweDMwLi4uIg0KPiANCg0KV2lsbCBkby4NCg0KPiA+IEZyb206IFlhemVuIEdoYW5uYW0g
PHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4gPg0KPiA+IEFkZCB0aGUgbmV3IEZhbWlseSAxN2gg
TW9kZWwgMzBoIFBDSSBJRHMgdG8gdGhlIEFNRDY0IEVEQUMgbW9kdWxlLg0KPiA+DQo+ID4gVGhp
cyBhbHNvIGZpeGVzIGEgcHJvYmUgZmFpbHVyZSB0aGF0IGFwcGVhcmVkIHdoZW4gc29tZSBvdGhl
ciBQQ0kgSURzDQo+ID4gZm9yIEZhbTE3aE1vZDMwaCB3ZXJlIGFkZGVkIHRvIHRoZSBBTUQgTkIg
Y29kZS4NCj4gPg0KPiA+IEZpeGVzOiBiZTM1MThhMTZlZjIgKHg4Ni9hbWRfbmI6IEFkZCBQQ0kg
ZGV2aWNlIElEcyBmb3IgZmFtaWx5IDE3aCwgbW9kZWwgMzBoKQ0KPiA+IFNpZ25lZC1vZmYtYnk6
IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9lZGFjL2FtZDY0X2VkYWMuYyB8IDE1ICsrKysrKysrKysrKysrLQ0KPiA+ICBkcml2ZXJz
L2VkYWMvYW1kNjRfZWRhYy5oIHwgIDMgKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZWRhYy9hbWQ2NF9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQo+ID4gaW5kZXgg
NmVhOTg1NzVhNDAyLi45OTQ3NDM3ZDk1NzQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFj
L2FtZDY0X2VkYWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCj4gPiBA
QCAtMjIxMSw2ICsyMjExLDE1IEBAIHN0YXRpYyBzdHJ1Y3QgYW1kNjRfZmFtaWx5X3R5cGUgZmFt
aWx5X3R5cGVzW10gPSB7DQo+ID4gIAkJCS5kYmFtX3RvX2NzCQk9IGYxN19iYXNlX2FkZHJfdG9f
Y3Nfc2l6ZSwNCj4gPiAgCQl9DQo+ID4gIAl9LA0KPiA+ICsJW0YxN19NMzBIX0NQVVNdID0gew0K
PiA+ICsJCS5jdGxfbmFtZSA9ICJGMTdoX00zMGgiLA0KPiA+ICsJCS5mMF9pZCA9IFBDSV9ERVZJ
Q0VfSURfQU1EXzE3SF9NMzBIX0RGX0YwLA0KPiA+ICsJCS5mNl9pZCA9IFBDSV9ERVZJQ0VfSURf
QU1EXzE3SF9NMzBIX0RGX0Y2LA0KPiA+ICsJCS5vcHMgPSB7DQo+ID4gKwkJCS5lYXJseV9jaGFu
bmVsX2NvdW50CT0gZjE3X2Vhcmx5X2NoYW5uZWxfY291bnQsDQo+ID4gKwkJCS5kYmFtX3RvX2Nz
CQk9IGYxN19iYXNlX2FkZHJfdG9fY3Nfc2l6ZSwNCj4gPiArCQl9DQo+ID4gKwl9LA0KPiA+ICB9
Ow0KPiA+DQo+ID4gIC8qDQo+ID4gQEAgLTMxOTksNyArMzIwOCwxMSBAQCBzdGF0aWMgc3RydWN0
IGFtZDY0X2ZhbWlseV90eXBlICpwZXJfZmFtaWx5X2luaXQoc3RydWN0IGFtZDY0X3B2dCAqcHZ0
KQ0KPiA+ICAJCWJyZWFrOw0KPiA+DQo+ID4gIAljYXNlIDB4MTc6DQo+ID4gLQkJaWYgKHB2dC0+
bW9kZWwgPj0gMHgxMCAmJiBwdnQtPm1vZGVsIDw9IDB4MmYpIHsNCj4gPiArCQlpZiAocHZ0LT5t
b2RlbCA+PSAweDMwICYmIHB2dC0+bW9kZWwgPD0gMHgzZikgew0KPiA+ICsJCQlmYW1fdHlwZSA9
ICZmYW1pbHlfdHlwZXNbRjE3X00zMEhfQ1BVU107DQo+ID4gKwkJCXB2dC0+b3BzID0gJmZhbWls
eV90eXBlc1tGMTdfTTMwSF9DUFVTXS5vcHM7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0gZWxz
ZSBpZiAocHZ0LT5tb2RlbCA+PSAweDEwICYmIHB2dC0+bW9kZWwgPD0gMHgyZikgew0KPiANCj4g
U29ydCB0aGUgY2hlY2tzIGluIGluY3JlYXNpbmcgbW9kZWxzIHNvIHRoYXQgaXQgaXMgZWFzaWVy
IHRvIGZvbGxvdy4NCj4gDQoNCk9rYXksIHdpbGwgZG8uDQoNClRoYW5rcywNCllhemVuDQo=
