Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033937AbeCAS0L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:26:11 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46668 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033879AbeCAS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:26:06 -0500
X-Google-Smtp-Source: AG47ELukeT7KFyhsvnt8fl7ZdmQnCP26QgkaGRmkBBYPis3iGf1XcAsswl1Pl+na3r8ioWQmlPhRnA==
Date: Thu, 1 Mar 2018 23:55:59 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Subject: [PATCH] char/bsr: add sysfs interface documentation
Message-ID: <20180301182559.GA32264@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Descriptions have collected from code comments and by reading through
code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-bsr | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-bsr

diff --git a/Documentation/ABI/testing/sysfs-class-bsr b/Documentation/ABI/testing/sysfs-class-bsr
new file mode 100644
index 000000000000..7bf145d32cbc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-bsr
@@ -0,0 +1,25 @@
+What:		/sys/class/bsr/bsr*/bsr_size
+Date:		Jul, 2008
+KernelVersion:	2.6.27
+Contact:	Arnd Bergmann <arnd@arndb.de>,
+		Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Description:
+		(RO) Size of the barrier-synchronization register (BSR)
+		register in bytes.
+
+What:		/sys/class/bsr/bsr*/bsr_length
+Date:		Jul, 2008
+KernelVersion:	2.6.27
+Contact:	Arnd Bergmann <arnd@arndb.de>,
+		Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Description:
+		(RO) The length of memory region that can be mapped in bytes.
+
+What:		/sys/class/bsr/bsr*/bsr_stride
+Date:		Jul, 2008
+KernelVersion:	2.6.27
+Contact:	Arnd Bergmann <arnd@arndb.de>,
+		Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Description:
+		(RO) The stride or the interval at which the allocated BSR bytes
+		repeat within the mapping.
-- 
2.16.2
