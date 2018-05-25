Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935607AbeEYFUI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:20:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39441 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935000AbeEYFUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:20:07 -0400
X-Google-Smtp-Source: AB8JxZo8ubqFshsftoRJ98yZpitmhv+hahAs6GRjo/E44c39FLLpHyxHYCoy8HcaOQLlE8pzxZEMEw==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: binding: Fix "#cooling-cells" property's name
Date: Fri, 25 May 2018 10:49:57 +0530
Message-Id: <9754c25e8459685d4919017dd7c8709cee7b89ce.1527224960.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be "#cooling-cells" instead of "cooling-cells". Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/hwmon/gpio-fan.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
index 439a7430fc68..2becdcfdc840 100644
--- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
@@ -11,7 +11,7 @@ Bindings for fan connected to GPIO lines
   must have the RPM values in ascending order.
 - alarm-gpios: This pin going active indicates something is wrong with
   the fan, and a udev event will be fired.
-- cooling-cells: If used as a cooling device, must be <2>
+- #cooling-cells: If used as a cooling device, must be <2>
   Also see: Documentation/devicetree/bindings/thermal/thermal.txt
   min and max states are derived from the speed-map of the fan.
 
-- 
2.15.0.194.g9af6a3dea062
