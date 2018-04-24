Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDXSui (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:50:38 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:31418 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750791AbeDXSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:50:34 -0400
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Apr 2018 20:50:33 +0200
X-ME-IP: 81.67.76.113
From: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Mike Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Subject: [PATCH v2 1/2] clk: meson: gxbb: expose VDEC_1 and VDEC_HEVC clocks
Date: Tue, 24 Apr 2018 20:48:37 +0200
Message-Id: <20180424184838.3406-2-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424184838.3406-1-maxi.jourdan@wanadoo.fr>
References: <20180424184838.3406-1-maxi.jourdan@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
---
 include/dt-bindings/clock/gxbb-clkc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 8ba99a5e3fd3..7a892be90549 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -125,5 +125,7 @@
 #define CLKID_VAPB_1		138
 #define CLKID_VAPB_SEL		139
 #define CLKID_VAPB		140
+#define CLKID_VDEC_1		153
+#define CLKID_VDEC_HEVC		156
 
 #endif /* __GXBB_CLKC_H */
-- 
2.17.0
