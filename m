Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D7AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B4621564
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B4621564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeI0FK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:10:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35986 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeI0FK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:10:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125-v6so577628oic.3;
        Wed, 26 Sep 2018 15:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZvh8F1h8/k/4SCeGOUgGF1a4pqt43zsP1FDiv8i3rQ=;
        b=GiWsQm8TEFFsl5CBUcMMNTjuDNs6mkXk6qZ5scL9OP/KywzZszg+pK8N+JuOiI8iHl
         b1xOJfOM5RTv62CsnyVnKP62Qu4pDD5OrSl/JuJ6QKm0ojHEfRCFLg89sOKEUHgFeD4s
         rWkfSE4F3xPC1q9DO1a8lV3IuGUSVQUjBjk5ZxXLcmyo//Zn5MlifZKz+hJZcAZt2gUy
         eEWt+Pyo1nftXoqjZPt0fMeyG1FGQikgqD9pw2rGt8zeBhyqIPVcRlzsJyHWdIA5FTG6
         MiSArRZ9DsCLMNYH0Ar0r+vMBOpaNY2RaMutDp6RFoY4yXILYxZJIygral1PZA9HYZhl
         2gdQ==
X-Gm-Message-State: ABuFfoht/r2n+c8rI5Hs8zIvVZMiGeKVnjSAS18mXihQ7mquZ2shVp8o
        EGAy2Qc3H+4pNh4G2bklsQ==
X-Google-Smtp-Source: ACcGV62LzyFL8bX3Kk6oqb22SlxBI4x8QZqG2ZTt5oK36ux24gyboMLRnr3sVm+F1+shgZfrQe+lkw==
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr1952153oia.150.1538002544176;
        Wed, 26 Sep 2018 15:55:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 39-v6sm378580otz.67.2018.09.26.15.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:55:43 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:55:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 3/4] dt-bindings: arm: add compatible for i.MX6ULZ
 14x14 EVK board
Message-ID: <20180926225543.GA20330@bogus>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
 <1537337088-28819-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537337088-28819-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 14:04:47 +0800, Anson Huang wrote:
> This patch adds compatible for i.MX6ULZ 14x14 EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
