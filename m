Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeENQ2X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:28:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752586AbeENQ2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:28:22 -0400
Date: Mon, 14 May 2018 18:27:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
Message-ID: <20180514162752.GG23049@pd.tnic>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 09:19:11PM +0530, Jeffrin Thalakkottoor wrote:
> hello,
> 
> output related of  "sudo dmesg -l emerg" from my laptop...
> 
> --------------------------------------------------------------------------------------------------->
> $sudo dmesg -l emerg
> [sudo] password for jeffrin:
> [    0.041023] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 5:
> ee0000000040110b
> [    0.041028] mce: [Hardware Error]: TSC 0 ADDR 160000080 MISC 5040008086
> [    0.041034] mce: [Hardware Error]: PROCESSOR 0:306d4 TIME
> 1526300792 SOCKET 0 APIC 0 microcode 2a

Run it through mcelog to see what it decodes to:

dmesg | mcelog --ascii

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
