Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946599AbeCBNa0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:30:26 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33491 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946584AbeCBNaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:30:23 -0500
X-Google-Smtp-Source: AG47ELsb7vfg1QfM3h7Q+C7FhWXEH+NN9mVkW5BSSb0kc78P5sCJQENOrdqrlliLBgt5ge7PnCrTOw==
From: Masanari Iida <standby24x7@gmail.com>
To: darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] xfs: Change URL for the project in xfs.txt
Date: Fri,  2 Mar 2018 22:30:13 +0900
Message-Id: <20180302133013.9744-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.16.2.345.g7e31236f652a
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oss.sgi.com doesn't exist any more.
Change it to current project URL, https://xfs.wiki.kernel.org/

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/filesystems/xfs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/xfs.txt b/Documentation/filesystems/xfs.txt
index 3b9b5c149f32..4d9ff0a7f8e1 100644
--- a/Documentation/filesystems/xfs.txt
+++ b/Documentation/filesystems/xfs.txt
@@ -9,7 +9,7 @@ variable block sizes, is extent based, and makes extensive use of
 Btrees (directories, extents, free space) to aid both performance
 and scalability.
 
-Refer to the documentation at http://oss.sgi.com/projects/xfs/
+Refer to the documentation at https://xfs.wiki.kernel.org/
 for further details.  This implementation is on-disk compatible
 with the IRIX version of XFS.
 
-- 
2.16.2.345.g7e31236f652a
