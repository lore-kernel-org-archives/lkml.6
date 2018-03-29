Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC2Oor (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:44:47 -0400
Received: from mail.phycore.de ([217.6.246.34]:56440 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeC2Oop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:44:45 -0400
From: Daniel Schultz <d.schultz@phytec.de>
To: robh@kernel.org
Cc: mark.rutland@arm.com, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: dt-bindings: Add rk808 PMIC reset property
Date: Thu, 29 Mar 2018 16:44:43 +0200
Message-Id: <1522334683-22169-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2018 16:44:43,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2018 16:44:43,
        Serialize complete at 29.03.2018 16:44:43
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about a new rk808 devicetree property. This can enable
the rk805/rk808/rk818 PMIC reset, instead of using soft resets from the
Control and Reset Module.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes:
	v2: Changed commit message

 Documentation/devicetree/bindings/mfd/rk808.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 91b6522..fa1a30f 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -20,6 +20,8 @@ Optional properties:
   default output clock name
 - rockchip,system-power-controller: Telling whether or not this pmic is controlling
   the system power.
+- rockchip,system-reset-controller: Telling whether or not this pmic is controlling
+  the system reset.
 
 Optional RK805 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
-- 
2.7.4
