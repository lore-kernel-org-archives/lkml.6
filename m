Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeFCIdp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 04:33:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40959 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeFCIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 04:33:44 -0400
X-Google-Smtp-Source: ADUXVKI4Ik2tLc5ONfHPE9TbWEICBKaRvmeTBi18MXlQ2qwVB1m5u1vN+K9u19nNCCDXpngj3BQO6epL9hFK3dPzZV4=
MIME-Version: 1.0
In-Reply-To: <CAK7LNASfiRcPVb0Bs_KWuAL3mtzdQfWwATVLkit8MkXeWtgrRQ@mail.gmail.com>
References: <1526351878-24961-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNASfiRcPVb0Bs_KWuAL3mtzdQfWwATVLkit8MkXeWtgrRQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 3 Jun 2018 10:33:42 +0200
Message-ID: <CAFLxGvwmm_tXv0mMoKVSRRC1_hvT7rbm7hVBFwD6fBAQAADrUQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] um: vdso: remove unused vdso-syms.lds
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 3, 2018 at 4:37 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi UML maintainers,
>
> 2018-05-15 11:37 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> This file contains symbol values, and was originally linked into
>> vmlinux, but I have no idea what it was actually used for.
>>
>> Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
>> not even linked.  Now it is completely orphan, and no problem has
>> been reported.  It is a proof that this file was not needed in the
>> first place.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Ingo Molnar <mingo@kernel.org>
>> ---
>
>
> Could you take a look at this patch, please?

Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
