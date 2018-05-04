Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeEDNz0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:55:26 -0400
Received: from mail.monom.org ([188.138.9.77]:43984 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbeEDNzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:55:24 -0400
From: Daniel Wagner <wagi@monom.org>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>, Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/3] 4.4.131-rt148-rc1
Date: Fri,  4 May 2018 15:55:13 +0200
Message-Id: <20180504135516.32601-1-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.4.131-rt148-rc1.

Here are couple of patches from Sebiastian which didn't make into
4.4.126-rt142 cycle.  I haven't included Julia's "seqlock: provide the
same ordering semantics as mainline" patch, because I don't know it
needs a review or not.

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 09.05.2017.

Enjoy,
-- Daniel


Daniel Wagner (1):
  Linux 4.4.131-rt148-rc1

Sebastian Andrzej Siewior (2):
  alarmtimer: Prevent live lock in alarm_cancel()
  posix-timers: move the rcu head out of the union

 include/linux/posix-timers.h | 2 +-
 kernel/time/alarmtimer.c     | 2 +-
 kernel/time/posix-timers.c   | 4 ++--
 localversion-rt              | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.14.3
