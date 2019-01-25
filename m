Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D984EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A648D21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="CTA64SVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfAYTZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:25:10 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33394 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYTZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548444308; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrAS6lQKg6nqeXPr8escVe6li1l1eadLaCMB+hHluVQ=;
        b=CTA64SVexfEd/P7ZdwOCrLHmc0zour6ZFsVo7WMqUeFWRfWp0coShzMQXHdIbM2RsTtTHy
        C4//aeoTIkdfpM2/r67iG49G/e4wUF901RghB7AnkwDNxGozE3jfRreRUr13BMPX9MHizG
        HvHhm88XMJyQArNHmJMaW8ewNQNej2Q=
Date:   Fri, 25 Jan 2019 16:24:58 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic: jz4740: Fix gating of UDC clock
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1548444298.1804.2@crapouillou.net>
In-Reply-To: <154844250661.136743.15303302299846585853@swboyd.mtv.corp.google.com>
References: <20190125153436.13517-1-paul@crapouillou.net>
        <154844250661.136743.15303302299846585853@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Fri, Jan 25, 2019 at 3:55 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Paul Cercueil (2019-01-25 07:34:36)
>>  The UDC clock is gated when the bit is cleared, not when it is set.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net 
>> <mailto:paul@crapouillou.net>>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu 
>> <mailto:contact@artur-rojek.eu>>
>>  ---
> 
> Any Fixes tag for this?
> 

Fixes: 2b555a4b9cae

Should I resend?


