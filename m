Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1765FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA65823FCB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA65823FCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeGEVcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:32:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33633 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbeGEVcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:32:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id c6-v6so19685729oiy.0;
        Thu, 05 Jul 2018 14:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VlTxtzaVEyPQuJ3MGxdyc2PfGqOyef+8mb5A0WEINFM=;
        b=dJukB51NH+1M+UZgquB9arZrguLn3bpq5xu9CBuhkKUu9tB39TDE/zX0je/st1i03E
         th5UVZrwPte5ot1mY5YIGT5HqFEjW32GAckMKPHiHWFUcD6jnde252ontmFbmQMj0Mwf
         U8vIO5wpcLleki0ur2gdX7oSzVt74DxIW1hGXo6mbCRsjdeiUcDR+wbphJfDrzsSwYVY
         Ctg2q9RCvgtJ0q8pRp1FAACE7QBdWe/onEoOEMUaVbM0V/5B8KKTXhT9skX43WQIUt3m
         f2oav/rZvxjgeDtVH0a5/mcXF2BwPsOXiX9VGqVi1N3VeleHWSlGIRmE6SEbLisV9Ers
         D89Q==
X-Gm-Message-State: APt69E24LkSZ3Jf0Lqtz026jAvTrcde9xs1c5oE+GWLcOcmGr52oV5Ld
        5CZIPckPoD1aBCTSmwr89Q==
X-Google-Smtp-Source: AAOMgpec5EmO/9VCqUmIELi4/FXh6ict1C8g0LjgggQC+Tm0WGlbbHnrQUQlk8Y6UH+5pPPtjI4Bvg==
X-Received: by 2002:aca:3045:: with SMTP id w66-v6mr9086612oiw.61.1530826360681;
        Thu, 05 Jul 2018 14:32:40 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id o65-v6sm4770487oia.35.2018.07.05.14.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 14:32:40 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:32:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: hx711: warning in dt binding example doc
Message-ID: <20180705213237.GA22282@rob-hp-laptop>
References: <20180704123719.GA30645@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704123719.GA30645@arbeit>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:37:19PM +0200, Andreas Klinger wrote:
> device tree compiler (dtc) gives a warning if a device node has "@" with a
> following number as it's name but no reg property.
> 
> fix the example in the documentation of avia,hx711 to conform to dtc
> behavior

Capitalization and punctuation needed.

The subject could be more specific. Perhaps "... fix spurious 
unit-address in example"

> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> index 4bee51d536e1..b218e093b55a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -18,7 +18,7 @@ Optional properties:
>  			high time of 50 microseconds.
>  
>  Example:
> -weight@0 {
> +weight {
>  	compatible = "avia,hx711";
>  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> -- 
> 2.1.4
