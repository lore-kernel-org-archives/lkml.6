Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeCUUD6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:03:58 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:45348 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753304AbeCUUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:03:56 -0400
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
Subject: [PATCH 1/7] dt-bindings: add cdtech vendor prefix
Date: Wed, 21 Mar 2018 21:03:07 +0100
Message-Id: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a vendor prefix "cdtech" for CDTech(H.K.) Electronics Limited

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ae850d6..9854399 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -61,6 +61,7 @@ capella	Capella Microsystems, Inc
 cascoda	Cascoda, Ltd.
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
+cdtech	CDTech(H.K.) Electronics Limited
 ceva	Ceva, Inc.
 chipidea	Chipidea, Inc
 chipone		ChipOne
-- 
2.7.4
