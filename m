Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB2ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BDF2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LJcLBpo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BDF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbeISLqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:46:30 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:36352
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730984AbeISLqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap//2N3XgXIs0vcxKMleyRK45UqgNYAKxjGmzKm5sDE=;
 b=LJcLBpo5cbnTMehzRK51WWdqqQCTEtAXQI9MdjPp9829Kzxfzm49af0oLPIQK3t5Vh73MFNotRsc+euGRqePjUX8SvjU4Ui1Ku1nUWf8a/H8eFmk579EUJhwHH9p3fMd1wf0tAD3FVKK+MzFsWHAh/TRCNiWy9SP0i4xp9D9FZs=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3919.eurprd04.prod.outlook.com (2603:10a6:803:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Wed, 19 Sep
 2018 06:09:59 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/4] dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
Date:   Wed, 19 Sep 2018 14:04:47 +0800
Message-Id: <1537337088-28819-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:2f::14) To VI1PR0402MB3919.eurprd04.prod.outlook.com
 (2603:10a6:803:22::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc5845a4-fbca-46d2-b69e-08d61df68af0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3919;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;3:gACaHNQaSB3zhXr/vXd+21tWfnqcV+wZyvDz/HXCPVECIg4o1Qa2CnXJG3y4oO4gVRNohZRGKnH8c09xEAI8IiVK1l9imZLXV/GzA/v6x4H9KfXGHfdBH1alKPgRe4z5CZpmo9aw3dcB062DrWC+lq/s3u+02TjMX+i/ylFLRItKKUir/MB3F2mzwV9lKGbkSqX1hWhbsyhj04a3BJBKLwNnFneyxE+aLgB8XyaibEBod20WFVcf0Oj3CWBaErul;25:MA4VZ7BQF7V35sYk6ydTkcEzkBpp/xC9/7eLbe2mQJCzUo8umpZ/cTnY7cAQFSixLnSolu4VgP0+MFKbYg56NxD/7vK+0f5cAY9cnBmNMcnRLqwzzjjcdIODPoKK23tPVtRt6G/+bVBJeTp4gzKFZ0tBWSoTAW71h6/E4vVj6zkCPgo4ZpuOXQKu7gs+M+AQSd3PTlJ8KUcNOtIcj8rOzH9ec/dTxRA/h0KnzPYyCnaje5AACPX2Izo8w9LUT+aPQ/L57xN158//6S9l02LcMdv9xXZ1SCCnfwSUOv58C8is0WkSClIlREzfT/bnkXEtAAYdedZk2SGZBzy7rBu7sA==;31:bkuxWzh5SDoMTcEksYifWwUeHQ1NkxeTSLqrpKtG0JccWBZ3nOLECF7otcfnzy3JRoduK+d049Pfc2yFcojkQUTPFy67GrJSzbFuDXZOc2yDAXhnZJDzQUlQ8tBu5xtLSK0RDy8yBsOuvNB3scB96ikmP2J/8EzAsHh8hwKKGAQGuIzqhV5K3ntMpUdss9MX7ro3dUQtkjlm2a/e/XrUO/VdervynAEGgx+7T7vO8f8=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3919:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;20:1MltkmOolxdjzIJxqlV74ikLntg9PP3nzL+mDUwsMOSLHM7U8UQUhRsBgT84vGUTVQYEGzk+Dy8BBPl+GylwoGjSOpRxHT+yoSpwndkdPeB39lZfTkhnzAAVtUaRjBStl4sBfpfMC6gZxEDLFPZy5YSCTUxkKTHOyDL+A9P3B8pDztLgJhOg1j50WnmDOk16ms0eDacVqqh7zLgMz4YZzQJeWhffC3XG3Z3Ao7Z0S1fWRjD/wqBBArYcIj1CAZwV81hTS3/IIwvcdr3oSQTqtDv3ZIbw+66NWARbav0ikcXW79ktbmVblG0xTz1Cb40sBsRedbBcFE+mPXt2h1twtLlJrlimyifbgA7mrZGmug9tsqsyZELMdDDW+LaiWY5Ky9XZPTY9YIkY9HXk+7tgwq2/HpCaxsxCs+SrYHJYp/orDceYeI7vON43hvCNtqedelJIddJrYVzz4rhnqdeOvgBYCvp6O1N9DOizCkDoP5OTBa1bocYvofuGtFDgUz2k;4:jYKUA9aM3noktFrQYs7WEtU8XSnQJmVcnv27cWW2CY0v/SiVCCalZfC0xHSRi2794MRGo8ZBrwrX/DtgZ5D0T/L4ToO9JtyriW2FzRJcyRWJbRq0QGxmCKYSvCQaViGAq9WDV/r+SgrnOLYcJnaPRm3wdJZc75u+8FT9/nf2ln4h9DazmCcg5e6u18QAt1ySh32xaKDY96zPiKTG9sGoPBznAvACneNPw1c1I525ozUpccZk0VuDqzV3H4MzWLvhaI0HHLky/QM2tslPL4LLf7fjt/GJ7CjvN7Wkl1WqhWfb9S0gXHdrUmII5RkrctjL
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3919C34BD28DE036C515B582F51C0@VI1PR0402MB3919.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:VI1PR0402MB3919;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3919;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(6506007)(51416003)(26005)(486006)(4326008)(16526019)(36756003)(52116002)(476003)(956004)(11346002)(105586002)(25786009)(6512007)(386003)(53936002)(2616005)(47776003)(6346003)(186003)(68736007)(81166006)(81156014)(446003)(8936002)(76176011)(50226002)(66066001)(106356001)(6486002)(5660300001)(6666003)(86362001)(305945005)(7416002)(7736002)(478600001)(575784001)(2906002)(16586007)(6116002)(3846002)(316002)(48376002)(50466002)(97736004)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3919;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3919;23:Vy+objfz0VyfuqRmXHBwqAm/ZBAwV2KEfkYb91r?=
 =?us-ascii?Q?/42w4QI4iXNwq1ZuY2Ms3jNlHIAxgQuXeLVl9VsnRrXUoVv69UNINQwziW2/?=
 =?us-ascii?Q?FmK12XxV74w/279Qwqn2Ho7rlHGQalLXRJcWlKWMhDmuLD/MXoGGmCgoEplr?=
 =?us-ascii?Q?aFHMiKzodtqlSGxX7n3OwK/osuIZHnT9Sivqt1cAQiUQvZF/mdA0uBT9fR8a?=
 =?us-ascii?Q?hsv2UG7R1MyPmwYpM8YUVVcMnttFg1My/Vvlj55LxMntkqVrzfmxr1t4wWWm?=
 =?us-ascii?Q?NKTZvfW8wNH86bo6h7AaT4PVnpicvkl2fk3Psm0+u+4c9ozBgHYwWdxfnKM8?=
 =?us-ascii?Q?b4sB6fKLpOvm2CFBE2ZnZhO8qGM+7RiMFxMMAZwForWLwiSfkWa7LRiwLDrl?=
 =?us-ascii?Q?HfhBLip/nQQWVEpP6YsODM2J+7sOXTUMNPbMUgjsbCeT45rcZGikZow5GAC9?=
 =?us-ascii?Q?SZLGdascNGiFM+LLSwi5FxQ+8Sadmm0jLsuG+6kFNoO98nqH1ZOE2uEzYyQQ?=
 =?us-ascii?Q?C1JsqbiqFQUzGBO2rZcVDa3SEzNrdvbYfNBeoXvXL/hu/Ib5pe1VnG3pEyLP?=
 =?us-ascii?Q?Irz12RRFWYf534nA03HLadGYFZDPIxz3pfysD6K8X9qjR+cgJHaM5/RkbATG?=
 =?us-ascii?Q?aCLZF+YE/Hh2FDlyV2Np6TiuO2AIGtXYBAdiY3FsLRkskOM1SfynaArYdTiS?=
 =?us-ascii?Q?GsiSQb5Jeal0/x1qch4D6T6KevT2xF8zNt48yRjxWHwbVKPI4s3QEuNa7Ztl?=
 =?us-ascii?Q?OB/79idF+vpA0+XI2f3+ficKx4zdzsLglH960QyiD4pL9C5lfsj4D+eHCdOj?=
 =?us-ascii?Q?kigYKvIU0yTUAEqFRWw3u75rfrvn1WiASAjvksyd2j4ReXd1NBp4PzSMhrlz?=
 =?us-ascii?Q?uXdzPhlbLl6Ac/1cIhaxq3NCscvVIwF48a0Aj+1Pz6Gov3auv38nqYhJQ0zR?=
 =?us-ascii?Q?hepGvWGsEB+fB26fJhjfk29VZpzDl6d8XIZQC9bi6Px5E9k8aJRHIR5evv4/?=
 =?us-ascii?Q?/yCohXH1GsIHaTcYIajH3dRC0u8129cVIwElfDrR/RSNiAfdqjQFC7ongj+j?=
 =?us-ascii?Q?XrCXT9GG1d6+aPfbs6QcUYph2e4I1VZEaHRMILWOQpW+DVPsNZj3bZYJoAk6?=
 =?us-ascii?Q?dJJyewMA/wf0Kzib7umGSOWFmST6BuqHCrJH+Y0+hg9fjF+K/+WA5U7WNPtl?=
 =?us-ascii?Q?427+KRa4S7YSOFPXzGH+XgVpK3zHshYwwGuwxbHVBwN8jBMoJpjJlQbeyCVG?=
 =?us-ascii?Q?0cu7I1/uMUctvwC4gpVk=3D?=
X-Microsoft-Antispam-Message-Info: tSqoxOo1ba7Bkp5SLF6BQjKcAbBy6z8S7HN38nfAWqCafn89+Dh4swTiFKu7jVt1jkNeeTFzk2jVgW/BIqglvpJAYYyvVc/lzyLgp1Ws9Sc+QbpHblDCft60ai7X112VFAIhQgXeDSNWHpEdmspJ4OISA+/fDW+BabiS0oSkMeaQuje8k+3dBbZXFnmfTbY8ecVm7CxvogWDFjNVrr+N/KoZjssGfIAcDlaUth6QlDghX6Szk0NqoUn06u5g/qHUbtj5UfUXL36btpDCX20nuNDMNs55bs+YedOQIlIQoakBTtyK0I4CWoRyzOvxBjL0tKkSDD67fE1krMUrkwVc6qA3VY1msju8ajEn9vu53pA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;6:wLSjf3jwElzqrf7ALgt+tMheD6WNqHNSPkDa4Z0mH3Q0RSv7YjsrIyw4uktyZ0H6SaMCgLrik9dJdkCBYd85+C/kponE/7KBNKkAEWd31wJo5UPBQSj9hb8VoalZFIKrft5BEYONLDCTiPHgTccZ5Xxh8krRrB9q/deoQ0aQl5N1FcnlE/9g6CNRRiTcXJfK6YWDkw9pY8hvwpnj38N+QJD2HCsy6W9PGIXhmFjGhcHwAE1jg0/fgZy8mXVoZ1Mmj/UNljUruBl9fFrIhX2MzpXcRZKD4vzS7m3cxXSqAuLL1CGlY5R8H8dD12Hr909xX/j7micelHVaBJS7SAgvQyHR8vs8g69+56BakKepoDScGPbGmpi93YW6Kv0gNsSLj/aGZvB4OHv3fLF++1o/drOhanoCj6EElysoK+AVMUq/AHo5gKw1qHr1JltvLC318jWovm/hev4EyGIblpvIVg==;5:OQ5d0uqSMhRNu1n1xcySzMUvjlbIMU9IPUlUJKqoh2zMFqD6cmRYIOgbG2Do2skUkqN3UAnm7zZvIUWhV/Yf4MDStHbpNddtxmaSz1UEtx8YvCOdkgJ3zBFTMWxa6f3TGkDDYr2NaOzSu7iwmag55FIWUg99ESYrX9zxtGV7ZbM=;7:RUaDPEH8MOvtiydy3Ad0pv9W+RL+YFXGwwj5WdcyudXio7XdqIZkcPX0kL9qXYsJoeTrewTpHz4aazd2m8zWCoSU98RgXClz6DamfD66+W302e22QxpokBw/F/KzaFHfx3s7QSzVlppOCfw33QmEYe/zo60IDyjG5gsrDoNT4xYTgBQ4d09VbIw9FGd4D1ayPOsZojvWDInRTFaSndpdNIDnZ+jQKhNBWFGhqHNE+p+R9ZmtGy2FRmvfxSgsZhEZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 06:09:59.3155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5845a4-fbca-46d2-b69e-08d61df68af0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible for i.MX6ULZ 14x14 EVK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 968f238..9a0ffce 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -85,6 +85,10 @@ i.MX6 UltraLiteLite 14x14 EVK Board
 Required root node properties:
     - compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
 
+i.MX6 ULZ 14x14 EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ulz";
+
 i.MX6 SoloX SDB Board
 Required root node properties:
     - compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
-- 
2.7.4

