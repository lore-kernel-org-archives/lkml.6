Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393EBC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA908208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA908208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbeHNS4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:56:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:5303 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbeHNS4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:56:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 09:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,238,1531810800"; 
   d="scan'208";a="254777539"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.90])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2018 09:07:57 -0700
Date:   Tue, 14 Aug 2018 19:07:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] tpm: add ptr to the tpm_space struct to file_priv
Message-ID: <20180814160757.GA14500@linux.intel.com>
References: <153419236870.8189.15489652816512817246.stgit@tstruk-mobl1.jf.intel.com>
 <153419237378.8189.17192381683473461307.stgit@tstruk-mobl1.jf.intel.com>
 <20180814160605.GC13648@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814160605.GC13648@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:06:05PM +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 13, 2018 at 01:32:53PM -0700, Tadeusz Struk wrote:
> > Add a ptr to struct tpm_space to the file_priv to have an easy
> > access to it in the async job without the need to allocate memory.
> > This also allows to consolidate of the write operations for
> > the two interfaces.
> > 
> > Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> > Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> 
> NAK
> 
> A rule thumb: do not add "links" between commits unless it is you cannot
> find any other way. The cover letter is made for describing feature or
> features that are defined a the set of commits.
                            ~~~~~
			    by a

/Jarkko
