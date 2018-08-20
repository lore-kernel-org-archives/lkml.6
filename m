Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C830C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D5620C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="WNwIjUeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D5620C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeHTNQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:16:53 -0400
Received: from mail-eopbgr10137.outbound.protection.outlook.com ([40.107.1.137]:53184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726606AbeHTNQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDKKVnTcyggsuPqN0pH+o17l1R1GUX1vvtz2lcLpQcQ=;
 b=WNwIjUeAp8T0edjZ9XMiByFYfzVRX1hY0kGuPF6ATuOH4IV4Wwt7WY+FQj3rteNdyNPhbyQ2KrCoLAckYEttsl496OdfAe3Q+JsULiT8AWm7S70k98C1S6VvkRKeP/yg9QySh+TLmhMOYQWi/erGiILcpdtGrEpOSz2Jp7B0WY0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23; Mon, 20 Aug
 2018 10:01:32 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/5] iio: potentiometer: mcp4531: switch to SPDX license identifier
Date:   Mon, 20 Aug 2018 12:01:11 +0200
Message-Id: <20180820100114.22966-3-peda@axentia.se>
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
X-MS-Office365-Filtering-Correlation-Id: fe5abdf8-045d-42a5-b4c1-08d60683e88b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:u5+pVISvkJRptJAaPWSQkBbmNxVv32dcPuedA18rRUIfMOr0coyySOGicsQb50ApR2ztIpI9hb4LGFAIG67KHs3ErN7X6HwUsb1rlnbU6L4TRFVSeV1VG0q+wT91RKZpbv5HhucMNesTGnU7s4QOCWElsea/cxKTAFsPGaEcPy/gEV4OIA4O1AKNeAvnYiSqjDmGuRRR5JTMF729mmrNRhp6wr1I3NIHJfynu8KG258MFDMatiOuj76wSIU8O6p+;25:VrbS42ymqnOuH2jIzv9j6mPOBE4m9EaSzGlfIYtdfiQwN65Jih1mxmgRpjRroqQZs6C+zdjX6PjWsieMQhPbQfkMKYGvFUVpV24f7tUPkL9EfIlL9/WBgeLWanEpDkiVj5aLR06uZMo7qgq32u9n6X/OaJqQoofMjeMIflurp2wcM6oXoNjrQk5ynESQ4/eZoES+ehRLMHEDrlbjt/yw8zT+K60xjaWIGHwT/5VECaJBraVug6Oj8wVep21phHp7SSl0HA+oPL4WL2cXo+3h7H7XmONJWDu/F4mdNahTRjSI7lrM4vOg2m6/9ZrdfTWZOnt0Kt6w+KHMEhVtPvSTag==;31:1oGy/kCtExw16cburUOY5Y87ethQYgKpqzJhfl2yX8nLmEOW1e2JxJG0bt67NyiJzfYMTI98g2TJHG+Gb4+aeCPl6C3qX8rHC+i2UQJw14Bg8l3Uss2pdXcbXPqXruHSM/7QH81oNQeHZXaACfR7vb4mToLBA5zdMD7NuZCJ32nS15EU37E3bUH/3+q5R7cX9gcQcyPeWucmo4Fwo91bngPbdHmPAZ/ytsPLVoedoQk=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24513060BA2858BD0B5B8100BC320@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:porEC8bXxSa6qX8JoyZvasKQsYx4HKUkgk0l+tkiPHMiHzcooBXpR6Dd1rSptkD6cl0Uz8My0RDdUhS3Fdf5VzSPWly4Khaosi4GbQvw7htneN+mI6QYzSIGLnwVYBXCLGwgROrG3gB/U90ynR+6HdleMdYFhQgx1ssl1wAT7FI/e16zsH1Jt34mBsQjIvlouM+ST9fjPnPo6NxQ4lEY7Rug4a0edtovNete15jw46BZpdNS10FZDhYRtB1a3cIssDLhZyet1mR/0UW4E4e8cw==
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39830400003)(189003)(199004)(6666003)(478600001)(2906002)(68736007)(47776003)(6116002)(66066001)(3846002)(5660300001)(6916009)(6512007)(1076002)(53936002)(476003)(486006)(86362001)(97736004)(6486002)(11346002)(956004)(2616005)(446003)(48376002)(25786009)(4326008)(50466002)(50226002)(8676002)(81156014)(81166006)(76176011)(51416003)(105586002)(74482002)(26005)(54906003)(16586007)(386003)(186003)(106356001)(2351001)(316002)(2361001)(8936002)(52116002)(305945005)(7736002)(6506007)(16526019)(36756003)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:UEms0tOVGiSe9Boli5cZO3+E5uwrUsLDNdIoTMc?=
 =?us-ascii?Q?JZXX7g3bnHGFbiRw4afzgHV+5yDKl1De6XBF3BbDrXxLdAZp8BFhq2EMNxi7?=
 =?us-ascii?Q?XhZYpKlkIBpvae4K7oPY/+dVW0Z/RPdusX3z+zdCGGpKvaFZjdHZFesZLH/V?=
 =?us-ascii?Q?DnAhJd2NElCll1J3jU+N4Q64b3P0dyYptmuIVmWmeir3KFkPsTVGp0kNJpFN?=
 =?us-ascii?Q?gKSN99TKXyndBmIGJp5+FPb4qLAPB5lxTTKdpDhVAwu5zW+Qc/uaDN7jToRt?=
 =?us-ascii?Q?thSQydXOVoG5LCchFHiamz3KakuSe+0ZcLDAvcD6f/02wu83D2nie3hq+LRm?=
 =?us-ascii?Q?GTCYYL2nzMREsGN96+4BwryMgGXe0k2kTKLpQ6lzhbHB6NRQlgI6vp82bK+u?=
 =?us-ascii?Q?REicy4Ep1TO3KIsd22nUiHY0IgE862zC1s0fMbNhbTrXAlcOoa4GWA/U3/Ib?=
 =?us-ascii?Q?c9TDDnOKxF7uhUE8okCFnM6gTjAbCjpmTMBMDtU3+2yuBTgmhQJ+guMHVQMi?=
 =?us-ascii?Q?SYOG7JG49ye77egm7Kmi9lCrI+AoW6xo6CStFBIXpjib8LBzfGWgF21olb50?=
 =?us-ascii?Q?66yFuNFtBUK/+am3K9Uwm89hhGEWqqCmsuTECRKoQdxQAVmEhFX+ipgCTQI8?=
 =?us-ascii?Q?fyBuYZ9agMk0PQd0srTkSduJ31Zc45vma6tLAgNHD87WS3Q3xEQfMrorwU5d?=
 =?us-ascii?Q?H8qMG4ijq+pNuYMQWGIA9eBTixhO/2JzUaUqGjVMtzHGJfQY2JBDf+lkZWVP?=
 =?us-ascii?Q?4K9PscvL7ZKoatG/w6F2isxKJ1Flp8/VhdBEKwkBMpdVbKopp4Flj4v8pZUS?=
 =?us-ascii?Q?MKncmks12UBGnrXJml7S3dge7WOEiLjqzPvWiKFZgKYCtCR/q6jsYd3wJOHs?=
 =?us-ascii?Q?Y+Hi1eGH5BEWxl3x85cjLaBH6Nsphgia/NYqixk/r0kgxlpuqBGowNzAoGBY?=
 =?us-ascii?Q?LJiTNXObxUZnXC7BWIfUCHfKd/64Ha5MkaSbu3gTeUlAiAlUYLThTOaSIvPW?=
 =?us-ascii?Q?hdyQwdc1HhBvOyOp44miDRu+YD2pO5zGw49CFsa4PnMqTlL5Av+szxvODMzW?=
 =?us-ascii?Q?hx8q72S/EpmRZgyUy69a0NQK0SOzY5ku/mZoeDtRyJBL8l6p3lVCZ6yvN9ZP?=
 =?us-ascii?Q?7r4HnHT2M4eCod03pYNIgkidxW0d4kuU1pzzVeosEk5FQhRjOCWZ98B1MJm2?=
 =?us-ascii?Q?CVT+cPoovItOitZ5utO0lY0Yq70zKw9+7v44ZHJzfPJGhhZLu2tJVMQA6D1e?=
 =?us-ascii?Q?4FODNiNyaJspV4rk7urq2cEd5MdxDD5XlM20ag+rFqEjNJZjZ+v09j4C9MQQ?=
 =?us-ascii?Q?q8RS/4kygtpULf1wYqPNDYss=3D?=
