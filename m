Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965609AbeEYOie (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:38:34 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33596 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965097AbeEYOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:38:29 -0400
X-Google-Smtp-Source: AB8JxZojhZUnI/dsO8la6XiAh//9vvLKsSSse1S7PUZQcj0g5CqMx3GH0YMu0UCmwHmHFgDr7+R0tQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 6/8] slimbus: qcom: remove redundant depends in Kconfig
Date: Fri, 25 May 2018 15:36:16 +0100
Message-Id: <20180525143618.820-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
References: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM SLIMBus controller is already under a 'if SLIMBUS' in Kconfig,
having depends on SLIMBUS is totally redundant. Just remove it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 1a632fad597e..bfb78d9a6583 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -15,7 +15,6 @@ if SLIMBUS
 # SLIMbus controllers
 config SLIM_QCOM_CTRL
 	tristate "Qualcomm SLIMbus Manager Component"
-	depends on SLIMBUS
 	depends on HAS_IOMEM
 	help
 	  Select driver if Qualcomm's SLIMbus Manager Component is
-- 
2.16.2
