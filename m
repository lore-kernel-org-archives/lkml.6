Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F86C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901EF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467307;
	bh=Cf7mx+63M23qCbAwESrhiHj1wiPUJHdIQ+Xd2bc3uSY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Y80f9WnwrMWK5n0Gq3Vg/2+XvZTd/53JGg8uZlzm3BDvuXhzY6lIUJ4xvOiVj/3EF
	 V0ejxftd3V/wio6xrDQhVcwabBCB2KSb60OrhEJIjhiEbA0GczSTL/UXlSzD4IhhDF
	 Ze1j5xUuJKJWUtzBy62AMZgg6UZM8G7rNNIqpXg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfANMBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:01:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfANMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hIqxw2MLXRbTt37ojRDB+XM3Ewi/gYAelOv1E5DqjwY=; b=BbKkPK9czHpY
        cDilvl8mFy/JO+UYdpGk6ikFoev1Dre6ZHOmPPY5z3wAchQY1F7OTAVny24hE/z68b/dTseVRbFBU
        NYTvDxgfNxSlVlOIcnTEvQCcWk6pl815X6kmcJZ1LZM1shKvzWcHLJJVoB6JvevF1n1BBSAB8O1Ic
        ++hTk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0vq-0004tQ-UG; Mon, 14 Jan 2019 12:01:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8D52F1127AD1; Mon, 14 Jan 2019 12:01:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Petr Cvek <petr.cvek@tul.cz>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Paul Parsons <lost.distance@yahoo.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: gpio: Convert to use descriptors" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114120125.8D52F1127AD1@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 12:01:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: gpio: Convert to use descriptors

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From fe665efe6554eb80ff301ba9765d497f5f24abb6 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Jan 2019 17:27:42 +0100
Subject: [PATCH] regulator: gpio: Convert to use descriptors

This converts the GPIO regulator driver to use decriptors only.

We have to let go of the array gpio handling: the fetched descriptors
are handled individually anyway, and the array retrieveal function
does not make it possible to retrieve each GPIO descriptor with
unique flags. Instead get them one by one.

We request the "enable" GPIO separately as before, and make sure
that this line is requested as nonexclusive since enable lines can
be shared and the regulator core expects this.

Most users of the GPIO regulator are using device tree.

There are two boards in the kernel using the gpio regulator from a
non-devicetree path: PXA hx4700 and magician. Make sure to switch
these over to use descriptors as well.

Cc: Philipp Zabel <p.zabel@pengutronix.de> # Magician
Cc: Petr Cvek <petr.cvek@tul.cz> # Magician
Cc: Robert Jarzmik <robert.jarzmik@free.fr> # PXA
Cc: Paul Parsons <lost.distance@yahoo.com> # hx4700
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-pxa/hx4700.c               |  23 ++--
 arch/arm/mach-pxa/magician.c             |  23 ++--
 drivers/regulator/gpio-regulator.c       | 146 ++++++++---------------
 include/linux/regulator/gpio-regulator.h |  12 +-
 4 files changed, 91 insertions(+), 113 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index b79b757fdd41..51d38d5e776a 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -702,9 +703,7 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies      = bq24022_consumers,
 };
 
