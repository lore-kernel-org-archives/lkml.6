Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeDKPGj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:06:39 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:38834 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbeDKPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:06:38 -0400
X-Google-Smtp-Source: AIpwx49FlVfOSkJXw+KHEwsBbWrkGMwR/EumLojrRH/SuOqyCvgFSxHxT5PA2tt2YnbAWenKPh5O2+PYHyWFV2a2d4g=
MIME-Version: 1.0
In-Reply-To: <20180411105853.0012696c@gandalf.local.home>
References: <00000000000032a0c30569916870@google.com> <20180411104702.7f24401f@gandalf.local.home>
 <CACT4Y+Yi8DLRHo6CbQk71i8oLzoqYvFprJUsEc3LE32jNnOhVw@mail.gmail.com> <20180411105853.0012696c@gandalf.local.home>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 17:06:17 +0200
Message-ID: <CACT4Y+YH2Bi1OFzf_vnMkQPJCL4qKX=wXgsXs7QB0pLSZX+UoQ@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in __free_filter
To: Steven Rostedt <rostedt@goodmis.org>
Cc: syzbot <syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 4:58 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Apr 2018 16:51:02 +0200
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> Hi Steve,
>>
>> Instructions for asking syzbot to test a patch are here:
>>
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication-with-syzbot
>
> I'll just add reported-by and add the patch. It does fix a bug,
> regardless. I have other things I need to work on to spend any more
> time on this one.


This will work too.

Thanks for the quick fix!
