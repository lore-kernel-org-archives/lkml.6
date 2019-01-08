Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE945C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B6E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="z1782FKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfAHPAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:00:37 -0500
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:47308
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727678AbfAHPAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrwB+SBmphqs4fxCV7yAcYsxyfsUuh30tqlpBJrKPMc=;
 b=z1782FKX3hjuRm4aCVuMYfTSl4kxKs7WJxD8DX1Oa/L6Y+Cmpb0I962wFNQ+POcKP6mIK/5u/Yplgih2RRQSeTUoKWFDMO24Ekd+AvIHT1syG/69IbEyZh+ed9Zg83yW1anFiom84/FOrPNFJOx46aEKfaTWsTxgJ17z44E0KoU=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3940.eurprd04.prod.outlook.com (52.133.40.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 15:00:32 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 15:00:32 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Topic: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Index: AQHUlt/bwU7HN6OdJEGSFUlfmMcu7qWU250AgBCFWYCAADYNgIAAAQgA
Date:   Tue, 8 Jan 2019 15:00:31 +0000
Message-ID: <6fd5ac6a-edb5-a600-3c10-b46a1c1d9906@ysoft.com>
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
In-Reply-To: <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0009.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::22) To AM0PR0402MB3716.eurprd04.prod.outlook.com
 (2603:10a6:208:d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3940;6:ZssPyeYPY+o1o2ZyLFUbkaYlC/VOoHYEW4XJpBBM3JFPL3H6HXOIZ7FxNMgsv1KwZ0mXZwhJPNRgNWvRkoBc5VNzpewMMhqNwK1/tBE5NBZ/dCYOieZE6TTjz1v6fGgIX5uHqcMkgAOrX7VlyIs5degY+2hpKYTZfmnsgJoSQ9/2SRUQcsh8TLnbBASH/IHiwgABDYzWRB+u+04a2BXjHdjvedN4bma2TJ0ckDWaxdt1d36kw6Bo1CKVTSAX5NDaXnUGauFqoDoMONFR/9bLZq6F2Do4Xm2U5Etd6aHPxZfxClJ1HVn7Bthdo30qx4AuqU0JVVdG1oOXSZS+gyU0LSnZ42hV6Jx+IEOGYeD1W9vpjcgF8cCX3sAu+dksYwVeTsa58jv/9X4xL/g04pGhoT+67HX0ObWzbh6AjergZ+S5ipDMat+741s4CT/EMNiWV6XYO0oJClFSTIMmB/IOCg==;5:quN9NWJYOQDAA4P6GaDuFXCAwjhnKo6aS0d4wIeNoFTZW1vplayQEhu4Ke7etj+1BSWQ0B2zb/k7GQuUBAIp1n/iXFYYr4laeCCGT9zhUCRP7IiT0Kig/IT6auOSpfF7uxjlTMjirR+yhZyPmFdhb/ui4Y9ejVzAz9g/9AGMQHONGQ2ecRv8aNGhkWZ7jRwGEmlrD2e7LoVAyRtSYQR1DQ==;7:fxHDA59WA+dgxgkTuFzzKgb9lGKvbODrOw8qYh8W06shTKGY6o71l10WcZ15bmSt67jgiAqErtoPVYMLq5jnVmKx5koSt0jlWP1O/5FwVIGiMaj3asJUM2OM5/6jxfXiiDpi/dkvjtufG1EWjWNtXQ==
x-ms-office365-filtering-correlation-id: 9396029d-7f80-4895-b185-08d6757a090a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3940;
x-ms-traffictypediagnostic: AM0PR0402MB3940:
x-microsoft-antispam-prvs: <AM0PR0402MB39404A08B7A4B555D0776FD49E8A0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3940;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3940;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39850400004)(346002)(396003)(366004)(136003)(189003)(199004)(31686004)(478600001)(3846002)(8936002)(6512007)(71190400001)(71200400001)(14454004)(72206003)(106356001)(4326008)(53936002)(66066001)(229853002)(86362001)(25786009)(36756003)(102836004)(386003)(105586002)(97736004)(26005)(6246003)(31696002)(256004)(93886005)(53546011)(76176011)(186003)(81156014)(8676002)(316002)(99286004)(54906003)(52116002)(6506007)(68736007)(6436002)(85182001)(81166006)(2616005)(2906002)(5660300001)(476003)(486006)(7736002)(446003)(6486002)(6916009)(11346002)(305945005)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3940;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z3OR6iWIpbPNhTmWAua375nRRUQnZMR2BS/H9eKVjEKF9Nh74ee8SuGHguWrD8qm9WHL7TwaLwIH1gp0TnrT8zwEtAv2Jh4pmlXOxNyJkdcOd4oAUXXOdDwfoSU27QQSsSJl/cMxbniybpQ+mtoaGNDkHAmrIAZAfjZR9I8JFYeMc10CBKySVXy5PjfKotTdSiVCdGn8XGS6Jgg+LX/p4Dg+Q/c0D/IqNdNFZkFKRuZzTbEpH9LqnzQCJ5yG69HxWqyymE65m+cncVXkVoTQzbK9V73KCq0iosMDmUS8GzQHVAH+Ww+T6CKQ1vbDzw8C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2176C3FE71BB442B4833B208C8754F8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9396029d-7f80-4895-b185-08d6757a090a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 15:00:31.5003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3940
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC4xLjIwMTkgMTU6NTYsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUsIEphbiA4LCAy
MDE5IGF0IDU6NDMgQU0gVm9rw6HEjSBNaWNoYWwgPE1pY2hhbC5Wb2thY0B5c29mdC5jb20+IHdy
b3RlOg0KPj4NCj4+IE9uIDI5LjEyLjIwMTggMDA6MjUsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+
IE9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0IDAyOjQyOjExUE0gKzAwMDAsIFZva8OhxI0gTWljaGFs
IHdyb3RlOg0KPj4+PiBUaGVzZSBhcmUgaS5NWDZTL0RMIGJhc2VkIFNCQ3MgZW1iZWRkZWQgaW4g
dmFyaW91cyBZIFNvZnQgcHJvZHVjdHMuDQo+Pj4+IEFsbCBzaGFyZSB0aGUgc2FtZSBib2FyZCBk
ZXNpZ24gYnV0IGhhdmUgc2xpZ2h0bHkgZGlmZmVyZW50IEhXDQo+Pj4+IGNvbmZpZ3VyYXRpb24u
DQo+IA0KPiBbLi4uXQ0KPiANCj4+Pj4gKy8gew0KPj4+PiArICAgIG1vZGVsID0gIlkgU29mdCBJ
T1RBIERyYWNvIGkuTVg2U29sbyBib2FyZCI7DQo+Pj4+ICsgICAgY29tcGF0aWJsZSA9ICJ5c29m
dCxpbXg2ZGwteWFwcDQtZHJhY28iLCAiZnNsLGlteDZkbCI7DQo+Pj4NCj4+PiBBbGwgY29tcGF0
aWJsZSBzdHJpbmdzIHNob3VsZCBiZSBkb2N1bWVudGVkLCBub3QganVzdCBTb0MgdmVuZG9yIGJv
YXJkcy4NCj4+DQo+PiBPSywgSSB3aWxsIGFkZCBhIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0veXNvZnQueWFtbCBmaWxlIGZvciB0aGF0Lg0KPiANCj4gQWN0dWFsbHksIGl0
IHNob3VsZCBnbyBpbiBmc2wueWFtbC4gVGhlIGZpbGUgZm9yIGV2ZXJ5IGJvYXJkIHZlbmRvciBp
cw0KPiBnb25lLiBpLk1YIHdhcyBwcmV0dHkgbXVjaCB0aGUgb25seSBwbGF0Zm9ybSBkb2luZyB0
aGF0Lg0KDQpPSywgSSB3aWxsIGRvIHNvLiBUaGFuayB5b3UuDQpNaWNoYWwNCg==
