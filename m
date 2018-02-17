Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeBQRGq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 12:06:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:31268 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbeBQRGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 12:06:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,525,1511856000";
   d="scan'208";a="205013021"
Date: Sat, 17 Feb 2018 09:06:43 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] x86/CPU: Add a microcode loader callback
Message-ID: <20180217170642.GA27868@araj-mobl1.jf.intel.com>
References: <20180216112640.11554-1-bp@alien8.de>
 <20180216112640.11554-3-bp@alien8.de>
 <20180217130753.GA25024@araj-mobl1.jf.intel.com>
 <20180217132800.GA10565@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217132800.GA10565@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 02:28:00PM +0100, Borislav Petkov wrote:
> On Sat, Feb 17, 2018 at 05:07:53AM -0800, Raj, Ashok wrote:
> > Could you only list it there instead? common.c has no other
> > microcode related functions other than this.?
> 
> I already explained that to you: this function is called by the loader
> but it uses facilities which are closer to cpu/common.c - get_cpu_cap(),
> etc.
> 
> Also, this file will be split eventually after the CPUID cleanup.
> 
> So it could just as well be called recheck_cpu_caps(), without the
> "microcode" prefix.

Never mind.. now that rings a bell :-)

> 
> So no need to do anything now.
> 
