Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KJB2GBEdG1tFOAAAmS7hNA
	; Sat, 09 Jun 2018 00:19:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4FEF8607A4; Sat,  9 Jun 2018 00:19:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CFC25601D2;
	Sat,  9 Jun 2018 00:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFC25601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeFIAT1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:19:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:36785 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753094AbeFIATZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:19:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 17:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,492,1520924400";
   d="scan'208";a="231121570"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2018 17:19:23 -0700
Date: Sat, 9 Jun 2018 08:29:17 +0800
From: Philip Li <philip.li@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 68abbe729567cef128b2c2141f2ed2567f3b8372
Message-ID: <20180609002917.GA22101@intel.com>
References: <5b1a9cac.E0zqScbTCJ5WgP6x%lkp@intel.com>
 <CA+55aFwHCJ-ra6GOz3bFXx21D1bOjN4L11Dybr5t2OHCAYCL5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwHCJ-ra6GOz3bFXx21D1bOjN4L11Dybr5t2OHCAYCL5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 08:48:29AM -0700, Linus Torvalds wrote:
> On Fri, Jun 8, 2018 at 8:12 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > arch/sh/include/asm/io.h:246:32: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > arch/x86/net/bpf_jit_comp32.c:2449 do_jit() warn: potential off by one 'addrs[]' limit 'bpf_prog->len'
> > drivers/acpi/battery.c:720:3-9: preceding lock on line 701
> > drivers/gpu/drm/amd/amdkfd/Kconfig:8: unknown option "imply"
> > drivers/gpu/drm/amd/amdkfd/Kconfig:9: syntax error
> > .. lots of these ..
> 
> Hmm? Is the kbuild robot not feeling well? This looks odd.
Thanks Linus, we will follow up to check what possibly went wrong here,
this does look unreasonable.

> 
>                     Linus
> 
