Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF65C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7575920880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7575920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeILMq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:46:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40177 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeILMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:46:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id x26-v6so804506lfi.7;
        Wed, 12 Sep 2018 00:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6M13bRV93nhRB9+fOf3zZVQiyWGch15Y3VxbgITVu+0=;
        b=moZ+LyHiEJnycj15lshJDeHs0fSLnPAhzBm6TM6ZlrGItB8kLkOx6TPo/5NvxuGwzi
         immfSxWfXD72OdEFySST0ny/6RS5sfBrhygJD66IcVAc3yqDGU0fyjQKCLBU/NPz/78o
         pxTJ+mGLC5T40Vz31/NsgPX6RXobrgrk5GZkU0W8teZ2r3cNABumH6yrRQzDHE7DLhQr
         8WDYiKTdJuAWJDGDsKNLW78ddma3sAehw3VRWV2jo7i/xPBHtZOIM1aF69jgT/j7oWBe
         7buMwMH3sApjzoja4c/sUw30HTcEfBvNgoDuCoe3wWVJg9zOVLCszKwWyEsewJn7sJjm
         Ij9g==
X-Gm-Message-State: APzg51D6kdrseFwspG0QtzCJDXCSGTSO/KNl8lkeqqVlUx/El3RBIzIP
        QtY1VOztZY9Hov5KnA7m6VM=
X-Google-Smtp-Source: ANB0VdbBGRnTQDcNfhSB01HgE5M7dfnTOQDAQJaA4G59Dc5c/5InndHA6VvPp4RU+5KR4BoJ4Ly7uQ==
X-Received: by 2002:a19:e21b:: with SMTP id z27-v6mr530712lfg.68.1536738189053;
        Wed, 12 Sep 2018 00:43:09 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k4-v6sm54134ljc.6.2018.09.12.00.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 00:43:08 -0700 (PDT)
Date:   Wed, 12 Sep 2018 10:43:06 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 4/8] mfd: dt bindings: add BD71847 device-tree binding
 documentation
Message-ID: <20180912074306.GC2381@localhost.localdomain>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <09eceb20f4f05ac48c6767d5f3359743e5b98985.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <20180911134947.GQ4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911134947.GQ4185@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:49:47PM +0100, Lee Jones wrote:
> On Wed, 29 Aug 2018, Matti Vaittinen wrote:
> 
> > Add ROHM BD71847 Power Management IC MFD binding information to
> > device-tree binding documents.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt       | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > index 3ca56fdb5ffe..d78172878faa 100644
> > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > @@ -1,16 +1,17 @@
> > -* ROHM BD71837 Power Management Integrated Circuit bindings
> > +* ROHM BD71837 and BD71847 Power Management Integrated Circuit bindings
> >  
> > -BD71837MWV is a programmable Power Management IC for powering single-core,
> > -dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
> > -low BOM cost and compact solution footprint. It integrates 8 Buck
> > -egulators and 7 LDOs to provide all the power rails required by the SoC and
> > -the commonly used peripherals.
> > +BD71837MWV and BD71847MWV are programmable Power Management ICs for powering
> > +single-core, dual-core, and quad-core SoCs such as NXP-i.MX 8M. They are
> > +optimized for low BOM cost and compact solution footprint. BD71837MWV
> > +integrates 8 Buck regulators and 7 LDOs. BD71847MWV contains 6 Buck regulators
> > +and 6 LDOs.
> >  
> > -Datasheet for PMIC is available at:
> > +Datasheet for BD71837 is available at:
> >  https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> >  
> >  Required properties:
> > - - compatible		: Should be "rohm,bd71837".
> > + - compatible		: Should be "rohm,bd71837" for bd71837 and
> > +			  "rohm,bd71847" for bd71847.
> 
> Nit: Probably sightly clearer as:
> 
> > + - compatible		: Should be "rohm,bd71837" for bd71837
> > +			                    "rohm,bd71847" for bd71847.

I think you're correct. I can change this while resending the series
anyways.

> 
> Apart from that:
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
