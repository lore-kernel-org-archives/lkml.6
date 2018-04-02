Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754492AbeDBKjn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:39:43 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:51892
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754322AbeDBKj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:39:27 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radheys@xilinx.com>, <lars@metafoo.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 1/6] dt-bindings: dma: xilinx_dma: Add optional property has_axieth_connected
Date: Mon, 2 Apr 2018 16:09:01 +0530
Message-ID: <1522665546-10035-2-git-send-email-radheys@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(376002)(346002)(39380400002)(2980300002)(438002)(199004)(189003)(90966002)(426003)(106466001)(76176011)(305945005)(36386004)(336012)(50226002)(126002)(8676002)(50466002)(2616005)(63266004)(48376002)(486005)(356003)(476003)(81156014)(51416003)(486005)(5660300001)(4326008)(446003)(81166006)(11346002)(103686004)(8936002)(2201001)(6266002)(6666003)(186003)(2906002)(52956003)(54906003)(42186006)(478600001)(110136005)(16586007)(106002)(316002)(47776003)(26005)(36756003)(107986001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1312;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:pKnLlKoJcnOnpkZlvq3w6IhN/oodS4bsBbeJMdqURynb5/0OwaWiVOaTOWg5sSfgiuNqc13xmw/RTaXYXqhCXZv231LQ3qJ3f9UHYmeMavh2F0uYhQCLZUIDpnna8h1L
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaa3f9c2-a6ef-4732-900b-08d5988600f0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR02MB1312;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1312;3:trMci5o70YwsrLbYRpcwrFsO2avRNpW3Aj8Zzi2xV0Ffp570bz8jBNE4jpTxIrK7rG+gYEwRmRJr95sIoUoh1Dp1MUOYNKyLAqhTwypviH8LUdH56d/jHIf4aAmRvFNo1tGxeGBm7ZyX69Cf4J1q4mOUmYv87IaLtnvlP+JYPCM9oR4A3Vk0565r38iJ65w6tXCQmRhbTFmzET/Ps5xVnnuDn0g0Y22G37KcBm+gid1KP6ZxyFAaL8pU8xteFfo3ZS64SLUCQZFhzzYVNHvscpkpbg+NnccFWlueY1nFa24GhDWB9FsW8kdFLJ4OJrL9E/AOce+0+JQNXM7RAC2cO2yG4Hr35byWOZZcPiLOt4Q=;25:DdVJWf3gpSULQbe1EJle28+QUz9PLlxHbDWLjy94mdLxNW3TMV6HzvGFFNpLgjtKynJZEyMutSwtpyEwQk2uCqgrLuwxrVH4n94ofGteITebKdv9nW6G7JoHXfeLs0nWFSR9I7eRjvgSsB2HI6/vpOfMPknhb7K8e0IFa2HJCuql2c2iPTf9VQpn++3WIz/J0NkmFxENGDtG2bY1+8ZKEH8WIGxySfBXw0k/6cu5qTF3DqcJdWxTJ2Id5phVLGxmxG5J1+vVYSJSUJ3JDfVOAxPgM1YO4IuAILaQcdOblyvH0X0Mx5d6hLwZXM0dRX73bKomGiPZyHPXVvD+bNEIXg==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1312:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1312;31:1OXR9yfb9sYVLFMsRsGDLrK+NHsYe6Xy9TTku4z/zL7Ke1ehqqepgdQwv3ZGKV9yYfF8+XQbAkk4jplnKdlg0Drft2oAvOvUH62yYRL6thq7GZMVqwE+BeGqbZ4ovuO6WKGEnYql/RxtBBpsLDihnEI7uDBUm+BfQBNLwE+F9wBtaKMPPyc8VPDq/z65SKOzn64zRqBFSM6t9inC9Ny7bhpb5ymHSr/IgmTPEltExpM=;20:dYPYxeVEUwWQKpc3EJsM8nBv6n5+8TOXonGgzRHoH3wwsd/42107aUPqRhicBBSeJfcX/WXe0o+y/QaRDMTnMEpGy1UoOrfTG9J1pgrdki2aWjht29iGTylFnrmqx+udnAMs9BMhC1GiwkTWVSwKX49pvOtsTsA6wGet9SsOE2tmvoh61KY09RxtVBu2e2s1PdtTHyZAQQJcGm5RE2y+QDmlk0XCQvf9V5/KKKIoMwaEK1aIam1cmrON2bgNwhhF2vjEvxNBeV42oh+UCvufw2EXmpTKWQEfwnxDrNzGgIKUA7nmsd4q9ekIjjfPZil0vVorQZs76Cvitbj0HIteBp7gv8PkCcfvtt2RQsBIsKwJ8udhNYuyQI+AZjYuNji+2udlL+2HsXFmqj9QHRigst3aRQj0LqoOBSqxL6T2mp+wcr/P5WEKr0DEhajuk0Nvmbo4srO9k57eR8Jxb8xG6jUXa5OYbMWTAlNChDLgmawAO7DB8e08YpFzfv8Ypwf3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB13121721C2C12B53B4AB57DDC7A60@SN1PR02MB1312.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR02MB1312;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1312;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1312;4:vzS+U00wYMUxPKILWKyQjg9fXHgfvdn3rwiSObVYCPMbDGBoCoy1TP1Yzti4eQ5RIaSvh4pSSmeEQKkcGFC33sdL+MrUS/tPjVTUHZ9rG2g3wz0Cgwdcq97CLYsIDRpXQL7gmVwiUjExZrLBzN4hxgohntLSmHBNLtOjq6aISs4mc+1c8V4QxVz6BNl/t/v+VRxFvsVm7jaz4rZxpgl3Djk9pjFjv4j9LXQWEQ/vSLKHePtu3bfMDY71ArVF1MLCoCbv5zPhaXKCKX/8bpG9qy6oWZzjKfSHgfY9wkhQXbYUWxaxHdb2YphfanWwj/kO
X-Forefront-PRVS: 0630013541
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1312;23:TcD7nGGbKb5S01uJpQqZtElHGOMGFo8U33S2bN2Lo?=
 =?us-ascii?Q?fKvmgxLRhZp4kMkQCOQozSSGtZpXef9BCFjrFOmCY9AtqQsi1WBcV0RKhtQc?=
 =?us-ascii?Q?SDESCSpsObk0VzmvOKm5Kmy47gtJJXE43IYmysE0/UwMP/5A3DBnU+NVz/t/?=
 =?us-ascii?Q?jSARv5l6HxmycB0CpktVMOzGl7y9Z1njrSwWGqMr49E3h8mgsj3mjKYmi7MO?=
 =?us-ascii?Q?x4xxLyEzNpn92IqF9uKF6XNAwPLiSvR/lduvjz4AsBIty777ffm0cR+0wuF2?=
 =?us-ascii?Q?hzCFSdTSEesEwG2wRFQ8dFT/UIi3CYbYeqtQsi3yaxOFF2mFjkTupmCXoBoF?=
 =?us-ascii?Q?zDsvUKTTtA8PysarM5wG0w6UVM35oYLZMIYdG1AH3x7tZC75RIrimWsd7AWk?=
 =?us-ascii?Q?JgLDOkdJneeYVNrYV81qId7cUmixMIvGShsp290JWta6AMcvHNB1WEJVJCaK?=
 =?us-ascii?Q?fWYx8lDLCd4gI8RZ5PqUOMjK6z9c3rYSv8Mz237pmDiqmESWj9T6JClWhgTV?=
 =?us-ascii?Q?SAM1LLcDoECkVj1v1k8CdsU7fuDM1iuiwrLJK6AchVGfQK7sRl0FdjOeTtS3?=
 =?us-ascii?Q?3gxKdw2Baq2a/uqARbph2cQ7HrOlIN8x7nl1xfMiU+eP0hHvw151GzpE0TFC?=
 =?us-ascii?Q?oXj9EASeLL2TH6jCbrYTl46kPKBcgaV4SF7O5dVV1lcRqeD2cvEqWHo7+N1Q?=
 =?us-ascii?Q?nubPP1QQULObPkqiH3SLctQ14SeFMRGgwgFi3z2fdsaYFekyYIv6uMkG4LpM?=
 =?us-ascii?Q?qeV7nZqbjAItCk3EnCGViz+oi1+Yb0OMjj+G0Nk7wSksNLEyj3S/2WK4n3j7?=
 =?us-ascii?Q?Rs/soBIoiHJ2mBLmHBt9ybwYeoxxSlqolr+6u5z6H6u8PboTjn8Bfj2WbRJN?=
 =?us-ascii?Q?keVW8zWH58U9hmALmxl82oGR3/q8P4mF7oL+7oLmCqh/YYGMklZz2AzTXbkg?=
 =?us-ascii?Q?tpfxEMACnzDi3Ljem04hGhVVsLnlIuv49LoUUGN2myAx/zHQIJR+JK0S38kG?=
 =?us-ascii?Q?iSAxZm+xotsJuhzIHs9sc+TyblNJXJWhWxXyQCGtUBV2gQ7GwNcKogqW/H4V?=
 =?us-ascii?Q?PpTqe5WtzyW/opY07+jFON6NgQlO2TjZC+fdH+Yfoo6MKWhN79aRa+1S8NRD?=
 =?us-ascii?Q?R7leohs024NLDngY8+Ne3bNO2RDhAmMlrnHK2NV0AKkXkaNRK9zefpbXCjmz?=
 =?us-ascii?Q?9xcOPaSnEfB00yUh8HwbtKNVHq+iogUi965hSRIOaiQettvk7uPbhnFzUpLs?=
 =?us-ascii?Q?UIjaO1MRnbj+J35gbWJJp2z/YXraW+me+G6MhLG?=
X-Microsoft-Antispam-Message-Info: gInhq1+noBVdwQUSoxC4b2pkw46hSn+ixX/D0jvrDy3EoBf4ZjXZ4VLyKeM6epIwgyYcW2KKYNI3pVDRUtLHUILGSRbl1CNKFocCZvuvyBz4Aku1AceEge5FYX23FTpo/Mv4lnWIud6h1VDtMqU4drxsfrW0tOwJjtbS6oJlw32bEq70k7TGpO/fpRjnXxkN
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1312;6:Uwg2tolvd/yQkk7s3+/7TO5EwUTr/+YejkkBYdANl+bNBV4xqgVAnxKk5ToxRcOdFPlp/z7VuB2AeojY8LUyxPd7C8IO96UEqeNktdLJMTU792oSmoDktnnIYPpWsLqtt1lFeyFC7SJHXxO6hUsctvoDR6pVrf7aqLUcbh1cxPjG36GxvHVNcMtGmqkyI59aJcoqUhEFVBHKkea55pVS8U1scJkWOOSevZl3ADr27APXbx4PRg/e9stiD9xG8BMNHEhTAS/qDAms8FbqkAs0yLWklcqIZolT4Nl1Lf80Z5TI8SWmZ2bEJm8Wc1Om2sbgreG+J5Tni77wcdisOAZxBedVWT1grGPi/mYJVW3kG0KDAxPHdcnmFuxCl1jt8bEtffoDh719irfqZHfICCcjc/daI4z6UtlmiTwQ7M91DlkRGox6BKpvrZiKd12mvxyjTMaiqZa70thfGyK2igbCjQ==;5:t80yBTGxaPknPiCgYWPsvrFFUyP2sg5lRfTXl05HksIP/WZ9l9ZnmXn26qalqfgMabu3L3wYu2kxe4rXt2IophY91bueI9Xhv/iEacPrtgsci3Jf738EUN9jLrF0UoZ7mBlqeiEE0il/F6eyxQ8pqbituDWT1zOVOzWJmK2fE1c=;24:JueBwxy0B2ij1pIDDhpj6mDJDMr/KTnq+EslUdsrcElImOaJHknOz08Ku7qIExyT2U6hV8xMZpDy0/yi1URIP5w40cm2FfW8WNfpXrYynG0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1312;7:NmbxFEH9HfsDKpfv4Wdu2xePgNpUD1thpbMrEN0wmv6dHqKI2PHkje0WeTNGGYcn4i8PZAhaOpg+BT6bq535HVgWB6LacfN6Nx3hDCS8doDHYCh3LoLvNw99SvvHH81qhalM15x5Ka+z8SzD37F2vfwY2ipRL++o18+E+VVWceoiSkCMOO1Xfv4lIGxXDl+OaDrgdGisheXSDbfy45A9Ho6onZyMNjKB/AlpdYxkFMrCcYH0VLRPvRgSoYRNXzv7
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 10:39:24.7848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa3f9c2-a6ef-4732-900b-08d5988600f0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1312
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional AXI DMA property 'has_axieth_connected'. This can be
specified to indicate that AXI DMA is connected to AXI Ethernet in
hardware design and dma driver needs to do some additional handling.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfa..5d592e3 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -42,6 +42,7 @@ Optional properties:
 	the hardware.
 Optional properties for AXI DMA:
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
+- xlnx,axieth-connected: Tells whether AXI DMA is connected to AXI Ethernet.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
1.7.1
