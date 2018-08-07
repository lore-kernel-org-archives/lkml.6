Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573FAC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8BC2151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8BC2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbeHGREs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:04:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40906 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbeHGREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:04:48 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so23288578ita.5;
        Tue, 07 Aug 2018 07:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5fcEFOPNeXboPGPaD1NnV9lHx//zzsS7yAB6xC3Makc=;
        b=WVGdSJhcYJYWhGPu6mcToF5Cea9BAMY8//fz3B/oH370ST5amVGRuzXfzuun1v0pTu
         3wt0j9wRo1lYiwdiw28bnyKM6K85WUTViQoKrrOcQ0FaQu5OwmLLNSk3Qhxj9WsNpoyC
         hR9LrFcYcgihvA3oSwCWc7WRSMGX0ov1tbnulbo76wtfMtSA6G070fGuootRP5ccgwlM
         e8P9C1ErO9zFuh25hzuVSlEPd7dhrO/PfcZBWRvTQlv/d3Ao+gss/wyr8TuVIGQ/7/6U
         /5dttEb6SCc5Th62N1laQFkKyPSwZnePW1K4m1WG1gb7V5t6LPSRA8T7rAlpxmwOb09f
         Y7EA==
X-Gm-Message-State: AOUpUlEpvkfkhDrI0ZhHEZiq0cR/1ZRnbBYVm8ROqhOv6KRhFrCroPpV
        fje+oPOin0AiOIwxwvtubQ==
X-Google-Smtp-Source: AA+uWPw/5tjgFO0AF/v2RlZBYykCNy30mgWDbdfzaQbTmrvbGYZr4q0gaKsvb9Jpghl/cT6DOsBkCQ==
X-Received: by 2002:a24:3ec3:: with SMTP id s186-v6mr2164396its.73.1533653407263;
        Tue, 07 Aug 2018 07:50:07 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z195-v6sm659072ioe.38.2018.08.07.07.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 07:50:06 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:50:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     linus.walleij@linaro.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-binding: pinctrl: Add NPCM7xx pinctrl and GPIO
 documentation
Message-ID: <20180807145005.GA25679@rob-hp-laptop>
References: <20180806152354.340380-1-tmaimon77@gmail.com>
 <20180806152354.340380-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806152354.340380-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 06:23:53PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM750/730/715/705 pinmux and GPIO controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt   | 216 +++++++++++++++++++++
>  1 file changed, 216 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt

Please add acked/reviewed-by's when posting new versions.

Rob
