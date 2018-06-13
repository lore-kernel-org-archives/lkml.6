Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E17CDC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B88208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B88208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754566AbeFMTA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:00:26 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:60543 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeFMTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:00:25 -0400
Received: from belgarion ([90.55.202.35])
        by mwinf5d11 with ME
        id yK0K1x00h0mKt3N03K0Ke6; Wed, 13 Jun 2018 21:00:23 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 13 Jun 2018 21:00:23 +0200
X-ME-IP: 90.55.202.35
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ASoC: pxa: add binding for pxa2xx-ac97 audio complex
References: <20180611202211.15501-1-robert.jarzmik@free.fr>
        <20180612221359.GA26741@rob-hp-laptop>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 13 Jun 2018 21:00:19 +0200
In-Reply-To: <20180612221359.GA26741@rob-hp-laptop> (Rob Herring's message of
        "Tue, 12 Jun 2018 16:13:59 -0600")
Message-ID: <87y3fiqzp8.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Mon, Jun 11, 2018 at 10:22:10PM +0200, Robert Jarzmik wrote:
>> This adds a binding for the Marvell PXA audio complex, available in
>> pxa2xx and pxa3xx variants.
>> +Required properties:
>> +  - compatible: "marvell,pxa2xx-ac97"
>
> Don't use wildcards in compatible strings. Though this is so old...
Yes, I could use pxa270-ac97.

>> +  - reset-gpio: gpio used for AC97 reset, refer to gpio.txt
> reset-gpios
Right, I'm on it.

>> +		status = "okay";
>
> Don't show status in examples.
Sure.

Cheers.

-- 
Robert
