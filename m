Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA35C21019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="opcmGoF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfAHOZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:25:40 -0500
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:58000
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbfAHOZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOPNfUa7NGeoc5si/DQabUNjN3OqamzMBH99+uH6pS0=;
 b=opcmGoF7qdja4jUpJaw9ezWxnSTq1UtHHv6Qav+YPVb6RLkd/Mi0SSxes+VzhPgt2+fzwjv9XNxH2ET47DgxZFNZqkBcoHjH9glZHLK9tJrCbPyRcebBS+Y1wEFWhHUA42weVH4hL4HbvhZBxPQeRiL1iPtp0H0fAwhxoHVUQt4=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3858.eurprd04.prod.outlook.com (52.133.39.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 14:25:34 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 14:25:34 +0000
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
Thread-Index: AQHUlt/bwU7HN6OdJEGSFUlfmMcu7qWU250AgBCFWYCAAC1QAA==
Date:   Tue, 8 Jan 2019 14:25:34 +0000
Message-ID: <353b8f62-e265-c3c1-e352-d33c204eb6dc@ysoft.com>
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
In-Reply-To: <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0068.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::45) To AM0PR0402MB3716.eurprd04.prod.outlook.com
 (2603:10a6:208:d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3858;6:+qFJ2D92S0JTZh14RUFuOcDKzrHHaFFcisC+Eb1MlBOBya/q6TcMwgfzeVr8LAuzqujhGOT8eQANlt98hrwE6tl0jHsfvQK0Vxo0Z+oCPHr/jQBXxErfdVQbK0E/nPdIL4l2U7cvjW12FE4S489McCC+bHGLUmGhDhUKq9RSuDUGFavbhvYdz2thzZkWy8AVl4pL5QSe1Hfs0ugfwgrvyvPJL6QWf4WNLB1Er6w9YT6SemTuIaASSqs5DWvoc1+nyj845Nq/AoQpZEJFmaQFgK7AeJiJs2hS34F+zuc31enlSHLoeBiWHfqRS9G5x5ZajMefrhrA2gEAmj2SfJQAq72fmbs/OeAB7uuGU0vsge8Xy0U/hzDwaLAHie5mlO53UKPPGKavjpkWoHQQqxS6S2pw4MuA9Gnli+MsSLYoKnrQo7NeXPigLGrSGQWVRVers6c7a8AEfDpzyS/fh2UFzQ==;5:83A0alB0lb4R64Ryg0ZYzM2ppDyXnJfHd5EJzhCkXKO4vgVEunxasRZlinhCZrMZxlWgP7dMLpX0Q654SakfphFVA8aTUqbJwMtbdj25+87LV/glQPzeUXU+wjHoAAdRiYGpGlD33W4HhZEEYk2U2dBwd6JMQkjmkIVO4m6pcRvZ/Lc+QWr1iPoTl3WMc9RebEIizWleA8mF6oBraEB4Uw==;7:xrwjbiaWFTL5RRAxS6CgFdqMeg3xazhbIVRkwNP1dpqGK2GIknfXfP2hnk3fbZn0h6zDecPS4Q5NkQ0DmfMx4r3LzpVFkV644+9IgZ1XFW9QO3CIke4c/mpqkZoNbYlhfduJwPWMiJ9w4dIda7MiQg==
x-ms-office365-filtering-correlation-id: 59ad900d-e1b8-44ac-0a18-08d6757526d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3858;
x-ms-traffictypediagnostic: AM0PR0402MB3858:
x-microsoft-antispam-prvs: <AM0PR0402MB3858EC7EB4D0C184A376DB2E9E8A0@AM0PR0402MB3858.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3858;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3858;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39850400004)(376002)(366004)(199004)(189003)(6486002)(6916009)(85182001)(8676002)(81156014)(36756003)(81166006)(54906003)(6436002)(8936002)(68736007)(102836004)(7736002)(76176011)(52116002)(316002)(6506007)(31696002)(2906002)(26005)(186003)(305945005)(86362001)(229853002)(446003)(66066001)(11346002)(25786009)(71200400001)(71190400001)(476003)(478600001)(72206003)(53936002)(14444005)(256004)(966005)(4326008)(2616005)(386003)(53546011)(106356001)(105586002)(14454004)(486006)(31686004)(5660300001)(99286004)(97736004)(6306002)(6116002)(3846002)(6512007)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3858;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J/GNtfF20ynfn53/YEpj1kZ2RmGqEVSayUt+A3zSSahmEafwL66ctUs3wZwBYuNo6RrqWMo5vfYaomRD6bHcwkKn2s08RuORrbKUCybWoe2wuRl7FOk/w0KquMUhKf6K4RtNhM+dB7nMHVWdTT5j/nDGD/dvQ67iSDDv7eMjlzpWavxJbR8dYaRBWWL6zzcoUKxGJ5hTKM03voKiO+F5Gw6TC1uRFvNRaesRmhWRSNosYa+NO4YVd8OKSNRvIUI8VLay/avma6nHJBTrPhv08CAWi/drWesFJzAeiaXABTnNsq9Ayq5kfIecC8ofPnjD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <48294F8A05AD6141BE26D1E98A837D31@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ad900d-e1b8-44ac-0a18-08d6757526d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 14:25:34.0007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC4xLjIwMTkgMTI6NDMsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0KPiBPbiAyOS4xMi4yMDE4
IDAwOjI1LCBSb2IgSGVycmluZyB3cm90ZToNCj4+IE9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0IDAy
OjQyOjExUE0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0KWy4uLl0NCj4+PiArJmkyYzMg
ew0KPj4+ICsJY2xvY2stZnJlcXVlbmN5ID0gPDEwMDAwMD47DQo+Pj4gKwlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPj4+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2kyYzM+Ow0KPj4+ICsJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4+PiArDQo+Pj4gKwlncGlvX29sZWQ6IGdwaW9ANDEgew0K
Pj4+ICsJCWNvbXBhdGlibGUgPSAibnhwLHBjYTk1MzYiOw0KPj4+ICsJCWdwaW8tY29udHJvbGxl
cjsNCj4+PiArCQkjZ3Bpby1jZWxscyA9IDwyPjsNCj4+PiArCQlyZWcgPSA8MHg0MT47DQo+Pj4g
KwkJdmNjLXN1cHBseSA9IDwmc3cyX3JlZz47DQo+Pj4gKwkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4+PiArCX07DQo+Pj4gKw0KPj4+ICsJb2xlZDogb2xlZEAzZCB7DQo+Pj4gKwkJY29tcGF0aWJs
ZSA9ICJzb2xvbW9uLHNzZDEzMDVmYi1pMmMiOw0KPj4NCj4+IE5vdCBkb2N1bWVudGVkLg0KPiAN
Cj4gT0ssIEkgd2lsbCBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoYXQuDQoNClJvYiwgSSBk
b3VibGUgY2hlY2tlZCB0aGF0IGFuZCBpdCBhY3R1YWxseSBpcyBhbHJlYWR5IGRvY3VtZW50ZWQu
DQpOb3QgaW4gYSB3YXkgdGhhdCB5b3Ugd291bGQgZmluZCB0aGUgd2hvbGUgY29tcGF0aWJsZSBz
dHJpbmcgdGhvdWdoLi4NCg0KU2VlIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1
LjAtcmMxL3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9z
c2QxMzA3ZmIudHh0I0w0DQoNCkFyZSB5b3UgT0sgd2l0aCB0aGF0IGFzIGl0IGlzPw0KDQpUaGFu
a3MsDQpNaWNoYWwNCg==
