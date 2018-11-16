Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7FC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8F22089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8F22089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbeKPQa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:30:28 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:37638 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeKPQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:30:27 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gNXTJ-00051w-Mo; Fri, 16 Nov 2018 14:19:17 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gNXTH-00020U-Av; Fri, 16 Nov 2018 14:19:15 +0800
Date:   Fri, 16 Nov 2018 14:19:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Marek Vasut <marek.vasut@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND 0/2] Port mxs-dcp to imx6ull and imx6sll
Message-ID: <20181116061915.3tigrkkucg65xeai@gondor.apana.org.au>
References: <cover.1541604742.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541604742.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 03:33:30PM +0000, Leonard Crestez wrote:
> The DCP block is present on 6sll and 6ull but not enabled. The hardware is
> mostly compatible with 6sl, the only important difference is that explicit
> clock enabling is required.
> 
> All patches already have review tags from a few weeks ago. No changes
> relative to v4: https://lore.kernel.org/patchwork/cover/1001134/
> 
> Patches 3/4 were already accepted by Shawn Guo for the imx tree, this
> resend is just for the crypto parts now that the merge window is over.
> 
> Leonard Crestez (2):
>   dt-bindings: crypto: Mention clocks for mxs-dcp
>   crypto: mxs-dcp - Add support for dcp clk
> 
>  .../devicetree/bindings/crypto/fsl-dcp.txt    |  2 ++
>  drivers/crypto/mxs-dcp.c                      | 28 +++++++++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
