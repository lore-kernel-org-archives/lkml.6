Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA7EC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CF320867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CF320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeLAK5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:57:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:51059 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbeLAK5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:57:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 15:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="118914935"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by fmsmga004.fm.intel.com with ESMTP; 30 Nov 2018 15:46:45 -0800
Date:   Fri, 30 Nov 2018 15:46:46 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Message-ID: <20181130234646.GB3792@linux.intel.com>
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
 <20181106164603.w46wspmdj5e4slwe@cantor>
 <1541528254.8568.48.camel@linux.ibm.com>
 <20181130234507.GA3792@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181130234507.GA3792@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:45:07PM -0800, Jarkko Sakkinen wrote:
> On Tue, Nov 06, 2018 at 01:17:34PM -0500, Mimi Zohar wrote:
> > On Tue, 2018-11-06 at 09:46 -0700, Jerry Snitselaar wrote:
> > > On Fri Oct 19 18, Stefan Berger wrote:
> > > >Extend the documentation for trusted keys with documentation for how to
> > > >set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.
> > > >
> > > >Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > >Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > 
> > > Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Thanks!  This patch is now staged in the #next-integrity-queued
> > branch.
> > 
> > Mimi
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Brings to mind, in the long run where the backend code for trusted keys
should reside.

/Jarkko
