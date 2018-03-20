Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeCTT5F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:57:05 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38121 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:57:01 -0400
X-Google-Smtp-Source: AG47ELuOHOsNntEYmGN1Yy2U6typzJzMcaJE+JbOd5PKpwlPXovdm8V5u0NU+1jqP7flD+qe11zLkw==
From: Dongliang Mu <mudongliangabcd@gmail.com>
To: corbet@lwn.net, yamada.masahiro@socionext.com, slyfox@gentoo.org,
        tony.luck@intel.com, bjorn.forsman@gmail.com,
        mudongliangabcd@gmail.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix one dead link in ia64/xen.txt
Date: Tue, 20 Mar 2018 15:56:58 -0400
Message-Id: <20180320195658.17498-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 Documentation/ia64/xen.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ia64/xen.txt b/Documentation/ia64/xen.txt
index a12c74ce2773..464d4c29b8b5 100644
--- a/Documentation/ia64/xen.txt
+++ b/Documentation/ia64/xen.txt
@@ -26,8 +26,8 @@ Getting and Building Xen and Dom0
     DomainU OS  : RHEL5
 
  1. Download source
-    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
-    # cd xen-unstable.hg
+    # hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable
+    # cd xen-unstable
     # hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
 
  2. # make world
-- 
2.16.2
