Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeCTCLt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:11:49 -0400
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:16082
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750731AbeCTCLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:11:47 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <shengjiu.wang@nxp.com>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] ARM: dts: imx7d-pinfunc: update sai select input value
Date: Tue, 20 Mar 2018 10:08:40 +0800
Message-ID: <1521511720-17598-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131659855056460379;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(39380400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(498600001)(72206003)(50226002)(26826003)(4326008)(450100002)(53936002)(48376002)(50466002)(336012)(106466001)(2906002)(104016004)(85426001)(110136005)(305945005)(86362001)(5660300001)(356003)(6636002)(2201001)(68736007)(51416003)(54906003)(59450400001)(16586007)(47776003)(15650500001)(81156014)(77096007)(8676002)(8936002)(81166006)(105606002)(316002)(36756003)(97736004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB341;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD022;1:gwAUByAbBa8Uj+COeO99YJ7zYY3zYhpb2f9/93Z9AVQPpN5T+pdPSPpw/dBFzO5Dbh0g5UFsf9M5OeSNgt0gdFNUXhwbmCVz4mL3fdQV6Bk2T42I9qTr/MjRaFT6fTEb
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4272fe0d-5ffa-4140-78fa-08d58e07ee46
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BLUPR03MB341;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB341;3:RBRQvi3sAvK2oxqzwZdICkWax30V/Zm9Vp+G8feZp7C//aqhbxpuuIosVTSr4qQE4VHHXgvtDhRAFAyJfsGKuUfI3JSTo+NfpHQAAnOSbrOUOwZTFGDLeHOYPN+NUc3aCpRgzcMztucMIfMxYozHxBMWGIYg04sYERlUv4FyDZbZI5LEA/s+vHj8sYvS5MXwYxjHbwHERUCealmvTrnpnVQVFGxD5fGSpW43bj+mcm/lLG35mtIichz4+z1fRNMq9jrmZTnsoS0knSu6OXSj6PYdsNb/1AXgB+R7bCUQIcjoDxIv2fzvXtflTlyUclFcrr0RYuT/+20kyQVvz6g6GmlAfqfiD8nfczAPGTL11eE=;25:EHlww2UUgMrU5euNLJvZ5hzVOn5OPcuZWbsY44VJFRX7v+qHWsXQzD59JCQW7nPcqOMuACydWRGtfOIsYsitZ6j7IeojCf6Kxi6iS75YK8NfXLqGiNxgjdokEMHF4A2dwHCsXLkiVYi7h5zUF9Ki2gKINyKH0Kal3SgWjB0nVrHkBdbui/LgKe6xdW/2osbkA2k7A3VUI2EouB9TxHdUNxdwbXPNznT1+J4Zn9gZ/m8bkGUy4bqVeBP78lStGg33uW55Re69bKMK0Kpa7Q7Xo0xHXAZwnhCbb8TqyGn6TVdcJvww4YM9mY3//VgtUaSVSTXc5X8f2LxCZ65nHdPSRw==
X-MS-TrafficTypeDiagnostic: BLUPR03MB341:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB341;31:Zm/m/Yo3hq9rWD+EPMvcDcmDH3QpWwbeviNxVOefyYEbiquLCDcU4y9OYOETLGp2FoqyLm72cEHoqZczTkQcz++Ie0L6vFMZ00uDqkIMg+77M0DT2eFOJmy+vi1abR6hI1dNfIg0ND4siZhdjpzB8bAuc21yTzpzYIPrDtXY+HMw91/qu9wB0RQMicQ6xjm6+Jcaot1QAWPXr9fPabpL4ydutNkPCThubUvy7T/tbO0=;4:w5724Atutpj8HGG9Du7VZ1Pg9waxn/L4uB4DIm8vEiKmykTMGG78agnBF35eRK729LJoxf3ERCfainrhbUclJE0vIUcLmtdXoXBKn5selRt+koJN4fi6qoY46bI6NvwwpETi6nab9jyEmrtZwhnFrNUeizWGmunc9nUESHqHSqtqkFi64/pYaLVKbPoYPd+xAp+N60GFWMOkOlQ2g0YSDDBefg/smmBFmNHAZgkIZd8plJlbF9c4yEM7en3/JYnKPJczYL6F1li0lL+3qvxImVij/CD+CDJgVQC+/OSG/6j2UYvtgwinbgsx2Nwg5INK
X-Microsoft-Antispam-PRVS: <BLUPR03MB341FD72A60E5D9F8BC3CFA5F5AB0@BLUPR03MB341.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501244)(52105095)(6055026)(6096035)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123563025)(20161123556025)(20161123559100)(201708071742011);SRVR:BLUPR03MB341;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB341;
X-Forefront-PRVS: 061725F016
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB341;23:3sLqfdMHFjgC0HN4G/tHpPmOwfYkaPVO4KlWqAy6N2?=
 =?us-ascii?Q?8sa26HU7mDskauHYEFKmwfTW7e4/CnRABOt0tpjoQbewRPgBG/i5mlMp4Jag?=
 =?us-ascii?Q?sRN73aCuqn14uZc+lExxzyAubbjkp3jwaAjTHLHB0T1rKCnZUojRqqdX/OBV?=
 =?us-ascii?Q?hjzE7dZUHsizak1x65eRx++jbjceikwS7f6A17lNY6ujh6Ji+5ymUVgjmbhE?=
 =?us-ascii?Q?6a1oNQHtQkAV+azrDcqlGXvprpSsLvT9hIEiMNaWkG+vHUnPDNmKnRhnYBK4?=
 =?us-ascii?Q?3P0SyrVgoYtG8QKVExlb01Vbe4WsSUXP7EmED8w9zahOROTsb0oHi9m8VGnC?=
 =?us-ascii?Q?CyaZ9ixWy2/o7JdZ0x9RTvhZiO3/Yje5nk0gj7qy96N9H4AiPso2iPI1Ns6Q?=
 =?us-ascii?Q?+zHGJMUrnXMwsQ+JKZSz0ByswHNeM3B6vpZSjXCA5L9Dlxy2amjpRT7HsKFb?=
 =?us-ascii?Q?Ll/DdBmyeCQQe2g4TiQjt7hUy8ZYS0JfTDQMuw94p+SjlEhpPI6LgqFxZAYx?=
 =?us-ascii?Q?dqk4pda4IY5wLGgayzsMDCr5h9FEWp55th3xFanhWm7GFz/1oo/HCbNX0azJ?=
 =?us-ascii?Q?RFy7cWW4k3gtsZQC+3/iHx9A3KSsZO568wi1rah9V6lyqEsU4nmEiSCxJXDq?=
 =?us-ascii?Q?qs3uzqPfFIAbFXJst/3RLES3Z/m0NaUplEYE3BTZKzUkPSlfw22uhpcyug7G?=
 =?us-ascii?Q?I912C8fUfJkAbrUSUu86A6bUblsK7HhfO9PWb+1dv1bRUK6C0Y+Bann8q5mq?=
 =?us-ascii?Q?KKd9s4hL49yB8PuBmD3hQ4qWMWTx1Tx/5Jf2DXvGVbJmtIwzFJsqi2iEpHkV?=
 =?us-ascii?Q?82vNcsm8twtCXWckpn91EegRCkyrva7V+5RLlQRQ95LjsW22/xDsD+QP9pTG?=
 =?us-ascii?Q?OmCq5u4jp4GG5hx5jU8YaAcuqIawdOn17u3FrJmWXTK2RR6+j2AeNsRX8WHr?=
 =?us-ascii?Q?0qw1T4kEC7rBuA6yoiZDZBbmwSDUW+/BRvRhwuetYlis4tba1uybAd1ajY10?=
 =?us-ascii?Q?3Oca9Nhh86jZcOCJF1Yy3awvODCiH+SLZZOjRKZkoxnBYdK4rYvFblPknTLM?=
 =?us-ascii?Q?pTbfkEOXHhKZXdfAnfi43jBrAo9fMQnGTMLsNPuk31KZ0RreETLYuAdJu5ap?=
 =?us-ascii?Q?hCeX2QbbQAIdJNKEnojW1Eo6BrWvHHOYq21lRoxUQfRtcUAYgKJg=3D=3D?=
