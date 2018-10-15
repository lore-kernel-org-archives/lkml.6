Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C5FC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7852089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7852089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeJPAOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:14:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39375 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:14:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id y81-v6so15555134oia.6;
        Mon, 15 Oct 2018 09:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QCu88+v/rKrYw8FDqVth5v2B9w0vxnZsMmrohbeeyfw=;
        b=i1n+gQHrHlbGmIoX99QCDJaBfh31muinBi8lTN3wItXsf4HPXTALTYBH18MHEpsBI2
         RW7FzMcTObtomAJ9aSvSTAIi7OnID7PNCO74zYvzU2VGwrG3vIOkdD0bhyMwBG+fRbaf
         cGtecTw1pTTRexv7xuUkQce9FgrpCuU3D3SZZASroXagKb1kfD5VwvpjYj1SPges4Mw8
         wH5lrUMg2xVxttISM00sqrVRDYsG8+krPNjryATtX/YjvC8VWSe68LsyLcGQCsr4+4ps
         B4KOB5xBpAiUVVF0ZlUocCw3fNJOObENW9RDlW3INxKekcYXcvXjHSxahthYq3hmRYwq
         squw==
X-Gm-Message-State: ABuFfoh+JVoFWdw9tlluLtPORvVKOk0DozLau4WmAeF2swBs42RUplZd
        8uB9W4pN0LyuJ8/APlI+uA==
X-Google-Smtp-Source: ACcGV60D3v/heDp/PGG2JKQUn3cJ+DlIaf1sMQbzQ1vJnm1rTjY56IPz5dYAp8g5zZ672ulZEF+SPQ==
X-Received: by 2002:aca:dfc3:: with SMTP id w186-v6mr9889955oig.331.1539620917475;
        Mon, 15 Oct 2018 09:28:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r33sm4368708otc.37.2018.10.15.09.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 09:28:36 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:28:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/HISILICON SOC SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
Message-ID: <20181015162835.GA20955@bogus>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:03:06AM +0200, Daniel Lezcano wrote:
> Add the interrupt names for the sensors, so the code can rely on them
> instead of dealing with index which are prone to error.
> 
> The name comes from the Hisilicon documentation found on internet.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../bindings/thermal/hisilicon-thermal.txt         |  3 ++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi          | 63 +++++++++++-----------
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  1 +
>  3 files changed, 36 insertions(+), 31 deletions(-)

Lots of whitespace errors reported by checkpatch.pl.

> 
> diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> index cef716a..3edfae3 100644
> --- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> @@ -7,6 +7,7 @@
>    region.
>  - interrupt: The interrupt number to the cpu. Defines the interrupt used
>    by /SOCTHERM/tsensor.
> +- interrupt-names: The interrupt names for the different sensors

Need to define what the names are.

>  - clock-names: Input clock name, should be 'thermal_clk'.
>  - clocks: phandles for clock specified in "clock-names" property.
>  - #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
> @@ -18,6 +19,7 @@ for Hi6220:
>  		compatible = "hisilicon,tsensor";
>  		reg = <0x0 0xf7030700 0x0 0x1000>;
>  		interrupts = <0 7 0x4>;
> +		interrupt-names = "tsensor_intr";

That name seems pretty pointless.

>  		clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
>  		clock-names = "thermal_clk";
>  		#thermal-sensor-cells = <1>;
> @@ -28,5 +30,6 @@ for Hi3660:
>  		compatible = "hisilicon,hi3660-tsensor";
>  		reg = <0x0 0xfff30000 0x0 0x1000>;
>  		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tsensor_a73";

Just 'a73' is sufficient.

>  		#thermal-sensor-cells = <1>;
>  	};
