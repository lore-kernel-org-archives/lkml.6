Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B260C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 11:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E6220658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 11:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E6220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeIBPiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 11:38:23 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbeIBPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 11:38:22 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0Lto9d-1foGzV4Bin-011CkK; Sun, 02 Sep 2018 13:22:09 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 1/2] dt-bindings: hwmon: Add RPi PoE HAT documentation
Date:   Sun,  2 Sep 2018 13:20:50 +0200
Message-Id: <1535887251-29515-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:Ku1nXBUEdOGG1UKn5ilmpK5YyJcJ6n2Hc1c/XEItZkVmCDRfl6M
 U3hkWviUQwLQ1PSS9/5ZZ30R2T/QcLK+2Mbk7cVjfR+Ymetu32LRYKyOEnC8QfnVY9zcARI
 rr2vL79LxzPR3mUQCOxjQJKxv1+mjhbN+tgIhxxgO2c/Zlbx+XwfBrEdlV8DD0qvl7aGveP
 32EY8Bz0EqypGTTI4sqFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSzvHORPa3Y=:X9dY7x8IgEfx4+R2si96BS
 /lIisIrvETvEpHpJgMnCVpbgO0iRNwD6U7sz+DAqMfz/Dt3WzO/1LN1YyAsC6+pg4pAZu+k5m
 GOttbF+ow+KEaFev/npqDoj/YPaknLC7yVDzdAsi676EceGa3rx+ZfbREbm7GkEAV7+TU2FpK
 4aUDrqAhNa0tBd38HJ2LQWxlWZrZP9mK6/NYEkiBEwzV9wJhvTVwFJyYvcLzDA8SiIP7xGuEq
 I5vO8K3CoEUhhIa2GlHBbOG7dtpfWXLYlvHmWQRmy6PeO1IXSTmhJsbxb2SkkzEd5JsWvIogv
 gK3RGo1DSIplcCnwikSa7KQ1ON9cMKXX5w7woi8+kTiY7dx+a//MkWApzYxVZNTd6tdp5k6mT
 3Aj5UCV78pLdPC3F3NtSBG2PpTg0DwQRFxkLuuj4KMAPIyip+cR/LJ2viqsup/e1co3z9qwii
 OhOVe1JdsF4BHWPc02lVuAvQ7IgG7QsY6uXfDqb7NuBbTK4fMJ2IttmuuZ2CNySvO9L9CpHRG
 K+yDPawBQADRs08CKHrW6kfjVfpC7CRmKPcTEnda3CQHA9Z5BMfLIqzPuBpy7f3oFKg+0L1PM
 H45gw/9HlAhgR06YTLEB2WRnrH9NtobLRaIEnRS2/Q51tz8zONcbMU0TzZolZ6Wy5HX/aQ3gi
 rVeU3/yo709xBzluPGfqafU92mpjS2+A4k2Baa76ORuwCmhKkNruva5hFSgyMQkOxwa0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Schneider <serge@raspberrypi.org>

This patch adds the binding for the fan on the Raspberry Pi Power over
Ethernet HAT.

Signed-off-by: Serge Schneider <serge@raspberrypi.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/hwmon/rpi-poe-fan.txt      | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt

diff --git a/Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt b/Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt
new file mode 100644
index 0000000..c71f856
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt
@@ -0,0 +1,55 @@
+Bindings for the Raspberry Pi PoE HAT fan
+
+Required properties:
+- compatible	: "raspberrypi,rpi-poe-fan"
+- firmware	: Reference to the RPi firmware device node
+- pwms		: the PWM that is used to control the PWM fan
+- cooling-levels      : PWM duty cycle values in a range from 0 to 255
+			which correspond to thermal cooling states
+
+Example:
+	fan0: rpi-poe-fan@0 {
+		compatible = "raspberrypi,rpi-poe-fan";
+		firmware = <&firmware>;
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
+		cooling-levels = <0 50 150 255>;
+		status = "okay";
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			trips {
+				threshold: trip-point@0 {
+					temperature = <45000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+				target: trip-point@1 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+				cpu_hot: cpu_hot@0 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&threshold>;
+					cooling-device = <&fan0 0 1>;
+				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&fan0 1 2>;
+				};
+				map2 {
+					trip = <&cpu_hot>;
+					cooling-device = <&fan0 2 3>;
+				};
+			};
+		};
+	};
-- 
2.7.4

