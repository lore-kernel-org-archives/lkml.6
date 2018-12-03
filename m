Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78E22081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78E22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbeLCCx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:53:29 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39668 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeLCCx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:53:28 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gTeMQ-0001Qk-5m; Mon, 03 Dec 2018 10:53:26 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gTeMN-0002nG-0e; Mon, 03 Dec 2018 10:53:23 +0800
Date:   Mon, 3 Dec 2018 10:53:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dave Rodgman <dave.rodgman@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org, nd <nd@arm.com>
Subject: Re: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Message-ID: <20181203025322.ak5eymaib6ubo2nw@gondor.apana.org.au>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
 <20181127161913.23863-8-dave.rodgman@arm.com>
 <20181129044333.GH6379@jagdpanzerIV>
 <5b504430-fb4b-340b-66c2-1300c816cc3a@arm.com>
 <20181203024019.GB427@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203024019.GB427@jagdpanzerIV>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:40:19AM +0900, Sergey Senozhatsky wrote:
> 
> I'm not in any position to ask you to do this; white-space clean ups
> are not very popular (it's OK for staging tree; not so much otherwise).
> So we better ask David and Herbert.

I'm fine with white space cleanups.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
