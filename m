Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9747C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7917E218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545842953;
	bh=CTeaXQkJnxnshRr4brdCG7cjef1m5muuIznOxlBRvEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vsIac79WU1SfDWf8R0ligdLQ0PGnAtyouKQi98x61/z3+wt2njTtLz34oTlAGkGmG
	 UC2sZnfBic4l3fnAukSNI9s+4YP0AxXmDze9sJ/sCCAKyU17cbFGuadIXQnt1fUwb2
	 K6Kx4eIOLdjAzi8ZzXRS3zqWfNHEkkhuy11Y8BPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeLZQtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:49:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeLZQtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:49:12 -0500
Received: from zzz.localdomain (h184-61-154-48.mdsnwi.dsl.dynamic.tds.net [184.61.154.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34A0218EA;
        Wed, 26 Dec 2018 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545842951;
        bh=CTeaXQkJnxnshRr4brdCG7cjef1m5muuIznOxlBRvEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ou+HjORNHxJrJ/MhSaQkZgbzQKash4610ZROP+jLY9wTVTw6YLAXfTZpT4z44nhDS
         5WmEl5vfAqtjkTQf9ajHWD4t+34/Qhw6T3mx4yM3lLcwBysTOy6FmSQpEwlTpCGTma
         vJMiUqvGtbvPWK593ODoQR+tIbzMdqFprStNs598=
Date:   Wed, 26 Dec 2018 10:49:08 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: Crypto Update for 4.21
Message-ID: <20181226164906.GA622@zzz.localdomain>
References: <20161119102748.GA4277@gondor.apana.org.au>
 <20161213132414.GA7898@gondor.apana.org.au>
 <20170223125141.GA17400@gondor.apana.org.au>
 <20170904101225.GA12613@gondor.apana.org.au>
 <20171113074346.GA20245@gondor.apana.org.au>
 <20181023100958.GA11991@gondor.apana.org.au>
 <20181226132257.w43gf2fouprimwk2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226132257.w43gf2fouprimwk2@gondor.apana.org.au>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 09:22:57PM +0800, Herbert Xu wrote:
> 
> Please pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
> 

Hi Herbert, that branch is still on an old commit.  Probably you forgot to push.

- Eric
