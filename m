Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeAaRdJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:33:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:44822 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752543AbeAaRdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:33:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,440,1511856000";
   d="scan'208";a="170641694"
Date: Wed, 31 Jan 2018 22:57:47 +0530
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [Patch v1 6/8] x86/cpu: Add Cannonlake to Intel family
Message-ID: <20180131172747.GA9877@raj-desk2.iind.intel.com>
References: <1516352307-20123-1-git-send-email-rajneesh.bhardwaj@intel.com>
 <1516352307-20123-7-git-send-email-rajneesh.bhardwaj@intel.com>
 <CAHp75VcsMzTtn-TD32Jyh6pennLWLjEuiAi_-LJMowENv=P2-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcsMzTtn-TD32Jyh6pennLWLjEuiAi_-LJMowENv=P2-Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 02:39:47PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 19, 2018 at 10:58 AM, Rajneesh Bhardwaj
> <rajneesh.bhardwaj@intel.com> wrote:
> > Add CPUID of Cannonlake (CNL) processors to Intel family list.
> >
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: x86@kernel.org
> 
> Thomas, can you Ack this patch?

Sorry to bug you again, MAINTAINERS. The series depends on this patch for
enabling Cannonlake support. Requesting your ACK / Feedback for this one.

Thank you.

> 
> > Suggested-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
> > Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> > ---
> >  arch/x86/include/asm/intel-family.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> > index 35a6bc4da8ad..cf090e584202 100644
> > --- a/arch/x86/include/asm/intel-family.h
> > +++ b/arch/x86/include/asm/intel-family.h
> > @@ -10,6 +10,10 @@
> >   *
> >   * Things ending in "2" are usually because we have no better
> >   * name for them.  There's no processor called "SILVERMONT2".
> > + *
> > + * While adding a new CPUID for a new microarchitecture, add a new
> > + * group to keep logically sorted out in chronological order. Within
> > + * that group keep the CPUID for the variants sorted by model number.
> >   */
> >
> >  #define INTEL_FAM6_CORE_YONAH          0x0E
> > @@ -49,6 +53,8 @@
> >  #define INTEL_FAM6_KABYLAKE_MOBILE     0x8E
> >  #define INTEL_FAM6_KABYLAKE_DESKTOP    0x9E
> >
> > +#define INTEL_FAM6_CANNONLAKE_MOBILE   0x66
> > +
> >  /* "Small Core" Processors (Atom) */
> >
> >  #define INTEL_FAM6_ATOM_PINEVIEW       0x1C
> > --
> > 2.7.4
> >
> 
> -- 
> With Best Regards,
> Andy Shevchenko

-- 
Best Regards,
Rajneesh
