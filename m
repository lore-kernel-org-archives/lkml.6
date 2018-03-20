Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeCTOyd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:54:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37879 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:54:26 -0400
X-Google-Smtp-Source: AG47ELvU6QRsjvJ/+PDSD7BcpjVoYeBVnTkBd5Yt+qja4PmLt4qRI56uoF8fCbKMbZ2HIDqIC8GIxA==
From: Dongliang Mu <mudongliangabcd@gmail.com>
To: corbet@lwn.net, yamada.masahiro@socionext.com, slyfox@gentoo.org,
        tony.luck@intel.com, bjorn.forsman@gmail.com,
        mudongliangabcd@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] modify one dead link
Date: Tue, 20 Mar 2018 10:54:22 -0400
Message-Id: <20180320145422.24331-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 Documentation/ia64/xen.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ia64/xen.txt b/Documentation/ia64/xen.txt
index a12c74ce2773..aea4bb94aa59 100644
--- a/Documentation/ia64/xen.txt
+++ b/Documentation/ia64/xen.txt
@@ -26,7 +26,7 @@ Getting and Building Xen and Dom0
     DomainU OS  : RHEL5
 
  1. Download source
-    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
+    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable
     # cd xen-unstable.hg
     # hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
 
-- 
2.16.2
