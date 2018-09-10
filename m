Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E1C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A17C20658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A17C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeIKA5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:57:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32990 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeIKA5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:57:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so42712008oip.0;
        Mon, 10 Sep 2018 13:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9b2kgy6fLu6MHSqqMa1TC1PMZ9B5IiYhv0QKlG5rCw=;
        b=S4Nfwi26JYB/kLqASwnVFMU7SuLBOsjupH5uZtVCMNnVZ2sc7FqK/sKD4FRa/bKGKg
         U7Ezp/xE8rAzqkSmWHGTIpqN83txM9+zNLypLfHckfHAHGbI3LH92b71xO7SrdGjM8nP
         sCERcuo2RQhTSeZXkVLARXYkXtl/L4PEkwRVafL8Q6EpqH/qYxxSGy3B8ZsxPWjbwhEZ
         c1gHoFdW5Vw1zzZRFVIeL66QZtn5noLhSpINnQlbOWCBBbWK+Nf6FNCa8CRlBAnFYVnv
         OXv68DlS8jM70DdV7MquTat7aSgScIS5owf2lpEjChRMwnBI/VLsjLZYVzcneJLssXOy
         Q7WQ==
X-Gm-Message-State: APzg51D950r+6Rpa8nQI6cZTsPGol5tU+B8bAuwmxMY6qgi//j4JMY2v
        njfzS96pkVElz5fJbJYRp01qTp4=
X-Google-Smtp-Source: ANB0Vdbb4WmYjR4/xXFmj56C2xSKEs/icouUsj767ZXMgm3KOsmeUQUjblHXwUo6h6vIP3zxQfW2aQ==
X-Received: by 2002:a54:4010:: with SMTP id x16-v6mr24200135oie.228.1536609730529;
        Mon, 10 Sep 2018 13:02:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i3-v6sm11128167oiy.12.2018.09.10.13.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:02:09 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:02:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 01/13] ASoC: dt-bindings: update wcd9335 bindings.
Message-ID: <20180910200208.GA20640@bogus>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904102500.30318-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Sep 2018 11:24:48 +0100, Srinivas Kandagatla wrote:
> This patch updates wcd9335 bindings with recommended properties.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,wcd9335.txt         | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
