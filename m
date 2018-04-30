Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755107AbeD3RG1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:06:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35258 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754781AbeD3RG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:06:26 -0400
Subject: Re: Hashed pointer issues
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tcharding <me@tobin.cc>
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home>
 <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
 <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1e0bc2e2-a0d8-16b7-b6a4-cf97ecd99cef@infradead.org>
Date: Mon, 30 Apr 2018 10:06:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 10:01 AM, Linus Torvalds wrote:
> On Mon, Apr 30, 2018 at 9:57 AM Linus Torvalds <
> torvalds@linux-foundation.org> wrote:
> 
>> Although in *practice* we'd have tons of entropy on any modern development
>> CPU too, since any new hardware will have the hardware random number
>> generation. Some overly cautious person might not trust it, of course.
> 
> In fact, maybe that's the right policy. Avoid a boot-time parameter by just
> saying
> 
>   "if you have hardware random number generation, we can fill entropy
> immediately"
> 
> No kernel command line needed in practice any more. That's assuming any
> kernel developer will have an IvyBridge or newer.

any paid kernel developer :)

> 
> The "I don't trust my hardware" people can still disable that with
> "nordrand".
> 
> Hmm?


-- 
~Randy
