Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBC1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3EA21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBTHHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:07:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:48256 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBTHHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:07:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 23:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="127814402"
Received: from zhangyu-optiplex-9020.bj.intel.com (HELO localhost) ([10.238.135.159])
  by orsmga003.jf.intel.com with ESMTP; 19 Feb 2019 23:07:03 -0800
Date:   Wed, 20 Feb 2019 15:02:33 +0800
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: linux-next: Fixes tag needs some work in the kvm tree
Message-ID: <20190220070233.lca2kquyzypofyh7@linux.intel.com>
References: <20190216183433.71b7cfa7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216183433.71b7cfa7@canb.auug.org.au>
User-Agent: NeoMutt/20180622-66-b94505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the notification, Stephen.
@Paolo, should I resubmit the patch to correct?

On Sat, Feb 16, 2019 at 06:34:33PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   aa8359972cfc ("KVM: x86/mmu: Differentiate between nr zapped and list unstable")
> 
> Fixes tag
> 
>   Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing quotes
>     Please do not split Fixes tags over more than one line
> 
> In commit
> 
>   4d3f8e4ff75e ("kvm: vmx: Fix typos in vmentry/vmexit control setting")
> 
> Fixes tag
> 
>   Fixes: 'commit f99e3daf94ff ("KVM: x86: Add Intel PT virtualization work mode")'
> 
> has these problem(s):
> 
>   - No SHA1 recognised
>     The leading word 'commit' is unexpected and the surrounding single
>     quotes likewise.
>     Please just use
> 	git log -1 --format='Fixes: %h ("%s")' <SHA>
> 
> -- 
> Cheers,
> Stephen Rothwell

B.R.
Yu

