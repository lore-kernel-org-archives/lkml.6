Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657BCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D0B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D0B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbeG3X20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:28:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40898 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbeG3X20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:28:26 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so1417669ita.5;
        Mon, 30 Jul 2018 14:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pmO2bAKUIYD4QFUHlvMYb191vLB893nLHjxb5JGTIT0=;
        b=le+KnOXxlEW4tjKj71VKqPbapAqoD4zEXivjzkZdvLglI0mvADWx/qO/2+KxKfCsX1
         MJGdPiT8JETqurBY/wzODSwu8eFfz8mjoIyE/ZtQlMLx/iWnYkJHLRmQHfvd+SkJnPgx
         6/NzMhbpZ+I62yDQYyS6G/Zie04pdOhExNoBqWvCMurDtdT5asNVXz39tSyvtrv4uODq
         l0k+w/kkZC2wHYeeA8LydgY4wZNdgcc8VoOI0m1q3VtwvxFfOT3FrYMxz9OZl0leaAz2
         HwLtumAifOYRHnna6C8SRODD2S8esyj80tZcA6r/GstiMCBmOLAudtX2xFE2c0PapYqZ
         wydQ==
X-Gm-Message-State: AOUpUlGmxJUTvkWlAfs7uunJWgdBoe60fwNJynKCXtvjyLi6K1q5u6uT
        4xicGgj3rnBZL6MOxfCtyw==
X-Google-Smtp-Source: AAOMgpf6Qjts2pu5odhKe71mMCblHPbYPrwERhOVInXMcVCKaPA+HrxOHiyib40KNg8Y8hyxib5jwA==
X-Received: by 2002:a24:7c4a:: with SMTP id a71-v6mr936076itd.69.1532987487991;
        Mon, 30 Jul 2018 14:51:27 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id g10-v6sm3717395ioq.87.2018.07.30.14.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:51:27 -0700 (PDT)
Date:   Mon, 30 Jul 2018 15:51:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ASoC: qcom: dt-bindings: Add sdm845 machine
 bindings
Message-ID: <20180730215126.GA2167@rob-hp-laptop>
References: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
 <1532945454-10437-2-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532945454-10437-2-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:40:51PM +0530, Rohit kumar wrote:
> Add devicetree bindings documentation file for SDM845 sound card.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,sdm845.txt      | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt

Reviewed-by: Rob Herring <robh@kernel.org>

