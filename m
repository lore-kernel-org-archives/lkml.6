Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755249AbeDCJOH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:14:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37130 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeDCJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:14:05 -0400
Date: Tue, 3 Apr 2018 11:13:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Petr Mladek <pmladek@suse.com>
Cc: syzbot <syzbot+d1fe9b7b917f2715c7d4@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: general protection fault in try_to_wake_up
Message-ID: <20180403091333.GZ4082@hirez.programming.kicks-ass.net>
References: <000000000000f2c42e05688f3ab6@google.com>
 <20180403085002.cq6rjxcmggypo4kh@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403085002.cq6rjxcmggypo4kh@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 10:50:03AM +0200, Petr Mladek wrote:
> raw_spin_lock() succeeded here. Therefore lockdep was still working
> at this stage.

What does the success of raw_spin_lock() have to do with lockdep ?