-static struct gpio bq24022_gpios[] = {
-	{ GPIO96_HX4700_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+static enum gpiod_flags bq24022_gpiod_gflags[] = { GPIOD_OUT_LOW };
 
 static struct gpio_regulator_state bq24022_states[] = {
 	{ .value = 100000, .gpios = (0 << 0) },
@@ -714,12 +713,10 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name = "bq24022",
 
-	.enable_gpio = GPIO72_HX4700_BQ24022_nCHARGE_EN,
-	.enable_high = 0,
 	.enabled_at_boot = 0,
 
-	.gpios = bq24022_gpios,
-	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
+	.gflags = bq24022_gpiod_gflags,
+	.ngpios = ARRAY_SIZE(bq24022_gpiod_gflags),
 
 	.states = bq24022_states,
 	.nr_states = ARRAY_SIZE(bq24022_states),
@@ -736,6 +733,17 @@ static struct platform_device bq24022 = {
 	},
 };
 
+static struct gpiod_lookup_table bq24022_gpiod_table = {
+	.dev_id = "gpio-regulator",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO96_HX4700_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO72_HX4700_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * StrataFlash
  */
@@ -878,6 +886,7 @@ static void __init hx4700_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
 
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 08b079653c3f..6538a7c0e504 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -645,9 +645,8 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies	= bq24022_consumers,
 };
 
-static struct gpio bq24022_gpios[] = {
-	{ EGPIO_MAGICIAN_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+
+static enum gpiod_flags bq24022_gpiod_gflags[] = { GPIOD_OUT_LOW };
 
 static struct gpio_regulator_state bq24022_states[] = {
 	{ .value = 100000, .gpios = (0 << 0) },
@@ -657,12 +656,10 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name		= "bq24022",
 
-	.enable_gpio		= GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
-	.enable_high		= 0,
 	.enabled_at_boot	= 1,
 
-	.gpios			= bq24022_gpios,
-	.nr_gpios		= ARRAY_SIZE(bq24022_gpios),
+	.gflags = bq24022_gpiod_gflags,
+	.ngpios = ARRAY_SIZE(bq24022_gpiod_gflags),
 
 	.states			= bq24022_states,
 	.nr_states		= ARRAY_SIZE(bq24022_states),
@@ -679,6 +676,17 @@ static struct platform_device bq24022 = {
 	},
 };
 
+static struct gpiod_lookup_table bq24022_gpiod_table = {
+	.dev_id = "gpio-regulator",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", EGPIO_MAGICIAN_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * fixed regulator for ads7846
  */
@@ -1027,6 +1035,7 @@ static void __init magician_init(void)
 	regulator_register_always_on(0, "power", pwm_backlight_supply,
 		ARRAY_SIZE(pwm_backlight_supply), 5000000);
 
+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
 
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index b2f5ec4f658a..0cec163200c8 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -30,16 +30,15 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/gpio-regulator.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 struct gpio_regulator_data {
 	struct regulator_desc desc;
 	struct regulator_dev *dev;
 
-	struct gpio *gpios;
+	struct gpio_desc **gpiods;
 	int nr_gpios;
 
 	struct gpio_regulator_state *states;
@@ -82,7 +81,7 @@ static int gpio_regulator_set_voltage(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state = target;
 
@@ -119,7 +118,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state = target;
 
@@ -138,7 +137,8 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 {
 	struct gpio_regulator_config *config;
 	const char *regtype;
-	int proplen, gpio, i;
+	int proplen, i;
+	int ngpios;
 	int ret;
 
 	config = devm_kzalloc(dev,
@@ -153,59 +153,36 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	config->supply_name = config->init_data->constraints.name;
 
-	if (of_property_read_bool(np, "enable-active-high"))
-		config->enable_high = true;
-
 	if (of_property_read_bool(np, "enable-at-boot"))
 		config->enabled_at_boot = true;
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	config->enable_gpio = of_get_named_gpio(np, "enable-gpio", 0);
-	if (config->enable_gpio < 0 && config->enable_gpio != -ENOENT)
-		return ERR_PTR(config->enable_gpio);
-
-	/* Fetch GPIOs. - optional property*/
-	ret = of_gpio_count(np);
-	if ((ret < 0) && (ret != -ENOENT))
-		return ERR_PTR(ret);
-
-	if (ret > 0) {
-		config->nr_gpios = ret;
-		config->gpios = devm_kcalloc(dev,
-					config->nr_gpios, sizeof(struct gpio),
-					GFP_KERNEL);
-		if (!config->gpios)
+	/* Fetch GPIO init levels */
+	ngpios = gpiod_count(dev, NULL);
+	if (ngpios > 0) {
+		config->gflags = devm_kzalloc(dev,
+					      sizeof(enum gpiod_flags)
+					      * ngpios,
+					      GFP_KERNEL);
+		if (!config->gflags)
 			return ERR_PTR(-ENOMEM);
 
-		proplen = of_property_count_u32_elems(np, "gpios-states");
-		/* optional property */
-		if (proplen < 0)
-			proplen = 0;
+		for (i = 0; i < ngpios; i++) {
+			u32 val;
 
-		if (proplen > 0 && proplen != config->nr_gpios) {
-			dev_warn(dev, "gpios <-> gpios-states mismatch\n");
-			proplen = 0;
-		}
+			ret = of_property_read_u32_index(np, "gpios-states", i,
+							 &val);
 
-		for (i = 0; i < config->nr_gpios; i++) {
-			gpio = of_get_named_gpio(np, "gpios", i);
-			if (gpio < 0) {
-				if (gpio != -ENOENT)
-					return ERR_PTR(gpio);
-				break;
-			}
-			config->gpios[i].gpio = gpio;
-			config->gpios[i].label = config->supply_name;
-			if (proplen > 0) {
-				of_property_read_u32_index(np, "gpios-states",
-							   i, &ret);
-				if (ret)
-					config->gpios[i].flags =
-							   GPIOF_OUT_INIT_HIGH;
-			}
+			/* Default to high per specification */
+			if (ret)
+				config->gflags[i] = GPIOD_OUT_HIGH;
+			else
+				config->gflags[i] =
+					val ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 		}
 	}
+	config->ngpios = ngpios;
 
 	/* Fetch states. */
 	proplen = of_property_count_u32_elems(np, "states");
@@ -255,7 +232,8 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg = { };
-	int ptr, ret, state;
+	enum gpiod_flags gflags;
+	int ptr, ret, state, i;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gpio_regulator_data),
 			       GFP_KERNEL);
@@ -275,26 +253,17 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (config->nr_gpios != 0) {
-		drvdata->gpios = kmemdup(config->gpios,
-					 config->nr_gpios * sizeof(struct gpio),
-					 GFP_KERNEL);
-		if (drvdata->gpios == NULL) {
-			dev_err(&pdev->dev, "Failed to allocate gpio data\n");
-			ret = -ENOMEM;
-			goto err_name;
-		}
-
-		drvdata->nr_gpios = config->nr_gpios;
-		ret = gpio_request_array(drvdata->gpios, drvdata->nr_gpios);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"Could not obtain regulator setting GPIOs: %d\n",
-					ret);
-			goto err_memgpio;
-		}
+	for (i = 0; i < config->ngpios; i++) {
+		drvdata->gpiods[i] = devm_gpiod_get_index(&pdev->dev,
+							  NULL,
+							  i,
+							  config->gflags[i]);
+		if (IS_ERR(drvdata->gpiods[i]))
+			return PTR_ERR(drvdata->gpiods[i]);
+		/* This is good to know */
+		gpiod_set_consumer_name(drvdata->gpiods[i], drvdata->desc.name);
 	}
+	drvdata->nr_gpios = config->ngpios;
 
 	drvdata->states = kmemdup(config->states,
 				  config->nr_states *
@@ -303,7 +272,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	if (drvdata->states == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate state data\n");
 		ret = -ENOMEM;
-		goto err_stategpio;
+		goto err_name;
 	}
 	drvdata->nr_states = config->nr_states;
 
@@ -330,7 +299,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	/* build initial state from gpio init data. */
 	state = 0;
 	for (ptr = 0; ptr < drvdata->nr_gpios; ptr++) {
-		if (config->gpios[ptr].flags & GPIOF_OUT_INIT_HIGH)
+		if (config->gflags[ptr] == GPIOD_OUT_HIGH)
 			state |= (1 << ptr);
 	}
 	drvdata->state = state;
@@ -340,21 +309,19 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
 
-	if (gpio_is_valid(config->enable_gpio)) {
-		cfg.ena_gpio = config->enable_gpio;
-		cfg.ena_gpio_initialized = true;
-	}
-	cfg.ena_gpio_invert = !config->enable_high;
-	if (config->enabled_at_boot) {
-		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
-		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
-	} else {
-		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
-		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
+	/*
+	 * The signal will be inverted by the GPIO core if flagged so in the
+	 * decriptor.
+	 */
+	if (config->enabled_at_boot)
+		gflags = GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+	else
+		gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+
+	cfg.ena_gpiod = gpiod_get_optional(&pdev->dev, "enable", gflags);
+	if (IS_ERR(cfg.ena_gpiod)) {
+		ret = PTR_ERR(cfg.ena_gpiod);
+		goto err_memstate;
 	}
 
 	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
@@ -370,10 +337,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 
 err_memstate:
 	kfree(drvdata->states);
-err_stategpio:
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-err_memgpio:
-	kfree(drvdata->gpios);
 err_name:
 	kfree(drvdata->desc.name);
 	return ret;
@@ -384,12 +347,7 @@ static int gpio_regulator_remove(struct platform_device *pdev)
 	struct gpio_regulator_data *drvdata = platform_get_drvdata(pdev);
 
 	regulator_unregister(drvdata->dev);
-
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-
 	kfree(drvdata->states);
-	kfree(drvdata->gpios);
-
 	kfree(drvdata->desc.name);
 
 	return 0;
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regulator/gpio-regulator.h
index 19fbd267406d..49c407afb944 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -21,6 +21,8 @@
 #ifndef __REGULATOR_GPIO_H
 #define __REGULATOR_GPIO_H
 
+#include <linux/gpio/consumer.h>
+
 struct regulator_init_data;
 
 enum regulator_type;
@@ -53,9 +55,9 @@ struct gpio_regulator_state {
  *			This is used to keep the regulator at
  *			the default state
  * @startup_delay:	Start-up time in microseconds
- * @gpios:		Array containing the gpios needed to control
- *			the setting of the regulator
- * @nr_gpios:		Number of gpios
+ * @gflags:		Array of GPIO configuration flags for initial
+ *			states
+ * @ngpios:		Number of GPIOs and configurations available
  * @states:		Array of gpio_regulator_state entries describing
  *			the gpio state for specific voltages
  * @nr_states:		Number of states available
@@ -74,8 +76,8 @@ struct gpio_regulator_config {
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
 
-	struct gpio *gpios;
-	int nr_gpios;
+	enum gpiod_flags *gflags;
+	int ngpios;
 
 	struct gpio_regulator_state *states;
 	int nr_states;
-- 
2.20.1

