Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeEWJbz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:31:55 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:55616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932163AbeEWJbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:31:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>, Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v5 2/7] dt-bindings: display: atmel: optional video-interface of endpoints
Date: Wed, 23 May 2018 11:31:17 +0200
Message-Id: <20180523093122.27859-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523093122.27859-1-peda@axentia.se>
References: <20180523093122.27859-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::23) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:feh6wODSrbiqh7LFU5zHN+TvIamno5VWaDmjMFWlY5GO7iFSpgEzSi2FcrU0V1JYrTHPHfeiiNgnomFeoRu4axcHi2WspUpZ6KDWgQ27+iBP8cvU3Ncn8O2JFjHLOm7lGk+ye7znjVWeLNzpQpkSdIwhqxQQSI/Q5tBIMvHYEKfehxJG4e+NR4GU2SyBO2mGuD/k8XtGtAulup/l69ccI90MU3+amN5K4bufWw9W1sKlZhPBRyoA4AAh13dkL3d8;25:O9KyDEteR/e0R6LGUBrVQi7vKrkJHI857hCmdCzprDqIRQHVZAocrv6zEkDalgNM9tPFB/LFetjunbMTz6GMXLFXM++S39PK8GYj3TxrqVsbGO1l4aD+gA54ODcUThLHsCuLQaMdlh3zyU0NAXBPhQSZS3fm1v7CAqP+vADRyQmjpQxJMuGnHEJC0l3A6mRA2T9GSWXC7JEhUNrAwafZ8cjyZjdUxI4tpoB8Chru1+3oy7m72uGlAH0KycPrUWs7bVSS17Cea0WRYDMG4Wria4hiEZkKu4D9P9BpeucZc9jPgrhNHu7Os6lr7xlYFU4XnZdzPun8I+//9l8YtR+lbw==;31:oXGbu2l9ba9fyY5w/88jGcPQ9YGgIjnT3z+bfR5J+1H+pjhB/drB8AVO7rXXu5HHosEc3g9yBR/n1y6MScfOP6dhDcAhAbCCGHMS6dZ4gY25jRMyKBw3e42Q3ecDgCzlceiWvTh6CPMOeEzxgEcazQhuUBgp/BPWJiE9M9bH+xaVBg6ChIoXQGwHcqQy5DafZH56as+o4fCGEpvAkJsVXr6lai43jS3J7wO+gHlzz7E=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782225F5E69158B00C06F82BC6B0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:x71uA6BMQOfrEZY9tl7YlzCxc65qDxjxIvVYrWFyrTnSlWAqlrhiU7t8pvqUHD180LqX6TpsJLdxRZAMJDhYBARuCZsRpKicLGg8Tzp7jGpKqLgIAAmReTis0COiSuYKxY0+7mO9JpvwHSnFjkZ+gSHq/nmNhE4UIQLfpy/cdXEBDGKuRn1NVxYnnaC5epomkHKvcZ+0CGhzDq9RKLt2tuStIT/3LdIIX4lqBfCvGMpw6vWi9T4tOd6GMHujlRVtl64cIExam+o4ypNRVYM5Lw==
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(39380400002)(376002)(346002)(366004)(189003)(199004)(486006)(68736007)(956004)(476003)(3846002)(97736004)(6116002)(478600001)(2616005)(5660300001)(6916009)(6666003)(53936002)(2906002)(4326008)(11346002)(6512007)(446003)(1076002)(36756003)(86362001)(16586007)(7736002)(76176011)(52116002)(51416003)(25786009)(7416002)(305945005)(8936002)(6486002)(2361001)(48376002)(106356001)(66066001)(74482002)(50466002)(47776003)(26005)(316002)(6506007)(81156014)(105586002)(16526019)(186003)(386003)(8676002)(81166006)(50226002)(2351001)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:CZlBttXl6tWOQFMqcJjP9/BQSeGCaunczUruCby?=
 =?us-ascii?Q?KvoSSaCvcUuAOor8jT+6za8jh6q8b4MbmXnCqNEeVI7VgAC3Q4BaPjrtyjw8?=
 =?us-ascii?Q?O2s99LCz+wfnUKn02dunrQuYbGma4GODN3S4naEXY3oC3FpIn0ultDy2uDzP?=
 =?us-ascii?Q?ulqfduzR2aMPk9yZcWI4PHcPiBd0iuqbxCcQOXBOXgmGep7hW9WRuHN4SnFj?=
 =?us-ascii?Q?urPR5jGr3z13XF9Zk89IRMqMdERWUwzYhRcLCKAiePp2nS430rqIGkWl4ZMY?=
 =?us-ascii?Q?WCw64d+YckVMdIGP7wiPQdfwbk9XD9zbBiGdSAaq/M8XrfneE9zf8I56mYW/?=
 =?us-ascii?Q?AqI91WnxCVj1MFSVYQpqBqCWMuzndB5hSHPacRo5FwSjXQ9N6wDc2v00LKoV?=
 =?us-ascii?Q?/hiEUkMfvUWZQelRjRv9YkV32XuS9/VPDS11GTOM2MziZuBYfOEB+ps/XpAM?=
 =?us-ascii?Q?0OjA26Tt88OpqJGKEfvrVCEsctcEaigL5SSu1v9adZ3vJ+SMokuDG1qw/a1z?=
 =?us-ascii?Q?lz37/YAj7PdANAS1zo0Hm1Uba/gGBIrsQM/YpuNmnwCSiUl5u7vUe371A6ob?=
 =?us-ascii?Q?n77YbyltkLhEV6EVrUd1viCGHpx2MWeYfLxX3CXg/BVSKan9RyiWygflpdKP?=
 =?us-ascii?Q?7jmjpPd/ADJZvDPGpym8msa+4f425y5IW0RCaL2Pa4dVB8A/u3UcU7oATCLx?=
 =?us-ascii?Q?Da4ciitbwh8Zkz/HnY+tp/cApJS/pc1rEHz24Z7mGU9x1Z6TB3Q/tSY1i6YL?=
 =?us-ascii?Q?zgtmGVLdtJxwQtLC/UtQPlgX/4FB4BKl1b1AQ8xVDoi0UsddxuU4WJaIVyy9?=
 =?us-ascii?Q?PlC0pbWxDCPehvGtcvYSKOkQ3rKsQ+XWHZvUR3t2ZzFUZKICCGtgSveO7RvA?=
 =?us-ascii?Q?ixDdyQbFMkbVUA+abvHh6D92k6BUHkWr9Z1Wd3xvs1f/zquOxE9DKiGcriBm?=
 =?us-ascii?Q?+SMesfcTIx/4h58YVRrxYo/sciy85yB+eavv9K7+ky+ZHmMy+64rpDX/TGu/?=
 =?us-ascii?Q?cG7QDK0FG4A2v7ohRCcqvsDsX0/VPiErASRImVvSNC6ecZ76gPzwsBuVrPbH?=
 =?us-ascii?Q?HGNoBVL8NJ9bu4Aohg0pCd9ajYNx8YQuxR1slXupTvaNgBm8i8cQ/g5Sv4uN?=
 =?us-ascii?Q?ZHzM3E8Pe7KVsQlBRNdCN4Cn5arlc7RaFj2T7U+NIrpyyyxO1GC6sjXTxEPm?=
 =?us-ascii?Q?gYcfThLkdbHub7d3PoXNDJ5TWWsdMthNE+C755vOhA/hsjQxiUybuZWPQoQz?=
 =?us-ascii?Q?X1q3s0GDLbwkJQSQpTnk2hoeja4ThDNWW2EaFvviOPk0gYAE2I24JoAeGtew?=
 =?us-ascii?Q?hlytGc1yenKNejwY9mDSmaw4=3D?=
