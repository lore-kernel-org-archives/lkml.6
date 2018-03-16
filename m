Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeCPHSG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:18:06 -0400
Received: from mail-dm3nam03on0070.outbound.protection.outlook.com ([104.47.41.70]:38832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753164AbeCPHRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:17:50 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Aaron Wu <aaron.wu@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: <aaron.wu@analog.com>
Subject: [Blackfin removal] [PATCH 20/28] pwm: Remove Blackfin PWM support
Date: Fri, 16 Mar 2018 15:08:18 +0800
Message-ID: <1521184106-24475-18-git-send-email-aaron.wu@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
References: <1521184106-24475-1-git-send-email-aaron.wu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(59450400001)(186003)(77096007)(36756003)(26005)(336012)(8936002)(86362001)(76176011)(426003)(7696005)(8676002)(4326008)(50226002)(51416003)(246002)(316002)(2351001)(2906002)(72206003)(106002)(106466001)(356003)(16586007)(7636002)(478600001)(305945005)(48376002)(6916009)(2950100002)(50466002)(107886003)(6666003)(47776003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2617;H:nwd2mta4.analog.com;FPR:;SPF:Pass;PTR:nwd2mail11.analog.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD024;1:bhCv92zzsuJsaWO1eHVtH3u/AhyaGNNtNGV8ilU5QWccXv2R2ldegHZa2cjq/P9j8DJI5h7o9L4JvWHUUrcpTcs/gAK5DiUwEqxh9wCaQi7QfjNsXeCrpSpABEXblzkw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 141b32d9-a1c1-4c23-ba6a-08d58b0e057a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR03MB2617;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2617;3:S8q5Gydx/vY2PnuzMpVECt57Q5Vd45CUNBT1spx4OMdRCJedG0wGUwzi4ifupzEesex2xMBI8InnUUCbqYKXlpYxw/RqFR4Mo4Yg6shdipzOj4kFb8fjLuKUqn2vkP9Kgj53jfBMRboieKlTUWJcra0zFyQZbU5ahge8U6bdqCSR7mHtRLCj/6KLPty2CU6sNmUAHG99KAfpfVTj0T+Cd+cPFjbwQEXcMwY9B9TGEdZSNuttYSQ4UsF2ErBN/uV7pjYWxaPIgPaBnfYR8Ds9Q3AXPLltADeJzriDutR2H1cnZosf9So9sp6vESeewM2bSi60PgpG7QS5FZ2oBO2qXg==;25:OKnbDVnfIkKT6D+CFIAFalxw6cSl7GreOIxaJLDTljc4EO7CFeukwVnyrRua2qXLzNJT2lSDXlUNGQuj0rjsEIxyJC0roKOegIkARVM50YnW/YBaIEQ6y7TZc7qb2qtWgq5/UvvmXur1CjClhPOfw6J3ABq4ixOp67dHTtHP79VkrKjbE7e5SRNc133x2SG/pQ34o/hWFkvg3q3nnfyu4D2lKQJKsTE/b9syoyYxG+h80K9v+7K8AOCyYIGe6nv6uj3ur/GjY5DnQJWNGsRmdOXK+X+b0753fHnn2LBf5Z+jRAoZtOKMg7K9e32hE+n2OLGoRuVhe/Z8Y4l7x0jdgw==;31:QJkLhZCJ/MPhsRD8yUMJsRscq7w8xqWXPRpLEgUndfN+G4KAkYFLjNXldu/90Xcwq2loNZPlEb+UnWNftZzbNcnWIwAfouRnIg2dpXGThxPKnDhuxebt+dNyOHJm+I6U8EsREPeEdUQcQ2T+/BJOjsc4d8vjS49/QcOAdM/+ukkDzAeVn9Tz1aeFcfzSAtCX5Os9eFJrh/cjDstqS42V3bq/boNx8oQ3wnAMsgkSHH4=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2617:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2617;20:325lBIJgh9p1qxgoO52eeGoixXGoxvP3xnuTWk3ypkXAmjYXgVPFpsK+1WpkIy1QB+ngwutjkHpXDX+21ijZ4LWjVU6qT+a0flM25fnVSiapU7oJYhl4J461+giH+NvpXIduDb86BapU8p1MKRcHR1KPya9pugsjx7f3DQpNiCihZK+yn2krjc2vRbV2HazJrV38UyUpdF8Ei5RT3RMCgMRuONufIi2H7AAwHe4e5KoV0NC9CYdZmbQW70M3F23JqrHwdIEQtsoXDa1Y+2i/Fme4fSTRmrrWOzL/TVUUByAoAENL6TeYbKIeqhpB5HjseAUsUOAfA9lp8a8pTo2cneM7L2JaP+5fpuvAP5T4cA/9uv5CQ91XgL2U0Ve52vFLHTks8NqXySqSuBWnAvrvDz8st2EFrNkNFQjmMVKzY3gpwPOQabZYFqjuD/TxNrx5NTU5eviEE209yKP7dS22AfxEryc3vXFM7qNnTFCIMhr7JlEltOgp9YwlHfWnXdnJ;4:AT1/L/iP9lL3irzB2eJvjl2DFzTEJfLx/Jj8SwNZasZGl1VqYb/6Jcv2N5PcsJsebiXYlzUz5cJaLnUqCA+tuMeVkGpsncvDQGBnrK+S4fv0kcyB8GdG/wxAl+Vz+3hZVSDRYeJc/ygwdalfBJi3/6Yc41rhGEtHreQJTZfMwEkqF/WG8nXd+AmqMAcRVxE+xNCEvEJPcwsegBIElAA2hOHqtsHGpa0iDUXthQGk213Oet32rLa1TTyyIBM4xHIXFdfpt2cKLl0VLShW5VWeuvQHBj80C6o4D/HhQaKklA1hSujXTnDHoDL5TkiPCBTk
X-Microsoft-Antispam-PRVS: <DM5PR03MB261720589AA8D56E6FFA2BFDE0D70@DM5PR03MB2617.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR03MB2617;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2617;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2617;23:3lcYVDbxUaJSwj4zuRa52oY5suPHyepebYqUruta9?=
 =?us-ascii?Q?E1JaMY/JN5dyGQ28lIc5r1pUKW1kQbluN5Hp+XL6vHysxxzvQhk4nmFUjxHy?=
 =?us-ascii?Q?fZ2PyxI4X/wkn0WyQdSOvXuXVHFYbEFXQNXRkq4a5pnBkI6yQdh4c4uKt8UZ?=
 =?us-ascii?Q?xRYexmaqmskQz2sqHsKVpuP//ePgumXDwunauCmPE/8b9/2Ey4tXzFjUrRJ8?=
 =?us-ascii?Q?6h8A8Epz4LMKhRHedsBuv1KB+OTUd1ubupAu6QAl5cPUoHVnUumSh9cBxHRi?=
 =?us-ascii?Q?FgYJ08X5YznjQ0CkYO4nuJgZWlXihG1Peu+DH2pwKJ2TsvOWv74RfQ+nS2UK?=
 =?us-ascii?Q?/yAMnHFlLocwQVro06Idskyu4POYToLxlIer2k9WdWSrt7GrVhuVyMZ3abO9?=
 =?us-ascii?Q?l4aDDklb2M2AndhuMf6fHgVcqPMslJfRHVVEpgvmbjcpEu3GR/YonsqwLwIy?=
 =?us-ascii?Q?cWhHoQNmlhbkD9ilnYH+lzy3RVjtoQDD5Qxq33pmDN2Z7uhsN1sFBZgUWSuN?=
 =?us-ascii?Q?CZIh5puBsvra5tY4qNoZ3Pa2qnKXJFmZVqV10vpqLVE8nkRSzWPV19nIN0qx?=
 =?us-ascii?Q?CjJtydbPONd7R3Q5woh0qRRZnwiZYP3M7XYORiJSkOqxH5aiZ+Sog2tZNuP5?=
 =?us-ascii?Q?oBv5M1FlbSEQkSdSzmcObJ7y7RCo8iEhmopJskQOElz2NYtNb4ATGNSmM/Un?=
 =?us-ascii?Q?avtjhXsWABUJqbsjkOlYEMNR7PdK/sfiZQMHpm7ocYUlVKNaErJ+kw4u4VvI?=
 =?us-ascii?Q?B9mtZQCGzWdVC9Hu74/vkDXYm3E44XQtPFHRi1QWD3qPT3Aqg/8JXzx7vKFK?=
 =?us-ascii?Q?eXafZhALgUim9LTDB0qQSps49sF/wRsD5s3mQy96tnBnj2Nv1wAa3UplEXiO?=
 =?us-ascii?Q?qCmYSr9hfTbsw8Or8rG2sC8Q22DYIV8ReHijb+6VB03S+sZLRU/f+fK7fa53?=
 =?us-ascii?Q?TUlhE340fIlzDu2selYua/97lGlvpEwC4k8Gv0rXmNavhIL7G9rUIAiTZY+e?=
 =?us-ascii?Q?hWNucBiEDIWqpD/bm/qsKq8?=
X-Microsoft-Antispam-Message-Info: TzCsbefceo44whRFZbl7DL3WoNw+nc/OC1FrMjNYUqUoqQcA90txrO/JQk/134yqf15WaU8dd8TLibe+gu30EkSVpaDkwp2mfT8vcblfo53sdUCAhRAd3+7Nd39G7Rm1SbgaZmXTxmW8eyA9ZNEuQg4EyFUs2C1YBxRUaGBD0YGLyFq5M4kCJTvJtqtBHvzi
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2617;6:/gcHNDm/PqxabWVcjapwqvlZqaKLcy+tXoCixNZol5CIjDY2XYdX3hie6cEJEg43+ayB180UTvwnKc+zWoEOdqRfvJiQow8zqY6AOiTDG0t4CJkG6R33Bpf6whXXIBoCLcawkmYqvOkQal/Tcj3bfVmzKwdmJI35RWZvkd6dpigS+ZAKiVnaJmXVaE2qPew20fqiOdUOAGS7TS7lkC0R4g7Uzo84Rw8HphpmduTS/kJD0DJMYB9YCWCuVXVzDPCzPEo3o8m85V3yWK6B+JuF/Gmr+4uKzHjKnc0ezeD2/lCb0UWyZfIM3aYPUfFDqy2MQopoX2VVwjit+lHZ5dUt4Un1riQAcTzLG0bXFfYo6s8=;5:P25wgm4lPVumMrNiz5gVb+FsX6yAWaH3DeuMy2nHmfMRWEAV0YCL8GFw3pvFmhraJSw6LDVrGUYNYsbKw1QDOto5EkbqqRhDxTG3LT4gzVQdblaD5F3rHB0phLF335M8FJ/pq77/gFPS6MpddQakenjfAr3F0btB1bCAn1WjynM=;24:esqKzD6GY1YasLkH822B/1roBcZPJH2VmokAte9FD4HWLp/JX6IVpbiW+5TNE/jSHG2WTeEB5P8Jx2QXw69JXzhDdMKFWvEPKLcF9cLZEqU=;7:cIeJPKdyx8XyPFRQ/h/FQGEiFVOLtfFgNmgCnGlX+FNCxdanwi8OSQPAozSSm+1Oq2xE2oEK48FNOhRycOS4ZvPpROG0oxd9VBOY5cj2Cm2IpUYhoF1QdAM0sO28QkQKwq59hOUtwgSBtiysHsD9DBAJ5awXWpvJT6OwAGnimKrZL9M3MyoW69wNT2GtIjIvTl6LNNm/iqX4xrKeob+q4UvusVww3ytjRRB9SlLxrDHt6PDP9X2RmNS9Z0AT/KyH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 07:17:47.7561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 141b32d9-a1c1-4c23-ba6a-08d58b0e057a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2617
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aaron Wu <aaron.wu@analog.com>

Remove Blackfin PWM support
---
 drivers/pwm/Kconfig    |   9 ---
 drivers/pwm/Makefile   |   1 -
 drivers/pwm/pwm-bfin.c | 157 -------------------------------------------------
 3 files changed, 167 deletions(-)
 delete mode 100644 drivers/pwm/pwm-bfin.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50..5d9868d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -113,15 +113,6 @@ config PWM_BERLIN
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-berlin.
 
-config PWM_BFIN
-	tristate "Blackfin PWM support"
-	depends on BFIN_GPTIMERS
-	help
-	  Generic PWM framework driver for Blackfin.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-bfin.
-
 config PWM_BRCMSTB
 	tristate "Broadcom STB PWM support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0258a74..9c676a0 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
-obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
diff --git a/drivers/pwm/pwm-bfin.c b/drivers/pwm/pwm-bfin.c
deleted file mode 100644
index a9a8813..0000000
--- a/drivers/pwm/pwm-bfin.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/*
- * Blackfin Pulse Width Modulation (PWM) core
- *
- * Copyright (c) 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/pwm.h>
-#include <linux/slab.h>
-
-#include <asm/gptimers.h>
-#include <asm/portmux.h>
-
-struct bfin_pwm_chip {
-	struct pwm_chip chip;
-};
-
-struct bfin_pwm {
-	unsigned short pin;
-};
-
-static const unsigned short pwm_to_gptimer_per[] = {
-	P_TMR0, P_TMR1, P_TMR2, P_TMR3, P_TMR4, P_TMR5,
-	P_TMR6, P_TMR7, P_TMR8, P_TMR9, P_TMR10, P_TMR11,
-};
-
-static int bfin_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bfin_pwm *priv;
-	int ret;
-
-	if (pwm->hwpwm >= ARRAY_SIZE(pwm_to_gptimer_per))
-		return -EINVAL;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->pin = pwm_to_gptimer_per[pwm->hwpwm];
-
-	ret = peripheral_request(priv->pin, NULL);
-	if (ret) {
-		kfree(priv);
-		return ret;
-	}
-
-	pwm_set_chip_data(pwm, priv);
-
-	return 0;
-}
-
-static void bfin_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
-
-	if (priv) {
-		peripheral_free(priv->pin);
-		kfree(priv);
-	}
-}
-
-static int bfin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-		int duty_ns, int period_ns)
-{
-	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
-	unsigned long period, duty;
-	unsigned long long val;
-
-	val = (unsigned long long)get_sclk() * period_ns;
-	do_div(val, NSEC_PER_SEC);
-	period = val;
-
-	val = (unsigned long long)period * duty_ns;
-	do_div(val, period_ns);
-	duty = period - val;
-
-	if (duty >= period)
-		duty = period - 1;
-
-	set_gptimer_config(priv->pin, TIMER_MODE_PWM | TIMER_PERIOD_CNT);
-	set_gptimer_pwidth(priv->pin, duty);
-	set_gptimer_period(priv->pin, period);
-
-	return 0;
-}
-
-static int bfin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
-
-	enable_gptimer(priv->pin);
-
-	return 0;
-}
-
-static void bfin_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bfin_pwm *priv = pwm_get_chip_data(pwm);
-
-	disable_gptimer(priv->pin);
-}
-
-static const struct pwm_ops bfin_pwm_ops = {
-	.request = bfin_pwm_request,
-	.free = bfin_pwm_free,
-	.config = bfin_pwm_config,
-	.enable = bfin_pwm_enable,
-	.disable = bfin_pwm_disable,
-	.owner = THIS_MODULE,
-};
-
-static int bfin_pwm_probe(struct platform_device *pdev)
-{
-	struct bfin_pwm_chip *pwm;
-	int ret;
-
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, pwm);
-
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &bfin_pwm_ops;
-	pwm->chip.base = -1;
-	pwm->chip.npwm = 12;
-
-	ret = pwmchip_add(&pwm->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int bfin_pwm_remove(struct platform_device *pdev)
-{
-	struct bfin_pwm_chip *pwm = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&pwm->chip);
-}
-
-static struct platform_driver bfin_pwm_driver = {
-	.driver = {
-		.name = "bfin-pwm",
-	},
-	.probe = bfin_pwm_probe,
-	.remove = bfin_pwm_remove,
-};
-
-module_platform_driver(bfin_pwm_driver);
-
-MODULE_LICENSE("GPL");
-- 
2.7.4
