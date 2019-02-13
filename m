Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E340C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47118222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390914AbfBMI5K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:57:10 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49653 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfBMI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:57:08 -0500
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8C44EE0012;
        Wed, 13 Feb 2019 08:57:04 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 0/6] Add CPU clock support for Armada 7K/8K
In-Reply-To: <875zuwo4fi.fsf@FE-laptop>
References: <20181216094147.6468-1-gregory.clement@bootlin.com> <87a7k8o5d5.fsf@FE-laptop> <154713766177.15366.14948014236046606980@swboyd.mtv.corp.google.com> <875zuwo4fi.fsf@FE-laptop>
Date:   Wed, 13 Feb 2019 09:57:04 +0100
Message-ID: <871s4c5an3.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On jeu., janv. 10 2019, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hi Stephen,
>  
>  On jeu., janv. 10 2019, Stephen Boyd <sboyd@kernel.org> wrote:
>
>> Quoting Gregory CLEMENT (2019-01-10 08:16:22)
>>> Hi Stephen,
>>>  
>>>  On dim., déc. 16 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>>> 
>>> > Hello,
>>> >
>>> > This is the third version of a series allowing to manage the cpu
>>> > clock for Armada 7K/8K. For these SoCs, the CPUs share the same clock
>>> > by cluster, so actually the clock management is done at cluster level.
>>> >
>>> > As for the other Armada 7K/8K clocks it is possible to have multiple
>>> > AP so here again we need to have unique name: the purpose of the second
>>> > patch is to share a common code which will be used in 3 drivers.
>>> >
>>> > The last 2 patch enable the driver at dt and platform level and will
>>> > be applied through the mvebu subsystem.
>>> 
>>> What is the status of this series?
>>> 
>>> The only comments I had was from Rob about the binding and I answered
>>> them 3 weeks ago. Do you have any other comments? Do you expect a rebase
>>> of this series on v5.0-rc1?
>>> 
>>
>> I'm waiting for Rob. I think the binding is not proper so presumably you
>> will figure out what Rob wants and then change the code accordingly and
>> resend?
>
> Actually the binding describes properly the hardware we have and that
> what I answered to Rob.

I pinged you about this series more than one month ago, and answered Rob
concerned 2 months ago! He didn't said anything about my comments so I
really think that the binding is OK and described the hardware we have.

So could you consider to apply this series?

Thanks,

Gregory


>
> Gregory
>
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
