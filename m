Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeEKNxB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:53:01 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:45767 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeEKNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:53:00 -0400
X-Google-Smtp-Source: AB8JxZpwGAAvWv/kvUAgV0njmEWyGuyoTDCgih8Lt1IxmYANP2ccfl8LGNiXbC4Iqpz0/zD0zVbjVoFJIaojiW0uTBA=
MIME-Version: 1.0
In-Reply-To: <20180510102331.02ee1346@gandalf.local.home>
References: <0000000000003723710569916833@google.com> <CACT4Y+Yz-zRdEKTJeSdK5QTqPtgsSqwoJ4WU8bcX+8RwXUAiSA@mail.gmail.com>
 <20180510102331.02ee1346@gandalf.local.home>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 11 May 2018 15:52:39 +0200
Message-ID: <CACT4Y+Zyp-MfpZZ5wA90T_YB5sEG6=v-aZWZFwsOtJ8UdE56iA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in process_preds
To: Steven Rostedt <rostedt@goodmis.org>
Cc: syzbot <syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 4:23 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 10 May 2018 07:14:26 +0200
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+5702a7e6d4a13b3accd5@syzkaller.appspotmail.com
>> > It will help syzbot understand when the bug is fixed. See footer for
>> > details.
>> > If you forward the report, please keep this part and the footer.
>>
>>
>> This was bisected to:
>>
>> commit 80765597bc587feae8dbc8ce97a0f32e12a6e625
>> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Date:   Fri Mar 9 13:19:28 2018 -0500
>>
>>     tracing: Rewrite filter logic to be simpler and faster
>
> I could have told you that without the bisect ;-)

Well, it was a good candidate for testing of automatic bisection process ;)
It seems that it has found the right one, which is good.

> I'll try to get some time to look into this.
>
> -- Steve