X-Microsoft-Antispam-Message-Info: s2eXR2thowOlYGfrg4wr+j5bM0ykrdHuZjmZ7nvLnO4Mh/wsOfSo+vSen3Y8DNU5HYn4ZxakpTeHMnEnWyjL7nOYDLQA82HVzt4QkqemRPKWoir5G3y1h2Y5Zpf39qyA9WvccE7nSVcx0R1fcMtMshV065VuGccXhj1iOgTXgS+rIJ7qDfZ4y9nUKRKzA2/v
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB341;6:wJzebJ417ITVJeogdbGDxXo8BVXfneJVlYJQOHNCkS0FmjqjrqcX4+eVNPqrjyjqPhGs9w3xe5eIKSWLlHYtxEyzdDRq1Ca4zt/EMlvoocA+AEnvfUMqZ/pvYqth6LESSELsaDazDPEc7n+qKBVgHa2rUKj9e6gGoS36Facc/+FcMQKCZrfxZRUA6vcL2AyTibXGEYE+BKdjmcBlyJTlUPs2kMBK/QOTZx743TQHq/bPLP1NuArIWV3mucQneuYzUVXHFQGQzVti+BpVDs3D6dypSPsZxzzOgPNQj0yh/aLumg2ZA5OzqPWXw+IjJJbZa4St8KWDgpCq0uldXSvMg1KRqR0kgd6XqFxIITqPT4I=;5:rf8abOsyVxLpkKRXvgXBMWgzxkggDcOlPwXG46+1Wf3kbJslGxfKGxbympB5glD8h7FPvQOibcivt00/NfvxMJF00D1Zh3XtPLMQG6PknT9sR81O7boNTiqP9eEmAruwEYeopWboL4G23zOhUnoEZ/eQiJZzZz7RbvEo25lBFIo=;24:zhoFgNzTw16v5zcYwHKmUuHTprdlravpRSjSjXVUncgwn15ii0D7FRm50W7kVo+XSbXBw0Mk5gSMv6dPvjdGl6EYPnaDF7fjYF9A9T2wmxY=;7:9D4jV95/uUN3EXQPg0lziVypgBJPn/wTekseNRjEqQS6aX2h2IkX1BF8nLGanZwTtOojUKtcGYLMBLZ6B7AVpvY1+lCbo6584sqBuPeaxZ3OPfcgM/u3IZrUNQncdkXSvTOJMlWKp9KdAuVD6czbOqfnZBAy0A1e3MCuDDg2An2MUqaGuoG2BnyHSXSNdMCztIm7K1OoMuMOEQal3zwlJhldm0vZeJTTnCwwGOIROqtocGvmiqGpwoZb9vIQKWLN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 02:11:45.4744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4272fe0d-5ffa-4140-78fa-08d58e07ee46
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Update SAI select input daisy chain value according to
Reference Manual.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-pinfunc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h b/arch/arm/boot/dts/imx7d-pinfunc.h
index f2493bc..aa9dbea 100644
--- a/arch/arm/boot/dts/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/imx7d-pinfunc.h
@@ -592,7 +592,7 @@
 #define MX7D_PAD_UART2_RX_DATA__UART2_DCE_RX                      0x0130 0x03A0 0x06FC 0x0 0x2
 #define MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX                      0x0130 0x03A0 0x0000 0x0 0x0
 #define MX7D_PAD_UART2_RX_DATA__I2C2_SCL                          0x0130 0x03A0 0x05DC 0x1 0x0
