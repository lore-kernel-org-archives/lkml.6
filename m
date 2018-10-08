Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9CCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5230B20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="caRpIUTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5230B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJHRvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:51:25 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:4640
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbeJHRvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PZ7vgupObTrFkboo4XaUmbLHy07JPzA/kAtybo/RGk=;
 b=caRpIUToYKPpUAFpOCSP6XwKlvuhDcguStdRrPyEG9xD8u11W+Tr3tEnU6/wOVwK0wO2c/pRtPwCRW4LO4Car81Sx2n6PWkxufOlPc/HidltJ/xN7qbEV9R0Ni8L9zjqfushON2OuYtAH53+rmOnytetJdd4ak+b2kxsYd/EFNo=
Received: from shlinux2.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4212.eurprd04.prod.outlook.com (2603:10a6:208:66::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 10:40:14 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V2 1/1] MAINTAINERS: imx: include drivers/firmware/imx path
Date:   Mon,  8 Oct 2018 18:25:07 +0800
Message-Id: <1538994307-8621-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::13) To AM0PR04MB4212.eurprd04.prod.outlook.com
 (2603:10a6:208:66::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9bf7a7e-2007-4a65-3841-08d62d0a6fe4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4212;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;3:ch08D4BjeIZYIA0891ZLkbNijSOLqrt6tuVdP/XRDBSZWf3qZDfteFYcJDAm2QzGb9v6h/bDw0OpCl2qXoEKKrW9rj7GeIWCkaM9BS8zbtolucQE+BDP41uxR3osueLceCLqjLeVox7hDR6SSW5YcltunjRLLcgNwZiuUXdD85qyEshAGWzzSPc4SiaHkV4gC3Q1KAOO7JhaUfxhdLg0dq2zVk6sqWXWr/knG9Du96eZQ7t69eedgjhvCrrMEOcL;25:9MXamgn0M7nTXmhWpbA3Ht3PiVmqenpeWbk22MGocnca4DhCbetQAo8ZvDBdmcwDXBlzAbqR4/0GTxI1zPQf7r4lE3pJu/m0K9xeCzejZn6bpYQ/FYd17EB0BnjD3pk3TKpFJtyjGCi5kVBrBH6Gw8RhU0FWJgsEk1TCf/LzAm8An9Z2feL+6+uzEKjyAZRD79ZVB4YgdxEJclnxQ0jJQ6G6lDTZas/ULWhLd30bTASZVu15vVYRVsdWL4sXZxvc9UpXKZsn2gMnDVZ+RkR8WJFNl7YEXGKo534iIzQRZa+l4KX+XKn7L+OmP7D6AyWN6XOp5kwQAST76x7eOw4CsQ==;31:YdFsZuABvmXY9M+9bzRBPkqaC1S88xJxiObc5Lt/bRfshVVbbrHQ33s9e6MHIqK3MnGGORXAGngm2XNhwTN5sp7RirADterghAzJI0LteXr6/b+dQMNcUGpwf8YOii9BZT/MBdKySL4294DcsHLgowZ4ZI5MaVN9m0cxkePLZlOpp7y/C0s6cgzZ90lD1tLnR7KbIy1TVGlrXfccLpstlV9u2MIgUbuFanvHwjwmACw=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4212:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;20:2TJZhJ5syO5f+4yfSx8op9fwU2TaacMdCxoUVRAZVNAmFdKBiqdD3I2xNb6zoXkYRiVYYwlXyDpu7Yuuqik0tcl6UTEBL5BE1LwJt3ZjZ0aOoXF/Wb/RpN61pQOwlfuM27JI36cAAJYuN60iXM3R/J/5/xlPQK/m1bZf1JsRjuCjOpLemAi/02Q42q9OzzKELMQhC2WJ+KypA6CedFQW5ujOq8aEm4Y7jBiidm98d+hn6F8WXDPuCuMkUl03Me9cGUrGb813y7VuhtyGCOtRnMHMsMIplStHyJeF3WXbjYmz+OlZ2XZ6Kaqx4IBrowdb9U9rcXukty8TCuQiy3uJL01smom4KUhB+qEVwHdzYURRHtNQRUNmg6ycC15FpQAuFhxCL/hDVfl4ldRSU4OuzuQ5zr1mObwmcLpv8j4niKKzS9gqYcJKv1y72JMHxmk3zeNFHDSkwT/eprVc9nElQy0sDOoKtD5T8cUN025exz8Zi3ZCvBP/OAVj3QWg/8Cn;4:RJaCxH90PmBwu23auBO3Q2zXaWd6cK4Yl0sidHIbw9VWojE3msex1KJ+2kMdLaSlP/1X2+zF6o61ZLGXfv9ZO4aVpkIYlWRy5yqWFkeWlwDsPA23qX7Fa4W2vHzbRJTxEGz8oL8nBp4Sn+0mvVpWtJM1CO4YPZGztMcdAS2Xy+DoU6NsFFU8NGMLTxRGYbwSjVPuid1VblGswY5NNFP6t6W5f+2YPs4VjHnOpGoNh6GBJaYJii7R8h/oxbiVSt5lQ2SWu8Rd409JFfF9ay1Ou4v+HGkqnmMS4/S4OaiVItFEdbooidbDTzpG6him77L4kD514cHJJXfu1wJaIrhm0qiHrWVoDsy19PbbY/uSk98=
X-Microsoft-Antispam-PRVS: <AM0PR04MB421230ECEFCFB7132444A9FE80E60@AM0PR04MB4212.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991055);SRVR:AM0PR04MB4212;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4212;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(47776003)(478600001)(39060400002)(486006)(66066001)(25786009)(50466002)(6916009)(6666003)(51416003)(48376002)(5660300001)(476003)(2361001)(16586007)(2351001)(105586002)(54906003)(8936002)(106356001)(52116002)(6506007)(386003)(316002)(4326008)(956004)(2616005)(53936002)(6486002)(2906002)(7736002)(6116002)(36756003)(50226002)(6512007)(16526019)(305945005)(26005)(186003)(3846002)(86362001)(8676002)(81156014)(68736007)(97736004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4212;H:shlinux2.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4212;23:1vcVGf9RcyphAIscmSbIvL98iuQH5KukMp7pb0Ym3?=
 =?us-ascii?Q?8zEV7DcNGpAzguTpZc0sumMrxQ9Q0rGi2FPW1MrPPRuZzPcE7FV9GsxEoiAD?=
 =?us-ascii?Q?5YeaPbRr3uE+Jh8NzBUzTZwt4rH4xE/3ZkNNB0kL5IfdclOENtyHrynsDT6H?=
 =?us-ascii?Q?2JgDTQBoQph1kNn00yFOXE+uJLYB8sW9pj8xRaBcyk1Rf8x4sBUosss5gNKm?=
 =?us-ascii?Q?6VSc8Anp6vPXX3X46ViQq7SFXWJXuTVy1+C1KPPqZ6Cqp8T2L5lxxd+TwdZX?=
 =?us-ascii?Q?Dt5KVka7XKc+wZElnD+k8aLDstL0XzmH94Ne66KFQePFtlmyQOXXVAYkUZlB?=
 =?us-ascii?Q?pFuuMIwDCsGMCgHwbAi2NI8HNLk1+2iPox0zM/WXBqarJjuzp43mOfr47gX/?=
 =?us-ascii?Q?Gc7A/9Zt0CcutKSCgrS8Z5Qq+ZwWVU/Uw+XguGUgll1VdzXVTqF0zyTb5K3+?=
 =?us-ascii?Q?MtWLT/NyEy6awQaGw5n0mzps39NcqdeCIKIfowUv1+WCeQxozlDptdB1klqL?=
 =?us-ascii?Q?GZOUbYRgEBI7cxyaaP4OEFUsDuv42Yae/XbUC5bdc8CCqYmdliIQgoyGH+gn?=
 =?us-ascii?Q?FnbOCl+yrbOk9TFIjCcbowtqiEA/npRJAUzrDZW6HXIF7/ZksYus0oeLvN++?=
 =?us-ascii?Q?kLrjE/JyptE/ikO3/beXfnU20PAPurOVVQUgYqO/0pD+r7y8IHiSvhPsvzrg?=
 =?us-ascii?Q?b8QZaFey1vcSsH4zpdGLH7c1xMMx99YBz96+ouddMPFIEKkhdAdf88DoLgJN?=
 =?us-ascii?Q?X80BMfXlucTwHxE1jXnkw7FNU/HjJZqBHlzfW7fH9+XI1Ivl01PFiO7jCEAe?=
 =?us-ascii?Q?4uKGJmnTRJ2zt8JCiMgD/SF0EJ29sYN6mgq/ubNXlVNnzYUvL6jaI5vRX2Wt?=
 =?us-ascii?Q?sBa5q3DFuyHWHGJBBa0DeFxogU0YuvSyQhkrm7CRrW5JMnI71Hbn88RCkEMS?=
 =?us-ascii?Q?jA2ynq/dzYXgCgQtn2RILAWCKN8ak681wuZh/2c/AC41kBoUpSvkatXJtrXa?=
 =?us-ascii?Q?DSu3uFdcy5SjkO8Ow9U5v/1plpJ7LTpE1nWWXj2icr/cO2TYboIjAIvQGAUx?=
 =?us-ascii?Q?q9NyPaOZl55Wy+S8KZR6R/Vna8v34tiyI6tkykpscrNMY3/uf+Atv9rO1xnP?=
 =?us-ascii?Q?ZaIg/CCSItMpOGwx7rGaZ7cXDJcaiA4zk3EYnjQ26kdC5IMsIVE8q60YK4j2?=
 =?us-ascii?Q?AX+Ates5PYGu93wOkPDgXfWywDnZ2zgHFQ7?=
X-Microsoft-Antispam-Message-Info: 2E2oUsI6Nhs4qZZ+gvOw4GjsnA0uNLJLAYeLjTBfWaNO9BdqvCUXedLEdhmnYXEqpboTQBtu8YDDnMYxLfgsgDKx7cy2LeuALkVzecPQxy7bsliqsMXS1r1QlS/tKw7IsZmWzgPJzQ55UPTJJeJh0wI7NjZOXwTgMPVnpVFwYAh4zKO2YpZHWIn4leQ5pxHMVho3kjRUbuRVdeSTScWscJwFtTyu5DImoT4R6Bdzt7EBKwA8IJgaYQUxU8XJsUyusnpXTRr4f3dZbQHaVx77cH+UD9VvDlgRQTxEuF2P4QWUaSVdcq0FggRXMNopSbHtwqphtify3ERo3IUm74HnVAp8RnqHTb+NQdvRVmUx+IM=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;6:akewugD/n6Inv5R6ylkghdjvG52ZiRmqCVYaAxYMUu/hXtq2JQMcoO2CId4iW53u0Gxc0bdPuZ0BMu5oDpZLTT/+YFfEpXxmcgi81tkxvycbah81rJfrix1SgqckP4L8JGh2r0cypWJTXpD2ye+so50SruzCe4qKv/p3xkHeV7ZfuqtKZbXEUWxwnjeHULYyDCpMD3xy8EOPOVSPbyRWILVDGsiZv4ROf2s70fVIpBwFrp0KbBI5tHazTpRS4JgcKLY5+TkiXedBcPwclYhh60EVWYK54kaguqM4DfIx9w6qCRvQb/zByBYpyT3pTX2SU6Ds6XzJ8vqCwKL3JgVRVd/JMIhr1C3KFdd5HEvUUQ1jmL7cClxhYs4/Dxla456V3qJlEKpalOLnGJmOL+cOvdm2i0Hw0OxXQBAXFNcGzSOHkymi/49wTwzTLxUlUgmzNO1i6OS6uEH24czlgXIBgQ==;5:/e1yMeW5plY9NzThI6i79WlVAAtIAzPN7HX2jAoQrDjYSFvsElt3pqhGqqYF2IyKQ3vAvo+SGqfvXsaOgLjqix97eDnyRGc6lwGi40dDEPdqFBdpiFfdjHnE4PQbIpaBEZmOEbuyHSqiocTq5hriMNhBtOOFfeDud0yCPX0afUo=;7:a2YLy1FN7AqQeDUI0W8hc4Dh+XEYVf2P15w554phjekIcf7EgfM7dopXnjC+JEsk//AtWi1R4/WbbQ/MzTT7bIPA6bmBKEYPvHiZQKPi9/Wn7j725vMAl6wRXY+BygxQupsL8Z956fMvy4W7X7xhBPK4u/wRl7Nc+pQ8omCL/fE0dwN8Qtah1FDRbL7+kSb3mTLNM4vJlRYQZR8Tngr6OZYId+O5HPCIHF3t7Hw1/zBBIR1r5W7s0kxL9ZarUotW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 10:40:14.0313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bf7a7e-2007-4a65-3841-08d62d0a6fe4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to newly added IMX SCU firmware support, let's add
drivers/firmware/imx into maintainership.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2:
 * add missing include/linux/firmware/imx
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052a..eee17f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1462,7 +1462,9 @@ F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
 F:	drivers/clk/imx/
+F:	drivers/firmware/imx/
 F:	drivers/soc/imx/
+F:	include/linux/firmware/imx/
 F:	include/soc/imx/
 
 ARM/FREESCALE VYBRID ARM ARCHITECTURE
-- 
2.7.4

