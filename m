Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeEVKSn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:18:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51497 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbeEVKSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:18:35 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, linux@armlinux.org.uk
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v2 3/3] Documentation/bindings: net: the sfp i2c-bus property is now mandatory
Date: Tue, 22 May 2018 12:18:01 +0200
Message-Id: <20180522101801.18947-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522101801.18947-1-antoine.tenart@bootlin.com>
References: <20180522101801.18947-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-bus property for sfp modules was made mandatory. Update the
documentation to keep it in sync with the driver's behaviour.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 Documentation/devicetree/bindings/net/sff,sfp.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/sff,sfp.txt b/Documentation/devicetree/bindings/net/sff,sfp.txt
index 929591d52ed6..832139919f20 100644
--- a/Documentation/devicetree/bindings/net/sff,sfp.txt
+++ b/Documentation/devicetree/bindings/net/sff,sfp.txt
@@ -7,11 +7,11 @@ Required properties:
   "sff,sfp" for SFP modules
   "sff,sff" for soldered down SFF modules
 
-Optional Properties:
-
 - i2c-bus : phandle of an I2C bus controller for the SFP two wire serial
   interface
 
+Optional Properties:
+
 - mod-def0-gpios : GPIO phandle and a specifier of the MOD-DEF0 (AKA Mod_ABS)
   module presence input gpio signal, active (module absent) high. Must
   not be present for SFF modules
-- 
2.17.0
