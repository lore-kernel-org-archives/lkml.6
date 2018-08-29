Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A73B2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A73B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeH2MIs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:08:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeH2MIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:08:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 571FB20795; Wed, 29 Aug 2018 10:13:06 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 206C4206EE;
        Wed, 29 Aug 2018 10:13:06 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     aditya@kobol.io,
        "thierry.reding\@gmail.com" <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list\:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>, gauthier@kobol.io,
        Alban Browaeys <alban.browaeys@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dennis@ausil.us, Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM lines per GPIO chip
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
        <1533522556-55055-2-git-send-email-aditya@kobol.io>
        <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
Date:   Wed, 29 Aug 2018 10:13:05 +0200
In-Reply-To: <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
        (Linus Walleij's message of "Wed, 29 Aug 2018 09:54:04 +0200")
Message-ID: <87in3tk2um.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
 
 On mer., août 29 2018, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Aug 6, 2018 at 4:31 AM Aditya Prayoga <aditya@kobol.io> wrote:
>
>> Allow more than 1 PWM request (eg. PWM fan) on the same GPIO chip.
>>
>> based on initial work on LK4.4 by Alban Browaeys.
>> URL: https://github.com/helios-4/linux-marvell/commit/743ae97
>> [Aditya Prayoga: forward port, cleanup]
>> Signed-off-by: Aditya Prayoga <aditya@kobol.io>
>
> It would be awesome to get some feedback from the MVEBU maintainers
> on this patch set.

There already has been reviewed from Andrew and also from Richard who
worked on the PWM part too. There were many questions raised, but no
feedback yet, so for now this patch set is clearly not ready to be
merged. We are waiting for answers and a new version.

Gregory

>
> Who are most active on Marvell stuff these days? Thomas?
>
> Likewise I'd be very grateful for a nod from the PWM maintainer that
> this is OK with him.
>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
