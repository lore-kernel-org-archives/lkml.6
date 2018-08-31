Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A47DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4E42083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FcYs1N/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4E42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeHaOjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:39:37 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:45696
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728389AbeHaOjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/PQ7mhCAp9mxFIccVuPuy8CNPGZfcjAkEMqPV8IW6c=;
 b=FcYs1N/TtJ7fyBISYnpdoLVBSFJj7gAOlQaDtDlPX98QdIj49FHb++0bCGV7jNzxk1k5KrbRu/1NxYeFYWcnvdqBZfSFjFPPvx3leVcA0Vria9QJLrRjTfEtCcjiAjunU+vZgaN9jJYXsJZwMqIG64DhNHcXG2MUk/dm8Kh9d5g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 10:32:26 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 7/7] MAINTAINERS: add maintainers for the NXP FlexSPI driver
Date:   Fri, 31 Aug 2018 16:00:04 +0530
Message-Id: <1535711404-29528-8-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::26) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dd9aa86-1b8c-41ea-25d1-08d60f2d0f38
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:tUJillqLz8TDLZ5BM9gLozurJuCN4EbQNIuBIpq7nmvr9UOuIQ/zwEllObkHJxbCqKv8r2uILYC8/UJk6zrAvpO058W1tP4tvff8HfyFqS0ag9uSIdqG5p+Nh6aLsQPbOScfCoe3CpEo+NUgIhMuxEgfqgmLvyklPd6dvfMkj6Ybw7CIbtKgqwSoy39EDYeAZC8qPsgM5ncvCa1J6foEDag9gik/79HY3aJo0ejXpnkjII7icavwZfEuZkbhrmHL;25:EA+FSumyRyIFUCnkaQjhyOvvVuiB/5z9l4l8q+tmCupbLnfZR1TO/xJMRV6XqZByiPPxd9Qho7eiFoa6nKsauU46B6U5dmojKzKAomup2LBukCr4YJE8RwkxwzJnHh2cMFVPuiwM9oBxT7JZa/OHCL1lSkMVOL2T9f2VmxZxY4OZRQGEKk+Irn6FQNfGJcqGRpSAMFJ69c+JmbbrtYBQkHq74ekq2p3CwfCSCF+L9jpHHbrXNEFEKGLl6kbDaHuMIRv0TCzdEHhUr0cm4by7VTudbOf26juR1VQvhoDcjR/YwiZ1X2XZ1xQV+PW3z39BuEaJDoGgHmeyIyMaP9NliVpdYX+05TjGJ8Ow59SSVAg=;31:+A9lCHkKQTR8tCD024s0vQElv4wN2ay7y+N2CsOhjiMaH7+9bICccmrUQ9OKJi+zjtNhlKxqVpAadv6hLhRLEfa9eFZXtiSWcKjDbxQ6PZ7d4MsJptqJ/vfwL8u6YvVXPEuUdDQNcr8oNlcP+Zx1Az7RO9T87pws/tnSOQzBoOZ0siRw2e7dIv7Z6noRA4UsM/nRC+lNOuq4RRpNXeUfNuSlZmmzj4qVxFLUnx/tE+c=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:rsBNOoe4UNvFFBSlgbbNDirVlfbfUg4lJu/tMytnt4JRQUFj0ecGUUUenGql/cyQtUuz6hiIBCSyBYRy2flUoLpzx5YSzS1gf6SuNex6xL4vzirOcj9BZeqKKtxKqGwE8mCOT/7b60cxXpYL7mxPym+E63Vib5lDBShWXKL3aTtHbwaM7SUIf5+EF95UoDdqPUS98hPzQTMy+CzUxz+3N5ZpkRzawm4+VZqZVhzM/xT6b4qF2wvGtIBlrCYhyauVtsERaf1vgBDT5b6VdcC+Bxkhkqhjy1q2OTPw8hvMsKo5ZXj5EuHBJqUs7wD845FPlHzKCqm4C9mGFREIMJhaXwMQWT7SQZo+znK5g6qAO3QJGZ5A8bZftLMOiZKubS6WQF9PHFj86ED+6l4SiVNpAFmPZoO4aRC2icXLIHltG7f1JgNTSEndLRQMViFYDq/AyzUdEFlf9U73b4XcvVu6sf1W9oFqvU3X2VN+3iz/4stU4a0KR2DC+zZdZe4K73Wm;4:4MU6N/xaiEWUTKTqABREXMYUzWdRqyWkMdXAvDXC7Z82qBcK7gqVHWoygDMHrkJxXfxEK7anPiGSAy37bfFK8ac9f2v5xR9qxEfzV8lcyQ6DEY/pcDBUfVYFHWGQaJAkLGekmZObd9uTHyoWieejsdsbDmstYkb+7qr1D04Mag+sE8OCx2oUs355MC18R/47A9UY/ryisOOF6+WrzkVCb35+mAkNAhQmQbI0zvB6+B1vNu+9wjpnLMUsl6cfB9YC6rtcm20ShgDIvmvIYXZNSxwwaNpM9CkalRc8K2hDa3uVGwNN1rbKu9uF8dDmnaYHUV7rZzKtVCavIl8OrKUIgGSLmYBMMQiA9dtQYX3UhKCel6pNoIKPXL3FVUj73erz
X-Microsoft-Antispam-PRVS: <HE1PR04MB10341693D8C8718A647A4D38990F0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(162533806227266);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(48376002)(7736002)(7416002)(8936002)(105586002)(5009440100003)(52116002)(106356001)(51416003)(55236004)(386003)(6506007)(81156014)(81166006)(76176011)(2906002)(86362001)(3846002)(186003)(50466002)(16526019)(6116002)(305945005)(26005)(6486002)(66066001)(47776003)(25786009)(36756003)(5660300001)(97736004)(8676002)(53936002)(6512007)(50226002)(316002)(6666003)(39060400002)(68736007)(486006)(4326008)(16586007)(11346002)(478600001)(446003)(2616005)(476003)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:FG4Dsvk9BWfWviwXuoED+GILNR3hX1Ngbx18nnnkE?=
 =?us-ascii?Q?x9ElFCqgTq/vvhI/QkPuuzP3j4qfFEYoDnDJ6O/r1KfTdvYhwsIhqykvCbw+?=
 =?us-ascii?Q?zwVIRbdddCi6+rz9UezznUlmZICr3GOM/nDk+YTd+uOvNH6MsaRv0Qn/5o2P?=
 =?us-ascii?Q?bKy+syFa2WEmH2drU3Mve9HZRSTS1sb2hZDh9UPQkP8gKj7pT7R+eduDmpYr?=
 =?us-ascii?Q?RK/3i8xjKDOQzlpE15c7/xEHnbEH+MsqJ/LW1Kj5NoTsbh3riso4OxSON8QI?=
 =?us-ascii?Q?K0Vc9090jHVmTtNYOoDowvS7crX8aAN5esVdFj7/6F9JmS98VpdyxwPZeI+i?=
 =?us-ascii?Q?2+NdXXdGqh/1jkuDtJzjUPRpiu9KpobLEzJkc2su8KtxtwXOjTCLAVsyjWxK?=
 =?us-ascii?Q?hr5r3Nx9dO8+0QnlaeHSxfQYwBUIsEZLKWpxLmk1eAZI8Y5h5u6S/aOymjMI?=
 =?us-ascii?Q?wmtRmNGMArHyPMaK+8KBss/CnTvw2+hFWj0jX5J5qgFgTh9QvxjfAGW/Ag3p?=
 =?us-ascii?Q?tIn4leUaRPqyVZnHAmu2kpponv4zod7VC9OpfXWqvzVQ980mOwYe8/GtzX9i?=
 =?us-ascii?Q?Oz53jmHxQoXeJHpCifn+Tg2mF4XY4Gl4yd7sRkMDe5YFFhWYEAEeeSNeq+R9?=
 =?us-ascii?Q?i27d8ZVGzajI1Wyk08+Oud9e9YufOH8kNUOMM/mAPzbiuzCEY5STzpPIgzWY?=
 =?us-ascii?Q?p2ympAIA8iWL9zfO44GorJ3CsF+2/gqDc7l7tWhb3eRgoqy7XFTe33cJf9fj?=
 =?us-ascii?Q?5cSLXkqKb57+zGPuCGNqQT1DYrUvrtrk2Qq7DKx/6rlusP0Y49/DkXgtxG2n?=
 =?us-ascii?Q?hEzQp8YpUcvfmeeKN6P2PnNPLk1+K2ry+zhe0FFWQeIOi5oOJA+NCXB5PN+o?=
 =?us-ascii?Q?rX/pAfl1S290czTS6dKoms8hSAPW7vbeiOTLVtvgDUPN6VciXBP35h6vJRhF?=
 =?us-ascii?Q?tABfrTRYsNdooEciVfczgoyhmRsDjZmlsTimMtxDkqTfC6RP/dziHJNdSYhn?=
 =?us-ascii?Q?e3V2+i48ta5Il5OaaD8UjhcvuBbbUAmrw6zEgA8U4tftB2bXlVt+RiMShu+7?=
 =?us-ascii?Q?jYw6tS6Td3pGi2i9684R9NbVNwDX6OkHVj9pVo/hZbuS/aBKTWQft/zgYZKF?=
 =?us-ascii?Q?Hofe8U+r9TCF0ouFaHLHJlkt5938T9F0sQFN2aZIz7H+TVNqWHQuv+VMUJvc?=
 =?us-ascii?Q?MoerVLQ66dtnXB74qUke8HVM5ROauT4LeAUdqfirxt9GbU1AVa3KXVP7IxdL?=
 =?us-ascii?Q?+Q66G2kvqha/raIRFRTsMafL7hMBd/GEAlPa9rb?=
