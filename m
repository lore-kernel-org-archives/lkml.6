Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D23ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F302721522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F302721522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbeIUDuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:50:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55745 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:50:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3C2198075A; Fri, 21 Sep 2018 00:04:44 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:04:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20180920220443.GB27468@xo-6d-61-c0.localdomain>
References: <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
 <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
 <20180914081822.GA21830@amd>
 <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com>
 <20180914214220.GA2081@amd>
 <be2ee681-7ae0-6545-0208-6ae5c1b7affd@gmail.com>
 <5a249ae3-e3f7-8eff-4022-ed982e364326@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a249ae3-e3f7-8eff-4022-ed982e364326@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> Easy to maintain will be a dedicated LED class driver.
> >>
> >> You mean, 3 dedicated LED class drivers and 3 MFD drivers with LED
> >> parts? We'll need complex driver anyway, and I'd really like to have
> >> just one.
> > 
> > In the LED subsystem we can wrap common functionalities
> > into a library object. MFD driver will be able to reuse it then.
> 
> I am currently working on that code now.  I expect a RFC on this this week.

Looking forward to that.

But you really need acks for the bindings, and since Rob is usually quite slow
acking them, it is easiest to use the existing binding... if it is wrong it
needs to be fixed, anyway.

THanks,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
