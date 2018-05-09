Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935307AbeEINTk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:19:40 -0400
Received: from osg.samsung.com ([64.30.133.232]:58914 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935188AbeEINTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:19:17 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v2 10/11] arch/*: Kconfig: fix documentation for NMI watchdog
Date: Wed,  9 May 2018 10:18:53 -0300
Message-Id: <30b7698983a917b736088821420ac0c3bd9f9a0f.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 9919cba7ff71 ("watchdog: Update documentation") updated
the documentation, removing the old nmi_watchdog.txt and adding
a file with a new content.

Update Kconfig files accordingly.

Fixes: 9919cba7ff71 ("watchdog: Update documentation")

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 arch/arm/Kconfig    | 2 +-
 arch/parisc/Kconfig | 2 +-
 arch/sh/Kconfig     | 2 +-
 arch/sparc/Kconfig  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..7b4fa8356978 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1305,7 +1305,7 @@ config SMP
 	  will run faster if you say N here.
 
 	  See also <file:Documentation/x86/i386/IO-APIC.txt>,
-	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
+	  <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO available at
 	  <http://tldp.org/HOWTO/SMP-HOWTO.html>.
 
 	  If you don't know what to do here, say N.
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fc5a574c3482..b6823215cc9a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -279,7 +279,7 @@ config SMP
 	  machines, but will use only one CPU of a multiprocessor machine.
 	  On a uniprocessor machine, the kernel will run faster if you say N.
 
-	  See also <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO
+	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
 	  available at <http://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe29316476..bf628dd7c195 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -689,7 +689,7 @@ config SMP
 	  People using multiprocessor machines who say Y here should also say
 	  Y to "Enhanced Real Time Clock Support", below.
 
-	  See also <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO
+	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
 	  available at <http://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45f1b2b..66171c2e428b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -189,7 +189,7 @@ config SMP
 	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
 	  Management" code will be disabled if you say Y here.
 
-	  See also <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO
+	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
 	  available at <http://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
-- 
2.17.0
