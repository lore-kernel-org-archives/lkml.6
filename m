Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FA0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17F120851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491047;
	bh=p05hRoKbfqW08nwoSTMGkkQvHVbRpcUNC7jK/wOMJsI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pEUu2tdrXnYEW5KCWEZi8zA1E7sj32hsqN7JiSmMExR4VRZ9WAlpbT0SmNVAJeY5E
	 V04VCKGXbeJMH49J1tXMDbQPXCoaOtaDB0r724uvstbPjVpwYpnkU7qKiOoiL5IT+T
	 mkO7f1I0v2+iwjLa0+ibWF4cWmdDfeGVzHQOAkBM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17F120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLKBR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:17:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51028 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeLKBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XCaJdIyA9ECwaIncB2hQosVntiKejaXUO0rm59q2Lyc=; b=iI7nsltgjDZ4
        G0e60EVvcRI4/Ksa+pnSRPiAwlzxAl7M6ftP8V3OoHMn8MYHEjKwxhKZlvHmsa0kIGxZ+dDqu6KlC
        /E5OLtHf6sKbHTKZqPVrz6/PO5TGBEszJVsLEP40w6EwbL33Rv/Pph5UAPJiizQS+Va2YbAsTacrw
        A4544=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWee-0000Lh-I4; Tue, 11 Dec 2018 01:16:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3C17111254C7; Tue, 11 Dec 2018 01:16:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "gpio: Add devm_gpiod_unhinge()" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011608.3C17111254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   gpio: Add devm_gpiod_unhinge()

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

From 891ddbc79a61eb5b919cf56202ecaf7259878cb2 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:46 +0100
Subject: [PATCH] gpio: Add devm_gpiod_unhinge()

This adds a function named devm_gpiod_unhinge() that removes
the resource management from a GPIO descriptor.

I am not sure if this is the best anglosaxon name for the
function, no other managed resources have an equivalent
currently, but I chose "unhinge" as the closest intuitive
thing I could imagine that fits Rusty Russell's API design
criterions "the obvious use is the correct one" and
"the name tells you how to use it".

The idea came out of a remark from Mark Brown that it should
be possible to handle over management of a resource from
devres to the regulator core, and indeed we can do that.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/gpio/gpiolib-devres.c         | 30 +++++++++++++++++++++++++++
 include/linux/gpio/consumer.h         | 10 +++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 43681ca0837f..fc4cc24dfb97 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -254,6 +254,7 @@ GPIO
   devm_gpiod_get_index_optional()
   devm_gpiod_get_optional()
   devm_gpiod_put()
+  devm_gpiod_unhinge()
   devm_gpiochip_add_data()
   devm_gpiochip_remove()
   devm_gpio_request()
diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index f9591b5c9748..0acc2cc6e868 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -346,6 +346,36 @@ void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
 }
 EXPORT_SYMBOL(devm_gpiod_put);
 
+/**
+ * devm_gpiod_unhinge - Remove resource management from a gpio descriptor
+ * @dev:	GPIO consumer
+ * @desc:	GPIO descriptor to remove resource management from
+ *
+ * Remove resource management from a GPIO descriptor. This is needed when
+ * you want to hand over lifecycle management of a descriptor to another
+ * mechanism.
+ */
+
+void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(desc))
+		return;
+	ret = devres_destroy(dev, devm_gpiod_release,
+			     devm_gpiod_match, &desc);
+	/*
+	 * If the GPIO descriptor is requested as nonexclusive, we
+	 * may call this function several times on the same descriptor
+	 * so it is OK if devres_destroy() returns -ENOENT.
+	 */
+	if (ret == -ENOENT)
+		return;
+	/* Anything else we should warn about */
+	WARN_ON(ret);
+}
+EXPORT_SYMBOL(devm_gpiod_unhinge);
+
 /**
  * devm_gpiod_put_array - Resource-managed gpiod_put_array()
  * @dev:	GPIO consumer
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 348885f2f3d3..8aebcf822082 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -104,6 +104,7 @@ struct gpio_descs *__must_check
 devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
 			      enum gpiod_flags flags);
 void devm_gpiod_put(struct device *dev, struct gpio_desc *desc);
+void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc);
 void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
 
 int gpiod_get_direction(struct gpio_desc *desc);
@@ -249,6 +250,15 @@ static inline void gpiod_put(struct gpio_desc *desc)
 	WARN_ON(1);
 }
 
+static inline void devm_gpiod_unhinge(struct device *dev,
+				      struct gpio_desc *desc)
+{
+	might_sleep();
+
+	/* GPIO can never have been requested */
+	WARN_ON(1);
+}
+
 static inline void gpiod_put_array(struct gpio_descs *descs)
 {
 	might_sleep();
-- 
2.19.0.rc2

