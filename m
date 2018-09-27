Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8474C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4C420836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4C420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeI0Wok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:44:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33721 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeI0Wok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:44:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id m23-v6so3184348otf.0;
        Thu, 27 Sep 2018 09:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6lNSPq1NzHISnnKGCeyMQBcSDeAsJqEd4ij+yR8RpA=;
        b=L8H525dqE4gxzXyhAwKzeru5OatOPV3QuIDzCX+0v7T4sGFUSI34IdO1Jd4Oh81XKV
         WGBncxmhnltR0NQsBEL/34cGM/Wg5teE+GvgmhWckwEjY7sp7g30VI45jorGTT4Qua7+
         rSG1VcqBJtEllXfeNRdMPXw7icbH6XHguMtcs9f+8FQbFujbu9uNgA2Lkl2xt1rS5tfJ
         6Lng3nQa6YML0UywiwbWIdrrTnDbovd/vv7BWrKs0l9wQbORAR2OptA/HXaIqy7NfDDw
         hXzufefDoYoVfQjoFD1HrYaDt3A9gctxT+eBhh2Hjy44J3embG22jgz/A7+a7aPmx/Kj
         YaLQ==
X-Gm-Message-State: ABuFfog4eotccwodfQsL93Xs0/1niQrwKwtK6f6Ufp/ibMh3fUn4oa4H
        TjS2cA6dzI5xppx/ozu6+UPiMXG7jQ==
X-Google-Smtp-Source: ACcGV60ixZLaiLdAas1ug4LZ5JTMzsQ2c2mgDXuNuBKxnmdN/XTzKDSaersceN7HZulR3KNOO9sBFQ==
X-Received: by 2002:a9d:248:: with SMTP id 66-v6mr7737582otb.366.1538065538013;
        Thu, 27 Sep 2018 09:25:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e205-v6sm1097074oia.9.2018.09.27.09.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:25:37 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:25:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: pinctrl: renesas,rzn1-pinctrl:
 documentation
Message-ID: <20180927162536.GA16329@bogus>
References: <20180927135922.12015-1-phil.edworthy@renesas.com>
 <20180927135922.12015-2-phil.edworthy@renesas.com>
 <CAMuHMdV1n9KgU+6LxY3_jHTqgL1gKs+54yY0qjnwBeQX7UdOSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV1n9KgU+6LxY3_jHTqgL1gKs+54yY0qjnwBeQX7UdOSg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 05:15:54PM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 27, 2018 at 3:59 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> > The Renesas RZ/N1 device family PINCTRL node description.
> >
> > Based on a patch originally written by Michel Pollet at Renesas.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> > v6:
> >  - Instead of combining the pin nr and func into a single element, use
> >    a pair of 8-bit elements.
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
> 
> > +- Pin multiplexing sub-nodes:
> > +  A pin multiplexing sub-node describes how to configure a set of
> > +  (or a single) pin in some desired alternate function mode.
> > +  A single sub-node may define several pin configurations.
> > +  Please refer to pinctrl-bindings.txt to get to know more on generic
> > +  pin properties usage.
> > +
> > +  The allowed generic formats for a pin multiplexing sub-node are the
> > +  following ones:
> > +
> > +  node-1 {
> > +      pinmux = /bits/ 8 <PIN_NR MUX_FUNC>, <PIN_NR MUX_FUNC>, ... ;
> > +      GENERIC_PINCONFIG;
> > +  };
> 
> and
> 
> > +  Example:
> > +  A serial communication interface with a TX output pin and an RX input pin.
> > +
> > +  &pinctrl {
> > +       pins_uart0: pins_uart0 {
> > +               pinmux = /bits/ 8 <
> > +                       103 RZN1_FUNC_UART0_I   /* UART0_TXD */
> > +                       104 RZN1_FUNC_UART0_I   /* UART0_RXD */
> > +               >;
> > +       };
> > +  };
> 
> So the above is in response to Rob's comment on v4:
> 
> | > +#define RZN1_MUX(_gpio, _func) \
> | > +       (((RZN1_FUNC_##_func) << 8) | (_gpio))
> |
> | I'm not a fan of token pasting and it also goes against kernel style.
> | If every other Renesas platform is doing this, then fine. Otherwise,
> | you can express it in pretty much the same (source) space:
> |
> | pinmux = <RZN1_MUX_UART0_I 104>;
> |
> | Yes, this is 2 cells instead of 1, but if you care about space, you
> | can use 8 or 16 bit size.
> 
> I'm not so much impressed by the "/bits/ 8" part.
> No other pinctrl bindings uses this.
> We do have RZA1_PINMUX() and STM32_PINMUX() macros.

Yes, but those aren't doing token pasting which was my complaint here.

> Rob: Is this really what you intended?

Do whatever is most consistant. If you want a macro to shift fields, 
then fine.

Rob
