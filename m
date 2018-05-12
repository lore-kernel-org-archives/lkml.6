Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeELWGE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 18:06:04 -0400
Received: from vern.gendns.com ([206.190.152.46]:56263 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbeELWGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 18:06:02 -0400
From: David Lechner <david@lechnology.com>
To: linux-kernel@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] MAINTAINERS: add entry for LEGO MINDSTORMS EV3
Date: Sat, 12 May 2018 17:05:44 -0500
Message-Id: <20180512220544.24016-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an entry to MAINTAINERS for LEGO MINDSTORMS EV3 (an ARM-based
robotics platform). The files listed are exclusive to this device. Add
me as reviewer so that I will be cc'ed for any changes to these files.

Signed-off-by: David Lechner <david@lechnology.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index df6e9bb2559a..2e057e0138b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7960,6 +7960,13 @@ S:	Maintained
 F:	Documentation/misc-devices/eeprom
 F:	drivers/misc/eeprom/eeprom.c
 
+LEGO MINDSTORMS EV3
+R:	David Lechner <david@lechnology.com>
+S:	Maintained
+F:	arch/arm/boot/dts/da850-lego-ev3.dts
+F:	Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
+F:	drivers/power/supply/lego_ev3_battery.c
+
 LEGO USB Tower driver
 M:	Juergen Stuber <starblue@users.sourceforge.net>
 L:	legousb-devel@lists.sourceforge.net
-- 
2.17.0