X-Microsoft-Antispam-Message-Info: +dQ5s+5iV2X5cugX3vtOOMGe6u1ahfTRgHQnYOA6EwcaWDof7kMKqFw+tWiHklxzcKVGXfNvQxzhdh0QXzz8Xe6UPuAxKgF3XaoBtyhZFcbayJarChOG0Z20Cr05pdbR11I1+HjLtL1jzFXlBPRx6ajnV5Uaynk1c36xUKQNpyM9yQu9e0jYYs4y5vAhSsQq
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:jq5OY/ypeD+VeQBrJmZDFqkSLvvswQefdhOS9iIkdjaYm5Bo12NEX9LeYO9xtPzZHMOuKkFqn3OqNZ/QlNMQ4OdBfRNBZ4ObY/07qX4NtVFZfoSc9exsp+lhv4UjElmnSU30ReFC9uTMIIuwjsFaAsuR3k9RP82FyjKa5TzdEcftdTo6+qhb5MazkY0j9Kj4gVSK2TCMu838S3/apj3kwwU7z41aV+dAiAP25F9G6XDDr+n3Wzce+QN5Dg9nH7ijPUohT0aFKlJmDrJysONavlIDSKEXWhbFJIPoVpH1ALSBsRaVNiMOwuZEyi5LaKaGhj+o1ZW2nAa3eM2tNb1/GJU5wTQjuR+9LoPx6n1oBlCbKXpjeT1cKODcAtjnEbXdPvA1hqFjz/g/gSlkiQrupDjUBZykumH83+7OFirkuZRKzTP6GnZXj3xVM8bAoUlRsTVslD7t65rdsVF0F3QuMw==;5:oB8/2SZSZtXMhR7LZLfrsvcUPMcry6/g/7yZascYyEbHOR3fSoYUm341HZX/hwN7PL7ym1o3PK5HV5ISMgurp87mG+kkqx+u1qT8T31L4jhvVqdoFaOwqXVhwQZIfIY8f2h0onHdeDMl1q1WzdZqBOUhj5Lh0bwNxlJfohv0jvA=;24:SwD4aF1bnIiQGVl40Paz+ZoO0pUS7grmnLJ8zScWH3opb175j0pnDlBQLvAf0nb2CxM44RMsSGCz/NIrd4NPKnCYFYWDfEUX0wZlfEl23tI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:+7rH8RTqDb/lRTXTb7bOG9HGpF+wea3va9vExDk87JcP1chgfvvb0mioQXsJEHUyfK5+ptH0Iy5L3tS4YpOuvoVT/o1eEof32n/kPQNBYbnncS6lxTcZ5nb+FBi9alGS0XrkoiYcEDVoFjhETsP2wfM3LzGZcBs2u3seXqYRmDGXHrINVPq1r7aCWkGTdeGszJRLQ2CYez3KAxNioO0e/xPfmZpOJPxAgUVJfGW7NzbU1jLfMvH2z7cD1WFCdtRU
X-MS-Office365-Filtering-Correlation-Id: 19164aa0-174e-4ca5-3e07-08d5c08ffe93
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:31:41.4993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19164aa0-174e-4ca5-3e07-08d5c08ffe93
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With bus-type/bus-width properties in the endpoint nodes, the video-
interface of the connection can be specified for cases where the
heuristic fails to select the correct output mode. This can happen
e.g. if not all RGB pins are routed on the PCB; the driver has no
way of knowing this, and needs to be told explicitly.

