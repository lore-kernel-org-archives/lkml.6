Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeETUlN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 16:41:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60896 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbeETUlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 16:41:11 -0400
Date: Sun, 20 May 2018 22:40:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
Message-ID: <20180520204032.GA19845@pd.tnic>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic>
 <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 05:27:32PM +0530, Jeffrin Thalakkottoor wrote:
> output for "dmesg | mcelog --ascii"  command related

Ok, but please do not top-post.

...

> Hardware event. This is not a software error.
> CPU 0 BANK 0 TSC dead
> STATUS 0 MCGSTATUS 0
> line timer enabled
> smpboot: CPU0: Intel(R) Pentium(R) CPU 3825U @ 1.90GHz (family: 0x6,
> model: 0x3d, stepping: 0x4)
> Machine check events logged
> Hardware event. This is not a software error.
> CPU 0 BANK 0
> TIME 1526815774 Sun May 20 16:59:34 2018
> MCG status:
> MCi status:
> Machine check not valid
> Corrected error
> MCA: No Error
> STATUS 0 MCGSTATUS 0
> CPUID Vendor Intel Family 6 Model 61
> (Fields were incomplete)

Looks like mcelog has trouble decoding this. Have you updated mcelog to
the latest version in your distro?

> SOCKET 0 APIC 0 microcode 2a

@Tony, I'm hoping you'll be more successful in decoding the error by
hand.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
