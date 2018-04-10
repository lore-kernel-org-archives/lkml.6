Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeDJTt0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:49:26 -0400
Received: from sauhun.de ([88.99.104.3]:43276 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbeDJTtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:49:23 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Joe Perches <joe@perches.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/2] MAINTAINERS: add maintainer for Renesas I2C related drivers
Date: Tue, 10 Apr 2018 21:49:14 +0200
Message-Id: <20180410194914.7268-2-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180410194914.7268-1-wsa@the-dreams.de>
References: <20180410194914.7268-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Intentionally missing i2c-riic here, Chris Brandt will add himself for
that one later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since v1:
* add EMEV2 and PINCTRL DEMUX drivers

 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fe9149fa062..e53d40028e03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5906,6 +5906,11 @@ S:	Supported
 F:	drivers/phy/
 F:	include/linux/phy/
 
+GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
+M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
+S:	Supported
+F:	drivers/i2c/muxes/i2c-demux-pinctrl.c
+
 GENERIC PM DOMAINS
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Kevin Hilman <khilman@kernel.org>
@@ -11884,6 +11889,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git c
 S:	Supported
 F:	drivers/clk/renesas/
 
+RENESAS EMEV2 I2C DRIVER
+M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
+S:	Supported
+F:	drivers/i2c/busses/i2c-emev2.c
+
 RENESAS ETHERNET DRIVERS
 R:	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
 L:	netdev@vger.kernel.org
@@ -11899,6 +11909,12 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/adc/rcar_gyro_adc.c
 
+RENESAS R-CAR I2C DRIVERS
+M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
+S:	Supported
+F:	drivers/i2c/busses/i2c-rcar.c
+F:	drivers/i2c/busses/i2c-sh_mobile.c
+
 RENESAS USB PHY DRIVER
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-renesas-soc@vger.kernel.org
-- 
2.11.0
