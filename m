Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969733AbeCSTli (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:41:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37244 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969699AbeCSTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:41:29 -0400
X-Google-Smtp-Source: AG47ELvftZr+qBI1ds0QbfbLs1nfw9ka7GVodGgmZQfBqJtdyEjTWArBWQ1fY1GS5J4RqxCGtABAgg==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: [PATCH v2 1/2] dt-bindings: Add vendor prefix for Bticino
Date: Tue, 20 Mar 2018 01:11:13 +0530
Message-Id: <20180319194114.15349-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added 'bticino' vendor prefix for Bticino International.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
- Collect review tag from Rob

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ae850d6c0ad3..da0ead5b1ea3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -56,6 +56,7 @@ bosch	Bosch Sensortec GmbH
 boundary	Boundary Devices Inc.
 brcm	Broadcom Corporation
 buffalo	Buffalo, Inc.
+bticino Bticino International
 calxeda	Calxeda
 capella	Capella Microsystems, Inc
 cascoda	Cascoda, Ltd.
-- 
2.14.3
