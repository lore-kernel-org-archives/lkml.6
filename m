Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 06XoJSkSGlu6WAAAmS7hNA
	; Fri, 08 Jun 2018 05:20:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7FAE3607A4; Fri,  8 Jun 2018 05:20:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vDUWVlkO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CDA3F601C3;
	Fri,  8 Jun 2018 05:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDA3F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeFHFUh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:20:37 -0400
Received: from mail-co1nam03on0064.outbound.protection.outlook.com ([104.47.40.64]:60288
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750883AbeFHFUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoGtrCCsmRuXtaVx0tE/zEPUdZY7U677gakJ6M0CxVs=;
 b=vDUWVlkOZkBgM651G3BOz3DrhJcjS/xG12lo7MFFDtZ+ysBTcKpeO8bNc6ieJLQUtQ0KdBRgyHmPez/RBXVydLBuUvClGkFsvecZsUOKfuwWpanTLNMftjY9h6rGdxktMySlOgMTpXWwKU2tBSDcvcAYHYTH5V9757U7s2YWAkg=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2640.namprd02.prod.outlook.com (10.168.206.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Fri, 8 Jun 2018 05:20:33 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::e826:8d65:9e76:6426]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::e826:8d65:9e76:6426%9]) with mapi id 15.20.0841.015; Fri, 8 Jun 2018
 05:20:33 +0000
