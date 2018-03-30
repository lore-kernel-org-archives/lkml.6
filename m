Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeC3R0R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:26:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58920 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeC3RYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:24:30 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 04/10] mfd: ti-lmu: drop of_compatible for backlight driver
Date: Fri, 30 Mar 2018 19:24:08 +0200
Message-Id: <20180330172414.26575-5-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the of_compatible for the backlight sub-device. There
will be no extra sub-node for the backlight.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/ti-lmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 2ee09d099832..de76298cf3a8 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -58,7 +58,6 @@ static const struct mfd_cell lm3532_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3532,
-		.of_compatible = "ti,lm3532-backlight",
 	},
 };
 
@@ -78,7 +77,6 @@ static const struct mfd_cell lm3631_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3631,
-		.of_compatible = "ti,lm3631-backlight",
 	},
 };
 
@@ -89,7 +87,6 @@ static const struct mfd_cell lm3632_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3632,
-		.of_compatible = "ti,lm3632-backlight",
 	},
 };
 
@@ -97,7 +94,6 @@ static const struct mfd_cell lm3633_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3633,
-		.of_compatible = "ti,lm3633-backlight",
 	},
 	{
 		.name          = "lm3633-leds",
@@ -115,7 +111,6 @@ static const struct mfd_cell lm3695_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3695,
-		.of_compatible = "ti,lm3695-backlight",
 	},
 };
 
@@ -123,7 +118,6 @@ static const struct mfd_cell lm3697_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
 		.id            = LM3697,
-		.of_compatible = "ti,lm3697-backlight",
 	},
 	/* Monitoring driver for open/short circuit detection */
 	{
-- 
2.16.2
