Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeBWKI3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:08:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:42522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeBWKI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:08:27 -0500
Date: Fri, 23 Feb 2018 10:22:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 4.16-rc3
Message-ID: <20180223092245.52acfu56hhfpmqvl@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull one printk-related fix for 4.16-rc3 from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-linus

============

- People expect to see the real pointer value for %px. Let's substitute
  "(null)" only for the other %p? format modifiers that need to deference
  the pointer.

----------------------------------------------------------------
Adam Borowski (1):
      vsprintf: avoid misleading "(null)" for %px

 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
