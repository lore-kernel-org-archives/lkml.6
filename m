Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-775307-1524467640-2-16362036692704460889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524467639; b=dO+e+8hcCY+J6XxhrvLrgYj7ysayHlFeMl76URa5jqIspgSsvN
    ZqgM7mdZl3ymAOc8Vl4c1sZ/hUPcqgI+tXTbdgKUnAnZhQDwVO1UNGm+HBZ0kanP
    +/Mqmq9KVzsiYjbm4TqOo2W47kT+PbY93Ftr2W1S/QgbgAMB0lH6G7eD5bIIYaCQ
    guXMM66m6cKhe74KT6ORVXC+x9TiDWBHGFPFqASEKWJy+1PyV5CfahHrmuVpemZ/
    lJc3SbDYRqEugvR+6hMFrjSd4v5n4kxYFLlCL6PxXsfvwc2IEMAkI4zpTzFtC0W8
    bQcSwDfWmstryEFqU/LN3aHd/pjMCLJO6GLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524467639; bh=b/S0NMraUH4O9eCdKIDMtlDmHkUeTy
    7X5LxKSlirtvU=; b=phtQjyF8kZlGRqm93fE6ZlOpeN3/9RuN7QjzqPrx8R/7u2
    kNI34KdK/SHFigmUWpShm4AFJAoSf1gsXDlX1+Ub2A/JHTg/vPIlMee5zQ3C+1bM
    Z0bewkJO0lez2rT8IMcWzvOvGhpVfghSP9L2ISaIeFXGH2bBAbF1l5/1yZ33/nx1
    s3ZNd9TZd/wnvK663CB/wkDjzof2U/RHe34tfWdeRQgGxS9oe4IafvCuh8ljQjpW
    cqmdOrCpdciRcqDvvyI6oObDI2xqVYoB93hXaoY40+1SrpVO323o09B1mtvci3dJ
    okbQQoJLlR55jw/XOdoWu9S9ddSS5it8TJnvYtcA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPtS7bm57eFO1Jcn9bQaeQ0vWYnSkEq6QVthqzFF2UtTRqBL+WRuzHuPGSLAq6Q5onNtIaHZRQx9gzx2dsI6J2g4oB5lbsuXslrFU0gFIArjLjrUOplh
    tDr3w1qBkLUf4Shs6oUOYLnPlEPZq5lTrwCnZqtblUPVHH32fygsHp4UAnhznUUBhlBj6pSl6VLjKM02PCjo08vewYhnZD2zchrPaVISP/nYwbykB+z0DEvo
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=KxrDYYeofMLKJ3l61cEA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeDWHN4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 03:13:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeDWHN4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 03:13:56 -0400
Date: Mon, 23 Apr 2018 09:13:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ben Hutchings <ben@decadent.org.uk>, stable@vger.kernel.org,
        Wen Xu <wen.xu@gatech.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.9 37/95] ext4: add validity checks for bitmap block
 numbers
Message-ID: <20180423071350.GB28186@kroah.com>
References: <20180422135210.432103639@linuxfoundation.org>
 <20180422135211.941652389@linuxfoundation.org>
 <30c688b5783a5779811ce68893b7001390b9e200.camel@decadent.org.uk>
 <20180423060352.GA8194@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423060352.GA8194@thunk.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 02:03:52AM -0400, Theodore Y. Ts'o wrote:
> On Sun, Apr 22, 2018 at 10:54:23PM +0100, Ben Hutchings wrote:
> > >  	offset = blk - group_first_block;
> > > -	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
> > > +	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
> > > +	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
> > 
> > Isn't sb->s_blocksize a count of bytes?  If so, doesn't that mean that
> > we should be comparing with sb->s_blocksize * 8?
> 
> Yes, nice catch, Ben!  Can we temporarily drop this patch from the
> stable queue until I can get a fix in?
> 
> In practice this shouldn't be a problem because of the default ext4
> layout with flex_bg.  But we should definitely get this fixed before
> we let this flow into the stable kernel.

Now dropped from all queues.  When you submit the fix, can you also tag
it for stable so I know to pick this one back up?

thanks,

greg k-h
