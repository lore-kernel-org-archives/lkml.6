Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88FEC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE6A249C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE6A249C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934100AbeGCQvJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:51:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:3709 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933961AbeGCQvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:51:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 09:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="51733049"
Received: from cdikicix-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.69])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2018 09:51:03 -0700
Date:   Tue, 3 Jul 2018 19:51:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <jejb@linux.vnet.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until module
 shutdown
Message-ID: <20180703165102.GB19800@linux.intel.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
 <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
 <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
 <1530631615.3142.6.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530631615.3142.6.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> On Tue, 2018-07-03 at 18:24 +0300, Jarkko Sakkinen wrote:
> [...]
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Is James maintaining this now? Have not seen his feedback yet...
> 
> Hey, I thought we both were ...
> 
> However, it looks fine to me
> 
> Reviewed-by: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
> 
> James

OK, I was not sure how that discussion went. I could add myself as
co-maintainer to MAINTAINERS because I anyway need to go through
all of these.

If anyone does not vote against, I'll send a patch.

/Jarkko
