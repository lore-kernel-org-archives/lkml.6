Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeE3Q7n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:59:43 -0400
Received: from mail-ve1eur01on0067.outbound.protection.outlook.com ([104.47.1.67]:55533
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753432AbeE3Q7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:59:42 -0400
From: Shenwei Wang <shenwei.wang@nxp.com>
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on
 i.MX8x
Thread-Topic: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block
 on i.MX8x
Thread-Index: AQHT84pNMjdFhAI/vUSobBw7N99yZ6RIh/dg
Date: Wed, 30 May 2018 16:59:38 +0000
Message-ID: <HE1PR04MB328939CAD27C15DD182C5E40896C0@HE1PR04MB3289.eurprd04.prod.outlook.com>
References: <20180524180848.61844-1-shenwei.wang@nxp.com>
In-Reply-To: <20180524180848.61844-1-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB3017;7:2bn9rrTZVozZt0tLq1cTpWZyVT5i9pOpMywVCZitWRvJWZPWDmxBbdbqKh5gKaJKti1sSZtMgQogCbXrrjv9nUj5xtchR2RhnzVGpS8DLb1fIYF4Unp0wd5SN2x4dsBxWeqHkBqb+3fY3UfJj8oEDdqsqe5qq8IEOpgjhxHnSPyfaDgUs6FTjkjZYdgBVmTw1IU7GZ9PgCwd4TByMlMlEpkfviPltD3QpGL5jm820D4CzXDHOowKFIBWySuxx1dX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3017;
x-ms-traffictypediagnostic: HE1PR04MB3017:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shenwei.wang@nxp.com;
x-microsoft-antispam-prvs: <HE1PR04MB3017B3338E02D24E17093747896C0@HE1PR04MB3017.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB3017;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3017;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(366004)(39380400002)(346002)(199004)(13464003)(189003)(7736002)(305945005)(39060400002)(99286004)(76176011)(3660700001)(6436002)(9686003)(486006)(74316002)(25786009)(97736004)(53936002)(7696005)(446003)(476003)(105586002)(3846002)(44832011)(4326008)(66066001)(3280700002)(6116002)(2906002)(106356001)(186003)(229853002)(316002)(6916009)(6246003)(11346002)(2501003)(5250100002)(2900100001)(8676002)(14454004)(55016002)(26005)(33656002)(81156014)(81166006)(1361003)(5660300001)(53546011)(59450400001)(8936002)(5640700003)(102836004)(68736007)(478600001)(6506007)(86362001)(54906003)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3017;H:HE1PR04MB3289.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /rdkVOS3fO4MO9wRwltDhGjCv1dVH0L49zY5i5+blhoUPb8AKyoJLdqLAazmWVYZj5yc37doWuu3ET2bb17AB2gUwnf3Fcxr8u5uQ//patlMksJ0g/oeb3ibxZL+tvqxdunnatVRjqNGP2P+BUzhUUt341QUp5VHrg17ekU8TJMETsVD+ITVrCoQt6kCAIaP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 87d5a5cc-19c5-4c57-814d-08d5c64eba9b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d5a5cc-19c5-4c57-814d-08d5c64eba9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 16:59:38.2045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3017
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UGxs3k002837

Ping.

Shenwei

-----Original Message-----
From: Shenwei Wang 
Sent: Thursday, May 24, 2018 1:09 PM
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org; Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH 1/1] pwm: fsl-ftm: Support the new version of FTM block on i.MX8x

On the new i.MX8x SoC family, the following changes were made on the FTM
block:

1. Need to enable the IPG clock before accessing any FTM registers. Because the IPG clock is not an option for FTM counter clock source, it can't be used as the ftm_sys clock.

2. An additional PWM enable bit was added for each PWM channel in register FTM_SC[16:23]. It supports 8 channels. Bit16 is for channel 0, and bit23 for channel 7.

As the IP version information can not be obtained in any of the FTM registers, a property of "fsl,has-pwmen-bits" is added in the ftm pwm device node. If it has the property, the driver set the PWM enable bit when a PWM channel is requested.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c index 557b4ea..0426458f 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -86,7 +86,9 @@ struct fsl_pwm_chip {
 	struct regmap *regmap;
 
 	int period_ns;
+	bool has_pwmen;
 
+	struct clk *ipg_clk;
 	struct clk *clk[FSL_PWM_CLK_MAX];
 };
 
@@ -97,16 +99,31 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 
 static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)  {
+	int ret;
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	return clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret = clk_prepare_enable(fpc->ipg_clk);
+
+	if ((!ret) && (fpc->has_pwmen)) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC,
+				BIT(pwm->hwpwm + 16), BIT(pwm->hwpwm + 16));
+		mutex_unlock(&fpc->lock);
+	}
+
+	return ret;
 }
 
 static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)  {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	if (fpc->has_pwmen) {
+		mutex_lock(&fpc->lock);
+		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16), 0);
+		mutex_unlock(&fpc->lock);
+	}
+	clk_disable_unprepare(fpc->ipg_clk);
 }
 
 static int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc, @@ -363,7 +380,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)  {
 	int ret;
 
-	ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+	ret = clk_prepare_enable(fpc->ipg_clk);
 	if (ret)
 		return ret;
 
@@ -371,7 +388,7 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	regmap_write(fpc->regmap, FTM_OUTINIT, 0x00);
 	regmap_write(fpc->regmap, FTM_OUTMASK, 0xFF);
 
-	clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+	clk_disable_unprepare(fpc->ipg_clk);
 
 	return 0;
 }
@@ -428,6 +445,10 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
 	}
 
+	fpc->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fpc->ipg_clk))
+		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
+
 	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(fpc->chip.dev, "ftm_fix");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
@@ -446,6 +467,8 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.base = -1;
 	fpc->chip.npwm = 8;
+	fpc->has_pwmen = of_property_read_bool(pdev->dev.of_node,
+						"fsl,ftm-has-pwmen-bits");
 
 	ret = pwmchip_add(&fpc->chip);
 	if (ret < 0) {
@@ -480,7 +503,7 @@ static int fsl_pwm_suspend(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_disable_unprepare(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -503,7 +526,7 @@ static int fsl_pwm_resume(struct device *dev)
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
-		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_SYS]);
+		clk_prepare_enable(fpc->ipg_clk);
 
 		if (!pwm_is_enabled(pwm))
 			continue;
--
2.9.2
