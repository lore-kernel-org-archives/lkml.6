Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DCAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1092177B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="alV+jLns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfBOPQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:16:47 -0500
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:58329
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727663AbfBOPQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNNZCbGO5LbrtC5C4tcy/yhDDog8p+a71zmq6zcKO6A=;
 b=alV+jLnsp5QYeEivA3NqL+BPBS6UTpjYgM4NuxTilRTXbfPBA2jxONBeplSHUihRpy01aI7tOlqtwAypQyIm4fWAmvJtplXXgy0+W+Q1MLRjBnXGzyNglGtZEsEf1C5ys/dOejmfLEGKdRhgl2Z6z3QpNTTv9pvjwrVU8voM7qk=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6566.eurprd05.prod.outlook.com (20.179.18.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 15:16:42 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 15:16:42 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Colin King <colin.king@canonical.com>
CC:     Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] mlxsw: core: fix spelling mistake "temprature" ->
 "temperature"
Thread-Topic: [PATCH][next] mlxsw: core: fix spelling mistake "temprature" ->
 "temperature"
Thread-Index: AQHUxUDLgbgCGr1IbUe6IiajOPixQKXg+GOA
Date:   Fri, 15 Feb 2019 15:16:42 +0000
Message-ID: <20190215151639.GC18851@splinter>
References: <20190215151153.17206-1-colin.king@canonical.com>
In-Reply-To: <20190215151153.17206-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::36) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.176.7.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e390cc93-a88b-411e-f9af-08d69358971c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6566;
x-ms-traffictypediagnostic: AM6PR05MB6566:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB6566;23:GBOLTD1Gchw9jWR5jIKr5SWv6N307JnPHA0upafXG?=
 =?us-ascii?Q?HPEOh2t04NU+dZxVtMAjBgQbOMQkpYpjbtY/0SSz4EAKDQY7thBEAe2h//L9?=
 =?us-ascii?Q?bOVLNe88hhgE8TiqocygILeLsJdJVNaLf2Su4vS/r6Iio/y2Kz6BLTz7Iry5?=
 =?us-ascii?Q?7PeZ87eyf3wJCwuCcnmlViKo1CfRHnE7WQxygaOhG0PNWkvsWdo+vogrvQqy?=
 =?us-ascii?Q?CkD2gLq7N4eO5ZKOWyaB/LkMuoBbUDvrzHPKJAvrHes1jKzsCmb6ny3CpwEN?=
 =?us-ascii?Q?6P0AgSroJcM7nrMe/of0p5j+HAi+d/kvbi6TIIy0RSfv7RsZh+oMHmgAvyMP?=
 =?us-ascii?Q?86RylVkoVxlSee4S0rw+3eCSE0BE3Yb0wuzgpUjdoMpn5ek6zQfCmgyD3eOT?=
 =?us-ascii?Q?vx6M1stQjJfBrMjvNjfG+zHSrIGKgbFONYMHjhxAxdncmb/goIDCBa9HBC8H?=
 =?us-ascii?Q?zkAMd176qHbl6oGFGnVztzcrEHF/RUABNHMKy2u/1KCNfcWOwOKZdiJnfsuh?=
 =?us-ascii?Q?8opPyoK2Q6CtS8hpKmaO+PyXSiu7Ki2ZDF58oag/AssRYXMRisat4AHNl+a/?=
 =?us-ascii?Q?sqBnGVlxqX4t1ugDsYwoho6EyoCVB7pZVJDPGkxJ5IUr1GUe2GsQpKG//vlE?=
 =?us-ascii?Q?NC/UzhRlMixMdSCNXzdVLu6JniQHbTS2xVqqWkoZNofp6NZQfDkrGJ50MVWu?=
 =?us-ascii?Q?peZqmEXlD0UACtXVZmWIm13SaO8MakUGBo3Wj5aMjwUQ1pyMj3aY3qDMljqx?=
 =?us-ascii?Q?OAPVaSx/dxjJ8pOBVecKsVOlo90MfcgKMdUjHeE1SdZo76UtoSiZBkWX/7qx?=
 =?us-ascii?Q?7Zdp52LLF7aP9r/KWlwqExTBE4S//Pe97QQdYjIrW8At5FjLEIfCxJiKXAQM?=
 =?us-ascii?Q?wxYzy5ni7IYUgtGwDcfePdP9ay36M+tcyccHZ4q7A3ERbRv6HRuczxnPUlWS?=
 =?us-ascii?Q?MpihOkqwTobgRmyibBJp+QbxN2iK74ZZ3HHFt0asLAuODiWZ9IZ9oAlCMeKF?=
 =?us-ascii?Q?texLcwEZas1YjmtbWIobn7lky85ylxpwiTgrxuOr/5Z8DNOgLKbrAr7mHmCi?=
 =?us-ascii?Q?xeMmCLc5GA90RpT0gd5kl7VrNC+7DOzVA6bRG2ap1plRCIIQgWq2tKxI40B9?=
 =?us-ascii?Q?h/XfsIu8uvi0B4ORy/SAwlXc2wHfDRt576+HAE5F8r5qorApC79tVBx74nks?=
 =?us-ascii?Q?CLTOEMZ0J3N0q/KnRIPamZTYIOLXgQ+D6XBMAitPPa/pvEJ3w2CizJ6y8Neb?=
 =?us-ascii?Q?tKJwNCqRjd878qgZ+0gQVoWx6qvyIboy8MqnF7zaGCTPRV2uzE+17+yGE28J?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <AM6PR05MB6566233ECC25B9E9BF90D8B3BF600@AM6PR05MB6566.eurprd05.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(81156014)(1076003)(14454004)(97736004)(9686003)(8936002)(186003)(7736002)(386003)(305945005)(558084003)(478600001)(486006)(52116002)(6436002)(229853002)(26005)(68736007)(11346002)(105586002)(6506007)(476003)(33896004)(6512007)(6486002)(8676002)(6916009)(86362001)(99286004)(446003)(76176011)(25786009)(53936002)(4326008)(6116002)(3846002)(66066001)(316002)(54906003)(71190400001)(81166006)(256004)(71200400001)(33716001)(102836004)(106356001)(6246003)(2906002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6566;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GLAA3X7wycEOxj3vVvOReaYW9Q9PIJQh3lF9q3UD4YTX7oaa1pC+W7tfXret2KZCrB3l4yw+7e/0b6JIm4gyhIupPqppF/45lXrIxWEI8gs5mrqroq5cDnfADN8XhHJlUiYNPBL86793FE3INx8mMy7V3z2QUk0aU45tdUrsCdrODHHpWBNo18CxER50blpD+Y0tHLx/ZlXTjGC83Q/hcDBkFO9zPvEFclrzFOWt3itnAJ7WeDeU2T96tdxJsnCMtNVBSWcBJqEv5j+hhX4rnQGxn+4g+Kv8HzUQL7+ybU4kodZzM/LVIyZmtwoB+j1M7gFOR7lwPulNATujXZmI1dJv1KQwnPlzmY/SCVDS8BcpVfKJTxh2xNK9MbWoZyODeUfxmVAmIEt6IB+o/LKB5NbgF0YfihVQYA4p0a5ZjhE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42E2E64ABD7B4B48B18646015F6C78F8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e390cc93-a88b-411e-f9af-08d69358971c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 15:16:41.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 03:11:53PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in several dev_err messages, fix these.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

Thanks!
