Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeDCMJ3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:09:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38470 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:09:28 -0400
Date: Tue, 3 Apr 2018 14:09:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180403120921.GC4082@hirez.programming.kicks-ass.net>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403095118.rpf7tj577dppvx7d@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 11:51:18AM +0200, Ingo Molnar wrote:
> If it's being relied on, or if there's actually something firmly planned,
> which we could track, then I'd have no problem with reverting this change
> and waiting one more kernel cycle or so.

I don't see why the clang people can't go back to using out of tree
patches to make their compile 'work' until they've caught up with 7-year
old tech.

Also, I'd really like to know if there are any plans to support
asm-cc-output, otherwise we'll have this same old drama all over again
in a few years :/
