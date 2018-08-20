Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55877C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEB120C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="PGOc30h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEB120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeHTNQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:16:57 -0400
Received: from mail-eopbgr10137.outbound.protection.outlook.com ([40.107.1.137]:53184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbeHTNQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFRgJTrsly56FA6MB/HwUcfRAl9FnHWJtK+DUpZDETU=;
 b=PGOc30h6guguJCcf43pkG7yDM0uhk3gMovJs8r23W8RRj5Ubg0VW1QRyRuiq31IwwerxNUOeTan+whc9fpPY2wMZJ862noguaX7APg9v5qEr9gQleJNLza5+29MBCAlgWFq3XVV86E4yrCzDBUm71xyXyffrEPG7oHhYn+saRaM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23; Mon, 20 Aug
 2018 10:01:44 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 4/5] iio: dpot-dac: switch to SPDX license identifier
Date:   Mon, 20 Aug 2018 12:01:13 +0200
Message-Id: <20180820100114.22966-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180820100114.22966-1-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::29) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53fcff04-0831-484c-1383-08d60683ef80
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:cvlRQsDtegBnFsI6RZZDCG2RrcGsdpyttmeXNLOJDJHBiyDTrOIWhAZltoI1tvBysu/SfHfG6J6tstsxK/j0Zlz+TqNZ/QaxpzJ5wg/5hDGHwG0Ix4xU3eXkHi5eF5nYAMAzGgi21UERsaXFGvw2Z3Mka6rCAIfPPOjVF54d6D4Z8+tkpwD88Xdhu13ALDu9tc8n/sGedaMv5w+GF/OcZNrFcSj9hYqLURS+klV4rgt4Kla0IMftN+KY4uPKZBmB;25:zLFL6QJXrwQ0dl2Sf2IsNvHUJtwhe3Gf6Znnw04HaGKX/trECU4MohpVMOjkhPPf1RJSPSZonbcG/OWr3K5367JwpziSKm/wBkkyyKsoPGXtzcmvA11NpoWySrYvqHI5YF1Fh+yy8TzjunAKPuAI6Wblcy8fE3mU9Us5heHwhcCiX7A2HuwJSVZ3GuNg/xIFSCB3tZX46ommJAXMYzX3xdAPu3cUmVx4Qm72DB3DWu4A1BvQkEx/q9glgJyLa+77h2FNY1/WiZ69tGuF/0F1uNEGMNALx18eXvzExdysGYFWXy0WD0JKYvYKa8VNZTsNez6fAeJx/770cXG9fs5CHQ==;31:T6wkrS9l/34f3sY1ne/suARDcPsrZRw9+byotamJvRUCcceuxQQB1j/GUE9V+Vi5lTRyrQZBj2yHkQtc11X4ZDfRCexdYVEY0LKpvtGjoy/DCjukgWu18voQZloHSlcmt6zpDCsCeujCMJV5KYvcqgYvxkTbpXL5XDbOhkH1ZM8u91HTqOb+qnL7+tTJggufIVrcvPjkMQwTgQ93GD16bBzIBXP2VKMzZcaMs9bbmcM=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24513915AB81E7C2AEBF49BCBC320@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:x6cATvuF7f0RWwpxP1d6k9Sa4ZSvMIJqutl4rPN0vPVo0eXd0xy23sr2uAJ1KBIo1nj3VbCwduYdnLEE0waANSf/g53c9qxHZqFDUUfCGYdzaaLObniwhnSCS/nbVYSBjxSi5iEu2ltpoJdkM60AHedWB7V7J+IXSJd2BjvL9I4RMpQnSVCTinpEeuiyUapSUDPtABw4a/DvVt3wkyAmJ0/FS3jW2/jJ7v9EO4+s1aVnos3Mk94PVP/VwDdRXMZm275jFFLt5V75ORjvfJ0G7g==
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39830400003)(189003)(199004)(6666003)(478600001)(2906002)(68736007)(47776003)(6116002)(66066001)(3846002)(5660300001)(6916009)(6512007)(1076002)(53936002)(476003)(486006)(86362001)(97736004)(575784001)(6486002)(11346002)(956004)(2616005)(446003)(48376002)(25786009)(4326008)(50466002)(50226002)(8676002)(81156014)(81166006)(76176011)(51416003)(105586002)(74482002)(26005)(54906003)(16586007)(386003)(186003)(106356001)(2351001)(316002)(2361001)(8936002)(52116002)(305945005)(7736002)(6506007)(16526019)(36756003)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:BNVTZld58jW4xiBWIsHVD716CFSpadJxdHyTQe8?=
 =?us-ascii?Q?lKImeL8TCZBFSN7+qEG6K5DTF9KmSSmSnVUIuXTYwOXqpn6S91BBIGJXHDqv?=
 =?us-ascii?Q?H4P88LBszvHo/Z7RjPTiBxE2WYiN5RLOsIVWEJibRWnU1m8J1aD75mkVPhrK?=
 =?us-ascii?Q?TdgL7Sg0VcCuTXZvhHp689vVVJaUVxzzhBdhyhBVCQGBvPqsM5SuRkTvKj+5?=
 =?us-ascii?Q?7HDoRS48gbffc6/9SmI/56XV0BJOzUA+s4ym9k9AJ4hQ5L4BUObWhdh6GIKr?=
 =?us-ascii?Q?k5amCUeEAJJL/rucn9Po02OK3KHVxLvjOdvuNmpo9M7O3Pw1iQupwQC4cnbt?=
 =?us-ascii?Q?x63Jwtrxk5myp4cyX5U4MGyrX9NvrNCsbmgkZ8NO9FBC4WLCVR+KQReKAsNg?=
 =?us-ascii?Q?0VdQP1U3LygR3t4SxggzQud0QlvvEUpoW7+sKo3tO/DCCOc46+Zx+ih3mEnS?=
 =?us-ascii?Q?ZqCcteg51VZrrPyPsnlIoxOcdWJ1ka3jGT+O2M+tJ+FDm+MslMM+8SxIxoB9?=
 =?us-ascii?Q?t707dXjzcDfzakiiTudcT1LnrgChFHrHcQUJPEsOZ8Anti/wYK7pAYrvhaaX?=
 =?us-ascii?Q?1fEVc07dQG79oXqy7Kz0lnYu7EyQ+IaL51QDZy7wmKFFKG0p4YYp+9HO7vge?=
 =?us-ascii?Q?9/7MCh7quUCxcAr0aT4XCHNC4trjk6iaflIK72OZJbJx0YDT5huun0nrjQ55?=
 =?us-ascii?Q?pTXchZdkUXiToyE3gU3+tpW3qlxHYMikhr4L1sHTcQKCcsjtkRL/Sd3157N2?=
 =?us-ascii?Q?wsED185a5fX0iVQF0hW118KpLE7rrY7r6/YOrykpFGCHyKdGoDnwqnT45LGH?=
 =?us-ascii?Q?CSN8PaElwWDRmPJop0ul0/uyBCdUjO0xJvE2ZCMv3OCtJfiFLgIkk3+cX4+M?=
 =?us-ascii?Q?KD25N3Jh7A6Bx0vVdNfPPvbVvutRzD8gaCGEe0E56k5UMtNy1keV5B8Mtx+0?=
 =?us-ascii?Q?/gtafqV3SGzYj5IPecBKWJKttmB7Fb5PHvWfpNwG0fK41vGIDBIFWtNFQPkP?=
 =?us-ascii?Q?t4QX5RGJsNJMaT7a6QlO+nEK+YPe9HXwbFgO4s6LeNIjMc/8sknompKXRtyW?=
 =?us-ascii?Q?uX181q7X1QUfljBD/JSn+oikpz1Z2v1r4fJOqfDt0hFeon/lNAncfy1AGcin?=
 =?us-ascii?Q?0ED2YdAmb7sWML33HGDsOflk+C3+iAiCFaq+HoB8Vc+4LsXnfXLL590CF5zz?=
 =?us-ascii?Q?upLCmhcYFEOMGAPWJ/D8UnhIHB67jdWiIO8YSondLq8qjCRwrD8+b4Q64TjR?=
 =?us-ascii?Q?+ZX0jXakRJhzrp9JtTgkhgqx+hmnAJKUgiHsSrkfT1v44nEWLUsCfrkqAZEC?=
 =?us-ascii?Q?bNf5IIIINK/9bvBf6kq7Tl6mhbFe89YiNdkPsOC+vZPHT?=
