Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeCPTW6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:22:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeCPTW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:22:56 -0400
Date: Fri, 16 Mar 2018 20:22:41 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Radim Krcmar <rkrcmar@redhat.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        kvm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
        Kyle Huey <me@kylehuey.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v5 1/3] x86/msr: Add AMD Core Perf Extension MSRs
In-Reply-To: <150643f7-b464-0bd0-6ae8-6403b4d34700@redhat.com>
Message-ID: <alpine.DEB.2.21.1803162022190.1509@nanos.tec.linutronix.de>
References: <cover.1517850302.git.Janakarajan.Natarajan@amd.com> <7cf7bd5fa6d24cd46a9ea50024b0010bf3d01088.1517850303.git.Janakarajan.Natarajan@amd.com> <20180306210338.GD12128@flask> <150643f7-b464-0bd0-6ae8-6403b4d34700@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Paolo Bonzini wrote:

> On 06/03/2018 22:03, Radim Krcmar wrote:
> >>  /* Fam 15h MSRs */
> >>  #define MSR_F15H_PERF_CTL		0xc0010200
> >> +#define MSR_F15H_PERF_CTL0		MSR_F15H_PERF_CTL
> >> +#define MSR_F15H_PERF_CTL1		(MSR_F15H_PERF_CTL + 2)
> >> +#define MSR_F15H_PERF_CTL2		(MSR_F15H_PERF_CTL + 4)
> >> +#define MSR_F15H_PERF_CTL3		(MSR_F15H_PERF_CTL + 6)
> >> +#define MSR_F15H_PERF_CTL4		(MSR_F15H_PERF_CTL + 8)
> >> +#define MSR_F15H_PERF_CTL5		(MSR_F15H_PERF_CTL + 10)
> >> +
> >>  #define MSR_F15H_PERF_CTR		0xc0010201
> >> +#define MSR_F15H_PERF_CTR0		MSR_F15H_PERF_CTR
> >> +#define MSR_F15H_PERF_CTR1		(MSR_F15H_PERF_CTR + 2)
> >> +#define MSR_F15H_PERF_CTR2		(MSR_F15H_PERF_CTR + 4)
> >> +#define MSR_F15H_PERF_CTR3		(MSR_F15H_PERF_CTR + 6)
> >> +#define MSR_F15H_PERF_CTR4		(MSR_F15H_PERF_CTR + 8)
> >> +#define MSR_F15H_PERF_CTR5		(MSR_F15H_PERF_CTR + 10)
> >> +
> > x86 maintainers,
> > 
> > are you ok with this going through the kvm tree?

yes.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
