Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7225C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4286B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=softnautics.com header.i=@softnautics.com header.b="eQJK1L75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4286B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=softnautics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934244AbeFRL14 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:27:56 -0400
Received: from mail-bo1ind01on0134.outbound.protection.outlook.com ([104.47.101.134]:45123
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933481AbeFRL1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softnautics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM7qR27Ggr7ooJwlS07f6mSgFNpPMcd1ung59yvlQNc=;
 b=eQJK1L75TBni9YqPtK/Q1lr5Gy6ZRV+gIbXm6XS3CSBk1fWz5A6mxj6f6yLegwpscHY7z3yx5lmLDJTvCh2Cw736eGjCy9d87k//gzcU5FuPuaU9VFbp0NSlwSFCgqTTHWgQDPFNsJmJ47o9t5+Xv1O0XxDh0l6IX95HGLwEwkk=
Received: from jayb.sibshivalik.com (219.65.63.222) by
 MA1PR0101MB1589.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:2a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 11:27:48 +0000
From:   Jay Buddhabhatti <jay.buddhabhatti@softnautics.com>
To:     thomas.petazzoni@free-electrons.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Jay Buddhabhatti <jay.buddhabhatti@softnautics.com>
Subject: [PATCH] staging: fbtft: Add missing blank line after function definition
Date:   Mon, 18 Jun 2018 16:57:41 +0530
Message-Id: <1529321261-7727-1-git-send-email-jay.buddhabhatti@softnautics.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [219.65.63.222]
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To MA1PR0101MB1589.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:2a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e5b9eb-7d94-44be-9a48-08d5d50e85ac
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MA1PR0101MB1589;
X-Microsoft-Exchange-Diagnostics: 1;MA1PR0101MB1589;3:9i5O+M52MxMUKXptse7HsYnDjyghijgTWgHljkoqm8dNFbKVsP/AfcNHrkDZCsUU184DXQPt6IBy/BlZLKiCLkQfGl0g3F99sy0Ru4al/Y68yz9DXpuxJEqQwaHR14NoR91eZot9oiwi8en9SACiJEe1UAECu1kC2OLLPuE4GY1iRO7moYIhbDtQy0qMsdYAnhH5lX17POYsA07EpeDrFHNZzhrQdCNyjCXpepsle628zhHcO5iu+xVHSKxH/hof;25:OpG9Qp0h5HMOyaMZ9JeXi13v/PeKlSq/iM95yhP8AtdP1XOaAYUSzilfEOlfgbTY+dgqD/fS1fMGcrhX/AvNRtFFjl+DcASmlARqcgvXR0/g7SfPQz4Om29gNLK48RTCMJ/7jBqaZnSB16gLLVmxpRZKkTlYEYVduf1JQv2UQ14ewMcRxu8haW2epVT92LW2KaCjkMWeBOJHZGWViIbQYQDvA+bD+MFzIWqVrn/dISjqR84I3t/CGg7rTBm4Y5ECh/wXPRuozVFdjuaKBjh5FS5+C4ffFpp73qhZs1YBsI5bkfRshPYHpSdYHwhJ5GWJeX9CeOJfoNaa3AtEWAe8BQ==;31:ypCRO9Bft5gmXuH0eDstuXwMJSZHlwqlaKahcfMZQXnzpN+kYRsoKxSVJ7hiE6m4aMy0GNHZQzDbadMpRvIq26a/9Xuqvj91r9dKA21B06WH2wzMc8EPW8SgNa1WQptCc3nv35N2+nRNS4VEappKTuC6gaBkB2n+TXuDpLG2gLGB4bezc9uNs6Rj9ryCn55fejRg604se1o81UeBGl8ACP1vAIoX3/6N8YSYDT+jxaE=
X-MS-TrafficTypeDiagnostic: MA1PR0101MB1589:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jay.buddhabhatti@softnautics.com; 
X-Microsoft-Antispam-PRVS: <MA1PR0101MB1589857293434B343415C70F8C710@MA1PR0101MB1589.INDPRD01.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:MA1PR0101MB1589;BCL:0;PCL:0;RULEID:;SRVR:MA1PR0101MB1589;
X-Microsoft-Exchange-Diagnostics: 1;MA1PR0101MB1589;4:ozE25OAaTA41IL2BznSGGcnqx3SDtpSQ0INl9vD9irwp17fWEk/EWRHiGGJzqF6lPZ36wAacQwV6A7SZi0rEu+aTM9wJ7u3kEK5fIuAbYjf8JsM2+UGGbET5a/Zy0BPCk+LhhYqjKcUXvCzOmrqAfDypEOZRToUk2o4MDW+gCHPK+kgaIrl0rZUwi4Cyy61NvXlnYpB+CpM39MhlABrPC/HnqXL6utbUOetBKLoQPNcmGthpCSshOUsA5cxVh7Ijgo/anTeWwQe5igzB+0v+QQ==
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39380400002)(39830400003)(199004)(189003)(53936002)(6486002)(105586002)(575784001)(86362001)(81166006)(8676002)(2906002)(81156014)(106356001)(53416004)(8936002)(44832011)(68736007)(486006)(476003)(478600001)(52116002)(7736002)(51416003)(2616005)(956004)(3846002)(47776003)(97736004)(316002)(36756003)(305945005)(66066001)(107886003)(186003)(6506007)(386003)(16526019)(5660300001)(25786009)(6116002)(26005)(50226002)(6666003)(69596002)(4326008)(50466002)(16586007)(48376002)(6512007)(1857600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MA1PR0101MB1589;H:jayb.sibshivalik.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: softnautics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MA1PR0101MB1589;23:D+tUSITrrNqa8pfviRALt/0UULqkfx3ywEsvEJd?=
 =?us-ascii?Q?oTy39ZLvVotA4qg2J5qY8fKreS86+Iow1+XBEycccWufaROz6FZBQnNP/daN?=
 =?us-ascii?Q?x4huLHNqF0z+wUCuXC8e/+eqevZAfoK6gY68HN8cLVPaL1FJk61uXgBG7v7o?=
 =?us-ascii?Q?cg9RtQN9Gpik2WASm2jkTt4T5t29eX40FG01eej1tSaH+hjfPgraehiGAcwN?=
 =?us-ascii?Q?OED6kWWhcWipeYxPYCMkhINWUV9NZ1oxrg9xxsehssUzPhNqjai+iNOJIsz9?=
 =?us-ascii?Q?dLvJXXL09C72ONsI/Rc2ltBm1u8ITLrVF5urC9px49wDPajk/eIs000Csxm8?=
 =?us-ascii?Q?1ffr2+v/SI7GukGv0uevayolin3A28Cq0lFUzbdfck5knClXz4TRWs1DQtEf?=
 =?us-ascii?Q?6nyxc6TAqTNFVdcfkxQCx94t2i2xhl0A5BFxrQpsrDd2NQc8I2mijl/fTSQR?=
 =?us-ascii?Q?oTLGwtgRRzBdacqjKYsNUOX2Duo4YFfY2jwDS/LVeindeoP3nKhqKYBJbLKk?=
 =?us-ascii?Q?Tt8XIUX2t9IpP5e7+ZLzqqRF4vN925AAAUr1c6ruKKbk3yRUpR9Bp1sJaeTi?=
 =?us-ascii?Q?UX3oJjBzmBLqtRptEDbJ/7C34DTYI6bhD51tlmujauGoukG0CZrAbJ9EqiPn?=
 =?us-ascii?Q?0gcWhdOY6ZyF5uWKsmphfRqEvfd/K2iRQqhWvgUIZ9sbhslOBYEbdryNm8GQ?=
 =?us-ascii?Q?L+8aGKWuaepmEsrfhBCPTVsQTO6G3uM8YseHUaSQGWULDjooQNQypDm9LmEz?=
 =?us-ascii?Q?3+U/Km7BR/bFfawFszfw3VjyUiyyTyv25o8q3VZXYG/aasj+SMPyb27xdRDZ?=
 =?us-ascii?Q?h2j4w1dsH11cMKUzHAchUT9y4A1Tcz2sWQR4idEqJpXb9mSLFxDPOuxiYMXJ?=
 =?us-ascii?Q?ghWrSdYaX+cFwSTVHy4e+NzpLZzvoTiVyOf5m/Fz8GY4JJSo/msYVKb2bFNc?=
 =?us-ascii?Q?zRp5Ify6emXKiDktegWPP6dDTFI/MpDHK7FdyItCNKyfupdTeradm1skxRY0?=
 =?us-ascii?Q?BMOCgQEB1PQXF+lfRiHAZ7vRQIXx5Yjvy0KHIxBfw9JU33kIfbDb0g+4INE4?=
 =?us-ascii?Q?RwrkO9Bo0NMqiyAydC95r8LrLf6ktyf599cp9e5Qgt7SuFTS7LrVw3hzYIxs?=
 =?us-ascii?Q?hitmFOeqXEgXFETAnj/h/OblkfRGAqYT703Q7hVJ/jPUSu1FG83cVqjAuLNl?=
 =?us-ascii?Q?Q619JiDjs7LCmkb/sBJNQ9q89CzhW4uweGTy5Me3rcgYzDD9C76dvsPoaIA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: +ggBIYKaPqF1c6fx0i6HeJNqC8l9T4Q/Vi8CaRYQts+2rG5B1YiVjo8ToDP689yz5oJ9DwLAd7iPVTOW16jmgsVUbrQBiO1oA1x5WPGr5tMBmIqkbX8AALyh8wL5KnIAqJRmKlb3EbP8WFD1vu4Lqo0TGkcv6iOZU4JWhOw7ouXCpOEykkE5ZXeF9oVqdl58XDS1GbKgpang15IV7oA1Cqk+H1uk+UZ6AjQLzfh9DGBMAGfmWjukw86spaNqcyPyvEdE99ALR0wGEbAhTleOfCudp17i3F9dJwN1yCIXjkUQAh55vtQtf1XMXV0Zo0u+VoldSHeUqdTyjjVpw9xQfg==
X-Microsoft-Exchange-Diagnostics: 1;MA1PR0101MB1589;6:zC09jFYbpjjg32BXljhseFQQ+2cssgQgfnggPx0z8drpZUoqW8IF6yhdEPY42aiI0C1qV+YD61SSoWGVU54qVz7p5pfaAREucjQIEjJkJ3cjBpP3E0Lc30xh7lQoGbChK6q85Pww5nYSCY7TeG1daV7oTYU3alP4FmgIpvwR2JXlNVUYYk8T9PbDu/J1+R4jFaMJn+6cIhM6VswVudwl1hEfXDwdU7jEGiAxPiXkpaW/VM4nf7o5s8ogiWncQwG5qY2YhXIBEfNYPRC9Txt5zrJn9XSnJ93e17u6fq56oSwW7N1Ex9EaBhWc2NPtxzMMUHr/8xIWrZWRSZNg/cL7Cb/XrDKospmIU6CKG7qBUvAoQ/F0fpKKC08fHE5sUxQvbM4CS7X/n9me/OAS3KS02RMMmqa+biOL6W3c5FNSjAQytZJh+7hramqAh4Q4QCHgyEft6Mxr1fKBuG+vB5EUrw==;5:MjkZJ5aiIBFthos7Srsn+1amEJAPYysE8y0z5BaEChQNRWNgIBbRxMaSgPJ3yHNXy1f6I+4Xjm00VVxnRuAtKQVIEiQdCRwYVMrAPZGr8wU6U7sJLZ6mpiRWd1KAwyJZgMqWYkKx7JMU5EItLyYFmbWLS6Z9aetA0dIJHlHQ1ns=;24:hyNXtxacaTawvIaDRniWf5DuWzrRfb3jWHS1ijtSDv1LGsLA2wP4MDXs90F2csiVI6ekY9lHilWxYQ6goEQa6iylhurNWHiHLU6hy3PtZ/4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MA1PR0101MB1589;7:rb+qq9GUzfh5euCgiHLBMv5Y0YRtgSAUnUVcQXn06e9jO1ZA8AhhKkujcRZyrpoEsznQUPS4e+EzgphUnXU/zQpnNXR+UVqzGZPRWTRB/awhqdW6GAGJjOTOCx5hsy30faeV04ZW/369vUKBug5YtEV1zZQQy2YNtVvnKFSWahvcLdGSMZ2Uj6ytYoNmEm5ZPRh3ILcaPmC3z9Trz8jfnpMQkzDjiGtFExP7Df9fA4pxLAYAzTQrSi4eaQ4XdhEY
X-OriginatorOrg: softnautics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:27:48.4389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e5b9eb-7d94-44be-9a48-08d5d50e85ac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 17b76cff-50c6-4f7a-9198-dd4afc5f8bea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR0101MB1589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reslove checkpatch warnings by adding missing blank line after
function definition.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@softnautics.com>
---
 drivers/staging/fbtft/fb_s6d1121.c | 1 +
 drivers/staging/fbtft/fb_ssd1289.c | 1 +
 drivers/staging/fbtft/fb_st7735r.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_s6d1121.c
index b902442..b0c7a77 100644
--- a/drivers/staging/fbtft/fb_s6d1121.c
+++ b/drivers/staging/fbtft/fb_s6d1121.c
@@ -154,6 +154,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 	return 0;
 }
+
 #undef CURVE
 
 static struct fbtft_display display = {
diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index cbf22e1..b35d5b2 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -153,6 +153,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 	return 0;
 }
+
 #undef CURVE
 
 static struct fbtft_display display = {
diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/fb_st7735r.c
index 631208b..c2089f4 100644
--- a/drivers/staging/fbtft/fb_st7735r.c
+++ b/drivers/staging/fbtft/fb_st7735r.c
@@ -152,6 +152,7 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 	return 0;
 }
+
 #undef CURVE
 
 static struct fbtft_display display = {
-- 
2.7.4

