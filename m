Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeBSMsR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:48:17 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:33188 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeBSMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:48:15 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, maxime.ripard@bootlin.com,
        jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v4 05/13] mfd: axp20x: probe axp20x_adc driver for AXP813
Date: Mon, 19 Feb 2018 13:47:28 +0100
Message-Id: <a82ff9673c8652d3fbc17c5966feb230349e6200.1519044068.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the axp20x_adc driver probe with platform device id
"axp813-adc".

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 1977a03..e5516aa 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -885,7 +885,10 @@ static struct mfd_cell axp813_cells[] = {
 	}, {
 		.name			= "axp20x-gpio",
 		.of_compatible		= "x-powers,axp813-gpio",
-	}
+	}, {
+		.name			= "axp813-adc",
+		.of_compatible		= "x-powers,axp813-adc",
+	},
 };
 
 static struct axp20x_dev *axp20x_pm_power_off;
-- 
git-series 0.9.1
