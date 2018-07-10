Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F025C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4B120881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Wp7UZaOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4B120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933416AbeGJBSX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:18:23 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:13984 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933372AbeGJBSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:18:16 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 10 Jul 2018 10:18:15 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 3163669AD1;
        Tue, 10 Jul 2018 10:18:15 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,332,1526310000"; 
   d="scan'208";a="284914041"
Received: from mail-os2jpn01lp0148.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.148])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2018 10:18:14 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oyvg9ov135CxohgvrI4liiAseTCNnub9BG8hLJT4AMg=;
 b=Wp7UZaOx+5cluVwzDI/XoC5mnYMT90KMVLsF5JEJR0/JupzuOZ/hEBof0IPwRG9FbaJM7B/0iJrjtOku1AY3wM63Grziv2LwvSfNTeiNBIzdM6ekWSvmHoIyaPTpDnzSRK6ImsLUFzg4+ovD+MysI9EW5ceHy76n7DDa6U4/XBI=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB2919.jpnprd01.prod.outlook.com (52.134.253.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 01:18:13 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::3820:2ee6:79bd:c8b6]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::3820:2ee6:79bd:c8b6%3]) with mapi id 15.20.0930.022; Tue, 10 Jul 2018
 01:18:13 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TAKESHI KIHARA <takeshi.kihara.df@renesas.com>
Subject: RE: linux-next: Signed-off-by missing for commit in the pinctrl tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the pinctrl tree
Thread-Index: AQHUF890Gn0hmXHEX06i70DSwMUcQKSHfaKAgAApiQA=
Date:   Tue, 10 Jul 2018 01:18:13 +0000
Message-ID: <OSBPR01MB22933EFD31CAC8A88CE08EDAD85B0@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20180710075439.4a449b3d@canb.auug.org.au>
 <CACRpkdZrsGzULrNaoaX6bSy6z6o-gshQXrRhzUk=tuFF86shDw@mail.gmail.com>
In-Reply-To: <CACRpkdZrsGzULrNaoaX6bSy6z6o-gshQXrRhzUk=tuFF86shDw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2919;7:IbdTsbnKIYJW39wKyWxcRoiRTIUXfiXp3yIZCHY3ynpbwDzlzpHCA8alQJH64n1Q04kcQC9rQYa4q6apd699bk3M/qxfBHTPYdu8Mg3c8LsqjDVDF7J/ud2kfprlPrdEEkneCE/GbVsdWFpP1oyIW6ukrXvn48n2VYfInU+OrsbPy3QCCSqtsWD7FaoLc1FK1AywaIUcKyF/My7esaxOXg+DL9X7hXIYc28T+ZylzHS2BB/o2uA63+BfyqSBuarn;20:CHhsysDoBcmmYz0pKNQQYJo9yjhG6bit8gPs1HEXdm/JHXDE3UB8zxsHtFVopumLvbfBuEZWWvtA5yRSD2pZquRIT7vbrG1EjX/J9pqt9TS9z5y9frFe3VmX2NGHLlYav7GGbM3AMjX0McwWyrr/h+qAawkeHAiD0WCkbyNGNtg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 23acd9ae-38ff-4650-2fd2-08d5e60301e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2919;
x-ms-traffictypediagnostic: OSBPR01MB2919:
x-microsoft-antispam-prvs: <OSBPR01MB29191031FA27465FEAC0D211D85B0@OSBPR01MB2919.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB2919;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2919;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(136003)(396003)(376002)(13464003)(199004)(189003)(4326008)(6246003)(2900100001)(107886003)(53936002)(25786009)(3846002)(6116002)(76176011)(256004)(14444005)(99286004)(7696005)(2906002)(86362001)(14454004)(478600001)(106356001)(110136005)(105586002)(66066001)(316002)(97736004)(305945005)(33656002)(8936002)(81166006)(81156014)(26005)(6506007)(53546011)(8676002)(186003)(102836004)(74316002)(7736002)(476003)(486006)(54906003)(9686003)(446003)(11346002)(55016002)(5660300001)(229853002)(6436002)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2919;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aOQtUFTPZVp8x2fzo7vdhBrPb1PgzqcWPGJxgVWCaOrGuX4+/kLeUt//GZ1tHGTZIlzIAewqTzhJ+vovkZaoyccYSCYop6PTfXJjUnFojxsqZchjTW/6hy948L5KI2S0JaYTLI+P36mMsquU+wvUq7Y5wtwtoXavyIFlMF+B+H85RIt20ROoOf5Ll9mw5NKiD8HA3AZd0HZXerLzvmImLdDevqjEkJjPyQalp41LEspshoP0Q/dbedEV0ntxRwrtDEJYSNPv8cXmuoIywSj8pdYGMDXkKVq/9qcSR/cwdkvSd8ihdIl4JdklSxZl2qDvhRbvodBDD5D0Oq9EEl4+Fk0xwQ9SqYmUb6xKb2XT50k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23acd9ae-38ff-4650-2fd2-08d5e60301e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 01:18:13.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwgTGludXMsIEdlZXJ0LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IExpbnVzIFdhbGxlaWosIFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTAsIDIwMTggNzo0
NiBBTQ0KPiANCj4gSG0gbXVzdCBoYXZlIGNvbWUgZnJvbSBHZWVydCdzIHB1bGwgcmVxdWVzdD8N
Cj4gDQo+IChJJ20gcmVndWxhcmx5IHdyb25nIGFib3V0IHRoaXMgc28gbm90IHNvIGNlcnRhaW4u
Li4pDQo+IA0KPiBHZWVydCBjYW4gSSBmaXggaXQgdGhlIHVzdWFsIHdheSBieSBzaW1wbHkgcmVi
YXNpbmcgYW5kDQo+IGFkZGluZyB0aGUgcmlnaHQgU29CPw0KDQpJJ20gdmVyeSBzb3JyeSBmb3Ig
dGhpcyB0cm91YmxlLg0KV2hlbiBJIHBvcnRlZCB0aGlzIHBhdGNoLCBJIGRyb3BwZWQgdGhlIGF1
dGhvcidzIFNpZ25lZC1vZi1ieSB3cm9uZ2x5Li4NCg0KU2lnbmVkLW9mZi1ieTogVGFrZXNoaSBL
aWhhcmEgPHRha2VzaGkua2loYXJhLmRmQHJlbmVzYXMuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpZ
b3NoaWhpcm8gU2hpbW9kYQ0KDQo+IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlqDQo+IA0KPiBPbiBN
b24sIEp1bCA5LCAyMDE4IGF0IDExOjU0IFBNIFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1
dWcub3JnLmF1PiB3cm90ZToNCj4gPg0KPiA+IEhpIExpbnVzLA0KPiA+DQo+ID4gQ29tbWl0DQo+
ID4NCj4gPiAgIGE3NDJmY2Y3MjkwMiAoInBpbmN0cmw6IHNoLXBmYzogcjhhNzc5OTA6IEFkZCBV
U0IzLjAgcGlucywgZ3JvdXBzIGFuZCBmdW5jdGlvbnMiKQ0KPiA+DQo+ID4gaXMgbWlzc2luZyBh
IFNpZ25lZC1vZmYtYnkgZnJvbSBpdHMgYXV0aG9yLg0KPiA+DQo+ID4gLS0NCj4gPiBDaGVlcnMs
DQo+ID4gU3RlcGhlbiBSb3Rod2VsbA0K
