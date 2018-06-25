Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCA2C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DD825E8C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DD825E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeFYQ5h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:57:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:17582 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932936AbeFYQ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:57:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 09:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="67121875"
Received: from aluisell-mobl2.ger.corp.intel.com ([10.249.254.14])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2018 09:57:30 -0700
Message-ID: <7f90a0d8846650ce1e1d2598d980ab84da11cc70.camel@linux.intel.com>
Subject: Re: [PATCH v6] tpm: separate cmd_ready/go_idle from runtime_pm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date:   Mon, 25 Jun 2018 19:57:29 +0300
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9516CE@hasmsx108.ger.corp.intel.com>
References: <20180607212040.30989-1-tomas.winkler@intel.com>
         <20180618180406.GA20697@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D94EA09@hasmsx108.ger.corp.intel.com>
         <20180621161958.GA11859@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D9516CE@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-21 at 18:40 +0000, Winkler, Tomas wrote:
> I just wanted to make sure that 'RAW' not used in the api directly, it will
> break the flow, do have any suggestion to make it obvious.

We will look at each code review as for any other peace of code how this
flag is used and make decisions at that point what is legit use and what
is not.

/Jarkko
