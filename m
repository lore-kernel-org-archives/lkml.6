Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbeFASrK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753481AbeFASqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:46:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: devel@driverdev.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/5] ncpfs: remove Documentation
Date: Fri,  1 Jun 2018 20:45:45 +0200
Message-Id: <20180601184547.20213-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601184547.20213-1-gregkh@linuxfoundation.org>
References: <20180601184547.20213-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for any more ncpfs documentation around given that the
filesystem is now removed.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/00-INDEX  |  2 --
 Documentation/filesystems/ncpfs.txt | 12 ------------
 2 files changed, 14 deletions(-)
 delete mode 100644 Documentation/filesystems/ncpfs.txt

diff --git a/Documentation/filesystems/00-INDEX b/Documentation/filesystems/00-INDEX
index b7bd6c9009cc..5f305a2af852 100644
--- a/Documentation/filesystems/00-INDEX
+++ b/Documentation/filesystems/00-INDEX
@@ -89,8 +89,6 @@ locks.txt
 	- info on file locking implementations, flock() vs. fcntl(), etc.
 mandatory-locking.txt
 	- info on the Linux implementation of Sys V mandatory file locking.
-ncpfs.txt
-	- info on Novell Netware(tm) filesystem using NCP protocol.
 nfs/
 	- nfs-related documentation.
 nilfs2.txt
diff --git a/Documentation/filesystems/ncpfs.txt b/Documentation/filesystems/ncpfs.txt
deleted file mode 100644
index 5af164f4b37b..000000000000
-- 
2.17.1
