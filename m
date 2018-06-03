Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeFCSQx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 14:16:53 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:24524 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeFCSQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 14:16:52 -0400
From: Michael Rodin <michael-git@rodin.online>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Rodin <michael-git@rodin.online>
Subject: [PATCH] Documentation/admin-guide/README.rst: add a label for cross-referencing
Date: Sun,  3 Jun 2018 20:16:09 +0200
Message-Id: <20180603181609.7015-1-michael-git@rodin.online>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a label to the top of the file to allow cross-referencing.
Currently it's not possible to cross-reference this file from
Documentation/process/howto.rst because of the missing label.

Signed-off-by: Michael Rodin <michael-git@rodin.online>
---
 Documentation/admin-guide/README.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 02caa7efd5ef..15ea785b2dfa 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -1,3 +1,5 @@
+.. _readme:
+
 Linux kernel release 4.x <http://kernel.org/>
 =============================================
 
-- 
2.14.1
