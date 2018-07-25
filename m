Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC0C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39BF20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39BF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeGYRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:16:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36652 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeGYRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:16:29 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so9392129itp.1;
        Wed, 25 Jul 2018 09:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oeRGLOJ6sUYRQdG0hQtbtFiyYvrK3+lhe2pdw2PfEmk=;
        b=TPC0qEuwZcy+XMXYJ80opZisQmLpjARqIA8I1CWtyBWB8smikjWDUNsMOsruAgEIx6
         oSb5YNKVGWPakDcR3zxYw9g7BpYJi75jWS4c94DB2/KYZNEX7TR+7vwom8yR7JSDfCC6
         RtiTp+yMIL9aaSO57fuzeeczLkiyYVeF8rY6AoXxXyUv5fBZz9GP+A8GBLEE5uU2bO/O
         OIWB9Tzh/7C5jGMNaoVH3kXJMvKoIU3WEJKWTIjXSiE7AdErXbGYlOpgiDsJISsAzahy
         PHaxsaZ7vh4g9UVWNiebXEFEinjRw771rRj/hx3+cq6sJNe8w+LqBGjw/SShLUX02x99
         84AA==
X-Gm-Message-State: AOUpUlGs/rZksh1DFeI1dcTh67QIZU7vH6yl7Zz4MUzjRHvxDLQGEhmh
        Z4I69vcRWLL6Wxp7tRZrqD1IoOc=
X-Google-Smtp-Source: AAOMgpdcANkAkHVjXfKTVDZ7E1QK1eg9BjV3gewJvEt1G3jXI1E7NwGjplybx8KHPhNKtBwKiV6wKg==
X-Received: by 2002:a24:b71a:: with SMTP id h26-v6mr6829667itf.37.1532534650556;
        Wed, 25 Jul 2018 09:04:10 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id t64-v6sm2847335ita.13.2018.07.25.09.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 09:04:10 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:04:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: pinctrl: berlin: document AS370 SoC
 pinctrl
Message-ID: <20180725160409.GA20922@rob-hp-laptop>
References: <20180718135613.1c559b9c@xhacker.debian>
 <20180718135709.35128a54@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718135709.35128a54@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 01:57:09PM +0800, Jisheng Zhang wrote:
> Add as370 to existing berlin pinctrl device tree binding.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
