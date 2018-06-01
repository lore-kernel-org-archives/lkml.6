Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeFAAdY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 20:33:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45883 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFAAdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 20:33:10 -0400
X-Google-Smtp-Source: ADUXVKJFipDAHqbpQeLXk8jJafJNAUnojuwXueIAvF9ZYK2xJ3vw8FFoQjCuV9AFjE4CNrqgJCuyOA==
From: Brian Norris <briannorris@chromium.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Rhyland Klein <rklein@nvidia.com>
Subject: [PATCH 2/2] dt-bindings: power: sbs-battery: re-document "ti,bq20z75"
Date: Thu, 31 May 2018 17:32:52 -0700
Message-Id: <20180601003252.42810-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180601003252.42810-1-briannorris@chromium.org>
References: <20180601003252.42810-1-briannorris@chromium.org>
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

Cc: Rhyland Klein <rklein@nvidia.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
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
2.17.0.921.gf22659ad46-goog
