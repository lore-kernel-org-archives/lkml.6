Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 920E7C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4237B20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4237B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934736AbeFKTyU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:54:20 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:27736 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934713AbeFKTyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:54:18 -0400
Received: from belgarion ([90.55.202.35])
        by mwinf5d72 with ME
        id xXuC1x0060mKt3N03XuCfU; Mon, 11 Jun 2018 21:54:17 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 11 Jun 2018 21:54:17 +0200
X-ME-IP: 90.55.202.35
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Vinod Koul <vinod.koul@linaro.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND v2] dmaengine: pxa: add a default requestor policy
References: <20180530201249.26972-1-robert.jarzmik@free.fr>
        <878t7oruya.fsf@belgarion.home> <20180611042125.GD2452@vkoul-mobl>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 11 Jun 2018 21:54:12 +0200
In-Reply-To: <20180611042125.GD2452@vkoul-mobl> (Vinod Koul's message of "Mon,
        11 Jun 2018 09:51:25 +0530")
Message-ID: <8736xtrtej.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod Koul <vinod.koul@linaro.org> writes:

> On 09-06-18, 14:43, Robert Jarzmik wrote:
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> 
>> > As what former drcmr -1 value meant, add a this as a default to each
>> > channel, ie. that by default no requestor line is used.
>> >
>> > This is specifically used for network drivers smc91x and smc911x, and
>> > needed for their port to slave maps.
>> >
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> > ---
>> > Since v1: changed -1 to U32_MAX
>> Hi Vinod,
>> 
>> Could I have your ack on this so that I add this one to the dma slave map serie
>> after the merge window is closed please ?
>
> Sorry I was thinking it would go thru dmaengine tree, please do
> indicate if that is not the case. Nevertheless
>
> Acked-by: Vinod Koul <vkoul@kernel.org>
Thanks.

As this is a dependency to the serie, I'd rather take it, unless you insist, in
which case I'll rely on the fact that it will hit 4.19 cycle.

Cheers.

-- 
Robert
