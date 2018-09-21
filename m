Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4005DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54262150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w/JLcndj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54262150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390035AbeIUQMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:34 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:62342
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389593AbeIUQMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNnmsP/KL6fR3heFUu2WMTvl2ixsXPG4yOxuaPOcn4A=;
 b=w/JLcndj5soyufd8IOOcysZKkzg1tC12WTO0RgRvdJ/j2UVQSDvoqgLvWkImoTXhPKMIWOKFMWGo576izIfbWGJd8p7o1jYz4NaXH680DqLL79JLnSyaT0v9oi3Vz1y/HYcgtFIuxiaJ4lNvjZNnWM0tHuJPLSRssF41I+YTZjQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1028.eurprd04.prod.outlook.com (2a01:111:e400:8443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Fri, 21 Sep
 2018 10:24:10 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI driver
Date:   Fri, 21 Sep 2018 15:52:03 +0530
Message-Id: <1537525323-20730-6-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To AM2PR04MB1028.eurprd04.prod.outlook.com
 (2a01:111:e400:8443::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e8094b0-6361-442a-5823-08d61fac62f7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1028;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;3:cpIqrYvaLyNXro2fj5x0IB0pIZ2rjjzmXH5+1R2Bwy4mkopoiB5LJ6cx4os+NXc5Mu+HRtVG8hK0/MkqDhcoah6UpMookndMsh/DvEhvlixFvQNvHA/U0/puuO0smiZqEUvg+5Z9pTnvCyflxcTnKadMnr6hEka4Cdj/A2P80i02go60RapcQHed4KmB86aguPgibGD/ocySdQiN6sbPaAvg29XGKgRo+8FDWZwGlnhZO2+29WXt40z3uOJdkt7c;25:cw4NB+ZyDIA9hxnq8yf65xm2nK14yMBSeDJkJC+RLkR9RQ0X1YwnMM6EzLhMN36bqd99hIYv3azovoy81hBvtGgpoD12dNzuv6d3ctu+W75/505Mvt186qOeBCgoxcPEPvszAVVjSU/+jZyUtvK5AoIifN9YuMuEIa+J/HwNwcsRKS+rOC7WDe6pQWuVS2iAIYxIqvVYnM2mc/ENkV4bzqqwvRh38dMdVFnEL7B9EKPEFb/Lne/IaIUQHSHhjCBPoliqOXySgj/TuJ84tHcc5xPy4vzGSUaZHSSrG/D6VM7Wm0cUN+H/GJ/R5jw0JKoceMFBpW6uW4SjohNpiPC3zQ==;31:uAjiZzEPsjEKtXmODarUnt5PJGjGD0i9E9Oq/g9dILWo7MdOHt9GxPtACaDttL+HnOng6GAUvBsdGaMRUptEK4OHPRrjWFJaHg0vVMEpEQ/EIS4I9nALOr7P6mAQuWWlaUFOWTVu9TIIpC4EQKe756WHdoqybtgECjmKI+AhW6iZREbo9SwCTLFsVe3pqvt6wRasaSVcjX7y2mPHp1ieuJKJXS66I/TTK8tTxlAw7As=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1028:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;20:VlsdYdLg02Hygv6E7+L1CKEIBUfFTQR2kEUjXo57dK8r5WUlyHJa42/P6bw57dC0bR2cA1GED0vWaUW6OvrAY+RoDFHa4jFw7BfY9eSxcoWMzN9FsPaTI0MJ2jRgKsvqDUp5M/WAc2gEdub37c59mWPisxtAWVti+XRzDz5gZEpqTbJS8omHn4usZCJ4nFS5iX1Yf1xkbykD98fUkpVZN6bhy8glmZcaJsKUqrvpwWCzNcgxrT879Z4xTlU7Stias3yoTSwK5W/WFSX7zqe+G74Dxq0Nn4nnv0YlRO6Tuf75keR5IypFfyebOi8wVJ+3MHCcJ9pCid+tUqQwLkEISgUT9QRt9t+7t0frTyV/Xcmn0kSyd5lg2Wfg1NcCTWqTvBCOX224i175u3Sph9t0whb+eSLhjKVbr5fDpV24TrnS3kR7MtXgLMjGeiSveOlN0qxatHbQWG1gfyaqJs1opfpbGX5bQGt83shTzzL+6QDQkey3UBeGKdyQZWgWco1c;4:wrNxcc03EdqtABnE7L12K/fG0f38N1CptqexwAwMUjRSxNe1R96FPHkJQrAdUe5wDqgj5Gf2yeoPqx5LAWLfOZJbHX8u3Au619MfWEV+tItMMEnTK+3MIc2V1Oq2hpMMDjz0zwHcA4Vn8Rc7hUCWQRNR3B4J2Hu5ls7JAoB/kVWy0VVJUkXgMSz81w4oYP4+GIewn45dc9wuOdtAq5yy53+ijN8GgjB0UhDdW1oFFAW9lVrssFjyXs2hgL0TtTkI8N6muva8tEFuFXnB8vOE2Ym4Z9YMeOohn1OxuoXc6uZGxFpsiyeKlxKVAU7JOkf3Q1bnU9wEgQ/fg6N8u0OrAHOuMSvqd+aeTL82EIedIWLRJhCszPNh/Fa2LNvyEhQB
X-Microsoft-Antispam-PRVS: <AM2PR04MB1028B1421404FC2B7B8729D399120@AM2PR04MB1028.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(162533806227266)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1028;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1028;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(48376002)(105586002)(305945005)(2906002)(6506007)(25786009)(16526019)(186003)(81166006)(66066001)(81156014)(8676002)(316002)(2616005)(39060400002)(956004)(86362001)(476003)(50226002)(26005)(16586007)(11346002)(486006)(6486002)(386003)(5660300001)(6666003)(52116002)(5009440100003)(47776003)(51416003)(4326008)(76176011)(68736007)(97736004)(478600001)(6512007)(50466002)(7736002)(8936002)(36756003)(446003)(53936002)(106356001)(6116002)(3846002)(7416002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1028;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1028;23:ZtW+0eD1f9B54u54SG2ESJ9Qk8AH4eJD4zTEkr62l?=
 =?us-ascii?Q?zBUCj80JCKuNVINK49ZXWU/SdKTzLPHj22d6eEhEJbQf+c6e1uPOsrGAW4ew?=
 =?us-ascii?Q?t2gqPns7dj+ygJqTUxUtqGK+IJQf4po+v+w5tvvtWwujlH61i5YMj+bcrkh/?=
 =?us-ascii?Q?iBUTyKorlwZVj2s8QvHQBCw6s6zx97B8Y9OezrIZCZuO6pkjdpwsNrLPeG+K?=
 =?us-ascii?Q?NyuJIH6fFtvIu+InT1oo/ORkvsf1REaORTGTkxQHM7yG4QHfcw56moOORrln?=
 =?us-ascii?Q?VdZKsN9WlVq5sbhPdGs25165oZyObzy0eDlitHO/Sg/RbdC8oOlTb0RfI2Me?=
 =?us-ascii?Q?4y3uzzhBgziz3v7Zr8whCfmcYlJz1TKgX3ESD8Dr3CoL6D1kE10/6qJLvL6d?=
 =?us-ascii?Q?TWeiyZmDlkdmNUlUYLvdZqTdyARMnO48GzD/RljdqHmOmaPa8wP6hVHDz0Aw?=
 =?us-ascii?Q?IZzd9fPnedSpgV9b9sSXRVnhxt3bwOc7hwwlG0b2tFyGk0CTk2TSeUzz6mom?=
 =?us-ascii?Q?/2leU8F/veqTG4Bwfs5yiMajM04I+qaAbZuau9WcftaWN9PrKSR1iW8tqk5M?=
 =?us-ascii?Q?ZeUljB/HX1jdSVWTP061akrTBMVT7HW4nUJzzBZfeQgBAKfmTSzDlEbDjBAe?=
 =?us-ascii?Q?L7QktKmyivnIQN7QpvvctzcJ+fJau83r8bS5Tvh4YAu4V2eGSmABdDjkBh9O?=
 =?us-ascii?Q?OeXCluMY1l6o9hd2lc2+WCoWKGGP0Vr9j47fyImxI/aOdnOsRGVfDRZ9Pe6r?=
 =?us-ascii?Q?HJxnKp0Zsr4EOMH/Kejs5UoGM5pSJZo+r5CxO2yQ68Qq2NxEKa1jOLZJfYYs?=
 =?us-ascii?Q?c2SauaN48ENewkzKTrIK6B9vg7mNpUsTunfeyEu0KY9KhmhOkMYIktC9TC9s?=
 =?us-ascii?Q?iO7wuUyFvZG/I0naLs+4Gnp7XHl5MKHTxLBzTMFc42FwhvVJfXLDZ3kxuWkE?=
 =?us-ascii?Q?8whk2wvuXFa+SkV+SGiaSoEWn8YAA3AeUkAG76lSks2njWg2czjZyucQbRAl?=
 =?us-ascii?Q?xzZOlm4+15ukmA2fafmPU6Mv1dRELnvOKbP6LIIXa6v9p7rCWmkJxlJk/amu?=
 =?us-ascii?Q?3UlkPGvSc3IVv/CEcT1L8HyGfgxGcVdFg1P0jlLRYbr3j70xSIgN5QT2N63y?=
 =?us-ascii?Q?xle5BgTYkqviyWV4xF6RWpJI7Y72RoEzDZav6AMwLFQYUXCEAiELV+5who9D?=
 =?us-ascii?Q?1sIhqcaV6wQ/cSJ4y2LIJ9miS+aTCR+tlvoKeU2hFE7oOLVMYvJYH/lOJKMg?=
 =?us-ascii?Q?5C0LfST2+gCydN7Vus=3D?=
X-Microsoft-Antispam-Message-Info: TI3QzwzAuhB7HnhfxKYLyGBq+FJKLCOUMf8jCI5lG6/xKoGLdn2noEFgSDtWy8Bug8DrWWMhl1y5rs9gUHmJiCQiUSwUKgBAoE64IPMfF1BmeEeFz6UkALEyq/TIXrAjKFleOZqCy0kUK5LuYyWK1yh8Uo0m3KCB/9fRigYfipeioUHNENivy7jOeRI7LOeRLMtpT7M4yqBSWPVDa5G6m2PS3qL5rb9CRtedhvMpPCDdxXOtRDo7TRvLbjkexl8oHaEaFJH4ar1yPcWMT122pkw+Zry13lRiTB0BWVSyno6emYhAMkywOzqpkykqizT9/BAsXQBYt2W8DQD2a+dvpk3qYC0ELbT3E+790BXGMQE=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;6:at2b0lcN/cSb0TQJYDZI2NrJpsyoqODhnt5miU6ljDRvlQZSvDCTrC1OA52+Nl2zoOl0Z+QIlkzbXDO61tQhY7r4QPCHKAU1V/T706GHReZLOSAdq3oNJN1gKkGr6a8FDTGoSzcp1qlnQ8p6ryKb2rHAZ3wKzMoJv0GsWb6hv06xbF1Y/haA12PUhoIckrth6UDRvrrW2QoOrsU4X1Gp0llKi/JsKWD1xPCEKraRhJ1slRfAsaCOxk9QpZzMJ6jHQUszJOlhQpvcBJnB6VMhKbc7G/lyctfAoIenl5BHgb+ZCVZB5Ch5bIVNsVGbvpxFRbeFbCO629qfydvNXhsxeRglDAPsHMs1OM4NRhVPvq9t+bGwYBq7q8WaS/JwHntu4RTcS+ONKm7NNTTCt2uXPYDgG4ni7seGOXfkfbYuf4K9P8Y5rcAIsFVGPdvYbNVITtoN0noqlXPatkaY7zxm0g==;5:V4gip/1jORKqUvafRZlwUQ+ZGtgKWnvblEegMpJN+Jz7bOWIWdYM6f9rQjKXUJeCv710DCmZc/9bEP+J295M7PW5DmEF4l03nmoCNJTRTdpHDQDMbeeL9+1gBIagJqNLzfmqynZxZGQI5zKwMJ3q2fPRewYR18q0wxleGnppgdo=;7:/iZhoCd5zvUznloUQCVpdEaJYksWvTC3S2aad6epbB902JuZLy6sju2kxaRxx0nzxBrAHcGc6NAfbAJj3RUTXqNRxv2LmkUlvN2t3wZqlx/Dw/Bia9CSNdrNVdwDvHhP9g98RXVTFQTtyYPo7udFzG9Fs/Fz2z3g8bYIN4lQAHIki6O8jXX7dNtwYB5ptp0fbI334n18Ih0Fsnh+9k4w4B4EnAVqgwG1QHB8Bh6aHFY48yHgStFCnl5fh9vmfUgc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 10:24:10.7415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8094b0-6361-442a-5823-08d61fac62f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- None
Changes for v2:
- None

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

