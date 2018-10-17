Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F30C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D42214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D42214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJQOC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:02:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:37428 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:02:57 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gCf0n-0001jq-Uj; Wed, 17 Oct 2018 14:08:54 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gCf0l-0002DA-4J; Wed, 17 Oct 2018 14:08:51 +0800
Date:   Wed, 17 Oct 2018 14:08:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] crypto: streebog - add Streebog hash function
Message-ID: <20181017060851.r5mxvpq3l2ycvpio@gondor.apana.org.au>
References: <20181010121254.12220-1-vt@altlinux.org>
 <20181012061659.mextetc3v7urqkzx@gondor.apana.org.au>
 <20181012064105.bchujbwoaszrcu3l@sole.flsd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012064105.bchujbwoaszrcu3l@sole.flsd.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:41:05AM +0300, Vitaly Chikunov wrote:
>
> It is the first part of attempts to add to the Integrity subsystem
> ability of verifying file and module signatures by Russian GOST
> algorithms.

It would be better if these patches are posted together.  That
way we don't end up with a situation where the algorithm goes into
the kernel but the ultimate user is rejected.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
