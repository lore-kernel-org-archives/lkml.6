Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeBJJ5S (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 04:57:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54940 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeBJJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 04:57:16 -0500
X-Google-Smtp-Source: AH8x2263M+7fCulWq1dJs+7QoGoXVK0mGl5m59xsxGSfdg8k+Ew7kCKJMZWvMQY6137ykXqT/ac0BA==
Date: Sat, 10 Feb 2018 10:56:51 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] MAINTAINERS: auxdisplay: remove obsolete webpages
Message-ID: <20180210095651.y7kvf3oqp6pzvh33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6c26cb47d02..01e302f7967e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2484,8 +2484,6 @@ F:	kernel/audit*
 
 AUXILIARY DISPLAY DRIVERS
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
-W:	http://miguelojeda.es/auxdisplay.htm
-W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
 S:	Maintained
 F:	drivers/auxdisplay/
 F:	include/linux/cfag12864b.h
@@ -3373,16 +3371,12 @@ F:	include/linux/usb/wusb*
 
 CFAG12864B LCD DRIVER
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
-W:	http://miguelojeda.es/auxdisplay.htm
-W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
 S:	Maintained
 F:	drivers/auxdisplay/cfag12864b.c
 F:	include/linux/cfag12864b.h
 
 CFAG12864BFB LCD FRAMEBUFFER DRIVER
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
-W:	http://miguelojeda.es/auxdisplay.htm
-W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
 S:	Maintained
 F:	drivers/auxdisplay/cfag12864bfb.c
 F:	include/linux/cfag12864b.h
@@ -7866,8 +7860,6 @@ F:	kernel/kprobes.c
 
 KS0108 LCD CONTROLLER DRIVER
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
-W:	http://miguelojeda.es/auxdisplay.htm
-W:	http://jair.lab.fi.uva.es/~migojed/auxdisplay.htm
 S:	Maintained
 F:	Documentation/auxdisplay/ks0108
 F:	drivers/auxdisplay/ks0108.c
-- 
2.14.1
