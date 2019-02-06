Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9DCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E23218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549487181;
	bh=2qJ4Bnyj2GcLlBCkQmQPtCmNyvDXiZgc9Q12J6L4rYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2N3vLIcFWilN362PjOID2XCAVTDr4ZOK7WQuEPy5iaXbI47NWt0cUbflXKL4VcgCA
	 YY7pWIgyCoQCOf9080EX/q+DQecz0GlN0ARdYnBTxsY2444cf5gIunwVUhpB4wS37z
	 c8fy2jhEqh7f7/WlAlQCb2f04LkxPwwguhljno5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBFVGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfBFVGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:06:19 -0500
Received: from localhost (unknown [178.226.110.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 560A9218D3;
        Wed,  6 Feb 2019 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549487178;
        bh=2qJ4Bnyj2GcLlBCkQmQPtCmNyvDXiZgc9Q12J6L4rYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBaRRARoiSWVc7MRdL9978Kcj4Pl7mc6EIvTqQ1fXJFvbYmPEdaW4J07VbnDfUbyJ
         0jKrVQCr2Az4SM4h/SSCwYpraWxkn6MhsakVfV2jJUPijdaxP6Am8bogC7Qniw2Oug
         tQgStfIh6frZG74yDj+ItXirRKA1boGPwvdagLLc=
Date:   Wed, 6 Feb 2019 22:06:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH 1/6] vmw_balloon: bump version number
Message-ID: <20190206210605.GA4599@kroah.com>
References: <20190206051336.2425-1-namit@vmware.com>
 <20190206051336.2425-2-namit@vmware.com>
 <20190206164245.GA8466@kroah.com>
 <83759B2D-329A-4CBA-84A4-0511398D1AB2@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83759B2D-329A-4CBA-84A4-0511398D1AB2@vmware.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 08:39:52PM +0000, Nadav Amit wrote:
> > On Feb 6, 2019, at 8:42 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Tue, Feb 05, 2019 at 09:13:31PM -0800, Nadav Amit wrote:
> >> Following recent changes.
> >> 
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> ---
> >> drivers/misc/vmw_balloon.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> >> index f8240b87df22..7294f305753f 100644
> >> --- a/drivers/misc/vmw_balloon.c
> >> +++ b/drivers/misc/vmw_balloon.c
> >> @@ -34,7 +34,7 @@
> >> 
> >> MODULE_AUTHOR("VMware, Inc.");
> >> MODULE_DESCRIPTION("VMware Memory Control (Balloon) Driver");
> >> -MODULE_VERSION("1.5.0.0-k");
> >> +MODULE_VERSION("1.6.0.0-k");
> > 
> > Please just drop this pointless line, it means nothing and is always out
> > of date.  It's been removed from many other drivers, and I really don't
> > want to see it come back.
> > 
> > Your driver "version" is the kernel version, full stop.  That's all you
> > need to ever worry about.
> 
> I understand, and I will inform those who asked for the version bump.
> 
> Having said that, I do not see a reference for this policy. I understand
> that you removed the MODULE_VERSION from in-kernel drivers, but I also see
> that you accepted several drivers last year that used MODULE_VERSION.

I messed up, and will be glad to take patches to remove them.  Usually
that's the last thing I remember to check when reviewing patches, I
can always use the help :)

Also, I only received 1 patch in this series, did something go wrong
with the sending of it?

thanks,

greg k-h
