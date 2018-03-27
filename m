Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeC0Jgy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:36:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52278 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeC0Jgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:36:52 -0400
X-Google-Smtp-Source: AG47ELuxjT1tmonSUS6+8vRcl8SuxAKC/D+DJl5PbuDo2mpfI7x+PO7r6+iWkPicAIKIWNLwwvx4Xg==
Date: Tue, 27 Mar 2018 11:36:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Borislav Petkov <bp@alien8.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Hugh Dickins <hughd@google.com>,
        a.p.zijlstra@chello.nl
Subject: Re: [PATCH v3 1/2] x86, msr: allow rdmsr_safe_on_cpu() to schedule
Message-ID: <20180327093648.iba7rzvviolyjgmt@gmail.com>
References: <20180323215818.127774-1-edumazet@google.com>
 <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
 <336355a3-c11d-44fc-0642-671670980ac0@gmail.com>
 <20180325141242.GC21878@pd.tnic>
 <20180326064042.c6xod5n24kqttdiw@gmail.com>
 <CANn89iKy_jVpBvAebJFm1UKVKfG=p+R4B1tXmC4waeK7YzZh2g@mail.gmail.com>
 <alpine.DEB.2.21.1803261621430.1585@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803261621430.1585@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 26 Mar 2018, Eric Dumazet wrote:
> > On Sun, Mar 25, 2018 at 11:40 PM Ingo Molnar <mingo@kernel.org> wrote:
> > > If performance matters then the relevant MSR events should be added and
> > > gsysd
> > > should be updated to support MSR events.
> > >
> > 
> > Thanks for the hints Ingo. I have forwarded them.
> > 
> > I am pretty sure gsysd was designed and written years before perf even
> > existed,
> > so I am not sure all this will ever be implemented.
> > 
> > I guess I will apply the kernel patches locally for the time being.
> 
> I'm still considering to merge them because there is no real reason not to
> do so. The interfaces exist and are used. Reducing their impact is
> certainly worthwhile.

Ok, that's a good point, and the patches themselves are sane:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