X-Microsoft-Antispam-Message-Info: 85Q9RjsyLGHLz4Lx4Oe10kHZhANovQXUm2j1PlJHPwP1ODoEogWu+K15drB1fOCwJsd70jq6ySemMB428rtQVT1PLBgRUA7JVvvMIA+fpNgs24G10lANi2XUuVDGFWrLBaU/pIqDVNvIHCZf2eDeaiihY6SUg0H9Ec5ffLFJNLMAuR03eYiSFglw7uXYclZJ5fyzCoLz8myK5joqBW59Gier8ZHuMrhE1FRb0fzlrNAzrKDNx/nVwsOe+P79DsWpiFjQk5G0oB3ng925dKdiBMFgGncNJcF1ohdsZSryFVRGZjIHa36JFeDZgmt6c+cWi+UPXx57biV/1V2fCgkxoCWVIK4vGdl6tyZ0ytyQl/0=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:IU8+W/rxPKzpAiEozkeXBmoRijpOT+YAT9oImwkR4lAbUHFVUiuRTDh2t667sr5dY37n9AsvFZdCmEzVA8w0oQHGl2GXqKcViDgwTS/4+9cOMETmtp/sv2svIB+G/VJH5VJB5+gC66HXdkMrJ2OwTAbePiWfpMgq9EhUba29u6IC98KBUUDn6ZL4wzj4ZK9RU5Eo0ZOpmfAGUkRtkmOHDkCkP5YGxA9UJrC690jCL1Et/0Ct3+oRC8icGhp06ipdN5u8hm6vhCTJdYEIvUYvrFaOSTqpA2mtCkSDA010ZockgB5+hvJSUqG/p79s3qlsKQBAWB9JpvKSh0Ywf5YeOC9Viksiy0WKX6HP8hPrzs+RxCZ4E93Fjmm6L3Tl7nmBj6qP2mXYj+Rz+AEwA6v0G0Iq5fZa0XRhiI0e26puZOJbiyQalweoWStbvvjShgqK1hQqnvxys/Ay05aCthzbjw==;5:2ZC5mdB+ljZWY5Rds4AoM5ZIP+gMecmCEqVEgNbpgk0gEfnoHKAvtSCMHd5I79IEQH+q7d6xRXl4f/jS+47ggP+NPaGgkmL0bBEWb89+rcqmULMXshIinUXxLhCP0mj+T9kckoNNTYK6CdKIqyYm2CWPyQFMa1iW9ftL3amOvrI=;7:LiozF+kautbv1/e+rvN4OtMNth1nzfyKulIDC8wGQI3P+1PJKX+DCoPeWbijfGJcMWy7zan42OUAKcqigvUBX6YrwGm1ZDrGtdUclPlThOwfcCSK9Sbkc5+txCklFN9kZINNk/ulpTGCNF85mmaIckdAabsppl3jO0pTlght6ik9BV0rmXUdoHsWvA8diHJlip81vXihzUvJwqQD1AhhSvF7JmaxI6krLs8PaBQDLu/m6liPxKktm2N18EDa/kYN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:01:44.2619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fcff04-0831-484c-1383-08d60683ef80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the boilerplate license text.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/dac/dpot-dac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index aaa2103d7c2b..a791d0a09d3b 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO DAC emulation driver using a digital potentiometer
  *
  * Copyright (C) 2016 Axentia Technologies AB
  *
  * Author: Peter Rosin <peda@axentia.se>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /*
-- 
2.11.0

