Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeE1IAc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:00:32 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:26016 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753655AbeE1IAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:00:30 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] i2c: ocores: update HDL sources URL
Date: Mon, 28 May 2018 10:00:11 +0200
Message-Id: <20180528080011.30054-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The URL is broken. This patch fix it

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 drivers/i2c/busses/i2c-ocores.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 8c42ca7107b2..14c5f6bbfd95 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -1,6 +1,6 @@
 /*
  * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
- * (http://www.opencores.org/projects.cgi/web/i2c/overview).
+ * (https://opencores.org/project/i2c?do=projects&download=i2c).
  *
  * Peter Korsgaard <jacmet@sunsite.dk>
  *
-- 
2.15.0
