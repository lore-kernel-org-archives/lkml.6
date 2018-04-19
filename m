Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeDSQ23 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:28:29 -0400
Received: from mail-he1eur01on0127.outbound.protection.outlook.com ([104.47.0.127]:4137
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeDSQ2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:28:23 -0400
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/7] dt-bindings: display: atmel: optional video-interface of endpoints
Date: Thu, 19 Apr 2018 18:27:46 +0200
Message-Id: <20180419162751.25223-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419162751.25223-1-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::49) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(7094020)(4603075)(4627221)(201702281549075)(7048125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:2YYH3MfAcqCo4G+f2uLW4kppoEdiG5sq8Mg8ZjsSznUUZXbhULzCR5ZCRGqQJE12ow1PiCUmwJAP4S02HYvKDVcZO47eJCesGXyyQHvTlhD28aRstfHqjhp717sSkofjYDK80uE034OXmg/SuSPUR5xdY4kGnJGMIQ9VFx9XMsPtuVqx5W7qQjXLPYVnHGg7hp2a35u20UVOBk9SmPUsW0FLOxvfef2ldpItC5uPCQE+vLlES+djLvy/u+337JXY;25:8I3QJcVGlM9qp7qOASUDU6k5padDo9Lvd9SUiTrObNlc0CwR+HdabWqsWlAV01GdhFVp+OjygMZYh6iDqd9I+MkAcq277527cxqsFd80knepGD6IkXSQh2VEgsSPwCjBRo66QsSka0HheH1h0ttI+RxyGBPpULHmYPL/h8KewuPtM7tZKmoDl+YNM7U5UcsJc1eyQVZ+CG32Nlwi2/f+NsyLaT1zdQDDgeDPmB7BPEuX0YKEUuST2+7Ph1NuH9q3yDwyGi9vEqAPtF5ioMjThLtA/stEqTvvgkvJtobcB1PId+HQ5OPHx2CVXXjalrgOytq0+Heb/POhgga+vP2VMQ==;31:ZmcpW7DUzNXKvgHGIoTJ7NaQmp9ohZSXSujAYSXD0Pd4F3Xm4N/SkpfJXzzrTzzqITv2qsjihbgvTIptoXr9DxCgQk5KR9YARdIlzHSGvWEk6rxiSDvN7XRS/p1dyGBpgixXY2UK3Al5YpjLi2Z2OLHj88Su56gjhD8QSYAAj69Ra82Wq2iw9vr9Boh7iq6t9G97lTDynix3QMghKRp2mnbvsU/0ZoEsXlCH9yREa5M=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784998A8A526E6FF9140A2DBCB50@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:Z09Kyl5CdTz+tI2VmttUMcVi/7CNSHgkLoMojiRrKsKncIS/+nUWX2vS+oqGoC3TPSOstSxVxwm/ippw7FA2pcKZ7qjmIJ8hWVjydAI/kLTlIOrxs7LyFTFCfagKK/WGtidhpbme+prZ8JZNBYn1e/LlzJNLNWF9KSs3mqlJCfISZGQ8b0hb8Gf4tER5qBEV8538sNm2XIgJjhr4TZcieaXgzPLG8G3dh18P/4sn9hJpI7MJnoaXJrspMKmZuC6WlSZMR/+WHm4eUTnfcSIapA==
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(26005)(86362001)(50466002)(50226002)(8936002)(6506007)(386003)(76176011)(47776003)(1076002)(2351001)(66066001)(6116002)(3846002)(2361001)(16526019)(305945005)(186003)(74482002)(11346002)(956004)(2906002)(446003)(6512007)(52116002)(53936002)(6916009)(6486002)(476003)(508600001)(8676002)(4326008)(2616005)(36756003)(7416002)(7736002)(6666003)(48376002)(16586007)(5660300001)(54906003)(25786009)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:orc.pedanet;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2784;23:fI8rtvh+wtBF+vcywgMwXCrNObPwZQRP/00vBfu?=
 =?us-ascii?Q?SlcjQC6GbpFGBSbjont0sG1DSyDmRPXCDFKQNzKKXZ0rG2iY0jebVQFgm8zw?=
 =?us-ascii?Q?uHq8RPQuC2HzqypoAStXbDPludIVhpV61NNqpOZHDbRQ70BZLLcKKk4xEgso?=
 =?us-ascii?Q?Dbo43D1F7GiYRNy4IE/d1GSpkuQEL7cXou0Ve3PNDE2kav31HQG5idICzPlg?=
 =?us-ascii?Q?87NW9FQnW+dmSEzmU7ONNGHfRD08tOX5zmNhT1O1Rpk/SbRYFx7h67Im3m8M?=
 =?us-ascii?Q?slSAzJb7aI0TIubwY/pAF/nVu/jBylkX7LQKmnOHxdBgffTVz8SRAitMf8PN?=
 =?us-ascii?Q?jKBDTmWH8MBrO3bofECHrDf+nfmw3f3ydCpUEunFpT7dFWlUIQiO0V5ncamK?=
 =?us-ascii?Q?iLjJvKZxOzRvwQLxemDal+H8iixJsy1X4YWYWzy8reS7g6y5/lVQYa+jND+A?=
 =?us-ascii?Q?RHsvWHkEq1kp02X90OINBjRiziuAfj2S1SOtS/IWc2MLyVklDI1J1L9VlUPd?=
 =?us-ascii?Q?/q3zPuTI+xhltcx5w3Tgl+47z5OFOOPpNXKbhSiHOg4UXRGZXKSNpBEXF+pg?=
 =?us-ascii?Q?WQW7z5ZK8tCLb+N1Lj5ZFh9QSDAdPjiGcr5Uq5uTCU8p0jBOcV8PUHzbpthD?=
 =?us-ascii?Q?PSCX5sTisBXjMuO0C8ssSs0NLSXaM4do1Dtey1AcdUpVDvE75TggtnOMlqvq?=
 =?us-ascii?Q?CdRSdvaMtnVskR6b5enF4gMY4oRENM6IwYNMxq8q2krTrEUsN8u3wHW51DK1?=
 =?us-ascii?Q?g3vZaVLQSHAVazQkRUJ12eVuiiK/oTj3JoOUp+0uxfelcqqvpjubFO+C5Mwe?=
 =?us-ascii?Q?rQS55lPTt9Z6CFpsbQeeb+s4hBwXiCfC4ldx9f89Hd8wIbUKlGaPkZikBKOk?=
 =?us-ascii?Q?UqXP0Tcref2x2I9UrRiAc4FIptVwTaT/sRu8+RHPpDV4GFPhpfwzzQdMf52X?=
 =?us-ascii?Q?tXq/CoY0HtKQXNacBbLrRsPB5HItE3871/c2G/WbyuFTsJrGapcxitJxDP0Y?=
 =?us-ascii?Q?jfDyl8Fdy97ccWIQ4jrsWDrCkB3ptqCeKs8c3QSBoYzSb/A=3D=3D?=
X-Microsoft-Antispam-Message-Info: ykFyPalt8KjMzSq5scdtFTuPp8dWLvN1GXnlu/Jj3yKuzHa/7ghZJFAHaJpOTJh91VQ/qkaZbiZvmzJJS/bHfvnX4Xb0ldHOZHAwhCy1p+7uDqLUsrDwgIGFzC0lKvEDeu09eLVkSA9Ci1He+UnZN7S8q2bKNe+RTWcwp6s4HIl0hz5rTcx/WpvUG8ZbaTdv
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:L6cfOuX4Nv88js8S75i6mxGn2toC/gb+srp7Mhm8enkw2+A82LG2GTmqmm/IKpdS2feX5MfYJF2WZ37OSWcf4muePLarf3uxkzYBlirrXLCtPDQiDnlPlBjjpNQuNmrU+/ozBo8eD/hZGPDWf4DMs65IcufCaoNNwlZCC14ZbdC9Lz85+kQe+Me/wju/oJCtbvcU3LdoEk9F5k6bLsm3beNlXX0gf3fXiQR+rO5IYLVfktWx4c0pG0OnzxWj2t3AU3KPS6c3IA/2qt4wdw93HoqVZIolUr89gHYyIYJNOCsf0JVzntoYgtyh4/G6irw2ccERXLximxANm5Ikf2FWbbCfwFxJqMICOc8uLJQg7X80laNtZoZyTrrlkCCWiER0WE1sRkra1urE4juQU0kZxk1ueaYHlU1/cXZ8Uho6qV9UCcwehH6+4sLrHk7PIEoy7/SkcZXu+VWB2eIeSpa3ag==;5:/eeYh2F6jNNFLpyQTzByJILbsdgMsSsrxRyNX4kbckbgQ7cOLlvz34wHTxDcCCpeDM4EDHW5h+x5O6cq8h2ZuEkL0/hmXNWmH7DFMg8n5v2G59TAVMvk6XpTCsxEjqxnuKyecloYeEX2N6d5MOQZS6T3ez7N6BftyDyJocxClSQ=;24:9OXFP+N+/wGFiOEd97LfNpIkYX6JhGbeMSV2TSn/TE9DDPat0WIKT79NRf811TLnrFB6NxPrKhWEWCTD7nMdO7UcXxI/whksHy6gU0vdbXg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:aS0x5gYDYrzpRZouRyjM3zOr99Ju9xEFRzKDeA9dO9cOd/tqAC5Y2FWHyPgaiuIT8/PvwBrBqfyWMtA8L19+zyK+h9Yz19hdoT/Hg6QA0Gzp3zOkpFo/bPItAUEhWyiusP0c0vxnkA6CH4wbQDEQyD10LIuJQhH9+NaZYOgl5PGVIM3tGE3hqoefyIwfCAHBw7hrhMHZPQr8HbaMR2NX35snfr9lNjNBNor99TUjVxVvfhrhq3NYNKQ60h0XQXqV
X-MS-Office365-Filtering-Correlation-Id: 7e9c2b26-7541-4c73-568c-08d5a612905f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:28:19.2863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9c2b26-7541-4c73-568c-08d5a612905f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
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
