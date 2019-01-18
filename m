Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfARE4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:56:02 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:48158 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfARE4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:56:01 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gkMC6-0007VO-5E; Fri, 18 Jan 2019 12:55:50 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gkMC2-0000ex-S2; Fri, 18 Jan 2019 12:55:46 +0800
Date:   Fri, 18 Jan 2019 12:55:46 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-crypto@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/4] crypto: hisilicon: Add HiSilicon ZIP accelerator
 support
Message-ID: <20190118045546.hs37a2isfnvxgm7j@gondor.apana.org.au>
References: <1545465105-133138-1-git-send-email-wangzhou1@hisilicon.com>
 <1545465105-133138-4-git-send-email-wangzhou1@hisilicon.com>
 <20190111060859.k647ltxukywjmi3l@gondor.apana.org.au>
 <5C383908.4090107@hisilicon.com>
 <5C3F3BDF.6070409@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C3F3BDF.6070409@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:12:47PM +0800, Zhou Wang wrote:
>
> A stupid question: how do we test scomp alg?
> 
> It seems we can not use general comp API, e.g. crypto_alloc_comp
> to do this.
> 
> Could you give me any clue about this?

scomp algorithms are allocated through crypto_alloc_acomp.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
