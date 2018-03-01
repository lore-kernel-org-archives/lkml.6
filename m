Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965509AbeCACd1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:33:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965468AbeCACdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:33:24 -0500
To: LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/2] auxdisplay: make PANEL a menuconfig
Message-ID: <05da18fe-1e45-43db-f6d3-e4f6d50f3296@infradead.org>
Date: Wed, 28 Feb 2018 18:33:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

This change makes xconfig present the PANEL drivers immediately
following the AUXDISPLAY drivers instead of under the major menu
item "Device Drivers". It also unclutters the Device Drivers menu in
nconfig and menuconfig by moving the PANEL drivers to a sub-menu.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180228.orig/drivers/auxdisplay/Kconfig
+++ linux-next-20180228/drivers/auxdisplay/Kconfig
@@ -166,7 +166,7 @@ config ARM_CHARLCD
 
 endif # AUXDISPLAY
 
-config PANEL
+menuconfig PANEL
 	tristate "Parallel port LCD/Keypad Panel support"
 	depends on PARPORT
 	select CHARLCD
