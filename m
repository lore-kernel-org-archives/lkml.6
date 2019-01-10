Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56259C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27731206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfAJQgq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:36:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52598 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfAJQgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:36:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4945820A08; Thu, 10 Jan 2019 17:36:43 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr [109.213.145.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0B28220898;
        Thu, 10 Jan 2019 17:36:33 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 0/6] Add CPU clock support for Armada 7K/8K
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
        <87a7k8o5d5.fsf@FE-laptop>
        <154713766177.15366.14948014236046606980@swboyd.mtv.corp.google.com>
Date:   Thu, 10 Jan 2019 17:36:33 +0100
In-Reply-To: <154713766177.15366.14948014236046606980@swboyd.mtv.corp.google.com>
        (Stephen Boyd's message of "Thu, 10 Jan 2019 08:27:41 -0800")
Message-ID: <875zuwo4fi.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On jeu., janv. 10 2019, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Gregory CLEMENT (2019-01-10 08:16:22)
>> Hi Stephen,
>>  
>>  On dim., déc. 16 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>> 
>> > Hello,
>> >
>> > This is the third version of a series allowing to manage the cpu
>> > clock for Armada 7K/8K. For these SoCs, the CPUs share the same clock
>> > by cluster, so actually the clock management is done at cluster level.
>> >
>> > As for the other Armada 7K/8K clocks it is possible to have multiple
>> > AP so here again we need to have unique name: the purpose of the second
>> > patch is to share a common code which will be used in 3 drivers.
>> >
>> > The last 2 patch enable the driver at dt and platform level and will
>> > be applied through the mvebu subsystem.
>> 
>> What is the status of this series?
>> 
>> The only comments I had was from Rob about the binding and I answered
>> them 3 weeks ago. Do you have any other comments? Do you expect a rebase
>> of this series on v5.0-rc1?
>> 
>
> I'm waiting for Rob. I think the binding is not proper so presumably you
> will figure out what Rob wants and then change the code accordingly and
> resend?

Actually the binding describes properly the hardware we have and that
what I answered to Rob.

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
