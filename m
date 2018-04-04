Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeDDJas (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:30:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeDDJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:30:47 -0400
Date: Wed, 4 Apr 2018 11:30:41 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Shivappa Vikas <vikas.shivappa@intel.com>
cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 1/6] x86/intel_rdt/mba_sc: Add documentation for MBA
 software controller
In-Reply-To: <alpine.DEB.2.10.1804031146530.27913@vshiva-Udesk>
Message-ID: <alpine.DEB.2.21.1804041111170.2056@nanos.tec.linutronix.de>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com> <1522362376-3505-2-git-send-email-vikas.shivappa@linux.intel.com> <alpine.DEB.2.21.1803302153280.1479@nanos.tec.linutronix.de> <alpine.DEB.2.21.1804031625150.2511@nanos.tec.linutronix.de>
 <alpine.DEB.2.10.1804031146530.27913@vshiva-Udesk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018, Shivappa Vikas wrote:
> On Tue, 3 Apr 2018, Thomas Gleixner wrote:
> >  The proposed new interface has no upper limit. The existing percentage
> >  based implementation has at least some notion of limit and scale; not
> >  really helpful either because of the hardware implementation. but I
> > 
> >  How is the poor admin supposed to configure that new thing without
> >  knowing what the actual hardware limits are in the first place?
> 
> That is true. The default values only put it to a very high bandwidth which
> means user gets to use everything. There seems no other way other than
> caliberating to know the actual max bandwidth in bytes. That could be a better
> value to have as default so admin knows the limit. I will explore if there is
> a way to calculate the same without caliberating.

Right, ideally we get that information from the hardware.

Thanks,

	tglx
