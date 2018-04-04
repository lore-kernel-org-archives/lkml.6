Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeDDPSt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:18:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38683 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDDPSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:18:48 -0400
X-Google-Smtp-Source: AIpwx49Chiwt9YqT/Dxum9vohQcSL4YMlUZtY5SbLWfbu8k5kcZDnR69SeGMsgJVteaiIIii3bwXLg==
Date: Wed, 04 Apr 2018 08:18:47 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Apr 2018 08:08:27 PDT (-0700)
Subject: Re: [GIT pull] irq updates for 4.17
In-Reply-To: <alpine.DEB.2.21.1804041215180.2056@nanos.tec.linutronix.de>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
From: Palmer Dabbelt <palmer@sifive.com>
To: tglx@linutronix.de
Message-ID: <mhng-c21c8548-7183-480c-ba39-00007856d118@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Apr 2018 03:19:54 PDT (-0700), tglx@linutronix.de wrote:
> On Tue, 3 Apr 2018, Linus Torvalds wrote:
>> On Tue, Apr 3, 2018 at 6:51 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>> >
>> > Thanks!  The linked patch set should be fully bisectable, while this one
>> > will fail on some ARM randconfigs.
>>
>> If it's only some (not very realistic) randconfigs, I suspect an
>> incremental fix is probably the easier solution, rather than redoing
>> that whole branch.
>>
>> So mind at least sending that incremental fix on top of the branch to
>> Thomas and making his life easier if he decides to go that way?
>>
>> And if Thomas is busy doing something else (*), and I come back to
>> this tomorrow as-is, I'd want to pull his tree and just apply the
>> incremental fix anyway, so it makes sense to send it to me as well.
>>
>>                     Linus
>>
>> (*) I have long since accepted that some people have a life outside of
>> kernel development too, and don't always reply immediately. I may not
>> _understand_ it, but I am resigned to the fact.
>
> I briefly returned from that other life and applied the 3 patches on top
> after massaging the changelogs a bit and pushed everything out for you to
> pull.
>
> Thanks,
>
> 	tglx

Works for me.  Thanks!
