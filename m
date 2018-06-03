Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeFCSRo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 14:17:44 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:38598 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeFCSRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 14:17:42 -0400
From: Michael Rodin <michael-git@rodin.online>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Rodin <michael-git@rodin.online>
Subject: [PATCH] Documentation/process/howto.rst: add a missing cross-reference
Date: Sun,  3 Jun 2018 20:17:33 +0200
Message-Id: <20180603181733.7093-1-michael-git@rodin.online>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing cross-reference from Documentation/process/howto.rst
to Documentation/admin-guide/README.rst.

Signed-off-by: Michael Rodin <michael-git@rodin.online>
---
 Documentation/process/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 3df55811b916..130bf0f48875 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -85,7 +85,7 @@ linux-api@vger.kernel.org.
 Here is a list of files that are in the kernel source tree that are
 required reading:
 
-  README
+  :ref:`Documentation/admin-guide/README.rst <readme>`
     This file gives a short background on the Linux kernel and describes
     what is necessary to do to configure and build the kernel.  People
     who are new to the kernel should start here.
-- 
2.14.1
