Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeFBB3e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 21:29:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40433 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeFBB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 21:29:20 -0400
X-Google-Smtp-Source: ADUXVKL9QF90BrXAIdOkgwnuyC8K1j/6VYr6VTXdvMv+5cDJFkooJfZ0JwO0W4gLjuTORqXUm7P13Q==
From: Brian Norris <briannorris@chromium.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 2/2] dt-bindings: power: sbs-battery: re-document "ti,bq20z75"
Date: Fri,  1 Jun 2018 18:29:00 -0700
Message-Id: <20180602012900.181352-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180602012900.181352-1-briannorris@chromium.org>
References: <20180602012900.181352-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This compatible property was documented before the driver was renamed to
"SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
bq20z75->sbs rename to dt bindings")). The driver has continued to
support this property as an alternative to "sbs,sbs-battery", and
because we've noticed there are some lingering TI specifics (in the
manufacturer-specific portion of the SBS spec), we'd like to start using
this property again to differentiate.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Rhyland Klein <rklein@nvidia.com>
---
v2: add Rhyland's Acked-by
v3: no change
---
 .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index c40e8926facf..a7a9c3366f82 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -2,7 +2,7 @@ SBS sbs-battery
 ~~~~~~~~~~
 
 Required properties :
- - compatible : "sbs,sbs-battery"
+ - compatible : "sbs,sbs-battery" or "ti,bq20z75"
 
 Optional properties :
  - sbs,i2c-retry-count : The number of times to retry i2c transactions on i2c
-- 
2.17.1.1185.g55be947832-goog
