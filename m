Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB5CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDF1222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfBLXHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:07:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:56834 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbfBLXHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:07:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 15:07:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="124012378"
Received: from briva-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.236])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2019 15:06:56 -0800
Date:   Wed, 13 Feb 2019 01:06:55 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, PeterHuewe@gmx.de,
        jgg@ziepe.ca
Subject: Re: [PATCH 2/2] selftests: tpm2: Extend tests to cover partial reads
Message-ID: <20190212230655.GB3977@linux.intel.com>
References: <154939851385.18477.481518864800562919.stgit@tstruk-mobl1.jf.intel.com>
 <154939851969.18477.13778157467131576825.stgit@tstruk-mobl1.jf.intel.com>
 <20190211164803.GG8431@linux.intel.com>
 <9b879fd2-5c0a-aecc-b6cb-02e5255c22f6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b879fd2-5c0a-aecc-b6cb-02e5255c22f6@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:55:36AM -0800, Tadeusz Struk wrote:
> On 2/11/19 8:48 AM, Jarkko Sakkinen wrote:
> > You are missing a cover letter from this patch set. Please have it in
> > v2. Also use tag "selftests/tpm2" instead of having two tags in the
> > short summaries. Now they look a bit weird.
> 
> Since when is the cover letter mandatory?
> I understand that is helps for a complicated patch set
> to explain the problem and solution in the cover letter,
> but for this simple test case addition what's the point?
> And there is nothing forcing a cover letter in
> https://www.kernel.org/doc/html/v4.20/process/submitting-patches.html

OK, cool.

> Also double tags seams to be quite common for selftest.
> See git log tools/testing/selftests/

Prefer slash for TPM specific commits.

I can merge this after those extra logs are removed.

/Jarkko
