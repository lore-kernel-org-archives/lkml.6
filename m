Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AFCC43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1FC2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfADVJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:09:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:6772 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfADVJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:09:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 13:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="133026728"
Received: from mbakkere-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.235])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2019 13:09:37 -0800
Date:   Fri, 4 Jan 2019 23:09:36 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests: add TPM 2.0 tests
Message-ID: <20190104210936.GA6582@linux.intel.com>
References: <20181127221059.25966-1-jarkko.sakkinen@linux.intel.com>
 <20181127224900.fpbqujcsqwgxpwyq@gmail.com>
 <20181127225307.3wc3gd7zmfauie6i@gmail.com>
 <20181127231348.GB26051@linux.intel.com>
 <20181205003342.GA20846@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205003342.GA20846@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:33:42PM -0800, Jarkko Sakkinen wrote:
> On Tue, Nov 27, 2018 at 03:13:48PM -0800, Jarkko Sakkinen wrote:
> > Thank you! Would be good to have these merged to the kernel tree so that
> > one can include both functionality and test case when needed to the
> > patch set.
> 
> Should I include this to v4.21 tpmdd PR?

Still bit puzzled how to move this forward...

/Jarkko
