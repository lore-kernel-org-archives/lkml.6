Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4C0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E6921901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KXx483fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbfBMJhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:37:40 -0500
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:58854
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727548AbfBMJhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y+CMxlYGjBqSTs5EfvGxbCuw8gnwEzEUyS28UM/TFk=;
 b=KXx483fJQqnM97fRhX1x2P2/KKPL7YYLKoJl7MjyohT1Bw5jnBSqyL+3s4MsTyghq6j4n9Hhf/qK4gOVhnWxbVtB5M2YOvKUwW8UiUOBEPTGMAWAx9BedO0Hcxlk/L6Qvpd+OKeuHOz+jcnEiu/LCYt2BXzKjFPAM33BUgJCNy0=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB5323.eurprd04.prod.outlook.com (20.176.236.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 09:37:29 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:37:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] arm64: mmu: early_pgtable_alloc: remove unnecessary
 comments
Thread-Topic: [PATCH 2/3] arm64: mmu: early_pgtable_alloc: remove unnecessary
 comments
Thread-Index: AQHUw3+88usP6fkoZk2E9fP50sbv3g==
Date:   Wed, 13 Feb 2019 09:37:29 +0000
Message-ID: <20190213094831.7292-2-peng.fan@nxp.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
In-Reply-To: <20190213094831.7292-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:36::25) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:35::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f962ffb-6f8d-4792-6735-08d69196de94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5323;
x-ms-traffictypediagnostic: DB7PR04MB5323:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5323;23:Wql3tXcaq6X2O+HPthF7qNMdDTCJRnuOnvLKOfI?=
 =?iso-8859-1?Q?bUfGYmZUFEu9fBaRAtwmw0zsT8qifHhIdiOiNkKIMiAvWEovbz5SNDHbo8?=
 =?iso-8859-1?Q?2lYDZRtFAX+rEWsUsHBfTW4HXNoBN25cbZqhJ1PXbfPwc8O4dBZUWaeOGr?=
 =?iso-8859-1?Q?6paMpi59ED+682bn1Ql2UL64Uwbyx6uZcPdFJZfS9W1s1v+sJBcTvVnMHf?=
 =?iso-8859-1?Q?s4B0P/G703HV2RzicCnBAUbKwcTeqUOW7+Q6rl53mI5A0SlDJO1jt3nzWI?=
 =?iso-8859-1?Q?COwDu4BTw8Q3ciMIwrvLeXhZVQHvNM2Been31Ge5s4neTRlGiJpaSYZcqX?=
 =?iso-8859-1?Q?LnoQEhep4QxIlarZIJA6F03WBAIMnkSqQB2j5xoJewSClwgkB1NSZIdr28?=
 =?iso-8859-1?Q?C4+cstqgfDoTdYN/eVImQHILDBzELF4P7z6WfEOZc59nm+eyuIy4VNCfCR?=
 =?iso-8859-1?Q?9bIjHYQai5paDMnS5U07Bl8qb9LEqFK5ghDf1jiDRI+QpfA83uvqV28E1r?=
 =?iso-8859-1?Q?mmGgIwyg4WfYxK6R6GUvGbeL9tB2ih3+pm0PG1Y1oTNVEWAJwPJPEEw/wq?=
 =?iso-8859-1?Q?jTO5zZiL7NcrHHNJSRtobTk1znuUTfLVyvhyqvSLhOq6Rby/RQ45eyDLdD?=
 =?iso-8859-1?Q?AKFCrR4EHSQKyKrHJ4Rl6OWCmSTDW/dKqj9aHiJvsIvsr96zGN5ogt20yb?=
 =?iso-8859-1?Q?p9uOMm2O5IoA+/PDUjB0fxbZvJrZv9jysY2o+vSiJatBhMMb+sCK/MJ3kq?=
 =?iso-8859-1?Q?aLUyEjjIZ/CBO4cK5NW9uH5WQfkw77sMQ/rOG8jeOreyWeKtWLWnKo/7NW?=
 =?iso-8859-1?Q?W+YjAkaf0OM2zfRKdYcKjg4bgvgR5ql7SyMUbK9tkkfpB+V8r/uA9iJfmm?=
 =?iso-8859-1?Q?Ei2ES3QV73EgWCH/6rvql0YXTz3v5m75w4CJlyEPODFGkzPUSczmDaaUGD?=
 =?iso-8859-1?Q?DoSEmYQ1+U0UJY2DXBa0j/uFCcSip7YUg7VR8kwlfQ3TW/V0d3CDRkr3Sg?=
 =?iso-8859-1?Q?9t+pF323vwaib4zyMV33pO/X0EmLbf0+DkOjX50h6vky4LscJb4BZ7tCtw?=
 =?iso-8859-1?Q?iKxYAjJRofodqTxIguhdIn4Y2P+hLl+pStbD1TCtZP9hT6KeMEK78rtLZ+?=
 =?iso-8859-1?Q?zGnPX1pqAhNbp1k9wUnGbLY9NNcZikp6ng1LZu2fs44my2V94DbCusxWJU?=
 =?iso-8859-1?Q?vEv1CXFvy1YpenSFdnnBgLF5nXc8uty6o4yAxxNnG0dwP+fy/JMqjHAmkM?=
 =?iso-8859-1?Q?CzCtiy6IxlxcsKhIG+XZmriOeJR9GMf8wteWsgIsTMOXVmhNRQCf1QYhMt?=
 =?iso-8859-1?Q?ypstwcx2CwPm/5L8pZ4e7de?=
