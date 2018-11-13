Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC0C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A728922360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A728922360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeKNCyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:54:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:8165 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeKNCyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:54:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 08:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="91740553"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2018 08:55:21 -0800
Date:   Tue, 13 Nov 2018 18:55:19 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/17] Removed nested TPM operations
Message-ID: <20181113165519.GA4752@linux.intel.com>
References: <20181113122609.21643-1-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA1CD09@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA1CD09@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:30:55PM +0000, Winkler, Tomas wrote:
> > 
> > [was Detach TPM space code out of the tpm_transmit() flow but the scope
> > expanded a bit.]
> 
> I believe you making this series artificially large we can merge the
> first 4 patches and leave the rest for further discussion.

1/17, 2/17 and 3/17 are fairly obvious changes but they still should
have tested-by's. For 4/17 I need a sanity check from James Bottomley
that I'm not forgetting some tidbit of TPM space implementation (has
been while since I've worked on it so better to have 2nd eyes there).

I think also 5/17, 7/17 and 10/17 could be merged.

I can reposition forementioned patches so that they are in the head of
the series.

/Jarkko
