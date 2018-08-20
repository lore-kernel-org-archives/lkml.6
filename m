Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB23C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0DF20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="IEtP4rvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0DF20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeHTNQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:16:55 -0400
Received: from mail-eopbgr10137.outbound.protection.outlook.com ([40.107.1.137]:53184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeHTNQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7pZ1+t12b3EtOkLo81tRJSuDsNm1r2Sw0FqsyZ4lhg=;
 b=IEtP4rvrH5tXu1uVLyHQilDn1qt52q3QLOdzz1XaFRhfyilILRnqFSR8giMksutE6G3YibxiH/Ucjoda6Su2qXU/ung7uePaLmzmegfoO5NyIOqtJ2/cTO9bjX5iHo9Ksx2DvxJBcf0TIwjYtxXGbvXKKFuXWEoBOQ/4gYZlN88=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23; Mon, 20 Aug
 2018 10:01:39 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/5] iio: envelope-detector: switch to SPDX license identifier
Date:   Mon, 20 Aug 2018 12:01:12 +0200
Message-Id: <20180820100114.22966-4-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: d38826df-ab2d-4f6e-a120-08d60683eccf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:dWC6RtyQUEDh2PZ+1bLrcdiIDnODN4oyC1opjfyxXijAVd2UL2sMnPBmilG5e5BWqwJw2uZUXLZmZn2QlgZFoBgL7paz8nIEF22+xSHahhUM3hrbcHzw9+f71/e2r5ZwzbgWLGYINUPQS4MlcCp/VuM/baujHB0fzQMwBRIrCTsM3/mJaADtqtcfTJkAu6Mn6KJXrALD8JQmVN3llSlwRmZU/pzRgzbDd8fi6skoNKn7NKJQdq/+gxkllNtJqYPc;25:o3jLKcOTk23Z6aJUkxjRZbdiZyhmwL1wTjLgGvtWwYUJoXDoB0HIVHJkOY9yPL/iErKSFwPSHn4a/1eg8U2CoMvDXbQiaoxuC7z+4ugTFN1em76RkLXzVLHoF9DxnZCc3ElyLav4dHKTEiM1GZzWZ3z7DGx6Hl9E6Amz4pwifNnSjRHPsqwCORKnpJpZlyY6sp36rJpbepRREm4jpD17UtVQW7EQbKyc8qVT0nXDj8nokjqEVshh86Qo0N/3lwKB4pmoZ5Y9tI596jTCho0x/rcvEvCIMT/+wxWcytvE5oLKcEileAXh8YOQJ//IOEWt3dioab0NktPjH4xdIFu7cg==;31:Y9BGJOrG8QmduTEnfExNwkOPYz6aKizW0S56FrOx9eiYq3YMpzynmu/YTx5K+HANgbJO1NmRuMrWvp4DjVH5BIbl1JHYjEjpGuVop2jYn8qO54/qR11RV1E7TiwIrYaQhKBoSgBjpZHFTvCkcX5P8Z4Emg8QqPqxkNsYhe6gK2HI3lV7Ih2K9HQ5MsaBeIvUzHqY14rFsoy5pXE3NG1kLVvhiyWXwbEQqwA9oKvz40M=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB245118E9F6F238F472AFDA26BC320@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:iOhqRxKwxOXz2T2+BB7BCckvubRaWU/gQ85oj0/H5NKz+yR9qz/0oiSQRTBC54XUHBUbUHfpoWQWqNp6h23+9TWdbOqiONbiyzHcVIoqw+q/sVVtM1gTgF++gU6pYSyVxb/cqF2sMUm/ep270mWLugZWYeJnWVp7dc4RC3keZSlCbZ6QqNoqPfXhq/mg1Y8xYJ6rZ5Ue/SCbUdjvBbOeSbTOKEW+O2HTFm50bnxH9VwPGiDl8SsqnLJzL5/nQec3rp9XveCAXzJKB4tBx3Vluw==
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39830400003)(189003)(199004)(6666003)(478600001)(2906002)(68736007)(47776003)(6116002)(66066001)(3846002)(5660300001)(6916009)(6512007)(1076002)(53936002)(476003)(486006)(86362001)(97736004)(6486002)(11346002)(956004)(2616005)(446003)(48376002)(25786009)(4326008)(50466002)(50226002)(8676002)(81156014)(81166006)(76176011)(51416003)(105586002)(74482002)(26005)(54906003)(16586007)(386003)(186003)(106356001)(2351001)(316002)(2361001)(8936002)(52116002)(305945005)(7736002)(6506007)(16526019)(36756003)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:zrPUPIvYw5HdwkKcDiEi4tXU11ts4i06n2A4Fhb?=
 =?us-ascii?Q?hRy3Gep21jAG7G41V3RT1LtO56HossCf2atgTywybwnkEGRfQrN/92vE9X9s?=
 =?us-ascii?Q?yf9AgZUaHVQ03pbtaO6uCM79/0pCpqH5MPvUpZ/7nzJinUxgL39LmyAqYM66?=
 =?us-ascii?Q?6JfkNfbe7fY0F824Oa4arGE6Px3sHrV6yF4CmSYfqhRf+uMniRAyc9utbCpC?=
 =?us-ascii?Q?SrDsCNBhgxgR/1DVNg7cdhLcv1fP9iDWiTXqt53A0IWU11TSZgSqyJa7astq?=
 =?us-ascii?Q?ciMWdir3JErGDxoUJ4XRa5baWsZ8nyNux/wd3Tmtsy4q6SgPAt7b1CMKGPOQ?=
 =?us-ascii?Q?dIBr8KvYR2ctLheSh3hD1pzkTv1CLZ5D4Dp49fec3rW2IUtZeXB/GhfnKwP5?=
 =?us-ascii?Q?GK7fwECGI5FWo7Gp5N+d9uyU2g6zABw4Jwu9iydm8XDJObDz+oWfeJSaOhar?=
 =?us-ascii?Q?UeGuLW3FlUNCeDtU9gRB3R19UP/TBhwBEaleHSu92dQt+OTpb0097pDFO0Ep?=
 =?us-ascii?Q?9wx8B5+Rby4KBB2jz26y1YcEjcWUThT3xhSNNZqWbn02uEy84AAbVcZO7tDT?=
 =?us-ascii?Q?6yNOlVSLO7OmGVus4BHN/MvOCGt7gJO4OohXe9TOhbn8xuITllA3GPR+ZcfT?=
 =?us-ascii?Q?POrbVxlRQwwYRmLY8d7f5lpwk3UDN8Po72kQ/R2DiarDUYYh69z5GGY6uHSn?=
 =?us-ascii?Q?q/r+BvsEq49mQ4UyvDo/s5B1RC7XuCZPj6P1I0pkHYvYM4pWmhHHxVh50x87?=
 =?us-ascii?Q?MsLMdCCuCPAh9VN0cMnw8jrbRcXH09WcGoRU5mToyZz5meAOJq+xBQxk7UlL?=
 =?us-ascii?Q?Xt06oL0W3YyifA1EmPAsgMNNT8OFx8LsbI09LavvhgAqgJMmmZfShD+G7ol4?=
 =?us-ascii?Q?WDKJOetRCQ8piMB1V3dLC7u6Hv/PGn3AlsY1jWDzcAs2donXmaWLXAnHUjUT?=
 =?us-ascii?Q?/+EgoEhEvIfkebYx95jtXKgZIBahYaE86gZowk9OYDUkGF4NjKXTJfWoTZKy?=
 =?us-ascii?Q?uRaEPY9SM6OuiKxJaXBUgR9FjlcB94Q+tMDI93mkKleEdvedeil7DonF5ryO?=
 =?us-ascii?Q?xlUK4PRQCkqvSZqU5RHu4VAHad6V+MJnf6ZyNohSgNZhaJizpjoa4VyYrJlQ?=
 =?us-ascii?Q?rmkpQrkviQHsXwFvBiXOfA9C6Z2iws+FBipg8GuGDpKtRPGcxJsPWFejqAHX?=
 =?us-ascii?Q?CE3tTdEJoZDAWGDgXC0fjms+kG8/WkJuG9zKBvvYk1bdeuOzRroG/hS67WBp?=
 =?us-ascii?Q?RH4+Wt/gbXIQg+6djW7nUbg5a5LtGig1GSA6QhdN+vuTUsqytZmRpoHfEKrt?=
 =?us-ascii?Q?3kCw99pIBoLVQKtUn+nT0uH8=3D?=
