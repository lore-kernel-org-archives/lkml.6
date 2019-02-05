Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D7EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736502145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBEIhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:37:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:36601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBEIhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:37:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 00:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,562,1539673200"; 
   d="scan'208";a="297356952"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga005.jf.intel.com with ESMTP; 05 Feb 2019 00:37:01 -0800
Date:   Tue, 5 Feb 2019 10:36:59 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        stable@vger.kernel.org,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [PATCH v2] tpm/st33zp24: Fix the name collisions in
 tpm_st33zp24_spi and tpm_i2c_infineon
Message-ID: <20190205083659.GB7427@linux.intel.com>
References: <20190204133749.14176-1-jarkko.sakkinen@linux.intel.com>
 <575f4693-129c-469c-e54e-dbb9ad2a66f2@huawei.com>
 <20190204233117.GE14992@linux.intel.com>
 <20190204234047.GA15685@linux.intel.com>
 <a6a9e68d-ff0a-c33d-50ce-5d18939c1ab3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a9e68d-ff0a-c33d-50ce-5d18939c1ab3@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 09:08:33AM +0100, Roberto Sassu wrote:
> On 2/5/2019 12:40 AM, Jarkko Sakkinen wrote:
> > On Tue, Feb 05, 2019 at 01:31:17AM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Feb 04, 2019 at 02:49:54PM +0100, Roberto Sassu wrote:
> > > > On 2/4/2019 2:37 PM, Jarkko Sakkinen wrote:
> > > > > Rename TPM_BUFSIZE defined in drivers/char/tpm/st33zp24/st33zp24.h to
> > > > > ST33ZP24_BUFSIZE.
> > > > > 
> > > > > Rename TPM_BUFSIZE defined in drivers/char/tpm/tpm_i2c_infineon.c to
> > > > > TPM_I2C_INFINEON_BUFSIZE.
> > > > 
> > > > Please also add a prefix to TPM_RETRY in tpm_i2c_nuvoton.c.
> > > 
> > > Thanks, can do.
> > 
> > TPM_RETRY defined in
> > 
> >    32d33b29ba07 ("TPM: Retry SaveState command in suspend path")
> > 
> > has nothing to do with time. I'll also remove the comment about 5
> > seconds.
> 
> I'll do the same for patch 4/6.

Yep. I'll post a new patch ASAP.

/Jarkko
