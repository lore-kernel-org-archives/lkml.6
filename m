Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeCOK6y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:58:54 -0400
Received: from mail.phycore.de ([217.6.246.34]:45576 "EHLO root.phytec.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCOK6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:58:53 -0400
From: Daniel Schultz <d.schultz@phytec.de>
To: robh+dt@kernel.org, mark.rutland@arm.com
Cc: heiko@sntech.de, w.egorov@phytec.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: dt-bindings: Add PMIC reset property
Date: Thu, 15 Mar 2018 11:58:50 +0100
Message-Id: <1521111530-39920-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 15.03.2018 11:58:50,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 15.03.2018 11:58:50,
        Serialize complete at 15.03.2018 11:58:50
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about a new rk808 devicetree property, which can
enable resets by the PMIC.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
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
