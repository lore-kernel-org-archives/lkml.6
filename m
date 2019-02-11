Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC546C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717FB20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="nnSSnQFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfBKKwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:52:33 -0500
Received: from mail-eopbgr00124.outbound.protection.outlook.com ([40.107.0.124]:8096
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfBKKwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef0txBi/UKkrrVMf09ai4PXOV+X30VGLeZMdazOkIWQ=;
 b=nnSSnQFmKYMjeTFrpoTuZJVBzbsiFuyiym2IiVi8V6e6e6FZ5d6ivaXPAFJ7jaq6KbZG14ofDwRyPQ8+ERrlGtRBv6cAq3FkfXX+J06m+MVLeXD52lDp+48Sw+DMUjd71MXk6TrGDkmmHsz7TscV8fM4Z2IkAKeJ7LTYBGXd+uc=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB0862.eurprd02.prod.outlook.com (10.162.14.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.23; Mon, 11 Feb 2019 10:52:28 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 10:52:28 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Thread-Topic: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Thread-Index: AQHUweRFFunq7wteFEm0TQ/ULVV8ZKXaa/aA
Date:   Mon, 11 Feb 2019 10:52:28 +0000
Message-ID: <4aa1aa03-f762-c569-8733-b753ba34577d@axentia.se>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-6-federico.vaga@cern.ch>
In-Reply-To: <20190211083122.32485-6-federico.vaga@cern.ch>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0701CA0059.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::27) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB0862;6:nrYSXay8WrsuidB6hvia7XxIGV1DUlVwnX+j5KQ9srtfSS16fiFfQk75Ql5I7ce5cySk+c8cOEq+8944bTKPTykihfgOF/p1zyommI/QGOj8HfkUaA37BmfOtHl6+JiYDNnk4p4SZVV7mRRqclQgAITVFH8pcbXTGT1lewEtzZ0FpE/MKeIvjoeEkR2Te1bEaxStthkbdUF7MHxRbYg/ESgKPL45tOUvYWKnhgs1qqFCBTHdyST/eFqWr5/axA177a4mjYs0dT2ZmehoGszPM4SPm9/e1ovEL6QrSGkOiTDyknyjU8SxANEY2MelqXOataVKgrKy1yIMq8THpJ4WAKKL3CmD1IQKgYghbCEveX+r0y7chWMLPKTCv05NZWco+qLNOMa8mcvBpY8B79dqi9pB2TliAqtrgIb7XjOJUqhoQmljbk9u+Z7KQDiJj5/Vcq3Pq8RIfzR/aN+T9gCzJg==;5:vgkUAE1mLUQOcjY1tSnmK36Xh7XQif/F3PUQbeTX/tMl1rrH8A5kUbZJoNWXnPPDpHEw7+zdauJOr+e6mDEyvOAqjcjYYR5yE1ibPsxto6blrfxgEj/g4iOuqdtVeTtV+W9cmyiYho/wc4pGHyyNNcVusyqQEVNDqHBUVZa4uR/VHy8I40LbFzMwPwJGrsrELcgTtdH60doIsPS9u8xZ/g==;7:AhTpbrZvwUhNq2/u+Z7xhCg2jAU2CgigdBU1TbHL3Hv6PXPV6LdD+sak+nX5oazeGPnNcP49MUxMUaJvk0jUBxODnQmvOcDdEUphgSuJQCtPPavCYAUiKmDi9/Cybd28O4M1ul8gTdOjP2eihu5VjA==
x-ms-office365-filtering-correlation-id: 37f5d6c9-2ef1-4b0a-a30c-08d6900f0375
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB0862;
x-ms-traffictypediagnostic: VI1PR02MB0862:
x-microsoft-antispam-prvs: <VI1PR02MB0862236B3AB02F3CE3D40E1BBC640@VI1PR02MB0862.eurprd02.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39830400003)(199004)(189003)(102836004)(54906003)(99286004)(52116002)(386003)(53546011)(316002)(58126008)(110136005)(6506007)(14454004)(76176011)(11346002)(446003)(476003)(486006)(2616005)(74482002)(186003)(26005)(36756003)(68736007)(71200400001)(97736004)(71190400001)(65826007)(31686004)(105586002)(305945005)(7736002)(65806001)(6116002)(25786009)(3846002)(86362001)(66066001)(106356001)(4326008)(6512007)(6246003)(8936002)(2906002)(6486002)(31696002)(81166006)(81156014)(8676002)(229853002)(6436002)(508600001)(53936002)(64126003)(65956001)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB0862;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZPTMUsKP6LpI15u5dVFrvcmS3zBTG+PRosS6jd4BrkDOdmqEk7LgWkHm62C7xPgAASZFp1iGZGkmPlXFdk5I5KtSWKwqJfmYK1S3gYvdPPHL1xm7aUoMPXr2Qs0aZ0pEzkksEmagcoiA79aBlszOt6AOqD3uZkpB9Ac78oVDnuxJ2kK7Y/thTTAw5B8CKKOwitMmFflYI638mrNzUfptlfDjmFIrngzT/l83vnzkDeGmaBk48XMQ5WzJDYLWf2rOWpwrh/Mjhcg4lGah4PL0ustQGyLWXq+Du8WYhF1tIrcJjNiXcC03VN9puvs7NDH21UEnPUYh3dhraPeFQpr6MtJwO+g6tDgJeolJNZXXM+uf51bJ9dn6Gl5tA6q/z+FabkjWNh8vRLkKlvgdz9DWJtqWNUhvma9makEwIT1yUVE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43BA1A5162A0B94E8DAD53789F38FBB2@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f5d6c9-2ef1-4b0a-a30c-08d6900f0375
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 10:52:27.0710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB0862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0xMSAwOTozMSwgRmVkZXJpY28gVmFnYSB3cm90ZToNCj4gTWlzY2VsbGFuZW91
cyBzdHlsZSBmaXhlcyBmcm9tIGNoZWNrcGF0Y2gNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZlZGVy
aWNvIFZhZ2EgPGZlZGVyaWNvLnZhZ2FAY2Vybi5jaD4NCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBM
dW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9pMmMvYnVzc2VzL2ky
Yy1vY29yZXMuYyB8IDE5ICsrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtb2NvcmVzLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9jb3Jl
cy5jDQo+IGluZGV4IDViODAxOTAuLmJhMzVkMmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtb2NvcmVzLmMNCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY29y
ZXMuYw0KPiBAQCAtMTgyLDggKzE4Miw5IEBAIHN0YXRpYyB2b2lkIG9jb3Jlc19wcm9jZXNzKHN0
cnVjdCBvY29yZXNfaTJjICppMmMsIHU4IHN0YXQpDQo+ICAJCQlvY19zZXRyZWcoaTJjLCBPQ0ky
Q19DTUQsIE9DSTJDX0NNRF9TVE9QKTsNCj4gIAkJCWdvdG8gb3V0Ow0KPiAgCQl9DQo+IC0JfSBl
bHNlDQo+ICsJfSBlbHNlIHsNCj4gIAkJbXNnLT5idWZbaTJjLT5wb3MrK10gPSBvY19nZXRyZWco
aTJjLCBPQ0kyQ19EQVRBKTsNCj4gKwl9DQo+ICANCj4gIAkvKiBlbmQgb2YgbXNnPyAqLw0KPiAg
CWlmIChpMmMtPnBvcyA9PSBtc2ctPmxlbikgew0KPiBAQCAtMjAyLDkgKzIwMyw5IEBAIHN0YXRp
YyB2b2lkIG9jb3Jlc19wcm9jZXNzKHN0cnVjdCBvY29yZXNfaTJjICppMmMsIHU4IHN0YXQpDQo+
ICAJCQkJb2Nfc2V0cmVnKGkyYywgT0NJMkNfREFUQSwgYWRkcik7DQo+ICAJCQkJb2Nfc2V0cmVn
KGkyYywgT0NJMkNfQ01ELCAgT0NJMkNfQ01EX1NUQVJUKTsNCj4gIAkJCQlnb3RvIG91dDsNCj4g
LQkJCX0gZWxzZQ0KPiAtCQkJCWkyYy0+c3RhdGUgPSAobXNnLT5mbGFncyAmIEkyQ19NX1JEKQ0K
PiAtCQkJCQk/IFNUQVRFX1JFQUQgOiBTVEFURV9XUklURTsNCj4gKwkJCX0NCj4gKwkJCWkyYy0+
c3RhdGUgPSAobXNnLT5mbGFncyAmIEkyQ19NX1JEKQ0KPiArCQkJCT8gU1RBVEVfUkVBRCA6IFNU
QVRFX1dSSVRFOw0KPiAgCQl9IGVsc2Ugew0KPiAgCQkJaTJjLT5zdGF0ZSA9IFNUQVRFX0RPTkU7
DQo+ICAJCQlvY19zZXRyZWcoaTJjLCBPQ0kyQ19DTUQsIE9DSTJDX0NNRF9TVE9QKTsNCj4gQEAg
LTQwNSw3ICs0MDYsOCBAQCBzdGF0aWMgaW50IG9jb3Jlc19pbml0KHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IG9jb3Jlc19pMmMgKmkyYykNCj4gIAl1OCBjdHJsID0gb2NfZ2V0cmVnKGkyYywg
T0NJMkNfQ09OVFJPTCk7DQo+ICANCj4gIAkvKiBtYWtlIHN1cmUgdGhlIGRldmljZSBpcyBkaXNh
YmxlZCAqLw0KPiAtCW9jX3NldHJlZyhpMmMsIE9DSTJDX0NPTlRST0wsIGN0cmwgJiB+KE9DSTJD
X0NUUkxfRU58T0NJMkNfQ1RSTF9JRU4pKTsNCj4gKwljdHJsICY9IH4oT0NJMkNfQ1RSTF9FTiB8
IE9DSTJDX0NUUkxfSUVOKTsNCj4gKwlvY19zZXRyZWcoaTJjLCBPQ0kyQ19DT05UUk9MLCBjdHJs
KTsNCg0KVGhlIHBhdHRlcm4gfihPQ0kyQ19DVFJMX0VOfE9DSTJDX0NUUkxfSUVOKSB3aXRob3V0
IHNwYWNlcyBhcm91bmQgdGhlIHwgZXhpc3RzDQppbiBhIGNvdXBsZSBvZiBvdGhlciBwbGFjZXMg
aW4gdGhlIGRyaXZlciAoYXQgbGVhc3QgdGhlIHZlcnNpb24gSSdtIGxvb2tpbmcgYXQpLg0KWW91
IGNvdWxkIGZpeCBhbGwgaW5zdGFuY2VzIHdoaWxlIGF0IGl0Lg0KDQpDaGVlcnMsDQpQZXRlcg0K
DQo+ICANCj4gIAlwcmVzY2FsZSA9IChpMmMtPmlwX2Nsb2NrX2toeiAvICg1ICogaTJjLT5idXNf
Y2xvY2tfa2h6KSkgLSAxOw0KPiAgCXByZXNjYWxlID0gY2xhbXAocHJlc2NhbGUsIDAsIDB4ZmZm
Zik7DQo+IEBAIC00NjIsMTEgKzQ2NCwxMyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBvY29y
ZXNfaTJjX21hdGNoKTsNCj4gICNpZmRlZiBDT05GSUdfT0YNCj4gIC8qIFJlYWQgYW5kIHdyaXRl
IGZ1bmN0aW9ucyBmb3IgdGhlIEdSTElCIHBvcnQgb2YgdGhlIGNvbnRyb2xsZXIuIFJlZ2lzdGVy
cyBhcmUNCj4gICAqIDMyLWJpdCBiaWcgZW5kaWFuIGFuZCB0aGUgUFJFTE9XIGFuZCBQUkVISUdI
IHJlZ2lzdGVycyBhcmUgbWVyZ2VkIGludG8gb25lDQo+IC0gKiByZWdpc3Rlci4gVGhlIHN1YnNl
cXVlbnQgcmVnaXN0ZXJzIGhhcyB0aGVpciBvZmZzZXQgZGVjcmVhc2VkIGFjY29yZGluZ2x5LiAq
Lw0KPiArICogcmVnaXN0ZXIuIFRoZSBzdWJzZXF1ZW50IHJlZ2lzdGVycyBoYXMgdGhlaXIgb2Zm
c2V0IGRlY3JlYXNlZCBhY2NvcmRpbmdseS4NCj4gKyAqLw0KPiAgc3RhdGljIHU4IG9jX2dldHJl
Z19ncmxpYihzdHJ1Y3Qgb2NvcmVzX2kyYyAqaTJjLCBpbnQgcmVnKQ0KPiAgew0KPiAgCXUzMiBy
ZDsNCj4gIAlpbnQgcnJlZyA9IHJlZzsNCj4gKw0KPiAgCWlmIChyZWcgIT0gT0NJMkNfUFJFTE9X
KQ0KPiAgCQlycmVnLS07DQo+ICAJcmQgPSBpb3JlYWQzMmJlKGkyYy0+YmFzZSArIChycmVnIDw8
IGkyYy0+cmVnX3NoaWZ0KSk7DQo+IEBAIC00ODAsNiArNDg0LDcgQEAgc3RhdGljIHZvaWQgb2Nf
c2V0cmVnX2dybGliKHN0cnVjdCBvY29yZXNfaTJjICppMmMsIGludCByZWcsIHU4IHZhbHVlKQ0K
PiAgew0KPiAgCXUzMiBjdXJyLCB3cjsNCj4gIAlpbnQgcnJlZyA9IHJlZzsNCj4gKw0KPiAgCWlm
IChyZWcgIT0gT0NJMkNfUFJFTE9XKQ0KPiAgCQlycmVnLS07DQo+ICAJaWYgKHJlZyA9PSBPQ0ky
Q19QUkVMT1cgfHwgcmVnID09IE9DSTJDX1BSRUhJR0gpIHsNCj4gQEAgLTU2OCw3ICs1NzMsNyBA
QCBzdGF0aWMgaW50IG9jb3Jlc19pMmNfb2ZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldiwNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gICNlbHNlDQo+IC0jZGVmaW5lIG9jb3Jlc19p
MmNfb2ZfcHJvYmUocGRldixpMmMpIC1FTk9ERVYNCj4gKyNkZWZpbmUgb2NvcmVzX2kyY19vZl9w
cm9iZShwZGV2LCBpMmMpIC1FTk9ERVYNCj4gICNlbmRpZg0KPiAgDQo+ICBzdGF0aWMgaW50IG9j
b3Jlc19pMmNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQoNCg==
