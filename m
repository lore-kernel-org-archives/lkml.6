Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDDMjP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:39:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39263 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeDDMjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:39:12 -0400
Date: Wed, 4 Apr 2018 14:39:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 4.17
Message-ID: <20180404123910.e2rrfmau7f7jcb7i@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-linus

==============

- Add info about loaded kdump kernel into the dump stack header
- Move dump-stack related code from printk.c to lib/dump_stack.c
- Write message about suspending consoles in KERN_INFO log level

----------------------------------------------------------------
Dave Young (2):
      print kdump kernel loaded status in stack dump
      printk: move dump stack related code to lib/dump_stack.c

Petr Mladek (1):
      Merge branch 'for-4.17' into for-linus

Tomeu Vizoso (1):
      printk: change message to pr_info

 include/linux/printk.h |  7 ++++--
 kernel/printk/printk.c | 59 +------------------------------------------------
 lib/Makefile           |  3 ++-
 lib/dump_stack.c       | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 61 deletions(-)
