Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933614AbeEIDhK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 23:37:10 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51103 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbeEIDhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 23:37:09 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w493axlh022989
X-Nifty-SrcIP: [209.85.213.41]
X-Google-Smtp-Source: AB8JxZohEv+/doYHEE/7c5ljzwQPQdm+FXoIWs+NOYJ1itmqipnxZOhkKn7H7QWmeEJ00s5PtJMvp7tsrD8E0EFDxg8=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 9 May 2018 12:36:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQREY=32tX7m8dbJ6a_AhXLF_y-n5VLFBBcvXWaRvTmHg@mail.gmail.com>
Message-ID: <CAK7LNAQREY=32tX7m8dbJ6a_AhXLF_y-n5VLFBBcvXWaRvTmHg@mail.gmail.com>
Subject: [UML] Question about arch/x86/um/vdso/vdso-syms.lds
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, Nicholas Piggin <npiggin@gmail.com>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,


Please let me ask a question about vdso-syms.lds
under arch/x86/um/vdso/.

This file exists since:

commit f1c2bb8b9964ed31de988910f8b1cfb586d30091
Author: Richard Weinberger <richard@nod.at>
Date:   Mon Jul 25 17:12:54 2011 -0700

    um: implement a x86_64 vDSO


So, I think you are the right person
to reach out to.


Originally, vdso-syms.lds was linked to vmlinux,
but it is not since:

commit 827880ec260ba048f95fe646b96a205c394fa0f0
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Fri Jun 9 15:24:16 2017 +1000

    x86/um: thin archives build fix



Something may be missing from my thought,
but I wonder what vdso-syms.lds is used for.



-- 
Best Regards
Masahiro Yamada
