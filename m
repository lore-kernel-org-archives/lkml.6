Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DCCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486ED20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486ED20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937869AbeFSNSl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:18:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:63782 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937776AbeFSNSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:18:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 06:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="51103855"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2018 06:18:29 -0700
Date:   Tue, 19 Jun 2018 16:18:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, Haim Cohen <haim.cohen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 04/13] x86, sgx: add SGX definitions to msr-index.h
Message-ID: <20180619131828.GD5609@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-5-jarkko.sakkinen@linux.intel.com>
 <a51c11da-650a-1828-4173-e424a5340565@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51c11da-650a-1828-4173-e424a5340565@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 10:25:29AM -0700, Dave Hansen wrote:
> On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Signed-off-by: Haim Cohen <haim.cohen@intel.com>
> > Tested-by: Serge Ayoun <serge.ayoun@intel.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> These are a mess.  If you're signing off on it, a review of some kind is
> pretty implied.
> 
> Also, how did Sean write this, send it to Haim to sign off on it, and
> then send it to you?  That seems unlikely.

They've both done something to this. How should I change it then?

/Jarkko
