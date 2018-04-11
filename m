Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeDKO64 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbeDKO6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:58:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F7C21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 11 Apr 2018 10:58:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: stack-out-of-bounds Read in __free_filter
Message-ID: <20180411105853.0012696c@gandalf.local.home>
In-Reply-To: <CACT4Y+Yi8DLRHo6CbQk71i8oLzoqYvFprJUsEc3LE32jNnOhVw@mail.gmail.com>
References: <00000000000032a0c30569916870@google.com>
        <20180411104702.7f24401f@gandalf.local.home>
        <CACT4Y+Yi8DLRHo6CbQk71i8oLzoqYvFprJUsEc3LE32jNnOhVw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 16:51:02 +0200
Dmitry Vyukov <dvyukov@google.com> wrote:

> Hi Steve,
> 
> Instructions for asking syzbot to test a patch are here:
> 
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication-with-syzbot

I'll just add reported-by and add the patch. It does fix a bug,
regardless. I have other things I need to work on to spend any more
time on this one.

-- Steve
