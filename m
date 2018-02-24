Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeBXKIl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 05:08:41 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:40332 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750816AbeBXKIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 05:08:40 -0500
From: Sergei Trofimovich <slyfox@gentoo.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Sergei Trofimovich <slyfox@gentoo.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: doc: tweak whitespace for 'console=' parameter
Date: Sat, 24 Feb 2018 10:08:23 +0000
Message-Id: <20180224100823.24671-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 Documentation/ia64/serial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ia64/serial.txt b/Documentation/ia64/serial.txt
index 6869c73de4e2..a63d2c54329b 100644
--- a/Documentation/ia64/serial.txt
+++ b/Documentation/ia64/serial.txt
@@ -111,7 +111,7 @@ TROUBLESHOOTING SERIAL CONSOLE PROBLEMS
 
 	- If you don't have an HCDP, the kernel doesn't know where
 	  your console lives until the driver discovers serial
-	  devices.  Use "console=uart, io,0x3f8" (or appropriate
+	  devices.  Use "console=uart,io,0x3f8" (or appropriate
 	  address for your machine).
 
     Kernel and init script output works fine, but no "login:" prompt:
-- 
2.16.1
