Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966969AbeCAJeu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:34:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:35252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966675AbeCAJes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:34:48 -0500
Date: Thu, 1 Mar 2018 10:34:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 4.16-rc4
Message-ID: <20180301093446.vlukhvbsdpeg43gs@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull one printk fix for 4.16-rc4 from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-linus

============

- Make sure that we wake up userspace loggers. This fixes a race
  introduced by the console waiter logic in 4.16-rc1.

----------------------------------------------------------------
Petr Mladek (1):
      printk: Wake klogd when passing console_lock owner

 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
