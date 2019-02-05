Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5369AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AA32083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfBEKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:16:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:2490 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbfBEKQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:16:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 02:16:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="131202845"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2019 02:16:45 -0800
Date:   Tue, 5 Feb 2019 12:16:42 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        jmorris@namei.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH v3] selftests: add TPM 2.0 tests
Message-ID: <20190205101642.GA27954@linux.intel.com>
References: <20190204131640.11429-1-jarkko.sakkinen@linux.intel.com>
 <20190204232910.GC14992@linux.intel.com>
 <20190205101322.GA31095@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205101322.GA31095@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:13:22PM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 05, 2019 at 01:29:10AM +0200, Jarkko Sakkinen wrote:
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
> I'll put it and see what happens. It does not interfere other selftests
> anyway and cannot cause compilation errors given that it is pure Python.

Applied to git://git.infradead.org/users/jjs/linux-tpmdd.git.

Will be part of my next PR to James' security tree.

/Jarkko
