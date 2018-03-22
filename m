Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbeCVMHM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:07:12 -0400
Received: from mout01.posteo.de ([185.67.36.65]:36199 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753642AbeCVMHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:07:08 -0400
From: Martin Kepplinger <martink@posteo.de>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Documentation: admin-guide: add kvmconfig, xenconfig and tinyconfig commands
Date: Thu, 22 Mar 2018 13:06:56 +0100
Message-Id: <20180322120656.13644-1-martink@posteo.de>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kvmconfig, xenconfig and tinyconfig to the list of alternative
configuration commands. Descriptions are directly taken from the Makefile.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 Documentation/admin-guide/README.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 155372b3b57f..02caa7efd5ef 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -218,6 +218,13 @@ Configuring the kernel
      "make localyesconfig" Similar to localmodconfig, except it will convert
                            all module options to built in (=y) options.
 
+     "make kvmconfig"   Enable additional options for kvm guest kernel support.
+
+     "make xenconfig"   Enable additional options for xen dom0 guest kernel
+                        support.
+
+     "make tinyconfig"  Configure the tiniest possible kernel.
+
    You can find more information on using the Linux kernel config tools
    in Documentation/kbuild/kconfig.txt.
 
-- 
2.14.2
