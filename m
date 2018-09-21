Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F585C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7A721547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7A721547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbeIUKkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:40:02 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46016 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeIUKkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:40:01 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g3DR2-0004xp-Ml; Fri, 21 Sep 2018 12:52:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g3DQx-0001kQ-T2; Fri, 21 Sep 2018 12:52:51 +0800
Date:   Fri, 21 Sep 2018 12:52:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 1/2] Fix static checker warning
Message-ID: <20180921045251.cubm22rnx2cjsoup@gondor.apana.org.au>
References: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
 <31c49295223e51f5c1c4e36e7a09fe100dab1711.1536959537.git.Janakarajan.Natarajan@amd.com>
 <8dfca0f4-6639-3444-148f-eb0b0817fec6@amd.com>
 <20180919135741.5icpyesntcfbgtcr@mwanda>
 <7aa02bf8-8813-98e5-6729-af4ae63da7d0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa02bf8-8813-98e5-6729-af4ae63da7d0@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:43:48PM +0000, Natarajan, Janakarajan wrote:
> On 9/19/2018 8:57 AM, Dan Carpenter wrote:
> > Sounds reasonable.  The subject needs a subsystem prefix and it might
> > be better to make it more specific.  Like so:
> >
> > [PATCH 1/2] crypto: ccp - potential uninitialized variable
> 
> I'll put out a v2 with the subjects fixed.

This is not necessary.  I'll fix it up when I apply the patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
