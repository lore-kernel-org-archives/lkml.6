Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbeEUEjJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:39:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750704AbeEUEjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:39:05 -0400
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 21 May 2018 14:35:12 +1000
Subject: [PATCH 14/30] staging: lustre: clean up __LIBCFS_H macro
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152687731286.24196.3320470277753492185.stgit@noble>
In-Reply-To: <152687724799.24196.7718555295926047576.stgit@noble>
References: <152687724799.24196.7718555295926047576.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some confusion with names here - make it all uniform.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 63ea0e99ec58..ab77cf83af0f 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -103,8 +103,6 @@ static inline int notifier_from_ioctl_errno(int err)
 
 int libcfs_setup(void);
 
-#define _LIBCFS_H
-
 /**
  * The path of debug log dump upcall script.
  */
@@ -124,4 +122,4 @@ int lprocfs_call_handler(void *data, int write, loff_t *ppos,
 			 int (*handler)(void *data, int write, loff_t pos,
 					void __user *buffer, int len));
 
-#endif /* _LIBCFS_H */
+#endif /* __LIBCFS_LIBCFS_H__ */
