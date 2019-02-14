Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81619C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5396B222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437193AbfBNHPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:15:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39276 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbfBNHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:15:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id g80so4289117ljg.6;
        Wed, 13 Feb 2019 23:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5dfQ3LkH9ayPR2Af0cmF4zAdTTMzcYz6cLIrbfnS4DQ=;
        b=AsaPgUBUw4ybyJeI9cIjjWz8cL/OnPirfGyHuSnqScT9aPSQc269HeO7SWBH1Bibm5
         fv2zjdAbiEN2uwYQIRebIwLcqecKofi9Fx5Wwb6FjLpNpFF22wdU+4NjPf1juY50Uba1
         n4ULIR7jRCKNqhVTZo4TL5FpcZ72LpatSnwJahJoHGD+JcxuE5vZ8j9xteY7FcwO6DpU
         zae69X25d5MKPuvnDBaaXdYTBZzUD8tQ4JCwRHjiiXC0WPzbyig1m6NoryFIciondWnP
         Nm3NzplEVfl0e4VqOdPWyIB2+MWdldJYySH2HQKKEUAQ7UZTh5DyX/issjK/QB6wZ3bQ
         L/+A==
X-Gm-Message-State: AHQUAuawSuQQfb/kmC+yU9nHf9fdRncaQkN5Sw7Mv70W+lYGcv8MAUhr
        SMRnr8PjEMiuJBz/kE7p0bc=
X-Google-Smtp-Source: AHgI3Iagqqtog6huzhVk53gPNbIOc5PvapC/8xXp8SsTpq1aKoeB9qu7NWb8txzsu5/8/g3mCUI4dg==
X-Received: by 2002:a2e:899a:: with SMTP id c26-v6mr1319082lji.94.1550128550972;
        Wed, 13 Feb 2019 23:15:50 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x2sm105855ljj.79.2019.02.13.23.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 23:15:50 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:15:47 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/3] devicetree: bindings: bd718x7: document HW state
 related ROHM specific properties
Message-ID: <20190214071547.GD12247@localhost.localdomain>
References: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
 <501fe1a68a9ad0987ddc0d3f559b2bdd1f65a5b7.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
 <044d28c6ea1f9dd58f4c1942411aaf58@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044d28c6ea1f9dd58f4c1942411aaf58@www.akkea.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Angus,

Glad to hear from you again =)

On Wed, Feb 13, 2019 at 03:38:40PM -0800, Angus Ainslie wrote:
> > 
> >  Optional properties:
> >  - clock-output-names	: Should contain name for output clock.
> > +- rohm,reset-snvs-powered : Transfer BD718x7 to SNVS state at reset.
> > +
> > +The BD718x7 supports two different HW states as reset target states.
> > States
> > +are called as SNVS and READY. At READY state all the PMIC power outputs
> > go
> > +down and OTP is reload. At the SNVS state all other logic and external
> > +devices apart from the SNVS power domain are shut off. Please refer to
> > NXP
> > +i.MX8 documentation for further information regarding SNVS state. When
> > a
> > +reset is done via SNVS state the PMIC OTP data is not reload. This
> > cause
> > +
> 
> It looks like there is some text missing here.

Actually, the "This cause" is a leftover from previous version. So
nothings missing, just something extra :D But well spotted. I'll clean
this up for next version!

> > diff --git
> > a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> > b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> > index 4b98ca26e61a..4a05cbf915ee 100644
> > ---
> > a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> > +++
> > b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
> > @@ -27,8 +27,38 @@ BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6
> >  LDO1, LDO2, LDO3, LDO4, LDO5, LDO6
> > 

[...]

> > +----------------------------------------------------------------------------
> > +rest	| not supported		| not supported		| not supported
> > +
> >  Example:
> 
> Could you add an example of the optional properties ?

Sure. I'll do that for next version as well :)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
