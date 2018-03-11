Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeCKTIE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:08:04 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:40776 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbeCKTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:08:03 -0400
X-Google-Smtp-Source: AG47ELvep+eJODvwyQiV2MCNpWCtFSwFEwOf1KPVcECiwMEF94DwJ9ek3SQiat63PuHiSD+lxu3u7kd9hcFGsMoHRZg=
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9X7THvdZtoshSQbYGmAHvi+TdaqiM9ienASG-3-Zv88w@mail.gmail.com>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org> <CAKv+Gu9X7THvdZtoshSQbYGmAHvi+TdaqiM9ienASG-3-Zv88w@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 11 Mar 2018 12:08:00 -0700
X-Google-Sender-Auth: N-Kn6UlWkBEKWUGviUqF6T0kZBM
Message-ID: <CAGXu5jJSQZJMT1T0a4_yJ1FXCVEy+yhyYF8yLwVvugs8DA=_QA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] add support for relative references in special sections
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 5:44 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 11 March 2018 at 12:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Cc: James Morris <james.l.morris@oracle.com>
>
> Note when replying: this ^^^ email address no longer works.

James updated MAINTAINERS to: James Morris <jmorris@namei.org>

-- 
Kees Cook
Pixel Security
