Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCWR7q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:59:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39620 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeCWR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:59:44 -0400
X-Google-Smtp-Source: AG47ELvuqDmz+M2Eau1JdeF0fvxbE96ALNJW7TKz0fGMyyPl0wfaImqUII8Q3VlZDEmyipyFK15kjw==
From: Alvise Rigo <a.rigo@virtualopensystems.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org, eric.auger@redhat.com
Cc: linux-kernel@vger.kernel.org, a.rigo@virtualopensystems.com
Subject: [PATCH] MAINTAINERS: vfio-platform: Update sub-maintainers
Date: Fri, 23 Mar 2018 18:59:29 +0100
Message-Id: <20180323175929.15319-1-a.rigo@virtualopensystems.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the sub-maintainer entry as Baptiste has moved.

Add me and Eric Auger as sub-maintainers of the VFIO plaform driver.

Signed-off-by: Alvise Rigo <a.rigo@virtualopensystems.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73c0cdabf755..9619c41c2316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14688,7 +14688,8 @@ F:	include/linux/mdev.h
 F:	samples/vfio-mdev/
 
 VFIO PLATFORM DRIVER
-M:	Baptiste Reynal <b.reynal@virtualopensystems.com>
+M:	Alvise Rigo <a.rigo@virtualopensystems.com>
+M:	Eric Auger <eric.auger@redhat.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/platform/
-- 
2.14.3
