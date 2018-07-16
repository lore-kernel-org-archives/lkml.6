Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D452ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CE22089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CE22089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeGPSbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:31:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44635 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeGPSbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:31:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so76490596oih.11;
        Mon, 16 Jul 2018 11:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IFSIZaap9CcHT33SS6w9FCGwD1aO0F8Q5WvdL7Km3G4=;
        b=R3AV024cpL5NhYkZtTcChMaN0/Qmn6iKc0cP/pHaAJwi222xFj+ctWZdlYWYVqHDed
         s4vvPlYoI+e4nUquItUo6IQCjVlDMh+cRt36DqOLxwCRUdQCf5Q8F03UCFeirijT1fAY
         pR1K876OYuMLD963aUTfOR/UCT630/Zgfzo8UXuKM2cDEzfToBb6UdmiTw9MET0hBQkI
         zGz153t/JsgzSCx7oHw5a5G8mcPy5ay6nMXMQkAEzBfpbYBjrIZxELI58xpW1leuhWZU
         kduTe9XY6PhQVAG9t67LENEy/oObUsk/HQ9okmDAj+oILMWAkm2fSELPqwvF3U3GhTVG
         MSVQ==
X-Gm-Message-State: AOUpUlFlE/HtLhpQADu5rLLvijhi5TWbUeV8F9MSLuFN7muZ07TP5A9Z
        XyVBX12zhG5PJsu8wOEeyg==
X-Google-Smtp-Source: AAOMgpdQbtsF+5pTJ1sx8lVPB26eWKqzA4LrKGzSq50UClj9oYWFFbrLtVCi0Ov3LeQvV0Li6CG2sg==
X-Received: by 2002:aca:91a:: with SMTP id 26-v6mr343706oij.33.1531764160171;
        Mon, 16 Jul 2018 11:02:40 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id w8-v6sm17869975oiw.10.2018.07.16.11.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 11:02:39 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:02:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] documentation: pinctrl: Add compatibles for
 Amlogic Meson G12A pin controllers
Message-ID: <20180716180238.GA19285@rob-hp-laptop>
References: <20180714232754.5402-1-yixun.lan@amlogic.com>
 <20180714232754.5402-2-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714232754.5402-2-yixun.lan@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 11:27:53PM +0000, Yixun Lan wrote:
> Add new compatible name for Amlogic's Meson-G12A pin controllers,
> add a dt-binding header file which document the detail pin names.
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/pinctrl/meson,pinctrl.txt        |   2 +
>  include/dt-bindings/gpio/meson-g12a-gpio.h    | 114 ++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h

Reviewed-by: Rob Herring <robh@kernel.org>
