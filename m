Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WTRtDF6wGVuLVQAAmS7hNA
	; Thu, 07 Jun 2018 22:26:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A9CEC6089E; Thu,  7 Jun 2018 22:26:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 48628601D2;
	Thu,  7 Jun 2018 22:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48628601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeFGW0i (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:26:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:46771 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752237AbeFGW0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:26:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 15:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,488,1520924400";
   d="scan'208";a="47312397"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2018 15:26:36 -0700
Date: Thu, 7 Jun 2018 15:26:36 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/mce: Check for alternate indication of machine
 check recovery on Skylake
Message-ID: <20180607222636.GA27234@agluck-desk>
References: <cover.1527283897.git.tony.luck@intel.com>
 <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
 <20180607174337.GA22594@agluck-desk>
 <CAPcyv4hNjnm+CawtRzU=ROUo02+XsBxjUmMGMcpjHKnL5M42Jw@mail.gmail.com>
 <20180607202445.GC20936@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607202445.GC20936@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:24:46PM +0200, Borislav Petkov wrote:
> On Thu, Jun 07, 2018 at 01:18:31PM -0700, Dan Williams wrote:
> > I'm making an effort to get all persistent memory error handling holes
> > covered this cycle, so I think it makes sense for this to go through
> > the nvdimm tree. This looks sufficiently non-controversial that I
> > could justify sending it to Linus along with the other pmem updates.
> 
> tglx just took 1 and 3, 2/3 had a minor issue but the merge window
> happened so I'll send it later. It is nice to have anyway.

Thanks Boris.

-Tony
