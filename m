Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeBEUVW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:21:22 -0500
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:26146
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750949AbeBEUVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:21:00 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <fabio.estevam@nxp.com>, <robh@kernel.org>,
        <andy.shevchenko@gmail.com>
Subject: [PATCH v3 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
Date: Mon, 5 Feb 2018 19:01:55 +0200
Message-ID: <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
References: <1517850115-24340-1-git-send-email-daniel.baluta@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131623356577265883;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(376002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(104016004)(86362001)(450100002)(498600001)(110136005)(356003)(51416003)(76176011)(106466001)(26826003)(336011)(305945005)(2906002)(956003)(26005)(36756003)(2950100002)(68736007)(6666003)(105606002)(54906003)(97736004)(8676002)(8936002)(50226002)(5660300001)(81156014)(316002)(48376002)(53936002)(16586007)(50466002)(81166006)(47776003)(2201001)(4326008)(85426001)(107886003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR03MB1418;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD010;1:WhKmHQkKC0zbBDacwWcunUJTjDI9sVAxNBZBKA+5FSjDYLNPSnBaOl9+O+0U2U72jk6oDtOToyKOPPrMTBpMUgXGib0+J/6WP03v2RNag1GEFWc5i7PJk5s1af0EM4Ev
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a6b080e-ad6e-471e-b8db-08d56cd5f765
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BY1PR03MB1418;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;3:fXVZII9/zQZMBSX3VJkVaayaa4YXSoF+PNII00nzV9ox5HiaT45fSNdftaV+5tGRsUpJ+316PYWciUDtIX4FxslEyPgmjiPqNpGITw5uPO41fKZklrO3B4/xpKyBV2lVkDnrfMV1Y8LUMcegUpA9SsAdxXsWrqnaaWLxbNVVHN36RdQOtXniy0/2vdVHrwa8anoqDMH4MC8MvJMs/teIY9kFPSLgUnSF9TjYVdifH5R0vVrs6cf1iGsRloVupaN4Il+lVBL3jz0QCU1U2I11tGrqn+x95tG56rFhQT+3i6+8OSoQK1l8gFnhqaKtdvQHNZhqEKp76cTxPlNuQ56q4ceTt/lMvlCRQE3P7JFFhM0=;25:ULdT5kwU86ahXwLD7K36mdEk2p2xD4SFNUZVywOvjYqdtFRCXz+qrlqkLwlwEL5Fpe/fBM4DPx+dOgetfYAhKg3YiQl4TjE4CoRtXlzh2W0ZUNxj+FqHxXrcVit51ZYcvSTQmPcLuTi2jvriLSxBicqsWZAeBypXIReXoMRjWA3ByVZ2p3tD7qjhGSRQGDh2Sj+bl2/9ckSoOHwlTcz2WYN+rp1jtnVTD2KqRCDYQy0vu8F02NwoaGKNbG6wInMi3h8TjjgzrszUEyDVjHgwTo7UKT8BfXL9QT5P1C43tah7MuaLBbKRYJAh6nqMVmFI63g+Gb/KyOyPfxNvH1klFA==
X-MS-TrafficTypeDiagnostic: BY1PR03MB1418:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;31:tsMewkkgLDKnY5JAyph+mZ3icLHb1zL0JpZqw7S9t3b+jC9/8C4GU5DR1WyTJzB3y86gzyD6fbrzc0yU7FQ3nTzjCQ/jr2AjWjO64+GKh63GOje/b4/ztSBhokbrPSiUk1oZyW5uPUs4vpmZi6d5BknlEGeb2AKHNXlLhmS3tC2DC1IED4+JkuQXY7hZtFi70MRc1/uAe0KRmQp0KRGuFemuUekLHzfPqMxB6AKmrzg=;4:S9+MSsLu9PdIYY66gZ50hVtCQ1FwdsF65+4pUqiGBbmtDug3bFL4MyW+OimITEbBmqEW8xKKiYjOIffIreKtVfjd+cmYVNxy9/fls+XaOdZ4OWMfL3OMT6aSOWvJLTDqPzD5VFLVxvNTMyLD1+pcHozEPlABdaVbo7rSgT6JzYe6RstTYE62//BMAKnJGfux1ujnQ2gbY0YEDJe0LVEsL0kg3LTFkUDd2YzXdEvPX8eUuxF93G0d792M61LSz1ANVAQlFW7xeMsSX/CAglEwrPYbuVnxALk91llRiT2ubyMW3UFKEGUkS0BUekvwYz+M
X-Microsoft-Antispam-PRVS: <BY1PR03MB1418798E4C7FF4E35AFDC944F9FE0@BY1PR03MB1418.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(6055026)(6096035)(20161123561025)(20161123563025)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123556025)(201708071742011);SRVR:BY1PR03MB1418;BCL:0;PCL:0;RULEID:(400006);SRVR:BY1PR03MB1418;
X-Forefront-PRVS: 0574D4712B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR03MB1418;23:qH8Il6jZunjUDiAIkyzv7UnenQAqx4vqrLiZY5S9n?=
 =?us-ascii?Q?5WC/4snaOQPk/JSTUdaEOZCUB+fIC87fqusXcUKVpgN+DrAg2e3EFXXhz1dy?=
 =?us-ascii?Q?IOfYOS20zq0BUBrx8HpZrUJl7XFkqmk/yeUJY3048Av3nSbn+1Usfm2cggdj?=
 =?us-ascii?Q?XuzwuH1TDojf9PGQysfiqVFakYjBI17BqX+nx0g75cWfvLwg0xi4AZBS+7z7?=
 =?us-ascii?Q?va8BWt+q/1z9L+MZ6v7rIK7VPlbmgJZkLoskhxk9iUCBra2BTNlDQCiuwpqz?=
 =?us-ascii?Q?uppJjyDY8Z61QhisV7APWzApYLpFv3KrtqmztB3Rz05pEWUbQpibBlQvMS8X?=
 =?us-ascii?Q?5oBbAUeFdGJTSJoAoxsMjwHyZafiO+9u/gfv9HmwHLPluQWnEG4oAbqaYS57?=
 =?us-ascii?Q?XzcoXcE4/cn8LOnR/M0s0v/gTxKvR1fgIxMOgDnFcBC2cxD8cBkS/TQOtVlg?=
 =?us-ascii?Q?0O00zTir2WtXezbRJ6TubsJZJ+NIaAZiULP57I0s9haLJs0vaWwrqDf6I2TB?=
 =?us-ascii?Q?CijH1WcKc4ULyysQk2ffLeGHgNbPlQyENBIuyDPwpN+fsHSj9JLtUQLUHEKQ?=
 =?us-ascii?Q?peLMB8eUgBsXWdDpZa1RPs8nS0XLlBH9Tc3zQMx1NqFdXIJkS2V0c0KDDabA?=
 =?us-ascii?Q?JvQNReO/VCmLxrSMVAx3S/XTzmwIg7dMe7LZJthNL2PAp0/i0bCdEePiHfdJ?=
 =?us-ascii?Q?1ERnhmb5of2LiIyEfnS+WmLy6rWm2LBcEwRNDouKQntxZvcXk2/HwNppakQy?=
 =?us-ascii?Q?QHxLM5obcD718r/1XfpUwY57TStY7am5SxAf6DiQA3UeAL2ij/ytWxWgzMKY?=
 =?us-ascii?Q?L08DWm659CizOOh65KiWIUanVs73OHwZ2O0i/qougC5LcVPxYELND3K2vq4a?=
 =?us-ascii?Q?D41ZGs/HiInTP31T7XrJiJdQwA3UvKPP1efE6yEUpRG2O6RM2gkXZ+w/VJn9?=
 =?us-ascii?Q?5yc79PcI+/E0htEWcITQ5Wi6zS3p6dagjCGw8q/6oSWgDfoHrxohQg2n2uk9?=
 =?us-ascii?Q?a7RHGDGLp3BbpVsELVABlO3V+U1ozJ/FNxwB8e/3wG3Anp4Hg0VhchnHqRjo?=
 =?us-ascii?Q?hhwNkgLEtdOaEgWDfcmJhE+vN33kDcF+HZyejDQjEZ/ftOWeufwqzDt7etH3?=
 =?us-ascii?Q?/pDonfczbKECns2vF6ifHFzwA62Mf8QPmf2sU3S5mFo+LvaWB064g=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;6:N8lJaHlyMhnlP90AWyXxc10eOvj+0hquCf/hw6uVH6Q4sFTL2lYqcZZBsDvGD/ZvORSbm9wjnh/F0SFXJg9txEHEPJmpXs7OUVZFey289rZWctqGquoVFj1uDmTr6sAUNNJc0pY5bBYnyycT4Qgn7qwcg9+P+xPogvElojR0B9BH/PUw0+V6vTqXjSTXbIM7gBoW3F7ZOrde+RKgrrOtlHizmRAHTLdgDJLooGEbnFGguFUmbzn6spbX5QS/5ZvNxAmVj12rKdv7EGtUyxu7i3Cc/qSYpCfsNsAxqiBaA8M1VGPoLZONksSYXuOzSoxSYCXu4GNKHkmLYvoRfTbQ+Gwq3uYP1nv6uzFGZTuEQWQ=;5:EHt+mtmWmcmHSNePprkhNGoy/6CgTAF6bkkNDa+jnl8Jx4xJKoTsqlP+bfx+7S5e8IojVxMn7eWZnob3x4+uondYTA0pwNdrRmUJ6xOpJPfUHwHd3MIkLv3C0ldTT8yp1oSZenz/0XnoD536zwHBR0F647K6eC/i4QoAMaLzToQ=;24:cpxpUxlhAc71arwpYed3rwCZV7VqrXiEmrq9N03FAWzchCaQV/KisjeURD9y+GDyMU+vuK9TGXu/E/61DYffkbsuY1Hth00zp1h1O6mzoec=;7:zy2gCodU1jruyv8VRscyijO1zJI7Frn4tziXS+WhGxVbDemNpyp+DpaocRCpk/J4VESHcub//rLsfhqo5mMWa+188/mHXAjdvuOXeauiJSp+A1g+QrNYnZVnzLqJhBwKv5DSa+UIljbsvnPUaCcakXHMtL7gv2S5AYj4x8SqX32REhJzceHLitYd1j439zQxQ4uOR748iLRiookMiRsSJYtVFtOtM4p9hEyN4z4sGQ/8QwdZr/JGwaNztz3KlPxu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 20:20:56.3069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6b080e-ad6e-471e-b8db-08d56cd5f765
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB1418
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for AK5558 ADC.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak5558.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
new file mode 100644
index 0000000..7d67ca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak5558.txt
@@ -0,0 +1,22 @@
+AK5558 8 channel differential 32-bit delta-sigma ADC
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak5558"
+- reg : The I2C address of the device.
+
+Optional properties:
+
+- reset-gpios: A GPIO specifier for the power down & reset pin.
+
+Example:
+
+&i2c {
+	ak5558: adc@10 {
+		compatible = "asahi-kasei,ak5558";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	};
+};
-- 
2.7.4
