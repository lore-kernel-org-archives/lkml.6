Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeDJOOB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:14:01 -0400
Received: from sauhun.de ([88.99.104.3]:40692 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753171AbeDJON7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:13:59 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] MAINTAINERS: I'll maintain Renesas R-Car I2C host drivers
Date: Tue, 10 Apr 2018 16:13:47 +0200
Message-Id: <20180410141347.5014-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f7ccdcf76f7..3bb87e65889c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11897,6 +11897,12 @@ L:	linux-iio@vger.kernel.org
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
