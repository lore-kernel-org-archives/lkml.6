Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946646AbeCBOH6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:07:58 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:33066 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425080AbeCBOH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:07:56 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] checkpatch: Update section keywords
Date: Fri,  2 Mar 2018 15:07:52 +0100
Message-Id: <1519999672-15828-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit bd721ea73e1f9655 ("treewide: replace obsolete _refok by
__ref"), __init_refok no longer exists, so it can be removed.
While at it, add the modern variants that were still missing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Joe Perches <joe@perches.com>
---
v2:
  - Add Acked-by,
  - Improve one-line summary.
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae19f66..e8f8a65d31c73903 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -344,9 +344,10 @@ our $Sparse	= qr{
 			__force|
 			__iomem|
 			__must_check|
-			__init_refok|
 			__kprobes|
 			__ref|
+			__refconst|
+			__refdata|
 			__rcu|
 			__private
 		}x;
-- 
2.7.4
