Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934780AbeEWTuh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:50:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45750 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934312AbeEWTug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:50:36 -0400
Date: Wed, 23 May 2018 21:50:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
cc: Dominik Brodowski <linux@dominikbrodowski.net>, mingo@kernel.org,
        bp@suse.de, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Simplify the CPU bug detection logic
In-Reply-To: <20180523163347.GB15675@char.us.oracle.com>
Message-ID: <alpine.DEB.2.21.1805232149590.1706@nanos.tec.linutronix.de>
References: <20180522090539.GA24668@light.dominikbrodowski.net> <20180523163347.GB15675@char.us.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018, Konrad Rzeszutek Wilk wrote:
> > @@ -973,16 +965,16 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
> >  	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
> >  		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
> 
> Would it make sense to move that above 'rdmsrl' and the conditional as well
> to the logic below?

I did that when I was applying the patch ....

Thanks,

	tglx