X-Microsoft-Antispam-Message-Info: RZSpvBeVKHZs8CZ2ctlSw1IkBGSqABs4groknFUIADXKAlCS6saK07sWoLjls+k0Zw5phwAQzBQCu9sUn9OTyOc8woJIlwW8Z2Kh/vuaENIFbr/CtlW22yrlpAPGpsFmSAJ+ibT8SdDKKEs+iu53XmNAaHqvyJUhnXIS99C0tvIQpFj5TeN4t94g9C7ykw9qTlPGG2DkeFUOr8mNfC2gn1VNHQt/75FGyATELaWm5YGAx8BY3ZlcjG1UDfmerE/Dr0ynhyBcZRr3+OrnddW2J8U17PYk+NHzrEJCHC4yJHx5kOBZKqrItX+NvQ3gINPyfO7ejsNHt9soOFBjgPMv38FK/Z2sZdjWWOma2+w/9nA=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:0fAmGm5zVdRcrEEn0u5LBWNtn/sw9q3YXW0WJb609ItmKmEYlnJJhjs5YfZI5mOpKE1vMlIkgliX0ElEWBHFGE/DmLizFF8hxYqOVzidQ0XsXnsj1acGat8XN6doCrk92+3cYlyFuQ3Oq8Zih/XMRmnsCH3L++Jtoxi2pBgMPW91nsi0drtT+o/98537RfEGIMFOadweeD2V2hDT4BYmWNiCg3wjzT02Ry2eHGd+4O+IYywFh4j91m3BCgpJ+lgbJP8lAOXlcXyrJkIo+XqRTcyMLrVjHcPAS40tFlEnr3PLBBvtzFOXcKGy0y6Y/mxypl0bvORA2VBwwgdkg5R6CbJd1tr1W8knZ5vTsvJYwTHNPSQjsZMmf+dxI2EnGAfO7nIGWCItnfO0oLBz7GTu2Gap6E0sdO8saouYagdRqMPfQnDddGU4sS7h8yws1pp0YwAPmig9Eo7mmvTms8hCcw==;5:uWb6LEWdRYQ2bq2HLkpepYCrsnq/XHiIY8at9jt4A9i7PFYotrG5X0la/KCL/KPNFcqeZJRHy9tH8heJGC2wZhcEWBTHduuyZ5LQfwDeTlorxws7WUMntn3yVj4QKJkxx56vtMEuYINtlBiRQHHdsIrrCgnnKHdsHJGQu2Yuz0s=;7:lbPSaOo7hhaAPu8wKIIyCcC2VIIbi3U0Bg1eOuTAWbkhMBm+S56gxXWaGfD+6PJzA4qVd5nIOlcLSJ05XUctjAS/YguEGC/kBk4ou7161sfp3lMvmZSeXC4ONts8quO18lLh4XFi+K1a7CwngV9JkgOODXXpB5t6MXE28s8a5e0tV+4apHoPGjt2D+IDCqxuM3ad2zkRDsR9d8UGe1SUgYSwd/5nVe15NQzrC8yCi7hLIwCm4Ogk+D9UCPFkjfuA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:01:32.5941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5abdf8-045d-42a5-b4c1-08d60683e88b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the boilerplate license text and use the correct MODULE_LICENSE.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4531.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index df894af6cccb..831ad3e7871c 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Industrial I/O driver for Microchip digital potentiometers
  * Copyright (c) 2015  Axentia Technologies AB
@@ -22,10 +23,6 @@
  * mcp4652	2	257		5, 10, 50, 100          01011xx
  * mcp4661	2	257		5, 10, 50, 100          0101xxx
  * mcp4662	2	257		5, 10, 50, 100          01011xx
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/module.h>
@@ -403,4 +400,4 @@ module_i2c_driver(mcp4531_driver);
 
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_DESCRIPTION("MCP4531 digital potentiometer");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