X-Microsoft-Antispam-Message-Info: xhC4wSXo7bdLZz2S2AhwNrOXHWKfVByP/dG37swt5fJJZ43tIzSh46MRrJaDQlFwXto9FaybsdsTeZbdN0I4BTuOb5pZpeLxl4mhG044rVtBIFsksXntd/cGEVp3bmLaEYR6bjt7y9GTdVK1Q18MkNCpaBxydif/zfMEuUDsV2Lhwx5AN+ZGmDcPWrHLsxwH1l05r167xug88CeqxeWmd5kGbu0DVYAKb/cQjT8ZZ3201QXjAJ9C4/5miwEH3Zdy4oK+0pSyLOgxArmRg7878woTVcC4kDWmSRwVNYBq6Odzigd9gcpPsBa9s2Oa0/ywXuvE1gBX+QjN+dFvzj+Ms9K6gq+c4N7QBiswA+ir6WE=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:sZAFsUvAIlSj0c0FaYPITL9Q/TXOKx3uPRlD3SkRH651nOVMsnle6kXGgBw1n1o1ZqqyYwvIjFZjFuhaaDtDwdKLyNwGqEXbgTP2zwBdNsjpDsvzB8S7qIvrYHfUzPehZe2YB/C8pCBSE5tl4RyI3aEUtLfi5uM00kb/FlCrY430kYLPa/nxykUvKxV5UaY+Xj7/uQd3Nn81Kf+8WH8e+AHZTm3iTdCJ5e95ZyeMcJzPiUJre1i2j7Yps+9bSwYyU8qP/iZrmOXasRKuFombWgE0nLzewlPomLD/Y0gVAkahTMdjODycxm4RiphVPVFW6CGUpmRG7QEiKudf575rO8ko7OwaDgc5lLJt6pf2VwUK7DC5zHQJReX88ehmqdIKqaJVc1hlm/2XOAapVGuDFB4NwzaVNPDj9gge5nj9dL1QS9/rUeCVf1Zz+nIacO3d97IB+o5tWf/xN+fhox8zAA==;5:0NMtzqPZodsTJOv1Vt8M7kQDJXtqfpnx6Eznmh6o1QZcfnRugWz5vfAiiORVQspbjODv92GdEdFu7c5pcnQ7QKLBs58uFLQCLi2UMPMJz+rezGzYlEC93SsiptNjZvJ/wNAJ+24KK9463QiQDhkublkaUjHBu0eTraL02Bnbr6M=;7:4QLjWyF7S7/GOzLL1I/gpaRCkrlEKS/iLuuchoSKhT4iQ1uodyvgJonVl6ehMq6F4U9QOHuXyuBXQtu8XoSEU75cSZ1HxyN/ZyZCRgnF+JFwC8PSzq3jrj1E2sbAGcowJZDSkR7LrXtzutg0sSd6j1d6VlEsjghKPY5ItOWkigR3la9I7CxESskaMVPFETv/6F0zB1Nq8ivyjJ3eAwWnKWo6LrJqfr+W/rchLC/Ioz8AxaWFxPC6Bottp3O/dK5Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 10:32:26.9505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd9aa86-1b8c-41ea-25d1-08d60f2d0f38
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff..2696898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10228,6 +10228,12 @@ L:	linux-nfc@lists.01.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/nfc/nxp-nci
 
+NXP FSPI DRIVER
+M:	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.7.4

