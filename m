Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C7C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E08921836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeLPJhA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 04:37:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55759 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbeLPJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 04:36:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8382320BE1; Sun, 16 Dec 2018 10:36:56 +0100 (CET)
Received: from localhost (vfc69-4-88-175-133-2.fbx.proxad.net [88.175.133.2])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4393E206FF;
        Sun, 16 Dec 2018 10:36:46 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v2 0/5] Add CPU clock support for Armada 7K/8K
References: <20181206171516.15891-1-gregory.clement@bootlin.com>
        <154482536298.19322.16460657058404864070@swboyd.mtv.corp.google.com>
Date:   Sun, 16 Dec 2018 10:36:46 +0100
In-Reply-To: <154482536298.19322.16460657058404864070@swboyd.mtv.corp.google.com>
        (Stephen Boyd's message of "Fri, 14 Dec 2018 14:09:22 -0800")
Message-ID: <87h8fdke35.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On ven., déc. 14 2018, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Gregory CLEMENT (2018-12-06 09:15:11)
>> Hello,
>> 
>> This is the second version of a series allowing to manage the cpu
>> clock for Armada 7K/8K. For these SoCs, the CPUs share the same clock
>> by cluster, so actually the clock management is done at cluster level.
>> 
>> As for the other Armada 7K/8K clocks it is possible to have multiple
>> AP so here again we need to have unique name: the purpose of the second
>> patch is to share a common code which will be used in 3 drivers.
>> 
>> The last 2 patch enable the driver at dt and platform level and will
>> be applied through the mvebu subsystem.
>  
> The binding "marvell,ap806-cpu-clock" is not documented. It was in the
> previous series but then got dropped from this one? Why?

I made a mistake and start my git-format on the wrong commit, I am
sending a new series right now with this missing patch.

Gregory

>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
