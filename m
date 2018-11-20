Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A28C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914CB20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914CB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbeKTRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:42:02 -0500
Received: from ms.tdt.de ([195.243.126.94]:42764 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbeKTRmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:42:02 -0500
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 177C9204CA;
        Tue, 20 Nov 2018 07:14:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Nov 2018 08:14:23 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>, piotr.krol@3mdeb.com,
        Eckert.Florian@googlemail.com, Darren Hart <dvhart@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] gpio: Add driver for PC Engines APU boards
In-Reply-To: <CACRpkdZx-GgfgfGmB6KmTjzBEMnKyq3pUsHsgaZ1uBooN_sj9g@mail.gmail.com>
References: <20181115133201.29092-1-fe@dev.tdt.de>
 <20181115133201.29092-2-fe@dev.tdt.de>
 <CACRpkdZx-GgfgfGmB6KmTjzBEMnKyq3pUsHsgaZ1uBooN_sj9g@mail.gmail.com>
Message-ID: <80375fc16119693c868b2896bcc3c26b@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus

>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> 
> This is looking better and better! Thanks to everyone helping out
> and thanks for your perseverance Florian!
> 

I have to thanks for reviewing my driver.
This is the way opensource works.

Thanks for the feedback i will update the driver with your suggestions.

   - Florian

