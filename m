Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbeBJPcN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 10:32:13 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:48212 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeBJPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 10:32:12 -0500
From: Stefan Agner <stefan@agner.ch>
To: linus.walleij@linaro.org, aisheng.dong@nxp.com, fabio.estevam@nxp.com,
        shawnguo@kernel.org, kernel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] MAINTAINERS: add Freescale pin controllers
Date: Sat, 10 Feb 2018 16:32:04 +0100
Message-Id: <20180210153204.12728-1-stefan@agner.ch>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
and Sascha as reviewer.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82ad0eabce4f..fb672dfc519d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10768,6 +10768,17 @@ L:	linux-gpio@vger.kernel.org
 S:	Supported
 F:	drivers/pinctrl/pinctrl-at91-pio4.*
 
+PIN CONTROLLER - FREESCALE
+M:	Dong Aisheng <aisheng.dong@nxp.com>
+M:	Fabio Estevam <festevam@gmail.com>
+M:	Shawn Guo <shawnguo@kernel.org>
+M:	Stefan Agner <stefan@agner.ch>
+R:	Sascha Hauer <kernel@pengutronix.de>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	drivers/pinctrl/freescale/*
+F:	Documentation/devicetree/bindings/pinctrl/fsl,*
+
 PIN CONTROLLER - INTEL
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
-- 
2.16.1
