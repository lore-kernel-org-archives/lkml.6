Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEQJB1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:01:27 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38921 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeEQJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:01:05 -0400
X-Google-Smtp-Source: AB8JxZom7TgUejyoRV96Sss2qgP29uzfz5+rXfqsOefyzPuXW6o4ijvX7daTKAzmdIniHXN36uFaqg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH v2 8/8] slimbus: qcom: remove redundant depends in Kconfig
Date: Thu, 17 May 2018 09:58:50 +0100
Message-Id: <20180517085850.14276-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
References: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
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
