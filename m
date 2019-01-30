Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837AFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4357D218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbfA3VWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:22:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:62410 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfA3VWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:22:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 13:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,542,1539673200"; 
   d="scan'208";a="314986641"
Received: from unknown (HELO localhost) ([10.249.254.216])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jan 2019 13:22:12 -0800
Date:   Wed, 30 Jan 2019 23:22:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm: don't print error message in tpm_transmit_cmd when
 tpm still testing
Message-ID: <20190130212210.GA17308@linux.intel.com>
References: <20190129185911.13559-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129185911.13559-1-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:59:11AM -0700, Jerry Snitselaar wrote:
> Currently tpm_transmit_cmd will print an error message if the tpm
> returns something other than TPM2_RC_SUCCESS. This means that if the
> tpm returns that it is testing an error message will be printed, and
> this can cause confusion for the end user. So avoid printing the error
> message if TPM2_RC_TESTING is the return code.
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

And applied. Thanks.

/Jarkko
