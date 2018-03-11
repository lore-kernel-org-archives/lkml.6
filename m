Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeCKMoj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 08:44:39 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36302 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeCKMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 08:44:38 -0400
X-Google-Smtp-Source: AG47ELttoQhle9C+ox9kjhguZMKzqcP7uvnyK28pHBsrYYAyMRkKdNaQ278BRjrX3eyhYVhuQQNE4OiMO2D3k6B4ZyE=
MIME-Version: 1.0
In-Reply-To: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 11 Mar 2018 12:44:36 +0000
Message-ID: <CAKv+Gu9X7THvdZtoshSQbYGmAHvi+TdaqiM9ienASG-3-Zv88w@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] add support for relative references in special sections
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 March 2018 at 12:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
...
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thomas Garnier <thgarnie@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Morris <james.l.morris@oracle.com>

Note when replying: this ^^^ email address no longer works.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jessica Yu <jeyu@kernel.org>
>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
>
...
