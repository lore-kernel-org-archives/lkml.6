Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeEBJ5R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:57:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36082 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeEBJ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:57:13 -0400
X-Google-Smtp-Source: AB8JxZp7l3fOUHN9KtaTfYMY7Wb0IxWlcLHK/+HkfY6h81TlTrLYVOpQAGfH6e+igP/fY0fBzgfKlA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Suman Anna <s-anna@ti.com>, Aparna Balasubramanian <aparnab@ti.com>,
        Kevin Hilman <khilman@kernel.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/3] remoteproc/davinci: use octal permissions for module_param()
Date: Wed,  2 May 2018 11:56:59 +0200
Message-Id: <20180502095659.3626-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502095659.3626-1-brgl@bgdev.pl>
References: <20180502095659.3626-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch recommends to use octal perms instead of S_IRUGO.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index f134192922e0..b668e32996e2 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -25,7 +25,7 @@
 #include "remoteproc_internal.h"
 
 static char *da8xx_fw_name;
-module_param(da8xx_fw_name, charp, S_IRUGO);
+module_param(da8xx_fw_name, charp, 0444);
 MODULE_PARM_DESC(da8xx_fw_name,
 		 "Name of DSP firmware file in /lib/firmware (if not specified defaults to 'rproc-dsp-fw')");
 
-- 
2.17.0
