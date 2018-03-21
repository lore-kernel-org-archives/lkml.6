Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeCUUFN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:05:13 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:45434 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbeCUUEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:04:01 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 5/7] dt-bindings: add micronova vendor prefix
Date: Wed, 21 Mar 2018 21:03:11 +0100
Message-Id: <1521662593-25468-5-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a vendor prefix "micronova" for Micronova srl

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 9854399..b07d1fc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -217,6 +217,7 @@ micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
+micronova	Micronova srl
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
 mitsubishi	Mitsubishi Electric Corporation
-- 
2.7.4
