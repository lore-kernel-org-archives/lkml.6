Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeCPFXw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:23:52 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:44073 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeCPFXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:23:50 -0400
X-Google-Smtp-Source: AG47ELvaQpxtdTm6JZPK4/rr8XopF+rUaFPt78eyAgnF6gfM8SIsCxN58evE1RxcXVWjFfmSxh3O3Mm+PgQ2XqjodPY=
MIME-Version: 1.0
In-Reply-To: <20180316132529.45126501@canb.auug.org.au>
References: <20180316132529.45126501@canb.auug.org.au>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Thu, 15 Mar 2018 22:23:49 -0700
Message-ID: <CABeXuvrFkASp1g5LDW0MsENqtHRiT=Vp=F5GN3XdhGzaXkHNsw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the y2038 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Do you want me to send the fix as a patch or should I re-post the series?

Thanks,
Deepa

On Thu, Mar 15, 2018 at 7:25 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Arnd,
>
> After merging the y2038 tree, today's linux-next build (s390 allnoconfig)
> failed like this:
>
> In file included from include/linux/elf.h:5:0,
>                  from include/linux/module.h:15,
>                  from init/main.c:16:
> arch/s390/include/asm/elf.h:138:1: error: unknown type name 's390_compat_regs'
>
> Caused by commit
>
>   f00689038f71 ("include: Move compat_timespec/ timeval to compat_time.h")
>
> --
> Cheers,
> Stephen Rothwell
