Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C81C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993FB2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfBDMCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:02:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:23782 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbfBDMB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:01:59 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 04:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="113534915"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga006.jf.intel.com with ESMTP; 04 Feb 2019 04:01:56 -0800
Date:   Mon, 4 Feb 2019 14:01:55 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] selftests: add TPM 2.0 tests
Message-ID: <20190204120155.GE26799@linux.intel.com>
References: <20190201175054.26105-1-jarkko.sakkinen@linux.intel.com>
 <20190203222654.GA28988@x230>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203222654.GA28988@x230>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 11:26:55PM +0100, Petr Vorel wrote:
> Hi Jarkko,
> 
> > Added the tests that I've been using for testing TPM 2.0 functionality
> > for long time but have out-of-tree so far residing in
> 
> > https://github.com/jsakkine-intel/tpm2-scripts
> 
> > Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Acked-By: Joey Pabalinas <joeypabalinas@gmail.com>
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> 
> > +++ b/tools/testing/selftests/tpm2/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +
> > +TEST_PROGS := test_smoke.sh test_space.sh
> Maybe include lib.mk, to avoid make No targets error? (well, it's reported for
> more tests)
> 
> include ../lib.mk
> 
> make[1]: Entering directory '/home/pevik/install/src/linux.git/tools/testing/selftests/tpm2'
> make[1]: *** No targets.  Stop.
> 
> 
> Kind regards,
> Petr

Will do. Thanks for the review and the remark!

/Jarkko
