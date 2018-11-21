Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A63C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C3A21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C3A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeKURS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:18:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:9312 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeKURS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:18:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 22:45:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="108047964"
Received: from ncanderx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.86])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2018 22:45:40 -0800
Date:   Wed, 21 Nov 2018 08:45:39 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tpm: add support for partial reads
Message-ID: <20181121064539.GB3640@linux.intel.com>
References: <154265371562.23494.10113870855345906523.stgit@tstruk-mobl1.jf.intel.com>
 <20181120124810.GB8813@linux.intel.com>
 <77b031b2-7fa2-f057-1e6a-70f0427ec6c4@intel.com>
 <20181120230759.GF8391@linux.intel.com>
 <affa9788-9d86-341f-28fb-66a8720ef697@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <affa9788-9d86-341f-28fb-66a8720ef697@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:13:59PM -0800, Tadeusz Struk wrote:
> On 11/20/18 3:07 PM, Jarkko Sakkinen wrote:
> >>>> +	/* Holds the resul of the last successful call to tpm_transmit() */
> >>> This comment is cruft.
> >> Do you want me to remove it? This is the comment you proposed.
> > As I explained before it made sense before you made the remark that
> > it can only get positive values i.e. the length.
> > 
> So what do you want me to do with this one?

I don't think it needs now any comment because the variable describes
itself so well.

/Jarkko
