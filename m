Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C11C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AD62145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AD62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeIYKzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 06:55:18 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34082 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeIYKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 06:55:18 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g4fHt-0003Ua-R9; Tue, 25 Sep 2018 12:49:29 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g4fHq-0004sz-9E; Tue, 25 Sep 2018 12:49:26 +0800
Date:   Tue, 25 Sep 2018 12:49:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH crypto-next 00/23] crypto: skcipher - Remove VLA usage
Message-ID: <20180925044926.vkkj2fnfvshjqpt5@gondor.apana.org.au>
References: <20180919021100.3380-1-keescook@chromium.org>
 <CAGXu5jKFdMXYGJ9AmR9=OkTqrU9_RqtMXeOmXfivv0VvwPfOmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKFdMXYGJ9AmR9=OkTqrU9_RqtMXeOmXfivv0VvwPfOmg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 05:49:37PM -0700, Kees Cook wrote:
>
> > Kees Cook (23):
> >   crypto: skcipher - Introduce crypto_sync_skcipher
> >   gss_krb5: Remove VLA usage of skcipher
> >   lib80211: Remove VLA usage of skcipher
> >   mac802154: Remove VLA usage of skcipher
> >   s390/crypto: Remove VLA usage of skcipher
> >   x86/fpu: Remove VLA usage of skcipher
> >   block: cryptoloop: Remove VLA usage of skcipher
> >   libceph: Remove VLA usage of skcipher
> >   ppp: mppe: Remove VLA usage of skcipher
> >   rxrpc: Remove VLA usage of skcipher
> >   wusb: Remove VLA usage of skcipher
> >   crypto: ccp - Remove VLA usage of skcipher
> >   crypto: vmx - Remove VLA usage of skcipher
> >   crypto: null - Remove VLA usage of skcipher
> >   crypto: cryptd - Remove VLA usage of skcipher
> >   crypto: sahara - Remove VLA usage of skcipher
> >   crypto: qce - Remove VLA usage of skcipher
> >   crypto: artpec6 - Remove VLA usage of skcipher
> >   crypto: chelsio - Remove VLA usage of skcipher
> >   crypto: mxs-dcp - Remove VLA usage of skcipher
> >   crypto: omap-aes - Remove VLA usage of skcipher
> >   crypto: picoxcell - Remove VLA usage of skcipher
> >   crypto: skcipher - Remove SKCIPHER_REQUEST_ON_STACK()
> 
> How do these look to you, Herbert? I'd really like to make sure these
> make it for the next merge window -- they're the last VLAs left in the
> kernel now. :)

I have no problems with the crypto parts.  Do we have acks for
all of the others?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
