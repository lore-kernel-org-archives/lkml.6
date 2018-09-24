Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A49C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0516120833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0516120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeIYEkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:40:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:35398 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbeIYEkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:40:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 15:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,299,1534834800"; 
   d="scan'208";a="76951355"
Received: from rkchitto-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.24])
  by orsmga006.jf.intel.com with ESMTP; 24 Sep 2018 15:35:11 -0700
Date:   Tue, 25 Sep 2018 01:35:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/21] tpm: factor out tpm_startup function
Message-ID: <20180924223513.GB12088@linux.intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
 <20180921135820.20549-12-tomas.winkler@intel.com>
 <060a3dc0-046e-198c-f476-8c490140e9d6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060a3dc0-046e-198c-f476-8c490140e9d6@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 08:21:10PM +0530, Nayna Jain wrote:
> On 09/21/2018 07:28 PM, Tomas Winkler wrote:
> > TPM manual startup is used only from within TPM 1.x or TPM 2.x
> > code, hence remove tpm_startup() function from tpm-interface.c
> > and add two static functions implementations tpm1_startup()
> > and tpm2_startup() into to tpm1-cmd.c and tpm2-cmd.c respectively.
> > 
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Tested-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

Probably my bad, had an unfortunate misconfiguration in my vim/git
setup. Sorry.

/Jarkko
