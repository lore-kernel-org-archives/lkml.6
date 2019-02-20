Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D10C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8091420859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfBTPEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:04:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:32849 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfBTPEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:04:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 07:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="148394532"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.177])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2019 07:04:46 -0800
Date:   Wed, 20 Feb 2019 17:04:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] MAINTAINERS: add linux-security-module mailing list to
 TPM drivers
Message-ID: <20190220150445.GA4794@linux.intel.com>
References: <20190220035846.6272-1-jsnitsel@redhat.com>
 <20190220070413.GB23027@linux.intel.com>
 <20190220140357.5vbepgmexso3jc6d@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220140357.5vbepgmexso3jc6d@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 07:03:57AM -0700, Jerry Snitselaar wrote:
> On Wed Feb 20 19, Jarkko Sakkinen wrote:
> > On Tue, Feb 19, 2019 at 08:58:46PM -0700, Jerry Snitselaar wrote:
> > > I've seen requests to add linux-security-module to tpm patch
> > > submissions a couple of times recently, so just add the list
> > > to MAINTAINERS so get_maintainers.pl will mention it.
> > > 
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > I guess James should say something about this.
> > 
> > /Jarkko
> 
> Sorry, I meant to add James as well.
> 
> Maybe this isn't needed. Do you only want certain patches
> being cc'd to linux-security-module? Looking back at
> recent patches, it looked like it was a general request.
> If it is, I'll be more likely to remember if get_maintainers.pl
> brings it up. :)

I'm all open here. Not sure which practices apply to IMA. I kind of tend
to dilate to question does it make sense to CC to LSM for two reasons:

1. I think the original reason was that tpmdd mailing list was small.
Now with the new linux-integrity mailing list up and running there is
more eyes looking at the code. And more importantly the people are
subscribed who use TPM for something, like IMA developers.
2. I don't remember ever reading within the time that I've been
maintaining even a single comment from anyone that works with LSM's. The
value of CC'ing there is not very significant, which means that most of
the time the TPM traffic is just noise on that list.

/Jarkko
