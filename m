Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeCaMFe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 08:05:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46808 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeCaMFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 08:05:32 -0400
X-Google-Smtp-Source: AIpwx4/zCDFzZoRPGQkCHrhmPokOcSuQ/qPF04ajg+evMueinHuZZFjkCJpMCE41q7qRlDIVVoXw/fPkIhV13BAjbrs=
MIME-Version: 1.0
In-Reply-To: <20180331101914.ylrlgxhdohcosbnr@gmail.com>
References: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
 <tip-0fc8483b698620ea3d8cc6635b54eccc613c23a3@git.kernel.org>
 <1522163426.21176.24.camel@linux.intel.com> <20180331101914.ylrlgxhdohcosbnr@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 31 Mar 2018 15:05:31 +0300
Message-ID: <CAHp75VcqwTyVfG5DLMuCicsE7QgHxqyYQK2o_Co8-ZH+HTc+MA@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/io: Define readq()/writeq() to use 64-bit type
To: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>, sohil.mehta@intel.com,
        mitake@dcl.info.waseda.ac.jp, linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 1:19 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> On Tue, 2018-02-13 at 08:58 -0800, tip-bot for Andy Shevchenko wrote:
>> > Commit-ID:  0fc8483b698620ea3d8cc6635b54eccc613c23a3
>> > Gitweb:     https://git.kernel.org/tip/0fc8483b698620ea3d8cc6635b54ecc
>> > c613c23a3
>> > Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > AuthorDate: Fri, 19 Jan 2018 16:33:22 +0200
>> > Committer:  Ingo Molnar <mingo@kernel.org>
>> > CommitDate: Tue, 13 Feb 2018 17:14:41 +0100
>>
>> As of today I don't see this in linux-next
>>
>> % git tag --contains 0fc8483b69862
>> next-20180214
>> next-20180215
>> next-20180216
>>
>> What happened to this change?
>
> Hm, so it's a real mystery: I merged it, then removed it 1.5 days later without
> reporting anything. According to the Git log timestamp the removal happened late
> at night, so maybe it was a tired typo?

Who knows? )

> Anyway, it's a good thing you kept out an eye for this: I re-applied the patch for
> v4.17 and will let you know if there's any problem in testing.

Actually I got the same warning when tried to do some debug printings
with readq() as a parameter.
That's why I have noticed.

Thank you for re-applying!

-- 
With Best Regards,
Andy Shevchenko
