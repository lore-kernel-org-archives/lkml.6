Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E20C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E1720823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dz4jWR3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfBHRRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:17:06 -0500
Received: from mail-eopbgr30104.outbound.protection.outlook.com ([40.107.3.104]:15675
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbfBHRRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4T8hASYBqrwrpYUTp1PkLOZ3+nitrNWIUrtVKluhEw=;
 b=dz4jWR3T/mi7BizwOY6MHy1KXYIJxVMWXR8EWjqxu4Cpt8+9ss/I7mLUJyN82WtX+AqZEycc4euG2ONWhJjIq/s4k8BUBlX/vBTVLKNw0oBm8EEECbImYoq1o8ghNxyczl9mynjQ6o32NlZmPYCboQkEcuAlnq5hPW7HmpQwzOg=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4943.eurprd02.prod.outlook.com (20.177.200.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 17:17:00 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 17:17:00 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] i2c:ocores: add SPDX tag
Thread-Topic: [PATCH v3 4/5] i2c:ocores: add SPDX tag
Thread-Index: AQHUv8klEzm21JdfA0iov9KxV4XLoaXWJJwA
Date:   Fri, 8 Feb 2019 17:16:59 +0000
Message-ID: <789738e8-609a-f20b-11c2-54089366f612@axentia.se>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
 <20190208161201.7860-5-federico.vaga@cern.ch>
In-Reply-To: <20190208161201.7860-5-federico.vaga@cern.ch>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0902CA0057.eurprd09.prod.outlook.com
 (2603:10a6:7:15::46) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4943;6:qJjrOHLrGC/ar4S5oUU0TXL8E5c6J0ip8gxYEH2J6MriZkz1dxtNss0pBzvlqrliGBc47zM/MxwsyqrTNkUqC5ozdPpuS4l85TSkHyJTePoKPp+dKvLM9oe8KzjaXJ5Pkb6X04db8SNB5kw79WolDGtsWdTN66UO5ZzVyGswQFekoEdWLJnyLwsjYinUW0EwSp5YcnicjbYP+lshO6T1bgmVNpp4oZ4BdvFqhDd5Eoc5iLWZaDkBzupKK3sSV7fPHumSFEhy5hGYW6bbBjW639IRp3eK2Sm+XSt26tmog+1cHpvHN/PHJHSuEm8jlW6ie6Q5Wf0SIJ/gs7SMor18I7l9nnEnelMIWGUbkyn9uqpatmHo8nGmXwzddxQWU8y9soXcmvDUt0MgvnAjtShpEmQ5k9Z+tSeaNBXyC3l7Hy8zoGaRqKYJliOZYgpa7kj1UAJRxBQntkXD6qel3paZLA==;5:xJjSg55Bayz+5S8k3oPt2dNMPQ1f1HV76bGPQQOXJJnEghj0TRbi1MGxwkXCOliKTi1yMfZHfClk6FWcMKjIvOGUM7riQb9yQxYpBV72+X9VilXrCr79wtet/2N34f+kFwNOhGaiOzieg2o6cARXo0dIQJ1SaHd08regn0yEvL1GfG61iviRqURzJ7lx68/5xCoroAKq2arEHMSa0+wpwQ==;7:Geolyqqjixk34VBsP22JSRS+5fSQeFu7D71GnlAs0lX2cOLF7ObmDLn5p+LqCZSxxgfokM9fQguX3qQbZg7pfUmoBcjPG5WIzLn7WMP2Ei2YQDx2SajqH/Ue3hxjvcW9DjaMV4rsi1UJtOLuDHruzA==
x-ms-office365-filtering-correlation-id: d1b3c30e-9a30-48f0-0a4d-08d68de93b96
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4943;
x-ms-traffictypediagnostic: VI1PR02MB4943:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR02MB494368643BE7FDE7164BB8D8BC690@VI1PR02MB4943.eurprd02.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39830400003)(136003)(366004)(346002)(189003)(199004)(31686004)(81156014)(14454004)(486006)(186003)(6246003)(508600001)(53936002)(64126003)(97736004)(2616005)(65826007)(68736007)(52116002)(81166006)(74482002)(8936002)(256004)(476003)(8676002)(106356001)(386003)(26005)(105586002)(76176011)(102836004)(53546011)(6346003)(6506007)(11346002)(446003)(305945005)(54906003)(31696002)(316002)(7736002)(2906002)(86362001)(6436002)(65806001)(66066001)(58126008)(229853002)(6486002)(65956001)(99286004)(3846002)(6116002)(36756003)(4326008)(25786009)(71200400001)(71190400001)(6512007)(6306002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4943;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0oucR4mt6P+1QceKbhBdmhYAB68t2Nz+nxoxpRbodvJbO52Bp2LWc16yGsyb6ZoVhViyXD8pNyi/uPxaeUNFTsxsvDYN350AsVk/5XVMD+rstQeUFzo53ISbI4V8BPw8AH44qf9PBpcw/5DdFg6J5dBs/m98k8/2S9+W3qRjImoVqsbXjAZF/bp62VNTS9qfAuNAdAwemkkgSvcELKGTvrkxigXO5b5qv6X7039lsDtwHYs0J61uZ8x3HKH2z+7eOmUv3oktA9MxeDrDxlhGwaDk2jhehI4UM8lAISQXwFh78btCeRKcoGEFMIvIslVSOBQTNzLImDN1SP4exKc8t8JWSuv0AfgAHu/5qb8wqVWkw4CnSU+iGNXSDS96CZIL2PIGIImIpF5rEuS4wRrJwX7e9EX8qdKWywvjN9RW49A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE6712A6B1B87549B15C790ECF9C3DB6@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b3c30e-9a30-48f0-0a4d-08d68de93b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 17:16:58.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0wOCAxNzoxMiwgRmVkZXJpY28gVmFnYSB3cm90ZToNCj4gSXQgYWRkcyB0aGUg
U1BEWCB0YWcgYW5kIGl0IHJlbW92ZXMgdGhlIG9sZCB0ZXh0IGFib3V0IHRoZSBHUEx2Mi4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEZlZGVyaWNvIFZhZ2EgPGZlZGVyaWNvLnZhZ2FAY2Vybi5jaD4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9jb3Jlcy5jIHwgNiArKystLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY29yZXMuYyBiL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtb2NvcmVzLmMNCj4gaW5kZXggYmJlM2U5Ni4uNWI4MDE5MCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY29yZXMuYw0KPiArKysgYi9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLW9jb3Jlcy5jDQo+IEBAIC0xLDMgKzEsNCBAQA0KPiArLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gIC8qDQo+ICAgKiBpMmMtb2NvcmVzLmM6IEkyQyBi
dXMgZHJpdmVyIGZvciBPcGVuQ29yZXMgSTJDIGNvbnRyb2xsZXINCj4gICAqIChodHRwczovL29w
ZW5jb3Jlcy5vcmcvcHJvamVjdC9pMmMvb3ZlcnZpZXcpDQo+IEBAIC03LDkgKzgsOCBAQA0KPiAg
ICogU3VwcG9ydCBmb3IgdGhlIEdSTElCIHBvcnQgb2YgdGhlIGNvbnRyb2xsZXIgYnkNCj4gICAq
IEFuZHJlYXMgTGFyc3NvbiA8YW5kcmVhc0BnYWlzbGVyLmNvbT4NCj4gICAqDQo+IC0gKiBUaGlz
IGZpbGUgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZQ0KPiAtICogdmVyc2lvbiAyLiAgVGhpcyBwcm9ncmFtIGlzIGxpY2Vuc2VkICJh
cyBpcyIgd2l0aG91dCBhbnkgd2FycmFudHkgb2YgYW55DQo+IC0gKiBraW5kLCB3aGV0aGVyIGV4
cHJlc3Mgb3IgaW1wbGllZC4NCj4gKyAqIFRoaXMgcHJvZ3JhbSBpcyBsaWNlbnNlZCAiYXMgaXMi
IHdpdGhvdXQgYW55IHdhcnJhbnR5IG9mIGFueSBraW5kLA0KPiArICogd2hldGhlciBleHByZXNz
IG9yIGltcGxpZWQuDQo+ICAgKi8NCj4gIA0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiAN
Cg0KSWYgeW91IGZlZWwgdGhhdCB5b3UgbmVlZCB0byBrZWVwIHNvbWUgbGljZW5zZSBib2lsZXJw
bGF0ZSBhZnRlciBhZGRpbmcNCnRoZSBTUERYIHRhZywgdGhlbiB0aGUgU1BEWCB0YWcgaXMgcGVy
IGRlZmF1bHQgd3JvbmcuIFRoZSBTUERYIHRhZyBzaG91bGQgYmUNCmEgZnVsbCBkZXNjcmlwdGlv
biBvZiB0aGUgYXBwbGljYWJsZSBsaWNlbnNlLiBXaGF0J3MgdGhlIHBvaW50IG90aGVyd2lzZT8N
CkluIHRoaXMgY2FzZSB0aG91Z2gsIEdQTHYyIGFscmVhZHkgY29udGFpbnMgdGhpcyBnaXN0IG9m
IHRoZSBib2lsZXJwbGF0ZQ0KdGV4dCAoaW4gc2VjdGlvbiAxMSkgc28gcGxlYXNlIGp1c3Qga2ls
bCB0aGUgd2hvbGUgcGFyYWdyYXBoLg0KDQpDaGVlcnMsDQpQZXRlcg0K
