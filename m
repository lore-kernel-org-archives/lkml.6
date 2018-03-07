Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeCGM6W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:58:22 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40864 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754490AbeCGM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:58:14 -0500
X-Google-Smtp-Source: AG47ELsvOruUvjpssa2j/s8NFQFXIMvxpINx7PJfKlgFoCBK3HeBgitXRAQ3M97ID79EyR/MGAk3MoMyU6yMw/r6I24=
MIME-Version: 1.0
In-Reply-To: <20180307235329.53331366@canb.auug.org.au>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV> <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
 <20180307104002.GA505@jagdpanzerIV> <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
 <20180307114845.GA894@jagdpanzerIV> <20180307234142.1c7d2710@canb.auug.org.au>
 <CAK8P3a2sA0BmR4cS4Af+d42MabzkZZEBvMaTpoWwOu-N7pP=dg@mail.gmail.com> <20180307235329.53331366@canb.auug.org.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 13:58:13 +0100
X-Google-Sender-Auth: _9kSW63nAXSRGO-AyJICnvHxcD4
Message-ID: <CAK8P3a1_cBKDYtaC7JxzbVhhfNmqcX7ULap3LK-Q-0dUj-MEgg@mail.gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 1:53 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Arnd,
>
> On Wed, 7 Mar 2018 13:48:09 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> Right. At the moment, the plan is to remove metag, score, unicore32,
>> m32r, frv and blackfin. If you are building any more of those, you can
>> stop that as well.
>
> OK, thanks.  Will I get a tree with those removal commits in linux-next
> (sometime soon)? (I already have the metag removal via the metag tree.)

Yes, I should do that any day now, but first have a stack of arm-soc pull
requests to take care of.

I was planning to add these to my asm-generic tree, which is already
in linux-next, and related (enough).

       Arnd
