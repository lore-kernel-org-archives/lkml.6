Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2555A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2555A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966310AbeFOQdu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:33:50 -0400
Received: from osg.samsung.com ([64.30.133.232]:35377 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966153AbeFOQbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:31:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 38D8822C27;
        Fri, 15 Jun 2018 09:31:22 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lt8FQHCH02SK; Fri, 15 Jun 2018 09:31:21 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id C39B722B62;
        Fri, 15 Jun 2018 09:30:58 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTrcm-000854-PB; Fri, 15 Jun 2018 13:30:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@zh-kernel.org, dmaengine@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, sparclinux@vger.kernel.org,
        devel@lists.orangefs.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 26/26] fix a series of Documentation/ broken file name references
Date:   Fri, 15 Jun 2018 13:30:54 -0300
Message-Id: <041e7a803fc0e5c5dfc1fb8b2f761074ca0baa2c.1529079120.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As files move around, their previous links break. Fix the
references for them.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/translations/zh_CN/io_ordering.txt | 2 +-
 drivers/dma/dmaengine.c                          | 2 +-
 drivers/platform/x86/Kconfig                     | 2 +-
 drivers/sbus/char/oradax.c                       | 2 +-
 fs/befs/ChangeLog                                | 2 +-
 fs/orangefs/orangefs-sysfs.c                     | 2 +-
 include/linux/platform_data/sc18is602.h          | 2 +-
 kernel/power/main.c                              | 5 +++--
 8 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/zh_CN/io_ordering.txt b/Documentation/translations/zh_CN/io_ordering.txt
index e592daf4e014..1f8127bdd415 100644
--- a/Documentation/translations/zh_CN/io_ordering.txt
+++ b/Documentation/translations/zh_CN/io_ordering.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/io_orderings.txt
+Chinese translated version of Documentation/io_ordering.txt
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index b451354735d3..08ba8473a284 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -38,7 +38,7 @@
  * Each device has a channels list, which runs unlocked but is never modified
  * once the device is registered, it's just setup by the driver.
  *
- * See Documentation/dmaengine.txt for more details
+ * See Documentation/driver-api/dmaengine for more details
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f27cb186437d..ac4d48830415 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1052,7 +1052,7 @@ config SAMSUNG_LAPTOP
 	  function keys, wireless LED, LCD backlight level.
 
 	  It may also provide some sysfs files described in
-	  <file:Documentation/ABI/testing/sysfs-platform-samsung-laptop>
+	  <file:Documentation/ABI/testing/sysfs-driver-samsung-laptop>
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called samsung-laptop.
diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index 1754f55e2fac..524f9ea62e52 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -30,7 +30,7 @@
  * the recommended way for applications to use the coprocessor, and
  * the driver interface is not intended for general use.
  *
- * See Documentation/sparc/oradax/oracle_dax.txt for more details.
+ * See Documentation/sparc/oradax/oracle-dax.txt for more details.
  */
 
 #include <linux/uaccess.h>
diff --git a/fs/befs/ChangeLog b/fs/befs/ChangeLog
index 16f2dfe8c2f7..aff7eec8f327 100644
--- a/fs/befs/ChangeLog
+++ b/fs/befs/ChangeLog
@@ -389,7 +389,7 @@ Version 0.4 (2001-10-28)
 	(fs/nls/Config.in)
 
 * Added Configure.help entries for CONFIG_BEFS_FS and CONFIG_DEBUG_BEFS
-	(Documentation/Configure.help)
+	(currently at fs/befs/Kconfig)
 
 2001-08-??
 ==========
diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.c
index 079a465796f3..dd28079f518c 100644
--- a/fs/orangefs/orangefs-sysfs.c
+++ b/fs/orangefs/orangefs-sysfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Documentation/ABI/stable/orangefs-sysfs:
+ * Documentation/ABI/stable/sysfs-fs-orangefs:
  *
  * What:		/sys/fs/orangefs/perf_counter_reset
  * Date:		June 2015
diff --git a/include/linux/platform_data/sc18is602.h b/include/linux/platform_data/sc18is602.h
index 997b06634152..18602cab7799 100644
--- a/include/linux/platform_data/sc18is602.h
+++ b/include/linux/platform_data/sc18is602.h
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * For further information, see the Documentation/spi/sc18is602 file.
+ * For further information, see the Documentation/spi/spi-sc18is602 file.
  */
 
 /**
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 705c2366dafe..d9706da10930 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -455,8 +455,9 @@ struct kobject *power_kobj;
  * state - control system sleep states.
  *
  * show() returns available sleep state labels, which may be "mem", "standby",
- * "freeze" and "disk" (hibernation).  See Documentation/power/states.txt for a
- * description of what they mean.
+ * "freeze" and "disk" (hibernation).
+ * See Documentation/admin-guide/pm/sleep-states.rst for a description of
+ * what they mean.
  *
  * store() accepts one of those strings, translates it into the proper
  * enumerated value, and initiates a suspend transition.
-- 
2.17.1