From: Naga Sureshkumar Relli <nagasure@xilinx.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "wmw2@infradead.org" <wmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: RE: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Thread-Topic: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Thread-Index: AQHT/Wsmg8T3cSZFT0KMk8mIo2wW0KRU8VOAgADS3DA=
Date: Fri, 8 Jun 2018 05:20:33 +0000
Message-ID: <MWHPR02MB2623AA49F71D3D24B997C682AF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180607174203.035f187d@xps13>
In-Reply-To: <20180607174203.035f187d@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2640;7:kbX9eKyrtw9bc/M3OrVpGxuFGXY4fHcw0ETBYR/xa+ruQiusaAxm9ftUeV3PNruKGKRdQWsO7Kk2kbjabpfjH4bimgzw3fTARvTDObtcYRsImBWH+yy1yr8ccmuRgK1Uloc5nbDmSTSGgPAbQZcedVOsiVRK+jzaHIZSIvLPclUaRJkbQTeS9zZzAzKrZ3s9+tE3xKzyfp27YDSE+yD6RcK6JIZiebq3YlL6WG/fyJZemmtfgbOWY+bzpHlYzP8M
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2640;
x-ms-traffictypediagnostic: MWHPR02MB2640:
x-microsoft-antispam-prvs: <MWHPR02MB264001A0B8ABC5F4609C1666AF7B0@MWHPR02MB2640.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2640;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(54534003)(13464003)(199004)(51914003)(189003)(8936002)(5250100002)(2900100001)(6436002)(478600001)(6116002)(66066001)(7736002)(5660300001)(68736007)(3846002)(8676002)(54906003)(476003)(39060400002)(486006)(25786009)(55016002)(14454004)(81156014)(81166006)(74316002)(316002)(86362001)(4326008)(7696005)(97736004)(76176011)(2906002)(6246003)(3660700001)(6506007)(99286004)(55236004)(102836004)(7416002)(229853002)(106356001)(59450400001)(6916009)(105586002)(11346002)(53936002)(9686003)(26005)(446003)(186003)(305945005)(3280700002)(53546011)(33656002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2640;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3+Dz7AN1yY6l7eHLqUjWc2ix5ZLw0H0tWTyN17bxYwAiSmXhBrFR1+ZZ9i/zaEq5w0s9nGEu3CP8IZ6EwiJ2NGNt5H3OS0C92MGxp/8ebBZkaP9GajJlv9lz18JrMD3Q5ArQ3iNbsslJPda4kGFz3keAmJmeufc99iuY2ntLUXBrWkvqkQ8CR+z1rDvUxpBT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5b5ed0ba-263b-4781-7c38-08d5ccff8f68
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5ed0ba-263b-4781-7c38-08d5ccff8f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 05:20:33.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCBbbWFpbHRvOm1pcXVlbC5yYXluYWxA
Ym9vdGxpbi5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDcsIDIwMTggOToxMiBQTQ0KPiBU
bzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IGJv
cmlzLmJyZXppbGxvbkBib290bGluLmNvbTsgcmljaGFyZEBub2QuYXQ7IHdtdzJAaW5mcmFkZWFk
Lm9yZzsNCj4gY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOyBtYXJlay52YXN1dEBnbWFpbC5j
b207IGYuZmFpbmVsbGlAZ21haWwuY29tOw0KPiBtbWF5ZXJAYnJvYWRjb20uY29tOyByb2dlcnFA
dGkuY29tOyBsYWRpc0BsaW51eC1taXBzLm9yZzsgYWRhQHRob3JzaXMuY29tOw0KPiBob25naHVp
LnpoYW5nQG1lZGlhdGVrLmNvbTsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5hZ2FzdXJlc2hrdW1hcnJlbGxpQGdtYWlsLmNv
bQ0KPiBTdWJqZWN0OiBSZTogW0xJTlVYIFBBVENIIHY5IDEvNF0gRGV2aWNldHJlZTogQWRkIHBs
MzUzIHNtYyBjb250cm9sbGVyIGRldmljZXRyZWUNCj4gYmluZGluZyBpbmZvcm1hdGlvbg0KPiAN
Cj4gSGkgTmFnYSwNCj4gDQo+IE9uIFdlZCwgNiBKdW4gMjAxOCAxMzoxOTozOSArMDUzMCwgTmFn
YSBTdXJlc2hrdW1hciBSZWxsaQ0KPiA8bmFnYS5zdXJlc2hrdW1hci5yZWxsaUB4aWxpbnguY29t
PiB3cm90ZToNCj4gDQo+ID4gQWRkIHBsMzUzIHN0YXRpYyBtZW1vcnkgY29udHJvbGxlciBkZXZp
Y2V0cmVlIGJpbmRpbmcgaW5mb3JtYXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYWdh
IFN1cmVzaGt1bWFyIFJlbGxpDQo+ID4gPG5hZ2Euc3VyZXNoa3VtYXIucmVsbGlAeGlsaW54LmNv
bT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHY5Og0KPiA+ICAtIEFkZHJlc3NlZCBjb21tZW5z
IGdpdmVuIGJ5IFJhbmR5IER1bmxhcCBhbmQgTWlxdWVsIFJheW5hbA0KPiANCj4gQ2FuIHlvdSBw
bGVhc2UgYmUgbW9yZSBzcGVjaWZpYyBpbiB5b3VyIG5leHQgY2hhbmdlbG9nPyBJIGRvbid0IHJl
bWVtYmVyIHdoYXQgSSBzdWdnZXN0ZWQgYQ0KPiBmZXcgbW9udGhzIGFnbyA6KQ0KT2ssIEkgd2ls
bCB1cGRhdGUuDQoNCj4gDQo+ID4gQ2hhbmdlcyBpbiB2ODoNCj4gPiAgLSBOb25lDQo+ID4gQ2hh
bmdlcyBpbiB2NzoNCj4gPiAtIENvcnJlY3RlZCBjbG9ja3MgZGVzY3JpcHRpb24NCj4gPiAtIHBy
ZWZpeGVkICcjJyBmb3IgYWRkcmVzcyBhbmQgc2l6ZSBjZWxscyBDaGFuZ2VzIGluIHY2Og0KPiA+
ICAtIE5vbmUNCj4gPiBDaGFuZ2VzIGluIHY1Og0KPiA+ICAtIFJlbW92ZWQgdGltaW5nIHByb3Bl
cnRpZXMNCj4gPiBDaGFuZ2VzIGluIHY0Og0KPiA+ICAtIG5vbmUNCj4gPiBDaGFuZ2VzIGluIHYz
Og0KPiA+ICAtIG5vbmUNCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+ICAtIG1vZGlmaWVkIHRpbWlu
ZyBiaW5kaW5nIGluZm8gYXMgcGVyIG9uZmkgdGltaW5nIHBhcmFtZXRlcnMNCj4gPiAgLSBhZGQg
c3VmZml4IG5hbm8gc2Vjb25kIGFzIHRpbWluZyB1bml0DQo+ID4gIC0gbW9kaWZpZWQgdGhlIGNs
b2NrIG5hbWVzIGFzIHBlciB0aGUgSVAgc3BlYw0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mv
bWVtb3J5LWNvbnRyb2xsZXJzL3BsMzUzLXNtYy50eHQgICAgICB8IDUzDQo+ICsrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lbW9yeS1jb250cm9sbGVycy9wbDM1My1zbWMudHh0DQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+
ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJz
L3BsMzUzLXNtYy50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
ZW1vcnktY29udHJvbGxlcnMvcGwzNTMtc21jLnR4dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMC4uNTUxZTY2Yg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL3Bs
MzUzLXNtYy50DQo+ID4gKysrIHh0DQo+ID4gQEAgLTAsMCArMSw1MyBAQA0KPiA+ICtEZXZpY2Ug
dHJlZSBiaW5kaW5ncyBmb3IgQVJNIFBMMzUzIHN0YXRpYyBtZW1vcnkgY29udHJvbGxlcg0KPiA+
ICsNCj4gPiArUEwzNTMgc3RhdGljIG1lbW9yeSBjb250cm9sbGVyIHN1cHBvcnRzIHR3byBraW5k
cyBvZiBtZW1vcnkNCj4gPiAraW50ZXJmYWNlcy5pLmUgTkFORCBhbmQgU1JBTS9OT1IgaW50ZXJm
YWNlcy4NCj4gPiArVGhlIGFjdHVhbCBkZXZpY2VzIGFyZSBpbnN0YW50aWF0ZWQgZnJvbSB0aGUg
Y2hpbGQgbm9kZXMgb2YgcGwzNTMgc21jIG5vZGUuDQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KPiA+ICstIGNvbXBhdGlibGUJCTogU2hvdWxkIGJlICJhcm0scGwzNTMtc21jLXIy
cDEiDQo+IA0KPiBJIHRoaW5nIFJvYiBwcmVmZXJzOg0KPiANCj4gLSBjb21wYXRpYmxlOiBNdXN0
IGJlIG9uZSBvZjoNCj4gICAqIGFybSwgcGwzNTMtc21jLXIycDENCkFyZSB5b3Ugc3VnZ2VzdGlu
ZyBhbnkgb3RoZXIgY29tcGF0aWJsZXM/DQpPciBqdXN0IGEgY2hhbmdlIGZyb20gInNob3VsZCBi
ZSB0byBNdXN0IGJlIG9uZSBvZiI/DQo+IA0KPiA+ICstIHJlZwkJCTogQ29udHJvbGxlciByZWdp
c3RlcnMgbWFwIGFuZCBsZW5ndGguDQo+ID4gKy0gY2xvY2stbmFtZXMJCTogTGlzdCBvZiBpbnB1
dCBjbG9jayBuYW1lcyAtICJyZWZfY2xrIiwgImFwZXJfY2xrIg0KPiA+ICsJCQkgIChTZWUgY2xv
Y2sgYmluZGluZ3MgZm9yIGRldGFpbHMpLg0KPiA+ICstIGNsb2NrcwkJOiBDbG9jayBwaGFuZGxl
cyAoc2VlIGNsb2NrIGJpbmRpbmdzIGZvciBkZXRhaWxzKS4NCj4gPiArLSBhZGRyZXNzLWNlbGxz
CQk6IEFkZHJlc3MgY2VsbHMsIG11c3QgYmUgMS4NCj4gPiArLSBzaXplLWNlbGxzCQk6IFNpemUg
Y2VsbHMuIE11c3QgYmUgMS4NCj4gDQo+IFBsZWFzZSBhdm9pZCBwYWRkaW5nLCBqdXN0IHRoaXMg
aXMgZW5vdWdoOg0KPiANCj4gLSBzb21ldGhpbmc6IEFuZCBhbm90aGVyIHRoaW5nLg0KT2ssIEkg
d2lsbCB1cGRhdGUgaXQuDQoNCj4gDQo+ID4gKw0KPiA+ICtDaGlsZCBub2RlczoNCj4gPiArIEZv
ciBOQU5EIHRoZSAiYXJtLHBsMzUzLW5hbmQtcjJwMSIgYW5kIGZvciBOT1IgdGhlICJjZmktZmxh
c2giDQo+ID4gK2RyaXZlcnMgYXJlIHN1cHBvcnRlZCBhcyBjaGlsZCBub2Rlcy4NCj4gPiArDQo+
ID4gK01hbmRhdG9yeSB0aW1pbmcgcHJvcGVydGllcyBmb3IgY2hpbGQgbm9kZXM6DQo+ID4gKy0g
YXJtLG5hbmQtY3ljbGUtdDAJOiBSZWFkIGN5Y2xlIHRpbWUodF9yYykuDQo+ID4gKy0gYXJtLG5h
bmQtY3ljbGUtdDEJOiBXcml0ZSBjeWNsZSB0aW1lKHRfd2MpLg0KPiA+ICstIGFybSxuYW5kLWN5
Y2xlLXQyCTogcmVfbiBhc3NlcnRpb24gZGVsYXkodF9yZWEpLg0KPiA+ICstIGFybSxuYW5kLWN5
Y2xlLXQzCTogd2VfbiBkZS1hc3NlcnRpb24gZGVsYXkodF93cCkuDQo+ID4gKy0gYXJtLG5hbmQt
Y3ljbGUtdDQJOiBTdGF0dXMgcmVhZCB0aW1lKHRfY2xyKQ0KPiA+ICstIGFybSxuYW5kLWN5Y2xl
LXQ1CTogSUQgcmVhZCB0aW1lKHRfYXIpDQo+ID4gKy0gYXJtLG5hbmQtY3ljbGUtdDYJOiBidXN5
IHRvIHJlX24odF9ycikNCj4gDQo+IEkgdGhpbmsgdGhpcyBoYXMgbm90aGluZyB0byBkbyBpbiB0
aGUgRFQsIHlvdSBzaG91bGQgaGFuZGxlIHRpbWluZ3MgZnJvbSB0aGUgLQ0KPiA+c2V0dXBfZGF0
YV9pbnRlcmZhY2UoKSBob29rLiBJZiB5b3UgbmVlZCwgeW91IG1heSB1c2UgZGlmZmVyZW50IGNv
bXBhdGlibGVzIHRvIGRpc3Rpbmd1aXNoDQo+IGRpZmZlcmVudCBwbGF0Zm9ybSBkYXRhLg0KPiAN
ClRoaXMgY29udHJvbGxlciBpcyBhcHBsaWNhYmxlIG9ubHkgdG8gWnlucSBwbGF0Zm9ybS4gTm8g
b3RoZXIgcGxhdGZvcm0gd2lsbCB1c2UgdGhpcy4NCkJhc2ljYWxseSBwbDM1My1zbWMuYyBhbmQg
cGwzNTMtbmFuZC5jLCBib3RoIGFyZSBkaWZmZXJlbnQgZHJpdmVycy4NCkFuZCB0aGlzIGRhdGFf
aW50ZXJmYWNlIGhvb2sgaXMgaW4gbmFuZCwgYW5kIHRvIHNldCB0aGlzIHRpbWluZ3MgaWYgd2Ug
cmVhZCBpdCBmcm9tIHNldHVwX2RhdGFfaW50ZXJmYWNlKCksIHRoZW4NCldlIG5lZWQgdG8gbWFr
ZSBjYWxsIGZyb20gbmFuZCB0byBzbWMgZHJpdmVyLg0KTGV0IG1lIHRyeSB0aGlzLg0KDQo+ID4g
Kw0KPiA+ICtmb3IgbmFuZCBwYXJ0aXRpb24gaW5mb3JtYXRpb24gcGxlYXNlIHJlZmVyIHRoZSBi
ZWxvdyBmaWxlDQo+IA0KPiBzL25hbmQvTkFORC8NCkkgd2lsbCB1cGRhdGUgaW4gbmV4dCB2ZXJz
aW9uLg0KDQo+IA0KPiA+ICtEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3Bh
cnRpdGlvbi50eHQNCj4gPiArDQo+ID4gK0V4YW1wbGU6DQo+ID4gKwlwbDM1M3NtY2NfMDogcGwz
NTNzbWNjQGUwMDBlMDAwIHsNCj4gDQo+IFdoeSBub3Qgc29tZXRoaW5nIG1vcmUgZXhwbGljaXQg
d2l0aCB0aGUgJy1mbGFzaC1jb250cm9sbGVyJyBzdWZmaXg/DQpJcyB0aGlzIG9rPw0Kc21jYzog
bWVtb3J5LWNvbnRyb2xsZXJAZTAwMGUwMDAge30NCg0KPiANCj4gPiArCQkJY29tcGF0aWJsZSA9
ICJhcm0scGwzNTMtc21jLXIycDEiDQo+ID4gKwkJCWNsb2NrLW5hbWVzID0gIm1lbWNsayIsICJh
Y2xrIjsNCj4gPiArCQkJY2xvY2tzID0gPCZjbGtjIDExPiwgPCZjbGtjIDQ0PjsNCj4gPiArCQkJ
cmVnID0gPDB4ZTAwMGUwMDAgMHgxMDAwPjsNCj4gPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ID4gKwkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsJCQlyYW5nZXM7DQo+ID4gKwkJCW5h
bmRfMDogbmFuZEBlMTAwMDAwMCB7DQo+ID4gKwkJCQljb21wYXRpYmxlID0gImFybSxwbDM1My1u
YW5kLXIycDEiDQo+IA0KPiBOQU5EIGNoaXBzIGRvIG5vdCBoYXZlIHRoZWlyIG93biBjb21wYXRp
YmxlLg0KQXMgSSBzYWlkIGFib3ZlLCBTTUNDIGNvbnRyb2xsZXIgaGFzIHR3byBpbnRlcmZhY2Uo
TkFORCwgTk9SL1NSQU0pLg0KU28gdG8gZGlmZmVyZW50aWF0ZSB3aGljaCBpbnRlcmZhY2UgaXMg
c2VsZWN0ZWQsIHdlIGFkZGVkIHRoZSBjb21wYXRpYmxlLg0KVGhlIGR0cyBub2RlIGxvb2tzIGJl
bG93Lg0Kc21jYzogbWVtb3J5LWNvbnRyb2xsZXJAZTAwMGUwMDAgew0KCQkJI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQoJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCgkJCWNsb2NrLW5hbWVzID0gIm1lbWNs
ayIsICJhY2xrIjsNCgkJCWNsb2NrcyA9IDwmY2xrYyAxMT4sIDwmY2xrYyA0ND47DQoJCQljb21w
YXRpYmxlID0gImFybSxwbDM1My1zbWMtcjJwMSI7DQoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZp
bnRjPjsNCgkJCWludGVycnVwdHMgPSA8MCAxOCA0PjsNCgkJCXJhbmdlcyA7DQoJCQlyZWcgPSA8
MHhlMDAwZTAwMCAweDEwMDA+Ow0KCQkJbmFuZDA6IGZsYXNoQGUxMDAwMDAwIHsNCgkJCQljb21w
YXRpYmxlID0gImFybSxwbDM1My1uYW5kLXIycDEiOw0KCQkJCXJlZyA9IDwweGUxMDAwMDAwIDB4
MTAwMDAwMD47DQoJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MHgxPjsNCgkJCQkjc2l6ZS1jZWxscyA9
IDwweDE+Ow0KCQkJfTsNCgkJCW5vcjA6IGZsYXNoQGUyMDAwMDAwIHsNCgkJCQljb21wYXRpYmxl
ID0gImNmaS1mbGFzaCI7DQoJCQkJcmVnID0gPDB4ZTIwMDAwMDAgMHgyMDAwMDAwPjsNCgkJCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCgkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCgkJCX07DQoJCX07
DQo+IA0KPiA+ICsJCQkJcmVnID0gPDB4ZTEwMDAwMDAgMHgxMDAwMDAwPjsNCj4gPiArCQkJCWFy
bSxuYW5kLWN5Y2xlLXQwID0gPDB4ND47DQo+ID4gKwkJCQlhcm0sbmFuZC1jeWNsZS10MSA9IDww
eDQ+Ow0KPiA+ICsJCQkJYXJtLG5hbmQtY3ljbGUtdDIgPSA8MHgxPjsNCj4gPiArCQkJCWFybSxu
YW5kLWN5Y2xlLXQzID0gPDB4Mj47DQo+ID4gKwkJCQlhcm0sbmFuZC1jeWNsZS10NCA9IDwweDI+
Ow0KPiA+ICsJCQkJYXJtLG5hbmQtY3ljbGUtdDUgPSA8MHgyPjsNCj4gPiArCQkJCWFybSxuYW5k
LWN5Y2xlLXQ2ID0gPDB4ND47DQo+ID4gKwkJCQkoLi4uKQ0KPiA+ICsJCQl9Ow0KPiA+ICsJfTsN
Cj4gDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwNCg0KVGhhbmtzLA0KTmFnYSBTdXJlc2hrdW1h
ciBSZWxsaS4NCg==
