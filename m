Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4790ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB3B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB3B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeIRJwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 05:52:33 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:41672 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIRJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 05:52:33 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g27W8-0008OC-Mp; Tue, 18 Sep 2018 12:21:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g27W2-0003S4-0x; Tue, 18 Sep 2018 12:21:34 +0800
Date:   Tue, 18 Sep 2018 12:21:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     ard.biesheuvel@linaro.org, luto@kernel.org, davem@davemloft.net,
        andrew@lunn.ch, ebiggers@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sneves@dei.uc.pt, jeanphilippe.aumasson@gmail.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography
 library
Message-ID: <20180918042133.4ybztgdooxkoyiru@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qwRzuoo-3Hxahwu=Li2LCz06Uowaq1GFmkts6tsffM7w@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason:

Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> On Mon, Sep 17, 2018 at 7:26 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> OK, so let me summarize my remaining concerns as well. I may be a bit
>> more finicky than Andy, though.
> 
> Yes, and generally hostile to this whole initiative since the
> beginning. But I am very grateful for your reviews nonetheless, and
> I'll do my best to incorporate as much as is reasonable.
 
>> I would like to urge Jason to
>> bear with us and bring this discussion to a close before resubmitting.
> 
> What I fear is that either:
> - You don't like the Zinc initiative in one way or another, and the
> desire to "keep discussing" and adding more things is less out of
> their necessity and more out of a desire to stall it indefinitely.
> - You're going to bikeshed and bikeshed and waste tons of time until
> Zinc copies lots of the same design decisions from the present crypto
> API.

That may be your view but from what I've read Ard has been very
constructive in pointing out issues in your submission.  If your
response to criticism is to dismiss them as hostile then I'm afraid
that we will not be able to progress on this patch series.

Please keep in mind that this is a large project that has to support
multiple users on one hand (not just WireGuard) and complex hardware
acceleration drivers on the other.  Ard has been one of the most
prolific contributors to the crypto code and his review should be
taken seriously.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
