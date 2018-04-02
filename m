Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbeDBGX6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:23:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36567 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeDBGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:23:57 -0400
X-Google-Smtp-Source: AIpwx48cKeguxzUN4oLtb2+9LWLdFakoWwThrosArIJJwYuixT0YcnoiWmv48nNre5MVcl2OOG+QAA==
Date: Mon, 2 Apr 2018 08:23:53 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] Reduce <linux/interrupt.h> dependencies
Message-ID: <20180402062352.x5qhtzsl4gzrdloo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-headers-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-headers-for-linus

   # HEAD: 562c45d635ecd5c0648ceb4d4aff9bdc1ad91252 headers: Drop two #included headers from <linux/interrupt.h>

A single change that drops two #includes from a frequently used kernel header: 
<linux/interrupt.h>.

 Thanks,

	Ingo

------------------>
Randy Dunlap (1):
      headers: Drop two #included headers from <linux/interrupt.h>


 include/linux/interrupt.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 69c238210325..5426627f9c55 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -4,9 +4,7 @@
 #define _LINUX_INTERRUPT_H
 
 #include <linux/kernel.h>
-#include <linux/linkage.h>
 #include <linux/bitops.h>
-#include <linux/preempt.h>
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
