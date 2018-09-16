Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80362ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296DD2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296DD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeIQAu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:50:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:41716 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbeIQAu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:50:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 12:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,382,1531810800"; 
   d="scan'208";a="74770702"
Received: from vbsuresh-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.48.189])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2018 12:26:57 -0700
Date:   Sun, 16 Sep 2018 22:26:56 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>, flihp@twobit.us,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] tpm: add support for nonblocking operation
Message-ID: <20180916192656.GA9053@linux.intel.com>
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
 <20180916120349.GB5040@linux.intel.com>
 <f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 08:11:44AM -0700, Tadeusz Struk wrote:
> On 9/16/18 5:03 AM, Jarkko Sakkinen wrote:
> > I tried to test this but I get 404 from https://github.com/tstruk/tpm2-tss/tree/async
> 
> This has been already merged to tss upstream https://github.com/tpm2-software/tpm2-tss
> To enable it you need to configure tss with --enable-tcti-device-async=yes
> Thanks,
> Tadeusz

Thank you. Looking forward to try it out tomorrow.

/Jarkko
