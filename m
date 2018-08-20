Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C9C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2DF20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="gJKW/mO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2DF20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeHTNRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:17:03 -0400
Received: from mail-eopbgr10137.outbound.protection.outlook.com ([40.107.1.137]:53184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeHTNRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArjsFvLM1batid8IZpCLLTmsGYZ4xhWSFsMh2uTENRw=;
 b=gJKW/mO/HaJsnyvZJseEBJbJgXvQuihB4Tr1qq3QT1L77GHckQSZDOOwRxLcirdQq71sQHhOch+p4jdNaTNnPlGqarzRWnh/KuXxerNnKJ/kCVHwaewXP3Tbn4b+tLF+VfQM3FBTgncqCmH1F7t5VqdBEEKPeCLj0Iy0VRgVFHc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23; Mon, 20 Aug
 2018 10:01:48 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 5/5] iio: multiplexer: switch to SPDX license identifier
Date:   Mon, 20 Aug 2018 12:01:14 +0200
Message-Id: <20180820100114.22966-6-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: 410f41fa-4344-46f8-7ee0-08d60683f20a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:3l5mQfJQU5wUnE7tIRBEK5V56CewftlUIyBtC8jnQtEzxbJzQfR914GV72i436n4HYrmYivDYWizHuWPZ510bRW9SMRr3dgGkh4NnplLDjwbgopB/wgPQeD1fRVY8dZ6FtE3ukWJu9Lp9+OfrGY3xZygZl54w8CFMi2B7f0HkqwIxdUYB7pIBD058FrW8kTBgE8pQUgXmkjTmaCuDx5U37wRxlgWmOooVaPyPIPcSejwvVNW6RCOXmoPlnJQcO6K;25:ONuJ0C+UPU15es+R93S9eh+q+CDfHfDoNJLyBG20zuwfCforaWIfWScJivu6Fy9BFFGz3AGrx8BkNftog/PBub8CBUAhc+GaAmonXpQqdmpbJrBZOqbn3SiIKLyzYRGtC5yk17+wq+3t2jbeYGBmhf1Xkj1SHP9ysKKUCKHJrnunxhjYl0uwmRECR92BWgB1yYx1b64kEGx1rm+uzcv7ZTQ3j2Mbn6FMJ+U2GMc8IxgREjMgCTJDWxzsnOq11BDWE2gMF6fT3zsnie535pWLNei5WSA1BHbawlD+vRbVqbUhLqifiKSNTronrwJbydcQZr5AlkHouIQYy+t7eOnVvA==;31:PhigSr2UY2rjHoJyGInTKNl6BaBsYHORv7Q3QMuWpknQ1TPabZDgHYqogElxZV93XRM4X9OsfrwztJPcc1eW/DTxqJ62OzA/tKkCC62CEYVqsfmJa9UlmPsBU5fsoyP/zqhIHcCjlOpCZ4YY2fJw8vEuHMDfJtu+xpr6iIofbA0gOxxXDTv9r8KjLXUk3VMi1FYkSpIKtCHiA87w1AaiTt9eDlotCmGOAs93oKfRF4s=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2451737C3B2BC7820DCD4C17BC320@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:0XNddN/Mrtynh+MTQjRYsjV16CtWIfr3VrwyqZ++tSH37/dbCJgkoNBl7C+7JEqhu8wYNBsxI472OEkr4rqIrD0Gzw5tLS3pdaKt4wjPPr5eKIj1BAUYW3fwozbOnjgBQh5fvrZUh3sC/unmj3XIe+vVJrTWbT8Iidi4aLdfm6IpsjDKGiXJki8SZcQWG5PEujbVlUPP7EHTDuwnptuVE55C4RKAfXWnra4v+pBSZ9GRXe03V1V3b+b743AmGZfnCaTxuj6+B7JMFZuOkKaXww==
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39830400003)(189003)(199004)(6666003)(478600001)(2906002)(68736007)(47776003)(6116002)(66066001)(3846002)(5660300001)(6916009)(6512007)(1076002)(53936002)(476003)(486006)(86362001)(97736004)(6486002)(11346002)(956004)(2616005)(446003)(48376002)(25786009)(4326008)(50466002)(50226002)(8676002)(81156014)(81166006)(76176011)(51416003)(105586002)(74482002)(26005)(54906003)(16586007)(386003)(186003)(106356001)(2351001)(316002)(2361001)(8936002)(52116002)(305945005)(7736002)(6506007)(16526019)(36756003)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:KwTfjmvVdHKelqO0CMln/ysbWft0xcSwCyZwoG7?=
 =?us-ascii?Q?C/LRFuH/NYLJitxu0H6gLexpgXlEZBPAudETbW+r6yGXN1q5HP0ExR23axpT?=
 =?us-ascii?Q?8SjM1W9BMpwuXw4/JdabNpMQ3nNeGzYS2oCFdShMKFretnzeE5q13C3MY9w6?=
 =?us-ascii?Q?25MKZUJ/FFA5WuDfW3Nfz/OygY70gx2No0LIsk3KhU6hJIsIfyNQ/I2mUacX?=
 =?us-ascii?Q?ijKId2d2YNolBs6Ib2t9ztFLC8igoZlLNRF044i/8aSHZ4Bok1V8tAwkfHwT?=
 =?us-ascii?Q?xxudE7PLYeydUIv8bDgnwnqNEYlhuuto1uEYRQIZRHiVJ8MU1Txji93pTqMB?=
 =?us-ascii?Q?Lbv+jOz8jUir52tRhrg9i4bkJpP/a9LksxDKtZvX194LKjQ+wRT4LAT5nwKC?=
 =?us-ascii?Q?Ojv2Cz5GHalB9RDYb/aygJSUsB6oqe99Zh+lgStYVBqcT9/j+8o7CrV8W0dS?=
 =?us-ascii?Q?S2pRpGsAKtUE+h+AIBiOaDkjNvlQGwVI44ww/6cJwq1MX3aZaXnpQsXB/0xp?=
 =?us-ascii?Q?k0xakC+D5SSwfhFnkQO9loNr+7NaiV4/YF3HzcYgdHfHT7IQkNHNl49qezGv?=
 =?us-ascii?Q?OQPnbrHhTDIIN8YOP3bYVoU7fZMEVsOXT7rqZRYHMZje2Rmqz1F7Ubdwi3Jr?=
 =?us-ascii?Q?TXuaBIQvTqNvBDA7g8pGpKpANWU4BF1Fw+6tS1SdSdUk0uR4qT9TIJMUPeQq?=
 =?us-ascii?Q?wiKfEmBMELdffj526FSAD6x2mjF7i6bxQmfWJhcJhCLxh+BnO6sjcx22v2J8?=
 =?us-ascii?Q?Od8Xdekkcx1rBoUjkrwstKyJg3QKro6hAJsMIrddStOnfFbVqtM7RzO0+bLZ?=
 =?us-ascii?Q?kcQvsktR60/aX5xc4jIsTesa8SqVWBYHwgA/jHjAn8ySAo6nokMgQeK4hwx2?=
 =?us-ascii?Q?ou4kgDNI8mJPwX8V5sfy0mo1kULMQYlolG5xCIKsz8Ce1i3Futc6jnd1HkgM?=
 =?us-ascii?Q?J5i3DeniJAKifBTUDgBMMWFvwwDMwlIhMjsUlmaoOMnKkgSDF/MCPupAd66A?=
 =?us-ascii?Q?sO+QGhO1URnGMmv/8ynPNkPOYqxi+eKU1QqQRTl0HXTnscc+XaWu9sZeO6z4?=
 =?us-ascii?Q?nWR0AELCRz/sWfyJRYXYFflIzk72w2ZR/iz5TDF9uEJKajdBGEQnKs9Idy8K?=
 =?us-ascii?Q?nWMokpjb7qCUl68zb5OblBsd0hsPLGHmh4it9IU5wGjqoP8SEKA5zlkV5bOq?=
 =?us-ascii?Q?KDmD472ightPDEFjjetaWNp0jLKdLbi9AF9BJeymjjnoN2uNg5KzxR50bDd/?=
 =?us-ascii?Q?bWuI8EEOdADsqKH1SYpieASexj60laW71/zgaQrY2eRb8N7gO4F0GrF6pyps?=
 =?us-ascii?Q?5rWzoqbKlnMWLtHZE09SUOYQ=3D?=
