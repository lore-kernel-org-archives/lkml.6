Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935006AbeBMJvO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:51:14 -0500
Received: from mail.microcatalog.org.uk ([217.6.246.34]:44488 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934932AbeBMJvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:51:09 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: robh+dt@kernel.org, mark.rutland@arm.com, andrew@lunn.ch,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: phy: dp83867: Add documentation for CLK_OUT pin muxing
Date: Tue, 13 Feb 2018 10:42:32 +0100
Message-Id: <1518514952-22392-2-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518514952-22392-1-git-send-email-d.schultz@phytec.de>
References: <1518514952-22392-1-git-send-email-d.schultz@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.02.2018 10:42:37,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.02.2018 10:42:37,
        Serialize complete at 13.02.2018 10:42:37
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wadim Egorov <w.egorov@phytec.de>

Add documentation of ti,clk-output-sel which can be used to select
a specific clock for CLK_OUT.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 Documentation/devicetree/bindings/net/ti,dp83867.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.txt b/Documentation/devicetree/bindings/net/ti,dp83867.txt
index 02c4353..56060c0 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.txt
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.txt
@@ -25,6 +25,8 @@ Optional property:
 				    software needs to take when this pin is
 				    strapped in these modes. See data manual
 				    for details.
+	- ti,clk-output-sel - Muxing option for CLK_OUT pin - see dt-bindings/net/ti-dp83867.h
+		for applicable values.
 
 Note: ti,min-output-impedance and ti,max-output-impedance are mutually
       exclusive. When both properties are present ti,max-output-impedance
-- 
2.7.4
