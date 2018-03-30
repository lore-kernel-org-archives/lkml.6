Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeC3DwA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 23:52:00 -0400
Received: from mx.socionext.com ([202.248.49.38]:46785 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752977AbeC3Dvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 23:51:45 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] thermal: uniphier: add UniPhier PXs3 support
Date: Fri, 30 Mar 2018 12:51:20 +0900
Message-Id: <1522381880-18892-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522381880-18892-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522381880-18892-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for UniPhier PXs3 SoC. It is equivalent to LD20.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/thermal/uniphier_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 9570473..55477d7 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -365,6 +365,10 @@ static const struct of_device_id uniphier_tm_dt_ids[] = {
 		.compatible = "socionext,uniphier-ld20-thermal",
 		.data       = &uniphier_ld20_tm_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pxs3-thermal",
+		.data       = &uniphier_ld20_tm_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, uniphier_tm_dt_ids);
-- 
2.7.4
