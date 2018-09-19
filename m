Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01205ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5F220880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5F220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeISUhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:37:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:45333 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbeISUhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:37:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 07:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="84859340"
Received: from pqueiros-mobl.ger.corp.intel.com (HELO localhost) ([10.249.37.13])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2018 07:58:52 -0700
Date:   Wed, 19 Sep 2018 17:58:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/20] tpm: move pcr extend code to tpm2-cmd.c
Message-ID: <20180919145851.GB31076@linux.intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
 <20180918093459.19165-13-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918093459.19165-13-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:51PM +0300, Tomas Winkler wrote:
> Add tpm2_pcr_extend() function to tpm2-cmd.c with signature required
> by tpm-interface.c. It wraps the original open code
> implementation. The original original tpm2_pcr_extend() function
> is renamed and made static, called only from new tpm2_pcr_extend()
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

The change is OK. The last sentence in the commit message needs to
be fixed.


/Jarkko
