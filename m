Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeDCRgp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:36:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40230 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeDCRgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:36:44 -0400
X-Google-Smtp-Source: AIpwx48rkbG9lzQkr734t3+idXBUP90P9oWoD+hLyLslOn8vKAvfJ6qZBKfV2zfCbfrp1pYLbIIir+A6iYtpzRq28Cc=
MIME-Version: 1.0
In-Reply-To: <20180403085904.GY4082@hirez.programming.kicks-ass.net>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 10:36:43 -0700
X-Google-Sender-Auth: VhfPB2LWhARd3RflwI8-cpXjcxI
Message-ID: <CA+55aFwgBsWqJx4RXiqdpnBEBFX5J+xVcuETOT_BPQp1Yc24PQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 1:59 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> It's not just spectre, I believe you yourself wanted to use asm-goto
> somewhere in the x86 code:

Absolutely. But I don't want to make it impossible for clang people to
get their work done.

                Linus
