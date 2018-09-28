Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A900C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F2A2159D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F2A2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeI1Lbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:31:44 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:42578 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1Lbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:31:44 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g5l2C-00008a-SF; Fri, 28 Sep 2018 13:09:48 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g5l2C-00061S-6s; Fri, 28 Sep 2018 13:09:48 +0800
Date:   Fri, 28 Sep 2018 13:09:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Srikanth Jampala <Jampala.Srikanth@cavium.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgadam@cavium.com
Subject: Re: [PATCH cryptodev-2.6 1/3] crypto: cavium/nitrox - added support
 to identify the NITROX device partname.
Message-ID: <20180928050948.qmoul4drqhs3n7cz@gondor.apana.org.au>
References: <20180921113802.26475-1-Jampala.Srikanth@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921113802.26475-1-Jampala.Srikanth@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 05:08:00PM +0530, Srikanth Jampala wrote:
> Get the device partname based on it's capabilities like,
> core frequency, number of cores and revision id.
> 
> Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_csr.h  | 111 +++++++++++++++++++++
>  drivers/crypto/cavium/nitrox/nitrox_dev.h  |  17 +++-
>  drivers/crypto/cavium/nitrox/nitrox_hal.c  |  57 +++++++++++
>  drivers/crypto/cavium/nitrox/nitrox_hal.h  |   1 +
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  20 ----
>  5 files changed, 184 insertions(+), 22 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
