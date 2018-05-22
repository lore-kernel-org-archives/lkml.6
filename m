Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeEVUfN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeEVUfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:35:12 -0400
X-Google-Smtp-Source: AB8JxZqBTNVk1a7koJI0IUyyAdHKLjd3f4EcS0NjE4ODIMxBONyl1eto+1dzgxcPeQPC1+xmVYzs5EKQTG4Uzh3qHq4=
MIME-Version: 1.0
References: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 22 May 2018 13:34:58 -0700
X-Gmail-Original-Message-ID: <CALCETrVx4D0FTg0SW4yDiEBExP+e5k-JG5vEcWkGzKxsKAHjYA@mail.gmail.com>
Message-ID: <CALCETrVx4D0FTg0SW4yDiEBExP+e5k-JG5vEcWkGzKxsKAHjYA@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/build: clean-up of vdso Makefile
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "open list:USER-MODE LINUX (UML)"
        <user-mode-linux-user@lists.sourceforge.net>,
        user-mode-linux-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 7:52 PM Masahiro Yamada <
yamada.masahiro@socionext.com> wrote:




> Masahiro Yamada (3):
>    x86/build: vdso: remove unused $(vobjs-nox32) in Makefile
>    x86/build: vdso: remove unnecessary export in Makefile
>    x86/build: vdso: put generated linker scripts to $(obj)/

LGTM.

Acked-by: Andy Lutomirski <luto@kernel.org>


>   arch/x86/entry/vdso/Makefile | 11 ++++-------
>   arch/x86/um/vdso/Makefile    |  4 ++--
>   2 files changed, 6 insertions(+), 9 deletions(-)

> --
> 2.7.4
