Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B528FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8327D218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545239991;
	bh=wckdQZ9TCzcm+uUOS4j5/tzEL+ifDd89XahfbeOAXdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vX9s30wrPNS8eBT/TngW6CaElgkU0/68N04lve4ZzGbM6u8vhgz2lp7ka0aNGusfb
	 4njIFwJYFZLLlzejQ6bB2+XfcOUPdFWpqoY4hUgdMWVwT4ijQEabUe9tqjm3UA9aKA
	 IjFTphqR/1ygxGltb+H+3UKfnVX2SVIO/2zMtmbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeLSRTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:19:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42663 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeLSRTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:19:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so19785752otk.9;
        Wed, 19 Dec 2018 09:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IfBi3fo5kjS5XfEMoCoG1qMSAvm1cnRdTIIkMp2L8q0=;
        b=WMLunlURSN7w9+9+CsvAhEq09JJqk9+4ugW/tUloM5cgDH1mrBtXORrJZHTno5TYwo
         w3/pAaxK6RAVqmoZRqhLl6wyzeuI5MqcQNvJK+FFTf9EGG79dZs0Qi9mkQLuHiTp5c4E
         b2iFwdMD/PYesjCqg+Mzo0d+gNb+yHTl7SpzJhkGr3DAyL7WR4ocGNtDmnEBGh2UsPX8
         cYmbdd3SMheRCYowUrj5dVMakYfWRtKKrz/jLTWZM975l8brxLD1arA5EDt9FFL2xmow
         NL2vlOPeg4JTjw0qvvdnME1iGdvugf7B1ES8ofx4Wj4JchFt6czIByHl4qH+R2mC3py3
         z4xQ==
X-Gm-Message-State: AA+aEWa2IjnTyLZLWMHrd+211iAQyucfoSp0vJkx7dlSyiJT0gbDYdLn
        N23nmrltwPI/Obro6mb0og==
X-Google-Smtp-Source: AFSGD/VyeIyZKm3TDjtL+6cT7Gk53xWJixh5XFm13ILhUVaVLrUznzziJaEQxlK6QhRhCHVRCJwMCg==
X-Received: by 2002:a9d:2aa5:: with SMTP id e34mr14501129otb.67.1545239986954;
        Wed, 19 Dec 2018 09:19:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o16sm8837334otl.22.2018.12.19.09.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:19:46 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:19:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell,mmp2: fix a typo in bindings doc
Message-ID: <20181219171945.GA32656@bogus>
References: <20181203114748.637314-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203114748.637314-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:47:48PM +0100, Lubomir Rintel wrote:
> A trivial one, but it's annoying that copy & paste of the link
> doesn't work.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/clock/marvell,mmp2.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt b/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
> index af376a01f2b7..b0447d9896bc 100644
> --- a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
> +++ b/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
> @@ -18,4 +18,4 @@ Required Properties:
>  Each clock is assigned an identifier and client nodes use this identifier
>  to specify the clock which they consume.
>  
> -All these identifier could be found in <dt-bindings/clock/marvell-mmp2.h>.
> +All these identifier could be found in <dt-bindings/clock/marvell,mmp2.h>.

Really, should be: identifiers can be

> -- 
> 2.19.1
> 
