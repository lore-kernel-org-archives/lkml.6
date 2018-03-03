Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeCCKlK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 05:41:10 -0500
Received: from sysmic.org ([62.210.89.17]:54950 "EHLO lupi.sysmic.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751926AbeCCKlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 05:41:09 -0500
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jezz@sysmic.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jezz@sysmic.org>
Subject: [PATCH] ARM: dts: imx6dl: Fix typo in Engicam i.CoreM6 DualLite/Solo RQS
Date: Sat,  3 Mar 2018 11:34:29 +0100
Message-Id: <20180303103429.3063-1-jezz@sysmic.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously "Engicam i.CoreM6 DualLite/Solo RQS" include an imx6dl, not
an imx6q.

Signed-off-by: Jérôme Pouiller <jezz@sysmic.org>
---
 arch/arm/boot/dts/imx6dl-icore-rqs.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-icore-rqs.dts b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
index cf42c2f5cdc7..1281bc39b7ab 100644
--- a/arch/arm/boot/dts/imx6dl-icore-rqs.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-rqs.dts
@@ -42,7 +42,7 @@
 
 /dts-v1/;
 
-#include "imx6q.dtsi"
+#include "imx6dl.dtsi"
 #include "imx6qdl-icore-rqs.dtsi"
 
 / {
-- 
2.11.0
