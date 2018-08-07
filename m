Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D73C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2AE214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2AE214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbeHGNcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:32:24 -0400
Received: from ms.tdt.de ([195.243.126.94]:56031 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387428AbeHGNcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:32:24 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 41F7321804;
        Tue,  7 Aug 2018 11:18:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Aug 2018 13:18:31 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: Add driver for PC Engines APU2/APU3 GPIOs
In-Reply-To: <1846152.TW98f23PIX@debian64>
References: <20180801111243.2848-1-fe@dev.tdt.de>
 <CACRpkdbY3w-ptUOkv5TUZh+5oEGU+4BLO_6=12QecRveTSBKSQ@mail.gmail.com>
 <1846152.TW98f23PIX@debian64>
Message-ID: <37e92da47c20e8c771afcdb14c5532d8@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy

I think this are the information you want to have.

On 2018-08-04 20:22, Christian Lamparter wrote:
> As for the APUs. The vendor (PC Engines) happily provides
> PDFs and schematics for their boards:
> <https://www.pcengines.ch/pdf/apu1.pdf>
> <https://www.pcengines.ch/schema/apu1c.pdf>
> <https://www.pcengines.ch/pdf/apu2.pdf>
> <http://pcengines.ch/schema/apu2c.pdf>




