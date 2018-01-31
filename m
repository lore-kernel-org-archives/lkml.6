Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeAaRoa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:44:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46775 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932167AbeAaRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:44:28 -0500
Date: Wed, 31 Jan 2018 18:44:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [Patch v1 6/8] x86/cpu: Add Cannonlake to Intel family
In-Reply-To: <20180131172747.GA9877@raj-desk2.iind.intel.com>
Message-ID: <alpine.DEB.2.21.1801311844121.9911@nanos.tec.linutronix.de>
References: <1516352307-20123-1-git-send-email-rajneesh.bhardwaj@intel.com> <1516352307-20123-7-git-send-email-rajneesh.bhardwaj@intel.com> <CAHp75VcsMzTtn-TD32Jyh6pennLWLjEuiAi_-LJMowENv=P2-Q@mail.gmail.com>
 <20180131172747.GA9877@raj-desk2.iind.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2018, Rajneesh Bhardwaj wrote:

> On Fri, Jan 26, 2018 at 02:39:47PM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 19, 2018 at 10:58 AM, Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@intel.com> wrote:
> > > Add CPUID of Cannonlake (CNL) processors to Intel family list.
> > >
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: x86@kernel.org
> > 
> > Thomas, can you Ack this patch?
> 
> Sorry to bug you again, MAINTAINERS. The series depends on this patch for
> enabling Cannonlake support. Requesting your ACK / Feedback for this one.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
