Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966898AbeBNITk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:19:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34084 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbeBNITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:19:38 -0500
X-Google-Smtp-Source: AH8x224J220/ndb4fFmRWu0h7ewRqtoC3Zns8T2qeM/eQMhAvjVWqNhDr+EkMdDJqw+PNtlSMJ78ig==
Date: Wed, 14 Feb 2018 11:19:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm 1/3] proc: randomize "struct pde_opener"
Message-ID: <20180214081935.GA17157@avx2>
References: <20180214063033.GA15579@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214063033.GA15579@avx2>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The more the merrier.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/internal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -177,7 +177,7 @@ struct pde_opener {
 	struct list_head lh;
 	bool closing;
 	struct completion *c;
-};
+} __randomize_layout;
 extern const struct inode_operations proc_link_inode_operations;
 
 extern const struct inode_operations proc_pid_link_inode_operations;
