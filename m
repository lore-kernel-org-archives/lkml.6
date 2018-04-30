Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeD3RMU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:12:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51272 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeD3RMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:12:16 -0400
X-Google-Smtp-Source: AB8JxZru30fy79RKSiAiBtSFpzumGLBha8ozSeD+eXU5uaFLdHuRY9pxKNAs21Tzj1uY91+619Vad9PG8Q+/GjfDNGw=
MIME-Version: 1.0
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home> <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
 <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com> <1e0bc2e2-a0d8-16b7-b6a4-cf97ecd99cef@infradead.org>
In-Reply-To: <1e0bc2e2-a0d8-16b7-b6a4-cf97ecd99cef@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Apr 2018 17:12:05 +0000
Message-ID: <CA+55aFzezp7OCpK7HFFQ7LeUZZyFACrhx6px_ZFq5zgoNTwEVw@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tcharding <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 10:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/30/2018 10:01 AM, Linus Torvalds wrote:
> >
> > No kernel command line needed in practice any more. That's assuming any
> > kernel developer will have an IvyBridge or newer.

> any paid kernel developer :)

I suspect a lot of hobbyists too - it's not like ivy bridge is particularly
new.

But if not, we can burn that bridge when we get to it.

Also, if you're not paid to do it, I don't think you'll be working a lot of
error trace buffers during bootup. There are definitely more interesting
parts of the kernel to play with ;)

               Linus
