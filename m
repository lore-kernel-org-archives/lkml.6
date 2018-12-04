Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67009C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC662081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC662081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeLDUOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:14:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33939 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDUOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:14:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id h25so15493083oig.1;
        Tue, 04 Dec 2018 12:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxPFfJdn0iTqfmLdimZV9HsYmTTWR+DBvEKiSjlOSkA=;
        b=O2L2wHk7SFHUZ/GsXgHV3xYsHFxbcJHw/tjz3coX3meVxQf/d5rqgRPCYQQ2V1BHZs
         p3Bfz67JK1wBz5TXRdlbscOmXq1L7+/0Qde4ZxHvwhYHP9pUACWfn8FRC6PpiOmwuks3
         9yu+7kkfxpSkG5VVhzhgO7IMJH7EEdONA1avtS0XAY9n9h8+Wo8RR4NxvXwXK6ldO4lV
         nBIseHY8zG9oK1n7ojCsEIPJOQh38ge0EjV27GHqzXi15TLOhmgAnQQJhZYnmFMPT7Ub
         C4tvlQJpSxXFUVAELMy0u22bRfyOhfBiyDS25KJCNA2YEiYF6uvCyNCTPkiPYfpifPBA
         x9QQ==
X-Gm-Message-State: AA+aEWYlf2kPtIfMW1c+u73qsSPZp7TtsSHG2uxik/j+tF69iWQ5NWgg
        dSZzcm3h0h1VyEwbSyvfknqteEg=
X-Google-Smtp-Source: AFSGD/Www5hngA3MxnIpBoVT7tMrQ0j4KR2OUYdZ4z5jJIv6sDhzuFxnXeskKVfdeh8mJOXPN5fcsg==
X-Received: by 2002:a54:4d01:: with SMTP id v1mr12556149oix.246.1543954460905;
        Tue, 04 Dec 2018 12:14:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l9sm5474906otj.9.2018.12.04.12.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:14:20 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:14:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Yael Chemla <yael.chemla@foss.arm.com>,
        Ofir Drang <Ofir.Drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: crypto: ccree: add dt bindings for
 ccree 703
Message-ID: <20181204201419.GA13304@bogus>
References: <1542102039-22256-1-git-send-email-gilad@benyossef.com>
 <1542102039-22256-3-git-send-email-gilad@benyossef.com>
 <20181129064218.53qc33vus5anla76@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129064218.53qc33vus5anla76@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:42:18PM +0800, Herbert Xu wrote:
> On Tue, Nov 13, 2018 at 09:40:36AM +0000, Gilad Ben-Yossef wrote:
> > Add device tree bindings associating Arm TrustZone CryptoCell 703 with the
> > ccree driver.
> > 
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > ---
> >  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Which tree is this patch meant to go through?

You should take it as it is part of a series.

Rob
