Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964892AbeE2PGG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:06:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46897 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935380AbeE2PFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:05:06 -0400
X-Google-Smtp-Source: ADUXVKIsZeoZIIc+FRGlWZuYYmtLTCqZsW713TZnp5SjdZzuuzi4gbi7mCBClXD90G0AjpAr/BseEA==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v2 1/5] ARM: imx: remove inexistant EPIT timer init
Date: Tue, 29 May 2018 17:04:51 +0200
Message-Id: <20180529150455.17300-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529150455.17300-1-peron.clem@gmail.com>
References: <20180529150455.17300-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

i.MX EPIT timer has been removed but not the init function declaration.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
---
 arch/arm/mach-imx/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c8d68e918b2f..18aae76fa2da 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -38,7 +38,6 @@ void imx21_soc_init(void);
 void imx27_soc_init(void);
 void imx31_soc_init(void);
 void imx35_soc_init(void);
-void epit_timer_init(void __iomem *base, int irq);
 int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx27_clocks_init(unsigned long fref);
 int mx31_clocks_init(unsigned long fref);
-- 
2.17.0
