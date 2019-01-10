Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB9CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CFC214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Lolz4oTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfAJOGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:06:17 -0500
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:61856
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728181AbfAJOGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnrzdK3OIcqK93olaBpyqwegWd5mbl+qVPPc1/lWG/Y=;
 b=Lolz4oTFQ+Hybl/5PzcqpaW8yNCIl2/O58hTUbOR6WCRdlYIwe63ReaX2EU7RwNxXDmO+TSJtlPg/4xrUc6uMMhMHwy2CT1ThYM0NSneOjuSypCaWnH7watWe8AEombEF44j/AcRLb3YdOmH1ML+pzE22eLayt3WsTyhjzFNcdI=
Received: from DB7PR04MB4810.eurprd04.prod.outlook.com (20.176.233.96) by
 DB7PR04MB5180.eurprd04.prod.outlook.com (20.176.236.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 14:06:13 +0000
Received: from DB7PR04MB4810.eurprd04.prod.outlook.com
 ([fe80::951:9643:746c:47d7]) by DB7PR04MB4810.eurprd04.prod.outlook.com
 ([fe80::951:9643:746c:47d7%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 14:06:13 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
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
Thread-Index: AQHUlt/bwU7HN6OdJEGSFUlfmMcu7qWU250AgBCFWYCAADYNgIAAAQgAgAATRQCAACIwAIAC3asAgAACXIA=
Date:   Thu, 10 Jan 2019 14:06:13 +0000
Message-ID: <54495589-67d8-f0e2-c5b0-1fe912376e26@ysoft.com>
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
 <6fd5ac6a-edb5-a600-3c10-b46a1c1d9906@ysoft.com>
 <f96952b2-7b19-5397-00a1-0fe9b5800dab@ysoft.com>
 <CAL_JsqLRX2g1t-8YCqpZ5fd=-MyLPkgy88Gb=6ohEZbxWfS+LA@mail.gmail.com>
 <20190110135742.GC30487@dragon>
In-Reply-To: <20190110135742.GC30487@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0024.eurprd04.prod.outlook.com
 (2603:10a6:209::37) To DB7PR04MB4810.eurprd04.prod.outlook.com
 (2603:10a6:10:15::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5180;6:8Y//AcgRdkxAwNwoc+8aSD5b8Wf3WzdI07xOr/A2dzcRq1axIYIhBPpmVlrg1Y/6X8cgoaDTkP4wCp4koh1y42DwY+RM4Q8Funsj57ou7LGK9Ek989nCW5zXNjFc62VAO7yWNwmuB7lx4Hxk/BvfvBhT0z1bMzyG3kEtfhUjUVvu0iUFR2sEJCBShTA7szg0f1bDtArnkMJBhfc7a65jve0uv0vnazFhv+ROGcLPzl/9GJ5ru/mYwf52u34U17Vxss3dsXY4+G6CtH8ZHt1/UIS3TP9To7etr5zPzY07fOLVX7zBBQWs+NFvBzDb12POiw0mrhLK8yh+tpDZX9RKqPeZoD/FuexHIfmhXFSDDhbfTvurdFcmrpg7tOPL7XLNkGi3mOBryy6UKdXN3vL85k1rD+1JTsUcEPCdlOpHnb9ExEyEOuxWwiWgZkZx0jzBEi3+Ayx5r/R8daugMqj4+A==;5:K7W9T+6R9bj3tBhNq1VteFG9pq//WSaHOK5cbdPOuMdqwUZ27ugVC8IVoGguaUePXO2/iV6gXsYedfQJ+9p8qNynqnuUcLGHEXxHGohln2pSdR94GGxQafEmLlUIZfFUPFscLyJr3bkRegxVX4l79QzBt+Cz3iitng8nFfQ1iICsdm+go4wXy1QW6MYDLie/0ziC9YRAU3Xz0XxAwImXbQ==;7:PD/5X9nGnMMNtjaOz/IS/BJMpzLfRWRzDkiidsfSirz3qX8x+EPaQn9D2AgHMqBRiyFyLKXSFeLmIhLf0gnCNGfrErCKhJ1OuL2wXj7uY0ue86x047NBoKzYeYnXi5t9BemYfxUjFGQnQoaEUxRGSg==
x-ms-office365-filtering-correlation-id: ee08a059-8bc9-4ef6-4dcd-08d67704c7ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5180;
x-ms-traffictypediagnostic: DB7PR04MB5180:
x-microsoft-antispam-prvs: <DB7PR04MB51802D8036BB3472EBBFB6489E840@DB7PR04MB5180.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5180;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5180;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39850400004)(396003)(199004)(189003)(186003)(6436002)(2616005)(229853002)(97736004)(476003)(6246003)(99286004)(11346002)(6512007)(446003)(53936002)(105586002)(478600001)(5660300001)(36756003)(4326008)(6916009)(316002)(386003)(6506007)(86362001)(6486002)(558084003)(53546011)(85182001)(486006)(72206003)(52116002)(76176011)(31686004)(106356001)(31696002)(26005)(54906003)(102836004)(2906002)(256004)(25786009)(14454004)(3846002)(71190400001)(71200400001)(81156014)(81166006)(68736007)(6116002)(8936002)(93886005)(7736002)(66066001)(305945005)(8676002)(567974002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5180;H:DB7PR04MB4810.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0e2764porIkr1qI99MJJccbg/un9YsRcAqLqlfrETcPxiVhiGdBtULV9r7vYQHOJbFvUn9+kav56sDtxug14BZ/9hdq/rzO4rwlwMR4FH2vkTyBBq13ktVF0nHXHG9h9zV5uxgTtihc5Ell7EJcVGtBiZlNvS/wZs3tzI9RBiBbTcO4TXykPeBAcUVzY6k+QU2Cp3IPfLtbKC+/Ar3Q7FZB6Hi2yhoAz6Spx+yWhZ4Fa34mCkjkivBTRaw7ZTH2XtbrDQx7pQ1OD/39gQY3A4Zxll9pRdjEB5N4MLs36VENkUilv0FJFPrtqbllQZhYT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <11A56CF19AC4B545BAAF2A87CB8E41AB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee08a059-8bc9-4ef6-4dcd-08d67704c7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 14:06:12.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMS4yMDE5IDE0OjU3LCBTaGF3biBHdW8gd3JvdGU6DQo+IEBWb2vDocSNLA0KPiANCj4g
UGxlYXNlIGdlbmVyYXRlIHlvdXIgcGF0Y2hlcyBhZ2FpbnN0IG15IGZvci1uZXh0IGJyYW5jaCB3
aXRoIGR0LWJpbmRpbmdzDQo+IGJlaW5nIHNlcGFyYXRlIHBhdGNoIGZyb20gZHRzIG9uZS4NCg0K
T0ssIHRoYW5rIHlvdSBTaGF3bi4NCk1pY2hhbA0K
