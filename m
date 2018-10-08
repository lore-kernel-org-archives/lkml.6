Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59445C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB1820652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ovr0Nkfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB1820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJHSZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:25:43 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:16928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbeJHSZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8YRxU6ZRp77MdBdP9O0LFcfZeMHtgeeMRYpWY2Unjo=;
 b=Ovr0Nkfu7+5PK0sXtQmV/4SVpkt3iOnZOmp2P2JCIQR8yT62nx6jhK+Bewwc7JLTjS3Axz5PsEprtgepdgHlwW04YZAntZBDchdz7er4UQrjZOpYL9kZrjAluRw38cE/+f4CBlzAy1cmEQkTyZFvMAwFjnbpZa0tbS+9YJXOXRc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Mon, 8 Oct
 2018 11:14:05 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI driver
Date:   Mon,  8 Oct 2018 16:41:43 +0530
Message-Id: <1538997103-11152-6-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4689270-1c9f-4ca1-3236-08d62d0f2b84
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:Zb0mXGYDOzvI+coE0/jGj0AqCFq3RtvXZESeQGO1L50kTovmn4+bXfSMOVDFtAbg0hFm2PbLDmE1WldpmAGM9cAiHm3S92xvpKUIYKkODfrHFnrVsQ49ulz1qlAeEqsNosMqleMo28NhyPF8hMzT+0m4xqKLfGWX5t9qLjqJLdTFfJsrEUsONN/Cm7OSXwKR3V/dSVbKWSe7BfcQRJl/PxjjiGV/RwTJ5EvpyIJfGuuRQSp+fhn/CucqrsJW8mrZ;25:pF3B8r661kTAq6gsR2lLxdyKH+hUcDP+SsQAVmGYKi0QFApxNNk5ZtIpHVTHiIjQVOG2cF4O92FglhZIH1518qC6v+cwnS7MEkZDKwupLLodUH92eJNZk1JsbJ7IsBeRNXL1+tKSaQWNlALB8jClM9EuPNNlqnwtVKDHLJWE3mB/dzIWEhqVFHFlYB4CSwmfGLTEpLrOqJ1c5Tb4jAu2IG5fnLdcOIfoeIGFzrrykja19iLWgjNi2CUH+ttZg4MtvH3KaxF3ndEwtV3Gkow2acHX08/0Z8+nRIhuNwqilp1mo8GcMfHlKNpNDTi1tmBSFqyF/1ErJRnrAPGs1ttCQyg43w7RrVFnFXEXkFhk1Y8=;31:QduHHEwTAMNin/m/L9pHHCFedYIf7vhLnHu1JlWuGiTSwwi9HnKUC/PrQHlsXwAWLw/UJpvIDuXezK9S90Drz+EO1dXDhYyszpd4zx4Wv+D6IgSdXWQyp6sKgiZ9cb5f8sGyjofuN2IcdU+okXCMzaNxUwnHN9nCu8X+l12DxfXJbyWZdRonAnBeeg7uW5j7nLDPxLPGO/wgb/WxMqRW062Ql1cH7wr4tq7WjmaKrkU=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:0PQQX4Ghig7E/zEmw744T1fRAaMA+AXvBVSofvfO6J5KlcD5hGhO4EMCKhyEqMDZsX63ln4GnjqrHtn62Ox4u8eV2GfVc8HozAJBce24k51fpWr5Ped3V5MJq7XpnUBTK4Xf/4Z/X9+oJzo7W8mmDlXiGfOLWcjsZES4BDLcE032u2eESyiQOjL+74uSug3DfQV4p3BSbnvPLxGSqrlIec0TWjg5Gm2trTRAsktahNcHedsmWOT5VpPPQO36ggMoy8lLL2yTLnAXnhcdLAXSwOc0wnRXV5XTWJEouNSxc/odGDLcy74q1InPNvUwQVRviEuXBAMipmgA6tWnSZaZ0XHd4OSm2zL/qrc9LD0tyMKfgaYg1AhFWDt42loO6CVkII5MWJ+oTufXuXIEBE/0q10yTbD9oMT1VKSqMXgTDFQNq3/B/HK3j5pS3rUzfMDEANk9IF3CBHh+tEHBmeyGFF87y+oUmvgg95C88UAPu5MJhXG6vfq1rLUD6yDFcHzs;4:ZWzjfZkFNoQi3L76llZAfleT+T//wnJQI6bE3JYsXHSOT9xXuXxRd81qRxZgLmYlnAbEtUlDYrCsdvUdcQbLfs/NEl7UpK3Zky4xBXcMlFkyFXF8UrOjanxJG2cJ8MbRKVmw5h8Ha/SqIe/4rGkGgXVhufvoTXkD4S24SGccKkRrfioe/JQp7lV8z27HMoupaWYSnepVwIbSsjebZcKn5QXpT9gAdGh+vor3p3PmBPcmebWuEjX8KQ31Mql7SuwMefxv8R3sWd3RW7ToIjs0q9hSqM1n6ODW8VjgpdCn+g1jnJfycaPTVaUFLfHwd9lxjzqSeYlnxi2NDqACe1SRu6l9t3tQphCsCcEZ+xEobYarEIJGlDziWMWXJAHLE1HT
X-Microsoft-Antispam-PRVS: <HE1PR04MB103401129779C4F8D34BDA1799E60@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(162533806227266)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(2906002)(16586007)(105586002)(6506007)(55236004)(48376002)(316002)(50466002)(16526019)(6486002)(186003)(53936002)(6512007)(68736007)(26005)(106356001)(4326008)(52116002)(5660300001)(39060400002)(386003)(5009440100003)(51416003)(76176011)(97736004)(47776003)(7416002)(478600001)(2616005)(956004)(66066001)(25786009)(6666003)(6116002)(36756003)(476003)(486006)(86362001)(8676002)(305945005)(81156014)(81166006)(11346002)(446003)(3846002)(8936002)(50226002)(7736002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:sCQ9V5k0t1Gp34c4WuMQkrFPKIIypgI3QyCDuYRrx?=
 =?us-ascii?Q?v+OyRrkLqLBKeGy609Ko/Uc+O3qfCSxtg80i/wfhqpDoOPaO/Esu3eREAUuY?=
 =?us-ascii?Q?Lpgi1XqG1+ZWmT7IptsVRbinhXX0GvWNniycCJ4Duwi/LsrUodzMF78KSzxh?=
 =?us-ascii?Q?9mLFz/q1VX9C8xVz0HZVNJwTdci7Azh1ZwYfgqtslplt+wdpJ9ffNlRZlSUK?=
 =?us-ascii?Q?AkIXxhSE+yBVrp0EPFITVkWOLI1UZZTifU6ahFAGtravFasf+5HRkKWyASly?=
 =?us-ascii?Q?XmDqwk+8wFBOLThtMg48PfdPzMXFlzBJJ9SanYUyW4u9T+/QU2hbXze+E1Bb?=
 =?us-ascii?Q?LycpSAmSC0qJgMfCWEPb9+EPWJPn6m47nG7jJov5qwVamhBwKbYR3Klvx1jU?=
 =?us-ascii?Q?KHA28cgBEK0KSYULU8fcLY0zbg6NsPe5m1QfkHM4loSoqv21xDAlsY86sOWi?=
 =?us-ascii?Q?HJOHo1gq9L1j+UNnp8jglLRHV6zQPysKU69EzbiLNxVREwJ5YxNQpRdb3CmT?=
 =?us-ascii?Q?8H8Op3G7c5fgTWNaIitPTE5vbg05Gq8e6Ya5D2mkolO02fA6TWJ3lW15lKUR?=
 =?us-ascii?Q?MT25+sSbPpmEhRXcMTWV+e65S+IXV87vitVXvwik2Oo5GaAz4cPWMD3W3GYW?=
 =?us-ascii?Q?hzYKgGT9j/Ip9PvHWqg+SyAeec4Rm8eo71CPPclDWOBJXxFRzP1nXrcfORKT?=
 =?us-ascii?Q?7s4JgUP3yjinwLDIl+NJeDH1ikFG6fXLh7mj0AYhqsmNMUKMj7G+AwH+LYGZ?=
 =?us-ascii?Q?O29z4J1bxmz4m71CfFybkoWyQuxQIICABRnCU05LCnh0NwcdKIxtT8+4Sbsl?=
 =?us-ascii?Q?h4taN9SGsqE85KQ5bU5KkUGkh8H0FptxcLuxe0HHQsAOok7ii4h2N9Ni8pCe?=
 =?us-ascii?Q?QxllCF7qMa2ZTo8oxv2TlT8uOSytxru1yRKj4R8Ru0OncCCemXhUhOhhwiX0?=
 =?us-ascii?Q?oAvt4T2qxiFssLPhXhjtyLWaxfPxDQr5pmmACkPP8t1TP7/FUtbJgTB7mBW9?=
 =?us-ascii?Q?Jj7zvI7haP0PfybDsOFIe+M1VtFqYfmeEdCLfeebEvHb0NShUbrHL7h3v2ed?=
 =?us-ascii?Q?ZbsHEJq36OVNYQnC1MuZHgWsGLa7BBL+zRiVxXiKBvOPMB1WhZm3JB+KIqlI?=
 =?us-ascii?Q?+UIN3mMTjejpP0oifGx9tEvNJYLY8cbAN9/dkj2ZYAuLs1errOBXah0ZfnNt?=
 =?us-ascii?Q?7WX9zaYVi2HJfvqlcUXUHEs6NhWmmnTSsWLVuS4Qgl+4JxlE/Jthf2BnLm6Y?=
 =?us-ascii?Q?jhW+K6E1pED9KRvXQKQSp84Kaao+b7QxoZHrO48?=
X-Microsoft-Antispam-Message-Info: JV4f1xhBjcISxCPC3efbycHppJy25qq7PyLrJGhStUHTtLW+/p25NvqJVdbo88SJExM0HM4qr6ZbTBS/jiuYX/QOf3osMnVaPIPQldoZe5cmS1IzKfEZQpC6fqleKDHXjRPa+lTbsfXvF6XplCWKMRxQVYWXrHaa0tN/JRhg3B8CC83Zrlu7KU7XSLbm6sag+rLgRVXJv7pP9muzrhp8j1fX0u1K+KI6ZEy9zBEaqGzCf42bS3YYeL0n2Se/0U6L4Y4BlL2t8tVFXex1VJtiGmjroI2zYLUBWRpN2j9kUcytHW7j5uMbwVccdAWZIgPf2hEcUNgVwB9dX4ARAkqmDUqIhzMerCSDmg3G5v/+bb4=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:xStpq377zZl/ls02F4Lq1ND9p283lps23F/mL+IL8Dt/ZI0m8KlyW48pfEispH+hJaqp8x57b4r1YtxWJM6k8BEVDtVIJoif/zLI9PP7NZMG7n6KAHG3e4BE4KADr9YTxmu0S71vQFHObj7IOlRXj5/DwXiQ5/pwZgmKzgJqVgoxYIgNpO7MFQAJQytipkHv9FSfz0mN1nzpAoFq4Gc/Ld8cR7/lKn8SMKGNfDF10dye2ynzN9BwOEAcJHqWHYhzH8N/SdsABPFf7FYfhhmGBJI38UFBz1N306eN5xrM8nbqaD0j8ZL7nmgPGTdOYBtbmk3Nqc1YKyJZ77F3NdgManP8GTmkzqGJgIU2bX+iEIn4eUE/QzS4j/8S2sTlV898QQiSIH7VbORhEmxD+QcFupWP3aWsI/gpxhilCDmloLCva0SEoaeVJyKkPTmEXozztn3R6M3CBHMdXH++7+RV1A==;5:pB1gI+BW8tkeb0FW9fvQfgiJkmSPqUpaOraNPRHG8VkkRbQckBA3Gta5TFbQXdGJd4hx53N47fzNvN6wT72BYLGtIZPH6qA1RBO2c/hAnjbPz0Xw40Zp0iShwTsAi44gFrHmUHiNZ6P4pl0v7TxLVjVMuxj4Negj/kxJTTci/Ss=;7:Yj1AyB+1S4cz99+CxFKwKCutDf0rkQdYvsm38b9SKgadOntYFeZBHrAIgW093HBvD+tNoolpCGSSXqrTFG3mJjrm0ezW0mHQB/fzcobSasIKM/CVDaaefGbj2ihpa27hMlRILd+DVrIDiVTe+kVsKqxi3sPESkT/+NyO0YDXFLIV65bV6zqJp+wNd3kK732yDpYkjxe74GNb/UbYuhL/XgLquAeiV5BLIWTYPrjAlXg8W9m2j7OHYjWTkyeX1K4c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 11:14:05.0785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4689270-1c9f-4ca1-3236-08d62d0f2b84
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
Changes for v4:
- None
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