This is critical for the devices that have the "conflicting output
formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
RGB bits move around depending on the selected output mode. For
devices that do not have the "conflicting output formats" issue
(SAMA5D2, SAMA5D4), this is completely irrelevant.

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..9de434a8f523 100644
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
@@ -15,6 +15,14 @@ Required children nodes:
  to external devices using the OF graph reprensentation (see ../graph.txt).
  At least one port node is required.
 
+Optional properties in grandchild nodes:
+ Any endpoint grandchild node may specify a desired video interface
+ according to ../../media/video-interfaces.txt, specifically
+ - bus-type: must be <0>.
+ - bus-width: recognized values are <12>, <16>, <18> and <24>, and
+   override any output mode selection heuristic, forcing "rgb444",
+   "rgb565", "rgb666" and "rgb888" respectively.
+
 Example:
 
 	hlcdc: hlcdc@f0030000 {
@@ -50,3 +58,21 @@ Example:
 			#pwm-cells = <3>;
 		};
 	};
+
+
+Example 2: With a video interface override to force rgb565; as above
+but with these changes/additions:
+
+	&hlcdc {
+		hlcdc-display-controller {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
+
+			port@0 {
+				hlcdc_panel_output: endpoint@0 {
+					bus-type = <0>;
+					bus-width = <16>;
+				};
+			};
+		};
+	};
-- 
2.11.0
