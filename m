Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965354AbeCPP5h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:57:37 -0400
Received: from mout01.posteo.de ([185.67.36.65]:54899 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934612AbeCPP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:57:35 -0400
From: Martin Kepplinger <martink@posteo.de>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] README: Improve documentation descriptions
Date: Fri, 16 Mar 2018 16:57:07 +0100
Message-Id: <20180316155707.28426-1-martink@posteo.de>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"This file" indeed was moved once, but at some point "this file", the
top-level README, becomes a file in itself. Now that time has come :)

Let's describe how things are, and suggest reading "this file" first,
"this file" simply being a the admin-guide README file, not a file that
was once moved.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

That's at least my opinion :)

thanks
                         martin


 README | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/README b/README
index b2ba4aaa3a71..12b4674a483c 100644
--- a/README
+++ b/README
@@ -1,10 +1,9 @@
 Linux kernel
 ============
 
-This file was moved to Documentation/admin-guide/README.rst
-
-Please notice that there are several guides for kernel developers and users.
-These guides can be rendered in a number of formats, like HTML and PDF.
+There are several guides for kernel developers and users. These guides can
+be rendered in a number of formats, like HTML and PDF. Please read
+Documentation/admin-guide/README.rst first.
 
 In order to build the documentation, use ``make htmldocs`` or
 ``make pdfdocs``.
-- 
2.14.2
