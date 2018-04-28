Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758632AbeD1Qoa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 12:44:30 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35022 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeD1Qo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 12:44:28 -0400
X-Google-Smtp-Source: AB8JxZr9CuqXVIW2r2hOyPhZjAj465irJZLE6GJxQODygUrm6vbN9VH4SGauPMncJUvJ7OnJB6Q58vt6czasyMbW8nc=
MIME-Version: 1.0
References: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
 <20180428091823.h3iajtxkqdwdcpst@gmail.com> <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
In-Reply-To: <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Apr 2018 16:44:17 +0000
Message-ID: <CA+55aFyVEJtiRjcazfTst7swGNXXZFHByHO5++-Foq6TDZWjTg@mail.gmail.com>
Subject: Re: [RFD] x86: The future of MPX
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 9:36 AM Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> They need to be run as root.

Side note: don't get me wrong. If the MPX stuff isn't supported by gcc,
then there is little point in us supporting it in the kernel either.

So I'm just saying that the test-case is root-only and the crash doesn't
necessarily mean anything else than "badly written test".

                   Linus