-#define MX7D_PAD_UART2_RX_DATA__SAI3_RX_BCLK                      0x0130 0x03A0 0x0000 0x2 0x0
+#define MX7D_PAD_UART2_RX_DATA__SAI3_RX_BCLK                      0x0130 0x03A0 0x06C4 0x2 0x0
 #define MX7D_PAD_UART2_RX_DATA__ECSPI1_SS3                        0x0130 0x03A0 0x0000 0x3 0x0
 #define MX7D_PAD_UART2_RX_DATA__ENET2_1588_EVENT1_IN              0x0130 0x03A0 0x0000 0x4 0x0
 #define MX7D_PAD_UART2_RX_DATA__GPIO4_IO2                         0x0130 0x03A0 0x0000 0x5 0x0
@@ -1112,13 +1112,13 @@
 #define MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9                       0x0250 0x04C0 0x0000 0x5 0x0
 #define MX7D_PAD_ENET1_RGMII_TD3__CAAM_RNG_OSC_OBS                0x0250 0x04C0 0x0000 0x7 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL           0x0254 0x04C4 0x0000 0x0 0x0
-#define MX7D_PAD_ENET1_RGMII_TX_CTL__SAI1_RX_SYNC                 0x0254 0x04C4 0x0000 0x2 0x0
+#define MX7D_PAD_ENET1_RGMII_TX_CTL__SAI1_RX_SYNC                 0x0254 0x04C4 0x06A4 0x2 0x1
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__GPT2_COMPARE1                0x0254 0x04C4 0x0000 0x3 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__EPDC_PWR_CTRL2               0x0254 0x04C4 0x0000 0x4 0x0
 #define MX7D_PAD_ENET1_RGMII_TX_CTL__GPIO7_IO10                   0x0254 0x04C4 0x0000 0x5 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC                 0x0258 0x04C8 0x0000 0x0 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__ENET1_TX_ER                     0x0258 0x04C8 0x0000 0x1 0x0
-#define MX7D_PAD_ENET1_RGMII_TXC__SAI1_RX_BCLK                    0x0258 0x04C8 0x0000 0x2 0x0
+#define MX7D_PAD_ENET1_RGMII_TXC__SAI1_RX_BCLK                    0x0258 0x04C8 0x069C 0x2 0x1
 #define MX7D_PAD_ENET1_RGMII_TXC__GPT2_COMPARE2                   0x0258 0x04C8 0x0000 0x3 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__EPDC_PWR_CTRL3                  0x0258 0x04C8 0x0000 0x4 0x0
 #define MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11                      0x0258 0x04C8 0x0000 0x5 0x0
-- 
2.7.4
