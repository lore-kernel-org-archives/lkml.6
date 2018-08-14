Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7601CC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2444F214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2444F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbeHNTL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:11:57 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40340 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:11:57 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so20503740ita.5;
        Tue, 14 Aug 2018 09:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xA9mdI8PTonEBfemx4V/LcuTt+1BHJbwGYN1o4fLQSg=;
        b=U33+gvAQqDqotIIbPX/Yg5NbI9db+dYMQfNmFvp1H05NRl/XQKWOoZy8QS75SZlrZv
         G2GhDHCfCy0PSWdacElR+YySTeLYejWrvLRB5wyWPlmkDXf0zEe2JhJtpCp5uO2MvPE9
         esvy5E8IBPWXsT7kF2djIPsGXlxi9lmcikuBpHRYENEkiUtUIGoT5b+8EE4neCiOhCIJ
         5rixTV8Gagl7FDrDIHIbpvv7PzYQHp+3ySKxEULfyATodmr16UKb0A8bbGjk7g4VQsxg
         k+NE3pdD+pp3vBvSCCzp1G3QacY1WPCN67H/PEdOPY5SxEUZyD8/dFjW1oDTbQBSFJBK
         ffvQ==
X-Gm-Message-State: AOUpUlGstiQJBOMDx5e8wusbZuzt3vavaurS7ytT/6ERX3nhPSziGsya
        pnWH4V+bzX5nBrm+rx0r4A==
X-Google-Smtp-Source: AA+uWPxK+a89h+Q8Z1o+evXVH9j9jcTeCp81tuMPaF3ZUaJ2wMHu8UAHhzF8OBNifL6U0SueimFNVQ==
X-Received: by 2002:a02:6901:: with SMTP id e1-v6mr19560714jac.62.1534263847305;
        Tue, 14 Aug 2018 09:24:07 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 14-v6sm7737579itu.20.2018.08.14.09.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 09:24:06 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:24:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lee.jones@linaro.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: Applied "ASoC: dt-bindings: add dt bindings for wcd9335 audio
 codec" to the asoc tree
Message-ID: <20180814162405.GA450@rob-hp-laptop>
References: <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
 <20180801112020.93C4A1124241@debutante.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801112020.93C4A1124241@debutante.sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 12:20:20PM +0100, Mark Brown wrote:
> The patch
> 
>    ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
> 
> has been applied to the asoc tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

Why is this applied when I had requested changes?

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
