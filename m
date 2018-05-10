Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965999AbeEJOXf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965516AbeEJOXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:23:34 -0400
Date: Thu, 10 May 2018 10:23:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: KASAN: slab-out-of-bounds Write in process_preds
Message-ID: <20180510102331.02ee1346@gandalf.local.home>
In-Reply-To: <CACT4Y+Yz-zRdEKTJeSdK5QTqPtgsSqwoJ4WU8bcX+8RwXUAiSA@mail.gmail.com>
References: <0000000000003723710569916833@google.com>
        <CACT4Y+Yz-zRdEKTJeSdK5QTqPtgsSqwoJ4WU8bcX+8RwXUAiSA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 07:14:26 +0200
Dmitry Vyukov <dvyukov@google.com> wrote:

> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com
> > It will help syzbot understand when the bug is fixed. See footer for
> > details.
> > If you forward the report, please keep this part and the footer.  
> 
> 
> This was bisected to:
> 
> commit 80765597bc587feae8dbc8ce97a0f32e12a6e625
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Fri Mar 9 13:19:28 2018 -0500
> 
>     tracing: Rewrite filter logic to be simpler and faster

I could have told you that without the bisect ;-)

I'll try to get some time to look into this.

-- Steve
