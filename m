Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032140AbeBNQHR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:07:17 -0500
Received: from mail.visioncatalog.com ([217.6.246.34]:46611 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032056AbeBNQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:07:15 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: robh+dt@kernel.org, mark.rutland@arm.com, andrew@lunn.ch,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: w.egorov@phytec.de
Subject: [PATCH v3 2/2] net: phy: dp83867: Add documentation for CLK_OUT pin muxing
Date: Wed, 14 Feb 2018 17:07:12 +0100
Message-Id: <1518624432-15110-2-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518624432-15110-1-git-send-email-d.schultz@phytec.de>
References: <1518624432-15110-1-git-send-email-d.schultz@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.02.2018 17:07:12,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.02.2018 17:07:12,
        Serialize complete at 14.02.2018 17:07:12
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
Changes:
	v2:
	  -
	v3:
	  Fixed indentation.

 Documentation/devicetree/bindings/net/ti,dp83867.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.txt b/Documentation/devicetree/bindings/net/ti,dp83867.txt
index 02c4353..9ef9338 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.txt
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.txt
@@ -25,6 +25,8 @@ Optional property:
 				    software needs to take when this pin is
 				    strapped in these modes. See data manual
 				    for details.
+	- ti,clk-output-sel - Muxing option for CLK_OUT pin - see dt-bindings/net/ti-dp83867.h
+				    for applicable values.
 
 Note: ti,min-output-impedance and ti,max-output-impedance are mutually
       exclusive. When both properties are present ti,max-output-impedance
-- 
2.7.4