X-Microsoft-Antispam-Message-Info: Y3wXWAoX9xj2T3acGXXs2CxlgvD4uJ/oqrp8v9GAQ3M5R/D8dmJ99+qrKBz24AGPx0BXlSXff0uHwVCRo9kx+KjpS4lddgKzxMksVGWsf4K83bhAnPsHiVpI7VYSw4RtGlag24p3RuNxiU15EFFooEwS+g/YNaREyiocUBRlvBdP5ewLaipCsDGsgsEFTGoOmpMNs3yMFr3nl0/PXPPzEOz1zkWlkHSQBAKjvcC1rCZE2RdH0SgdeiOx6gxYwnmdEc7cLOcbdXmiP+KOYuoTX1yg1wMfg+iQSlnIUMxknd2aNm2Mie+D7Qsf+HcrzPnHknJS25PAEFMUitDHEfluUUfkOkzWH+Me7nMh1dQ7RAc=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:bYb8RFcwv2NAZ8ESRHIIYlLuF8+Dnv1O0Kvju94KGpy5EYl9XQhUrlfGPVoBME7j0g4yO74SETRkjaNEI5P9K+12vw5kOS1iHTm/DmOBIHeCAAz5b7A/rMP4Msvl8JAMa5DMmfbx6k3RuIWMBFG6rcKRSHgI8ct0LvBvVvQPjavGU3BDxQfL6qymP6+a8CJc0mpun3LDVARHQDTjOJxrv7tWAt2kwNVXp2RRpkiS1A9GiTBtPGAmSyWftmadoqAM5IpLCq9Uor5U6J3XrcI4I7SjQqH44W7fyJH78YSDBOVLCy/e/7KqqdaWLgFuKxGpo2JIzSwetHLvncUj8PJbd3P+AGWqQ4V2qEY9oNfppsKGHhRzeHcJwy6p2o/8aSDOvRC7GDGOpu68lZf/wjmG7CvQvYmUKkB8Begd/ELnVPOysoJbM8sYev5rekw2EHeMfUV02RMxeArmKDEarRsu8w==;5:NWDtVjmhYafnm6Ie1g+QkgqsXQwqfHnM+P8Il53Vb1fJ0sX4fvHpC/lgR4HFqcSQIElx5y5xJoK3T/k352k7dFreN50j7QD01X1gHykx6d7A/g5X6ShrXyQP6zV0UgqtOqMw0tO7Izzdp8df476C0mz2pbXnrvPTtYmM4sWPpG8=;7:sD0m/a9Lm0pE8MnB/2pwwmUR0K0ZT9AgPPBQSqzPlEHqAjep+/3tdjAikhUalw66t1O4t63ypuyNNJ1d+QLEx08yEjGwc1sqU/YN9wzjxxXZTLYNUicfkhQXj+qPZre7MzHrZBcWs0+G5MfvdFQSvEvnBh4XAd62UN190vA5y//yjAaXBOYnvySR/saVYp6Iz3cv3aq9ON9HXYwwgfX+5TGO0Mh5WsK/Q7arXXvUtVDbA+a5d/ki7Gj8FYP0PjJM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:01:48.5235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 410f41fa-4344-46f8-7ee0-08d60683f20a
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
 drivers/iio/multiplexer/iio-mux.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index e1f44cecdef4..0422ef57914c 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO multiplexer driver
  *
  * Copyright (C) 2017 Axentia Technologies AB
  *
  * Author: Peter Rosin <peda@axentia.se>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/err.h>
-- 
2.11.0

