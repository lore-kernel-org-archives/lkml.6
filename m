Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934056AbeCGQFs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:05:48 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40417 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933487AbeCGQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:05:44 -0500
X-Google-Smtp-Source: AG47ELvKuHDTbPmdhrV9FNSFuovQcrsw7cmtLu3gSZxOHSLo/4+sf+1fmdRFZkMSvDEhBNFG7yuvIDTKagH+FTpPyy4=
MIME-Version: 1.0
In-Reply-To: <44a75f98-8639-fdbd-6545-5c261f10fe06@monstr.eu>
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
 <44a75f98-8639-fdbd-6545-5c261f10fe06@monstr.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 17:05:43 +0100
X-Google-Sender-Auth: U9L53NdPEdhwzsnJQ3tS9rpcBUw
Message-ID: <CAK8P3a3sij2SZCe5JRgFsTqLB1gQq71MT8BfYqN--Wsd15g9pg@mail.gmail.com>
Subject: Re: CRIS port status, was: [PATCH] dump_stack: convert generic
 dump_stack into a weak symbol
To: Michal Simek <monstr@monstr.eu>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>, Mikael Starvik <starvik@axis.com>,
        linux-cris-kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 4:01 PM, Michal Simek <monstr@monstr.eu> wrote:
> On 7.3.2018 15:09, Arnd Bergmann wrote:
>> On Wed, Mar 7, 2018 at 2:40 PM, Sergey Senozhatsky
>> <sergey.senozhatsky@gmail.com> wrote:

>> If we remove cris, it's probably also appropriate to ask the question
>> about microblaze: Michal, I know your work on microblaze linux has
>> been winding down over the years as the user base shrinks (just
>> like for all others above). Should we keep it for a few more years for
>> the remaining users, or is it time to let go? I would guess we still
>> have active users on modern kernels, but that's what I thought
>> about cris as well ;-)
>
> It is not like that. I definitely have less time for Microblaze to
> develop new stuff but Microblaze HW is still regularly updated and new
> hw features are coming there and new versions are created. We are also
> updating and testing newer kernels and using latest kernel at Xilinx. It
> is definitely not in state that we should just remove it.
>
> There are still a lot of users which are happy with current state and
> there is no pressure to add new features like SMP/address extension/etc
> that's why there is no huge development in arch/microblaze.

Ok, glad to hear that, thanks a lot for the clarification.

       Arnd
