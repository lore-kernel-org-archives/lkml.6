Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbeBUJWZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:22:25 -0500
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:5921 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeBUJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:22:22 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jimmy.vance@hpe.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog/hpwdt: update maintainer information
Date: Wed, 21 Feb 2018 02:22:01 -0700
Message-Id: <20180221092201.8031-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..98b2ef91487d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6267,7 +6267,7 @@ S:	Odd Fixes
 F:	drivers/media/usb/hdpvr/
 
 HEWLETT PACKARD ENTERPRISE ILO NMI WATCHDOG DRIVER
-M:	Jimmy Vance <jimmy.vance@hpe.com>
+M:	Jerry Hoemann <jerry.hoemann@hpe.com>
 S:	Supported
 F:	Documentation/watchdog/hpwdt.txt
 F:	drivers/watchdog/hpwdt.c
-- 
2.13.6