x-microsoft-antispam-prvs: <DB7PR04MB5323EE6B8C75E68E78ABEA4688660@DB7PR04MB5323.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(14454004)(86362001)(2201001)(2616005)(2501003)(68736007)(50226002)(11346002)(1076003)(446003)(256004)(8936002)(6116002)(6512007)(3846002)(478600001)(71190400001)(7736002)(71200400001)(66066001)(316002)(52116002)(110136005)(26005)(99286004)(6436002)(476003)(305945005)(25786009)(4326008)(4744005)(186003)(53936002)(6506007)(54906003)(97736004)(2906002)(386003)(7416002)(36756003)(81156014)(6486002)(8676002)(44832011)(106356001)(76176011)(81166006)(102836004)(105586002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5323;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FVhzmuFnJqLGsMVdR5ZGmSDHSdqnrjWGNYJ3yw/0qY1D6rv5Obo0RdRtBnNkFV2liBaZaBkvtHfO2YTm0H6YV+XE6rWLFEQS5FT03fUvqUda4Kamo1/BDtL9HN5iGZ3ufCG+Y9lEmLATtIPyOektFKaXDG/5t7eQhLWijO/yX7sxuLIMY1IFQ+arWP70gs9CqZbnDzrISNRWYw1fq4qoGuzQmsFS0NTY2cIFJwny/fqY16anewBPNyA6e9MnAs4iUv0Z7NAbJZ0+eFuNboqwE+CTjLD+v+XuKBaGx0LCd/Zu29nP3MybdS5C9587uTtq/TQNRCMEcx3R8s7BY4CVgpHxa4GBxhfiZy3LfWG6ZxqhtHLrMzSs4uIiz8YT3C4TQGHYJ6rJuGzBGoYUhhXhEC3lRwIPRt96vPjU30+qwQo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f962ffb-6f8d-4792-6735-08d69196de94
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:37:24.7096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The empty zero page has been moved to bss area by
commit 5227cfa71f9e ("arm64: mm: place empty_zero_page in bss"),
and it alreay added "dsb     ishst" in head.S to make sure the empty
zero page visible to PTW.

There is no code to reflect the comment, so remove it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 065202da3ad2..f61fa7c8fd2e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -113,10 +113,6 @@ static phys_addr_t __init early_pgtable_alloc(void)
=20
 	memset(ptr, 0, PAGE_SIZE);
=20
-	/*
-	 * Implicit barriers also ensure the zeroed page is visible to the page
-	 * table walker
-	 */
 	pte_clear_fixmap();
=20
 	return phys;
--=20
2.16.4

