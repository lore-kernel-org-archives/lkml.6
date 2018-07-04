Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093FCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C240E20882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C240E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeGDRY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:24:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:28428 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752645AbeGDRYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:24:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 10:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="72262160"
Received: from saamir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.242])
  by orsmga002.jf.intel.com with ESMTP; 04 Jul 2018 10:24:45 -0700
Date:   Wed, 4 Jul 2018 20:24:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Kai Huang <kai.huang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 02/13] x86/sgx: add SGX definitions to cpufeature
Message-ID: <20180704172443.GD6724@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-3-jarkko.sakkinen@linux.intel.com>
 <alpine.DEB.2.21.1807032041310.1816@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807032041310.1816@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:48:54PM +0200, Thomas Gleixner wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> 
> Subject: x86/sgx: add SGX definitions to cpufeature
> 
> The prefix is bogus. Not everything you touch is SGX just because.
> 
> The proper prefix is 'x86/cpufeatures:' 
> The following sentence starts with an uppercase letter.
> 
> And with the proper prefix the subject wants to be something like:
> 
>   x86/cpufeatures: Add SGX and SGX_LC CPU features
> 
> > From: Kai Huang <kai.huang@linux.intel.com>
> > 
> > Added X86_FEATURE_SGX and X86_FEATURE_SGX_LC definitions that define the
> 
> Add the ...
> 
> ->						definitions that define
> 
> That's redundant.
> 
> > bits CPUID level 7 bits for determining whether the CPU supports SGX and
> 
> bits ... bits ?? 
> 
> > launch configuration other than the Intel proprietary key. If this the
> > case, IA32_SGXLEPUBKEYHASHn MSRs (0 < n < 4) are available for defining the
> > root key for enclaves.
> > 
> > Signed-off-by: Kai Huang <kai.huang@linux.intel.com>
> 
> Lacks your SOB
> 
> Thanks,
> 
> 	tglx

Thanks, will refine!

/Jarkko
