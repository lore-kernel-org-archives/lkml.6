Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbeE1I7u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:59:50 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:61576 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932119AbeE1I7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:47 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH V2] i2c: ocores: update HDL sources URL
Date: Mon, 28 May 2018 10:59:14 +0200
Message-Id: <20180528085914.30657-2-federico.vaga@vaga.pv.it>
In-Reply-To: <20180528085914.30657-1-federico.vaga@vaga.pv.it>
References: <20180528085914.30657-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The URL is broken. This patch fix it

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/i2c/busses/i2c-ocores | 2 +-
 drivers/i2c/busses/i2c-ocores.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-ocores b/Documentation/i2c/busses/i2c-ocores
index c269aaa2f26a..260736e28056 100644
--- a/Documentation/i2c/busses/i2c-ocores
+++ b/Documentation/i2c/busses/i2c-ocores
@@ -2,7 +2,7 @@ Kernel driver i2c-ocores
 
 Supported adapters:
   * OpenCores.org I2C controller by Richard Herveille (see datasheet link)
-    Datasheet: http://www.opencores.org/projects.cgi/web/i2c/overview
+    https://opencores.org/project/i2c?do=projects&download=i2c
 
 Author: Peter Korsgaard <jacmet@sunsite.dk>
 
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
