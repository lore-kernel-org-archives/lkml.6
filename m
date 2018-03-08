Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966381AbeCHTMr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:12:47 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40174 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965788AbeCHTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:12:45 -0500
X-Google-Smtp-Source: AG47ELu91qQSyc62U7kUjr7tAFliSxn43F0PLOdTUteez/ayGr9a4wj62HLgWW1u/s0lOdGeVUvx7Q==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 16/21] nvmem: snvs_lpgpr: Convert commas to semicolons
Date: Thu,  8 Mar 2018 11:12:00 -0800
Message-Id: <20180308191205.26943-17-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308191205.26943-1-andrew.smirnov@gmail.com>
References: <20180308191205.26943-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like commas were accidentally used where semicolons were
supposed to be. Fix that.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/snvs_lpgpr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index cb471d5e8e86..92e1e41d128e 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -110,12 +110,12 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->priv = priv;
 	cfg->name = dev_name(dev);
 	cfg->dev = dev;
-	cfg->stride = 4,
-	cfg->word_size = 4,
-	cfg->size = 4,
-	cfg->owner = THIS_MODULE,
-	cfg->reg_read  = snvs_lpgpr_read,
-	cfg->reg_write = snvs_lpgpr_write,
+	cfg->stride = 4;
+	cfg->word_size = 4;
+	cfg->size = 4;
+	cfg->owner = THIS_MODULE;
+	cfg->reg_read  = snvs_lpgpr_read;
+	cfg->reg_write = snvs_lpgpr_write;
 
 	nvmem = devm_nvmem_register(dev, cfg);
 
-- 
2.14.3
