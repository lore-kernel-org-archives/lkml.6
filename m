Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932383AbeCKVXP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:23:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36431 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbeCKVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:23:13 -0400
X-Google-Smtp-Source: AG47ELu21YJ/SLb0b0Pm32v23IUQFdg8dygDsibmiLKGP0tmCyPxFz3iViZLs1ow5q9ijwy9L2WTKKNsbvGuLK2SWC8=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_E8mVqaR9OmzP2whc7WHGaFX5ypCh7F0UHEyY1DY_t3Q@mail.gmail.com>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-2-ard.biesheuvel@linaro.org> <CA+55aFxcB+5oB_hL83EASOJQrVRCrzT9iS+2+XtEUToG6VHiqA@mail.gmail.com>
 <CAKv+Gu_E8mVqaR9OmzP2whc7WHGaFX5ypCh7F0UHEyY1DY_t3Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Mar 2018 14:23:12 -0700
X-Google-Sender-Auth: AdWsTk3E7TsuYmLf0b_Z8E00CbI
Message-ID: <CA+55aFwTUY5s6nh+bmmDyVEoz6ntt5OgdduKUbTnMn5e0q8Y3A@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] arch: enable relative relocations for arm64, power
 and x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 1:35 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> I'm sure all of these architectures define some kind of 32-bit place
> relative relocation in their ELF psABI, and I see how it would be
> cleaner to change everything at once, but I anticipate a long tail of
> issues with toolchains for niche architectures that I have no way to
> test.

Ok, fair enough.

           Linus
