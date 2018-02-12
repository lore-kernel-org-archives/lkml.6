Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeBLPGE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:06:04 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:39156 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbeBLPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:06:02 -0500
From: Stefan Agner <stefan@agner.ch>
To: linus.walleij@linaro.org, aisheng.dong@nxp.com, fabio.estevam@nxp.com,
        shawnguo@kernel.org, kernel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] MAINTAINERS: add Freescale pin controllers
Date: Mon, 12 Feb 2018 16:05:49 +0100
Message-Id: <20180212150549.8622-1-stefan@agner.ch>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
and the Pengutronix kernel team as reviewer.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82ad0eabce4f..df60ca7c3355 100644
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
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
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
