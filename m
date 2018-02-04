Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeBDKTe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 05:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeBDKTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 05:19:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0572217AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 4 Feb 2018 10:19:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Crt Mori <cmo@melexis.com>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Linux Iio <linux-iio@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v12 1/3] lib: Add strongly typed 64bit int_sqrt
Message-ID: <20180204101918.17b71aa7@archlinux>
In-Reply-To: <1516012575.3045.37.camel@perches.com>
References: <20180109151847.30258-1-cmo@melexis.com>
        <1515525824.9619.103.camel@perches.com>
        <CAKv63usChMeCNYJ6qshFcBCOLgEX9Q-mSv6miLG7YJkUKJ1gEA@mail.gmail.com>
        <CAKv63uuDya8LU-WHtKiqnEJCtg855aYduhowu0dv5qBd1r284Q@mail.gmail.com>
        <CAKv63uvq5Eq9f9VNSufUmJCOsd4vebbSu2V0Jzbmgth3vbJ9Dw@mail.gmail.com>
        <1516012575.3045.37.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2018 02:36:15 -0800
Joe Perches <joe@perches.com> wrote:

> On Wed, 2018-01-10 at 09:37 +0100, Crt Mori wrote:
> > Shouldn't I rather make it
> > 
> >          if (x <= ULONG_MAX)
> >                  return int_sqrt((unsigned long) x);  
> 
> With this change: (I believe done in v13) and
> as requested by Crt Mori in a private email:
> 
> Acked-by: Joe Perches <joe@perches.com>

Thanks Joe,

I've applied v13 which indeed does have this change.
Applied to the togreg branch of iio.git where it will sit until after
the merge window.

For now I'll only be pushing that out as a build test branch so
still time for improvements without having to revert or anything.

Thanks,

Jonathan

> 
