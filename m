Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755216AbeENQuq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:50:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:28063 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752347AbeENQuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:50:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,400,1520924400";
   d="scan'208";a="49137957"
Date: Mon, 14 May 2018 09:50:43 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
Message-ID: <20180514165042.GA2746@agluck-desk>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514162752.GG23049@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 06:27:52PM +0200, Borislav Petkov wrote:
> On Mon, May 14, 2018 at 09:19:11PM +0530, Jeffrin Thalakkottoor wrote:
> > hello,
> > 
> > output related of  "sudo dmesg -l emerg" from my laptop...
> > 
> > --------------------------------------------------------------------------------------------------->
> > $sudo dmesg -l emerg
> > [sudo] password for jeffrin:
> > [    0.041023] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 5:
> > ee0000000040110b
> > [    0.041028] mce: [Hardware Error]: TSC 0 ADDR 160000080 MISC 5040008086
> > [    0.041034] mce: [Hardware Error]: PROCESSOR 0:306d4 TIME
> > 1526300792 SOCKET 0 APIC 0 microcode 2a
> 
> Run it through mcelog to see what it decodes to:
> 
> dmesg | mcelog --ascii

Is the system crashing? Or do you just see this message but
no other bad effects?

Does is happen every boot? Or was this a one time message?

Can you grab some context lines from dmesg (say 40 lines
leading up to this message) to see what else was going on?

-Tony
