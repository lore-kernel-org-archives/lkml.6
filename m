Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F775C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48F7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48F7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeK1KPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:15:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:26999 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1KPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:15:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 15:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="93162704"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.96])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2018 15:15:39 -0800
Date:   Tue, 27 Nov 2018 15:15:39 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests: add TPM 2.0 tests
Message-ID: <20181127231539.GC26051@linux.intel.com>
References: <20181127221059.25966-1-jarkko.sakkinen@linux.intel.com>
 <0929dfe2-83aa-ff39-e37e-35bc499aaa0a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0929dfe2-83aa-ff39-e37e-35bc499aaa0a@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:34:39PM -0800, Tadeusz Struk wrote:
> On 11/27/18 2:10 PM, Jarkko Sakkinen wrote:
> > Added the tests that I've been using for testing TPM 2.0 functionality
> > for long time but have out-of-tree so far residing in
> > 
> > https://github.com/jsakkine-intel/tpm2-scripts
> > 
> > Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> > Tadeusz: does not include your test. Better that you send them after
> > this has been accepted to get proper SOB info.
> 
> Sure I can follow up after this is merged.
> Thanks,

Hey, noticed that there was extra parentheses in open() for tpmrm0. Not
a biggie, I fixed it in my tpm2-scripts tree, but when you actually go
on to make the commit and send it here for review run both test_smoke.sh
and test_space.sh.

/Jarkko
