Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B84BC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A67C21908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBHWAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:00:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:59281 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfBHWAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:00:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 14:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="132150845"
Received: from mwesterb-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.154])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Feb 2019 14:00:26 -0800
Date:   Sat, 9 Feb 2019 00:00:25 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     "Safford, David (GE Global Research)" <david.safford@ge.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
Message-ID: <20190208220025.GB13567@linux.intel.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C0151A3125@ALPMBAPA12.e2k.ad.ge.com>
 <20190118150011.GF4080@linux.intel.com>
 <cb86f5b6-8084-1e12-ce60-19418539b581@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb86f5b6-8084-1e12-ce60-19418539b581@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:21:02PM -0500, Stefan Berger wrote:
> On 1/18/19 10:00 AM, Jarkko Sakkinen wrote:
> > On Fri, Jan 11, 2019 at 08:28:00PM +0000, Safford, David (GE Global Research) wrote:
> > > You might mention that this is an important feature, as on at least some
> > > systems, ppi function 23 is the only way to enable/disable PCR banks.
> > > 
> > > I have tested this patch set on my HP Spectre laptop, and I am finally
> > > able to turn the sha-1 bank on and off. Much appreciated!
> > > 
> > > Tested-by: David Safford <david.safford@ge.com>
> > Great thanks David.
> 
> 
> While we are at it and for the grand finale of the day :-)
> 
> +All you people, keep yourself alive!
> +Keep yourself alive!
> +Keep yourself alive!
> +C'mon, give me your reviewed's
> +to keep me satisfied!
> +Give me your signed-off's                       (1)
> +to keep me satisfied!
> +Keep yourself alive!
> +A few test-by's will keep me satisfied!
> +Keep yourself alive!
> +Check-in!                                                (2)
> +
> +[In the style of Queen]
> 
> 
> Jarrko, do (1) and (2) to keep me satisfied :-)

I still think that in 5/5 branching could be better but is not a biggie
for me (does not make the implementation as whole any kind of mess) and
since it is now peer tested I rather would not modify it right now.

Applied to master and next!

/Jarkko
