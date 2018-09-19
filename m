Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F76C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4442820877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4442820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbeISWTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:19:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeISWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:19:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F88DBAD;
        Wed, 19 Sep 2018 16:40:23 +0000 (UTC)
Date:   Wed, 19 Sep 2018 18:40:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: process? [Re: Crypto Fixes for 4.19]
Message-ID: <20180919164019.GA7195@kroah.com>
References: <20171128230929.GA17783@gondor.apana.org.au>
 <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au>
 <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20180919062201.ov5o4vljvholgsed@gondor.apana.org.au>
 <20180919132324.GA24399@kroah.com>
 <d8c061a9-b415-e092-c28f-9e433d83b59b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c061a9-b415-e092-c28f-9e433d83b59b@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 09:10:55AM -0700, Randy Dunlap wrote:
> On 9/19/18 6:23 AM, Greg KH wrote:
> > On Wed, Sep 19, 2018 at 02:22:01PM +0800, Herbert Xu wrote:
> >> Hi Greg: 
> >>
> >> This push fixes a potential boot hang in ccp and an incorrect
> >> CPU capability check in aegis/morus on x86.
> >>
> >>
> >> Please pull from
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
> > 
> > Now pulled, thanks.
> > 
> > greg k-h
> 
> Hi,
> Just a process question:
> 
> It looks like Greg is not adding Signed-of-by: <himself>
> to mainline git commits, although the prior mainline git committer did so.
> 
> Is that omission on purpose?

s-o-b does not get added to git pulls, I "trust" the subsystem
maintainer got it correct.  That's what Linus has always done in the
past, what am I doing differently here?

> submitting-patches.rst says:
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path.

Yes, but not for git pulls.

I have not applied any patches sent in emails at this point in time, so
there's nothing that I could have even signed off on.

confused,

greg k-h
