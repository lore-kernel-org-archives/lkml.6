Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E733C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3CD214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3CD214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeIZVKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:10:14 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.131]:15146 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIZVKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:10:13 -0400
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PCEdNZ1JosR9A8+EnwdTNhIEa3LxU1dwv15qr4="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:24d1:c900:7e56:f2b:35d9:ddc0]
        by smtp.strato.de (RZmta 44.2 AUTH)
        with ESMTPSA id y02093u8QEii0zq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 26 Sep 2018 16:44:44 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
To:     ulf.hansson@linaro.org, hdegoede@redhat.com,
        quentin.schulz@free-electrons.com
Cc:     gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        shawn.lin@rock-chips.com, adrian.hunter@intel.com,
        baolin.wang@linaro.org, maxime.ripard@free-electrons.com,
        thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org,
        icenowy@aosc.xyz, wens@csie.org
References: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
In-Reply-To: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
Message-ID: <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
Date:   Wed, 26 Sep 2018 16:44:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
> [...]
>
> >> > I'd like to know if any progress has been made on that problem 
(I may
> >> > have missed patches).
> >> > Had you had the time to look at the issue?
> >>
> >> I have looked at the issue, but not manage to cook some patches 
for it.
> >>
> >> However, it's on my top of my TODO list for mmc. No promises, but
> >> perhaps and hopefully I manage to get something posted during the
> >> coming release cycle.

I would be interested in a ESP8089 driver in mainline and that's why I 
want to pick up this discussion.

What is the current status of the "mmc_reprobe_device" implementation, 
that Hans was explaining and Ulf wanted to provide some months ago?

BTW, I am not on any of the mailing lists involved, so I tried to 
recreate the proper mail headers manually for the reply to the correct 
thread.

Thanks,
Frieder

> >>
> >
> > Cool! If you ever need some testing, I'd be glad to test your patches
> > (even if they are in a draft/RFC state).
> >
> > Also, when you send patches, I'd appreciate being Cc'ed so that I can
> > put my Tested-by :) Thanks!
>
> Absolutely! I appreciate it.
