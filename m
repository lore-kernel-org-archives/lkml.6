Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDDHwZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:52:25 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56052 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeDDHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:52:23 -0400
X-Auth-Info: nADp4hI52NicLHh9by4l2ffhSNxknhyKNuE7/B0bg4Y=
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] doc: Add vendor prefix for Kieback & Peter GmbH
Date: Wed,  4 Apr 2018 09:52:04 +0200
Message-Id: <20180404075204.11417-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'kiebackpeter' entry has been added to vendor-prefixes.txt to indicate
products from Kieback & Peter GmbH.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ae850d6c0ad3..8ff7eadc8bef 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -181,6 +181,7 @@ karo	Ka-Ro electronics GmbH
 keithkoep	Keith & Koep GmbH
 keymile	Keymile GmbH
 khadas	Khadas
+kiebackpeter    Kieback & Peter GmbH
 kinetic Kinetic Technologies
 kingnovel	Kingnovel Technology Co., Ltd.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
-- 
2.11.0
