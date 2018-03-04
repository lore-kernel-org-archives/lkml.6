Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeCDUGN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 15:06:13 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:55763 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeCDUGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 15:06:07 -0500
From: Stefan Agner <stefan@agner.ch>
To: han.xu@nxp.com, boris.brezillon@free-electrons.com
Cc: marek.vasut@gmail.com, richard@nod.at, dwmw2@infradead.org,
        cyrille.pitchen@wedev4u.fr, max.oss.09@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/2] dt-bindings: mtd: rawnand: gpmi: document specific ECC strength
Date: Sun,  4 Mar 2018 21:06:02 +0100
Message-Id: <20180304200602.11475-2-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304200602.11475-1-stefan@agner.ch>
References: <20180304200602.11475-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document newly supported device tree properties nand-ecc-strength/
nand-ecc-step-size to specify ECC strength/size.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/devicetree/bindings/mtd/gpmi-nand.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
index b289ef3c1b7e..393588385c6e 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
@@ -47,6 +47,11 @@ Optional properties:
                        partitions written from Linux with this feature
                        turned on may not be accessible by the BootROM
                        code.
+  - nand-ecc-strength: integer representing the number of bits to correct
+                       per ECC step. Needs to be a multiple of 2.
+  - nand-ecc-step-size: integer representing the number of data bytes
+                       that are covered by a single ECC step. The driver
+                       supports 512 and 1024.
 
 The device tree may optionally contain sub-nodes describing partitions of the
 address space. See partition.txt for more detail.
-- 
2.16.2
