Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B12C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8275E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8275E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLDUOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:14:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39738 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:14:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so12568254otl.6;
        Tue, 04 Dec 2018 12:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A+Qk9DhhROnP1zchyM3hvmqs9WJyIj8j9z9M00Ka2NA=;
        b=stYCOryA7imekzP8qwwKenCJqRUyUVcXLbSPM9b2Bd0z+b+rESBVNF/enrNKHHIIvh
         mpMmWKgDDqT3g9RYCIAr7upC7iik/Rvjrb7vgKnPKpMZIcU4MVBn1TsAggJ0LiJCu6NK
         ylZzU0wyR6oG/LmsBB2Onniltp+GUDcNNIYxEsI/nT82YrMRp4TVuVPghM9HJVoYlwSd
         A+nkX6iqQ+H7iUp/tBgP5qloLDGkg8hD3/NtCeMFk0pdkfiHnDtmiChuo7sOOMFuCzNq
         AAcrZQ62GFTAZGjhExQqzQrqbezuxotLYCdhDNn8E1oqYxm0HX7BDoNlMmN5mv/oD5co
         CwRQ==
X-Gm-Message-State: AA+aEWZtQV/fHuCR1qHWIJN+68r+eqRY7vbP+VahHWRDWlIGSfxZcJuu
        lf6Xk5yoUuZThCo7JY0bSlZP+Sw=
X-Google-Smtp-Source: AFSGD/V1V4Z3ygQreXV3+OSeSx44OWOdVXkN3Z+lwQ0wbfH9t3YMmn95yI2Hbm+qbkJH/Il+P/Uf/A==
X-Received: by 2002:a9d:6a3:: with SMTP id 32mr12755356otx.156.1543954473038;
        Tue, 04 Dec 2018 12:14:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x127sm6841944oia.20.2018.12.04.12.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:14:32 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:14:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Yael Chemla <yael.chemla@foss.arm.com>,
        Ofir Drang <Ofir.Drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: crypto: ccree: add dt bindings for
 ccree 703
Message-ID: <20181204201431.GA15089@bogus>
References: <1542102039-22256-1-git-send-email-gilad@benyossef.com>
 <1542102039-22256-3-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542102039-22256-3-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 09:40:36 +0000, Gilad Ben-Yossef wrote:
> Add device tree bindings associating Arm TrustZone CryptoCell 703 with the
> ccree driver.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
