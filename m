Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeFERdI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:33:08 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:41726 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeFERdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:33:07 -0400
X-Google-Smtp-Source: ADUXVKJN3NtUfA7IMpfO1EKxlGaQPOgxdPx9C078f9uY73UA33VWtHsHE1DHwD/2oERfWkM1gwFzycxumvzwDZHxUU4=
MIME-Version: 1.0
References: <20180604122132.GA3337@gmail.com> <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
 <20180605150514.GA31065@gmail.com> <20180605172243.GA2059@avx2>
In-Reply-To: <20180605172243.GA2059@avx2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 10:32:55 -0700
Message-ID: <CA+55aFxTve6FxLuvWyyD88ACOg+3eHKbpWUeuvNZMSB=AFfuqg@mail.gmail.com>
Subject: Re: x86/asm: __clear_user() micro-optimization (was: "Re: [GIT PULL]
 x86/asm changes for v4.18")
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 10:22 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Tested? :^) I had P4 maybe ~15(?) years ago.

Did you EVEN test it on what you have today?

Do you have any numbers at all, in other words?

Micro-optimizations need numbers. Otherwise they aren't
micro-optimizations, they are just "change code randomly".

                    Linus
