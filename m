Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBZTzE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:55:04 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44499 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbeBZTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:55:03 -0500
Date: Mon, 26 Feb 2018 20:55:05 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jmattson@google.com, rkrcmar@redhat.com, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com, mingo@kernel.org
Subject: Re: [PATCH v3 2/4] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
In-Reply-To: <1519125725.7876.117.camel@infradead.org>
Message-ID: <alpine.DEB.2.21.1802262054160.1402@nanos.tec.linutronix.de>
References: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk>  <1519037457-7643-3-git-send-email-dwmw@amazon.co.uk>  <alpine.DEB.2.21.1802200854010.24268@nanos.tec.linutronix.de>  <1519116825.7876.112.camel@infradead.org>
 <alpine.DEB.2.21.1802201115190.24268@nanos.tec.linutronix.de>  <alpine.DEB.2.21.1802201141160.24268@nanos.tec.linutronix.de> <1519125725.7876.117.camel@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1732896448-1519674909=:1402"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1732896448-1519674909=:1402
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Feb 2018, David Woodhouse wrote:
> On Tue, 2018-02-20 at 11:42 +0100, Thomas Gleixner wrote:
> > 
> > > > However, Paolo is very insistent that taking the trap every time is
> > > > actually a lot *slower* than really frobbing IBRS on certain
> > > > microarchitectures, so my hand-waving "pfft, what did they expect?" is
> > > > not acceptable.
> > > > 
> > > > Which I think puts us back to the "throwing the toys out of the pram"
> > 
> > There are no more toys in the pram. I threw them all out weeks ago ...
> 
> One option is to take the patch as-is¹ with the trap on every access.
> As soon as Intel define that 'IBRS_ALL_AND_THE_BIT_IS_A_NOOP' bit in
> MSR_IA32_ARCH_CAPABILITIES, *then* we can expose it to guests directly
> again just as we do at the moment.

Arjan, is there any update on this?

Thanks,

	tglx
--8323329-1732896448-1519674909=:1402--
