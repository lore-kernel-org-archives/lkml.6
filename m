Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0CCECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B6821547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B6821547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbeIULbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:31:09 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46304 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIULbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:31:09 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g3EEN-0005Tp-0T; Fri, 21 Sep 2018 13:43:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g3EEJ-0000Y0-P6; Fri, 21 Sep 2018 13:43:51 +0800
Date:   Fri, 21 Sep 2018 13:43:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Srikanth Jampala <Jampala.Srikanth@cavium.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgadam@cavium.com
Subject: Re: [PATCH] crypto: cavium/nitrox - use dma_pool_zalloc()
Message-ID: <20180921054351.spae5c5ah2z4b6zn@gondor.apana.org.au>
References: <20180910082452.19842-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910082452.19842-1-Jampala.Srikanth@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 01:54:52PM +0530, Srikanth Jampala wrote:
> use dma_pool_zalloc() instead of dma_pool_alloc with __GFP_ZERO flag.
> crypto dma pool renamed to "nitrox-context".
> 
> Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
