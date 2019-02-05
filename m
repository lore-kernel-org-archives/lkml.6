Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF679C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67BB2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBEU57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:57:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:27050 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEU56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:57:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 12:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,336,1544515200"; 
   d="scan'208";a="124221731"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2019 12:57:52 -0800
Date:   Tue, 5 Feb 2019 22:57:51 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH v3] selftests: add TPM 2.0 tests
Message-ID: <20190205205751.GB13023@linux.intel.com>
References: <20190204131640.11429-1-jarkko.sakkinen@linux.intel.com>
 <20190204232910.GC14992@linux.intel.com>
 <alpine.LRH.2.21.1902060712500.3449@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1902060712500.3449@namei.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 07:12:57AM +1100, James Morris wrote:
> On Tue, 5 Feb 2019, Jarkko Sakkinen wrote:
> 
> > On Mon, Feb 04, 2019 at 03:16:40PM +0200, Jarkko Sakkinen wrote:
> > > Added the tests that I've been using for testing TPM 2.0 functionality
> > > for a long time but have been out-of-tree so far, residing in
> > > 
> > > https://github.com/jsakkine-intel/tpm2-scripts
> > > 
> > > Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Acked-By: Joey Pabalinas <joeypabalinas@gmail.com>
> > > Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> > 
> > Wondering if I can put this to my 5.1 PR?
> 
> Yep, should be fine.

Perfect, thanks.

/Jarkko
