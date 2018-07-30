Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588B4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0380720870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0380720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeG3X3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:29:03 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39932 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbeG3X3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:29:03 -0400
Received: by mail-io0-f195.google.com with SMTP id o22-v6so11201369ioh.6;
        Mon, 30 Jul 2018 14:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1H+BcA2HG/Dg6QA5mPttHLMZF8sZZ6ieK2ah50dD/88=;
        b=bIGuzFfx2JPfHTxOX8OnrxQtK0WIYnr05Dg0ToOaCoEEP+abb43iNRdduGrN06G9U0
         O5MD3yUHyI0zCg3rY7VldPjG+Y71R0boCkETWzxRjo7nC8yT0yqsDzmrUP4FnXyhXa0p
         oqvLOdDZQ1Tuv7bL0TTJou39iBEoiwqx4lOKDh/eoEa8UsDejC43zvu//GFhZxmElUXW
         FoguIGjLxv5gw4PH60Z39iITVw9eshbgMNmLhI4kmmB2RFlr/fUqFZ2sjF7GSzYBL1u9
         fV1N+jbZWmCTR4RFekVBsd9DiyJqzo3PWmKxag30JpAmVhrnRiGt4JjBzTwqlU9V6ohv
         0YeQ==
X-Gm-Message-State: AOUpUlES2lheaAqvikLzs7G8ESOygxuj2RdejWohJcZClWt8oZF+rw+d
        YEonn8GpknONKAIs7ePYJQ==
X-Google-Smtp-Source: AAOMgpcNgwyxV0ZbefntYVBijXHbcislFSAI60CTP/Z6rBcD9YiHHXP0dWXSYRVVjoVZ7uBZSbDyHg==
X-Received: by 2002:a6b:1c07:: with SMTP id c7-v6mr16029141ioc.298.1532987524604;
        Mon, 30 Jul 2018 14:52:04 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m7-v6sm3722043iog.30.2018.07.30.14.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:52:03 -0700 (PDT)
Date:   Mon, 30 Jul 2018 15:52:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: Update dt binding name for
 apq8096
Message-ID: <20180730215203.GA4407@rob-hp-laptop>
References: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
 <1532945454-10437-3-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532945454-10437-3-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:40:52PM +0530, Rohit kumar wrote:
> Remove qcom prefix from machine driver dt bindings of
> apq8096 SoC.
> 
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,apq8096.txt | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
