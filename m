Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeBTRS7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:18:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33533 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbeBTRS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:18:58 -0500
Date: Tue, 20 Feb 2018 18:18:12 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 11/22] x86/intel_rdt: Associate pseudo-locked
 regions with its domain
In-Reply-To: <9551bc69-1183-cc36-7ed9-5b949ce924cc@intel.com>
Message-ID: <alpine.DEB.2.21.1802201815550.24268@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <216ad1ef8314dc578a900ff8b06248464f5aa2ee.1518443616.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1802192218370.1853@nanos.tec.linutronix.de> <7bd1f8e8-116f-bdb2-23d2-a94f9a21e028@intel.com>
 <alpine.DEB.2.21.1802200017130.1853@nanos.tec.linutronix.de> <0efce774-57a8-40fa-7b8a-6e57e496bb37@intel.com> <alpine.DEB.2.21.1802201058350.24268@nanos.tec.linutronix.de> <9551bc69-1183-cc36-7ed9-5b949ce924cc@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Reinette Chatre wrote:
> On 2/20/2018 2:00 AM, Thomas Gleixner wrote:
> > On Mon, 19 Feb 2018, Reinette Chatre wrote:
> >> In addition to the above research from my side I also followed up with
> >> the CPU architects directly to question the usage of these instructions
> >> instead of wbinvd.
> > 
> > What was their answer? This really wants a proper explanation and not just
> > experimentation results as it makes absolutely no sense at all.
> 
> I always prefer to provide detailed answers but here I find myself at
> the threshold where I may end up sharing information not publicly known.
> This cannot be the first time you find yourself in this situation. How
> do you prefer to proceed?

Well, if it's secret sauce we'll have to accept it. Though it really does
not improve the confidence in all those mechanisms ....

Thanks,

	tglx
