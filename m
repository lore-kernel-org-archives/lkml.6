Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeBSOvs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:51:48 -0500
Received: from foss.arm.com ([217.140.101.70]:60202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752901AbeBSOvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:51:46 -0500
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: Add DT bindings for ccree 710 and 630p
Date: Mon, 19 Feb 2018 14:51:22 +0000
Message-Id: <1519051887-4668-3-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
References: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Arm CryptoCell 710 and 630p hardware
revisions.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
index cec8d5d..c2598ab 100644
--- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
+++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
@@ -1,7 +1,8 @@
 Arm TrustZone CryptoCell cryptographic engine
 
 Required properties:
-- compatible: Should be "arm,cryptocell-712-ree".
+- compatible: Should be one of: "arm,cryptocell-712-ree",
+  "arm,cryptocell-710-ree" or "arm,cryptocell-630p-ree".
 - reg: Base physical address of the engine and length of memory mapped region.
 - interrupts: Interrupt number for the device.
 
-- 
2.7.4
