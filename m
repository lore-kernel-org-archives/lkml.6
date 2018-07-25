Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54434C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8F420843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8F420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeGYSlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:41:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33051 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbeGYSlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:41:15 -0400
Received: by mail-it0-f68.google.com with SMTP id d16-v6so144307itj.0;
        Wed, 25 Jul 2018 10:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VZ/3ZcZv4Pw98euhzz71HBLA3BQxEFJJldG9tQUiGrE=;
        b=Oq5/p9VOm8sz3iQDNTwR1LjKh4SMzcDSjoZELUVa6lhdb7NyN5rfn8lfIj7XQQ1/2V
         +ezhkTJQVsqFcMad3+GdNCEcLJn5qX6TTo+c8jJkT7TBjWwlXuqnmOaGaaNCJMYRgNUH
         p3kwi3N5hJK1BvB7gVXdT/PWTNJADrvmhYIKPVha5QGGS78Tg7a34EoqORGk10FiS7r0
         JFUYM9DAK5akkKXoNT5Bjnrg01ssngZuy0nFGApHs4hylpkk5wEH6fxz7jQwLZUtbH0D
         DaHKt7iCMXUVDqTJ9o+A5LlsFBQitkzUal/pXsPAFFGo3ofmNYWZ2MAvHOKTQqckI7cN
         9ZjQ==
X-Gm-Message-State: AOUpUlGXqGHNaLhrRWKfzthrJnHAzE4LXPYkfY1WEU2abMsXb/OjtbzZ
        l68NqCVfEIsVrSV+PCmf6g==
X-Google-Smtp-Source: AAOMgpdlD0ZmAraBJetO72/HMYreOL+qSSWZ2I3CVJXv1foF6BtyeFSEuK2gr2mGU9UHevvQ4pUP3w==
X-Received: by 2002:a24:97cd:: with SMTP id k196-v6mr6647324ite.93.1532539716562;
        Wed, 25 Jul 2018 10:28:36 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id n127-v6sm2867818itn.7.2018.07.25.10.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:28:36 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:28:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] pinctrl: tegra: fix spelling in devicetree binding
 document
Message-ID: <20180725172835.GA15950@rob-hp-laptop>
References: <20180720082258.1590-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720082258.1590-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:22:57AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes a spelling mistake.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Also fix up the one in nvidia,tegra210-pinmux.txt as suggested by Jon.
> 
>  Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt | 2 +-
>  Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied.

Rob
