Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-608163-1524463440-2-11915616891913926516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524463440; b=dDeW42a8iVdm88uUUGmGMIyUS38uL7ZAL3yH1fE8FM/sMMIbTj
    nFcxv7doo1VRBoznOmtVnXjJVLiDsYjF/zOJjUzT3/+B0nIqEwzImaoR2ulWcSM5
    OC5eihtVeiYvZKIarryR/drnNG5xJ9r8Ni8qilf5qOixbMzNJaDTAPhKmvDep4CM
    aGcJVVJ20Tc4PMLg0H8gKNlY9LAYhoPBG1Hgcs8yTZ5MmBHSlMbrN57bxqFiqaJ1
    SV+Hf0tthNhxLtqR/uhsA/kObSf1MXrQ4+1JWt1Ny60IXaYE19W8v2DQ6IDDIS2j
    E4vOUkzLsyjtnIL2e7eJwKquadMqYKIaI0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524463440; bh=s2qVs4QLuRY0Qky4GpxzP8uSWrUOxY
    pMctRcWlcQimg=; b=Qe/n96PIdclRr7EoA04MnBfbZgBSdgliHuPvrR2Ha/BM47
    M6jMuoR32stTWHG5fGKzoHoD44nsmslYBPMFH20F1ovqf23tA7dfTELxGbstaGTN
    1866ivvRBhhoKhoOUszowbBZplO7JWTIn2oAy4pIfsjq3JDJ0AWlzBMjnTCTnARY
    3qQ0cINb6t3zyhxOsgLeoe7N29mqQSqO2D259MoSVbyrqa2wcqNWKPtGvglWD/ha
    KbaLt14CNzwJ5N8GEkiMEFKwAkfFjBmsTR7b8X2opcOLraDMj4qiH4QoZHqGaOUS
    7vBi6lR5M5GEinvUkTbdgJA2qC9b3cIYqfIDyzMA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=YmaU9ux4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=YmaU9ux4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAn0qB3mGdPSF0TSB+LbT/GY4o/rdt/sVgHh0OyRXMO7D63P5z2O3sSMAHKnLhKsMOT4vq+yQa3nnodAGRai8BykwbMm7mClPeY0O499ZuGI3oLnsVc2
    WJVozW8AYRfSYVpWdpDR5YwpMlqj+TU/pMFUwEUXIA+yMhmeAY+XUbNRQWIJUyhbxtv92eqeWt66IrT7MpDam21jij3hezUC5lN6Q9XlSbcweA339qIVkyAN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=GnY4FjVu1jG5_KsRFXwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeDWGD6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 02:03:58 -0400
Received: from imap.thunk.org ([74.207.234.97]:43992 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeDWGD5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 23 Apr 2018 02:03:57 -0400
Date: Mon, 23 Apr 2018 02:03:52 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, Wen Xu <wen.xu@gatech.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.9 37/95] ext4: add validity checks for bitmap block
 numbers
Message-ID: <20180423060352.GA8194@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ben Hutchings <ben@decadent.org.uk>, stable@vger.kernel.org,
        Wen Xu <wen.xu@gatech.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180422135210.432103639@linuxfoundation.org>
 <20180422135211.941652389@linuxfoundation.org>
 <30c688b5783a5779811ce68893b7001390b9e200.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c688b5783a5779811ce68893b7001390b9e200.camel@decadent.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 10:54:23PM +0100, Ben Hutchings wrote:
> >  	offset = blk - group_first_block;
> > -	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
> > +	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
> > +	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
> 
> Isn't sb->s_blocksize a count of bytes?  If so, doesn't that mean that
> we should be comparing with sb->s_blocksize * 8?

Yes, nice catch, Ben!  Can we temporarily drop this patch from the
stable queue until I can get a fix in?

In practice this shouldn't be a problem because of the default ext4
layout with flex_bg.  But we should definitely get this fixed before
we let this flow into the stable kernel.

       	    	      	  	 - Ted
