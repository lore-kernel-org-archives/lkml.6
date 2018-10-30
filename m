Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C1C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402A02081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402A02081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeJaHQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:16:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36316 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeJaHQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:16:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id r127-v6so10198171oie.3;
        Tue, 30 Oct 2018 15:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CaxjKQXbBonDVDugThnJ3WZigkojWHmkkX3hMcl9qgg=;
        b=oDEJ4Dy+b3eYQvAggI1mGI5Rzlse9odViqQGrYrputracBL5xjCqaf+77pyrnPOPvd
         7dQoKxXsV3AfnuZvmpknfQAnAfRVHibNtlVpAcqx2LMVkk8HhVO7saBHGLH3USjoKedC
         qT6X9YAp/vpVbduCc+qPrEjqizLN108AXYjGhEYscbTxG1hXb91XC8RBgHA5FifNbcZX
         McWB8NEDzuF+ikqLaKUf8bCXlPvc1IXPugHFzpUrc0vr+ldIiwDKU9pASJr+zjGDTdoI
         UmuSW36Z8b6YyvrLgSEPrp3upED5nGEzkv4uMaPqO/uZ2LOLuGYa7hWcVEwqRNYEfaac
         Zkuw==
X-Gm-Message-State: AGRZ1gJ6cAG8AoIdTZ0GKn/fhz3FaaNCu0OygT/EVz8fs3x4OTh2m49Z
        69uvyPzh1aU6p1WwTa90tNDieTU=
X-Google-Smtp-Source: AJdET5eBwcE/PBN4oCV5xir4sd1smV06wHXeMA5jcWDk+BjubFSAC2L31wvt+zLQFgacMRILYxFWsA==
X-Received: by 2002:aca:ebd1:: with SMTP id j200-v6mr336125oih.206.1540938043766;
        Tue, 30 Oct 2018 15:20:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l200-v6sm7951064oig.20.2018.10.30.15.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 15:20:43 -0700 (PDT)
Date:   Tue, 30 Oct 2018 17:20:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Yael Chemla <Yael.Chemla@arm.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: crypto: ccree: add ccree 713
Message-ID: <20181030222042.GA6716@bogus>
References: <1540806616-5483-1-git-send-email-gilad@benyossef.com>
 <1540806616-5483-3-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540806616-5483-3-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 09:50:13 +0000, Gilad Ben-Yossef wrote:
> Add device tree bindings associating Arm TrustZone CryptoCell 713 with the
> ccree driver.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
