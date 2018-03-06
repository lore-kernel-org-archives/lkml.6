Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbeCFVEU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:04:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752931AbeCFVET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:04:19 -0500
Date: Tue, 6 Mar 2018 22:03:38 +0100
From: Radim Krcmar <rkrcmar@redhat.com>
To: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Kyle Huey <me@kylehuey.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v5 1/3] x86/msr: Add AMD Core Perf Extension MSRs
Message-ID: <20180306210338.GD12128@flask>
References: <cover.1517850302.git.Janakarajan.Natarajan@amd.com>
 <7cf7bd5fa6d24cd46a9ea50024b0010bf3d01088.1517850303.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf7bd5fa6d24cd46a9ea50024b0010bf3d01088.1517850303.git.Janakarajan.Natarajan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-05 13:24-0600, Janakarajan Natarajan:
> Add the EventSelect and Counter MSRs for AMD Core Perf Extension.
> 
> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index e7b983a..2885363 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -341,7 +341,21 @@
>  
>  /* Fam 15h MSRs */
>  #define MSR_F15H_PERF_CTL		0xc0010200
> +#define MSR_F15H_PERF_CTL0		MSR_F15H_PERF_CTL
> +#define MSR_F15H_PERF_CTL1		(MSR_F15H_PERF_CTL + 2)
> +#define MSR_F15H_PERF_CTL2		(MSR_F15H_PERF_CTL + 4)
> +#define MSR_F15H_PERF_CTL3		(MSR_F15H_PERF_CTL + 6)
> +#define MSR_F15H_PERF_CTL4		(MSR_F15H_PERF_CTL + 8)
> +#define MSR_F15H_PERF_CTL5		(MSR_F15H_PERF_CTL + 10)
> +
>  #define MSR_F15H_PERF_CTR		0xc0010201
> +#define MSR_F15H_PERF_CTR0		MSR_F15H_PERF_CTR
> +#define MSR_F15H_PERF_CTR1		(MSR_F15H_PERF_CTR + 2)
> +#define MSR_F15H_PERF_CTR2		(MSR_F15H_PERF_CTR + 4)
> +#define MSR_F15H_PERF_CTR3		(MSR_F15H_PERF_CTR + 6)
> +#define MSR_F15H_PERF_CTR4		(MSR_F15H_PERF_CTR + 8)
> +#define MSR_F15H_PERF_CTR5		(MSR_F15H_PERF_CTR + 10)
> +

x86 maintainers,

are you ok with this going through the kvm tree?

Thanks.

>  #define MSR_F15H_NB_PERF_CTL		0xc0010240
>  #define MSR_F15H_NB_PERF_CTR		0xc0010241
>  #define MSR_F15H_PTSC			0xc0010280
> -- 
> 2.7.4
> 
