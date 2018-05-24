Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964929AbeEXMmt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:42:49 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:43054 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964791AbeEXMmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:42:46 -0400
Date: Thu, 24 May 2018 15:42:42 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>, peterz@infradead.org
Subject: Re: 85f1abe001 ("kthread, sched/wait: Fix kthread_parkme() .."):
 WARNING: CPU: 0 PID: 1 at kernel/kthread.c:486 kthread_park
Message-ID: <alpine.LRH.2.21.1805241540010.17544@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same kthread_parkme warning on many machines I tested with 
4.17.0-rc6-00158-gbee797529d7c (x86, amd64, sparc, parisc, alpha).

Your patch https://lkml.org/lkml/2018/5/4/212 fixed the problem for me.

Sorry for off-thread respnse, I found your mail from the web only.

-- 
Meelis Roos (mroos@linux.ee)