X-Microsoft-Antispam-Message-Info: w12aEetU8AtzwpE1T5T4aOBr0lTbSGBr1W8EX66cBhsfN8g0BcX6zT0uhQmSG6rqFWdDvLK8QuXSyOwEnfucRwP9DdTjxA42vRygfK2ENU1RNk9/D1Lfc9VcQlRrq5vA6Me9IUJXVia6gLql3DnRqS3iMOkLMPSlUREmlJq5SiXkkW6z84Q/AvSbwVubKIoCE5amE4dd5ZvuKMofAyNOPSVjvatPFxFXqbzpl7oecwuMrMBNAROt/0HqrJ5hggoKk4plwfXHUGMi40TBurqRT5CfD3jR7oDV7cQ3gcTdlFJwr1Z9xBO+aIVP/yKHhAfQN4mPKEn4Rh0eoKnVcr1U5CW0YwDIO92AHtVGSPtuvMs=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:2PLU+aOkBKVxNQBx4SrVhFORy1XgPT4N/KS+2ffPOUIAN4jGFWfJTaEl1h72kQpTKoiysiRBqvASD0dt4OpTiHYjf6kRqHi6ULKCKhvNPVIRc/NaS+4G9nprzR87+f2yjiE7wUcxCYxsgoIz+PNRz+TADUeVyU0mqt0g/N1A/OHjVl2b/O5HB7+uX1plYVi8n7xD7VhFFvr347JB4tMoDoJumo936yJ70ypREgYT/TEzDmCYt8toAfCu0yVODPmI/2bxY2fj48ZFIAVvyTso0cIysZlUYxn35zy6BAnEugFV5v4ViJYQ5aVCGwrNwnYkXTKTOoOYBpDwx/r1x9YAcTS/gZXh061L0xOikduyd5dKw9cAKynFPqnYr/PiI014UuV4SAHJ0UOBXXNa4LR062cefGOmV+Xol6EustKMq0IxuftCNPGmyyyaBYDiPwvuVwggGfitlfTTXTZLNXvt4g==;5:/zMIyD08MtcbdhJV3Z8lfc+N2iqFZE+Pf9TEKk3CupkZlIn17CfgEIB3Ln4ogjm1hOZevs1k92qYDTO6egrdneObSHOveKRgTlLcLerP8ir8IyomXaiEOcSE7q8P9acReHF77rnw5Vv8tys+YnnZvjpF6/WuUyfInUW6ql5Lvkc=;7:SpUGq/SxDIYKsvjUN4wSarD4hQ8PmeaJxnWH6ZfrTN6Nhp1III7otdtruVl2c6rD6k/xIU8NYJgIOzfVBggnDOd6RT6yMbZYiLPWRRCZ+RtGhgTMRhz7MQKYe06hC7Oh2OaXp3ALGv4GdnYOoxNJc5zj7SQO2z2NjlLVyQuh7zFWVTO+bnA822EAPjIblmNwoUN3nzaM4TO4qp9FoBoOaxA0mX2GGNnNUcgC7JusWic4da3iuGJZGEf/Dp8Nfe47
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:01:39.7501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38826df-ab2d-4f6e-a120-08d60683eccf
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
 drivers/iio/adc/envelope-detector.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 4ebda8ab54fe..2f2b563c1162 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for an envelope detector using a DAC and a comparator
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

