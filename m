Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2468DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD18C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD18C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeIGViO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:38:14 -0400
Received: from muru.com ([72.249.23.125]:55458 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbeIGViN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:38:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0F5ED80CF;
        Fri,  7 Sep 2018 17:00:27 +0000 (UTC)
Date:   Fri, 7 Sep 2018 09:56:22 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
Message-ID: <20180907165622.GI5662@atomide.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820181333.2527-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180820 11:16]:
> 
> Convert modem related GPIO setup from integer space to GPIO descriptors.
> Also, restore original initialization order of the MODEM device and its
> related GPIO pins.
> 
> Cleanup of MODEM relaated regulator setup is postponed while waiting for
> upcoming conversion of fixed regulator API to GPIO descriptors.
> 
> 
> Janusz Krzysztofik (3):
>       ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
>       ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
>       ARM: OMAP1: ams-delta: register MODEM device earlier

Janusz, can you please repost this series based on v4.19-rc1
with Linus' acks?

At least the header file has moved around now.

And as this also conflicts with your earlier patch
"ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor"
please repost that too in the same series.

If you have other arch/arm/*omap*/* related patches then
please repost those too, these are the only ones I still had
tagged :)

Regards,

Tony

