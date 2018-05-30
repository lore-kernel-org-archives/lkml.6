Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeE3MFM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:05:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37123 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeE3MDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:03:54 -0400
X-Google-Smtp-Source: ADUXVKKjIWEnCB85J682oRUBIbtse0DZg+1eANUNMes+RXdDtnOkPx2wlRIQXuWvjaTwv3Fktlltnw==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v4 1/5] ARM: imx: remove inexistant EPIT timer init
Date: Wed, 30 May 2018 14:03:23 +0200
Message-Id: <20180530120327.27681-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530120327.27681-1-peron.clem@gmail.com>
References: <20180530120327.27681-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

i.MX EPIT timer has been removed but not the init function declaration.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
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
