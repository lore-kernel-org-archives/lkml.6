Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933745AbeEIGgT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:36:19 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:52708 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeEIGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:36:18 -0400
From: Richard Weinberger <richard@nod.at>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jeff Dike <jdike@addtoit.com>, Nicholas Piggin <npiggin@gmail.com>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [UML] Question about arch/x86/um/vdso/vdso-syms.lds
Date: Wed, 09 May 2018 08:36:09 +0200
Message-ID: <1621114.mSmC2JOP5I@blindfold>
In-Reply-To: <CAK7LNAQREY=32tX7m8dbJ6a_AhXLF_y-n5VLFBBcvXWaRvTmHg@mail.gmail.com>
References: <CAK7LNAQREY=32tX7m8dbJ6a_AhXLF_y-n5VLFBBcvXWaRvTmHg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro,

Am Mittwoch, 9. Mai 2018, 05:36:18 CEST schrieb Masahiro Yamada:
> Hi Richard,
> 
> 
> Please let me ask a question about vdso-syms.lds
> under arch/x86/um/vdso/.
> 
> This file exists since:
> 
> commit f1c2bb8b9964ed31de988910f8b1cfb586d30091
> Author: Richard Weinberger <richard@nod.at>
> Date:   Mon Jul 25 17:12:54 2011 -0700
> 
>     um: implement a x86_64 vDSO
> 
> 
> So, I think you are the right person
> to reach out to.
> 
> 
> Originally, vdso-syms.lds was linked to vmlinux,
> but it is not since:
> 
> commit 827880ec260ba048f95fe646b96a205c394fa0f0
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:   Fri Jun 9 15:24:16 2017 +1000
> 
>     x86/um: thin archives build fix
> 
> 
> 
> Something may be missing from my thought,
> but I wonder what vdso-syms.lds is used for.

Hmm, I think we can kill it. In 2011 I used the x86 vdso
code as "template" this is how the file made it into UML.
AFAICT it was forgotten after all the vdso related refactoring
in um and x86.

Thanks,
//richard
