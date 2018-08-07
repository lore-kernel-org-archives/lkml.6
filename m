Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123A0C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22B9216F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22B9216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbeHGVeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:34:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:18934 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbeHGVeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:34:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 12:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="252776249"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2018 12:18:20 -0700
Message-ID: <58c02aeff4285498272b0a13b8de2dc1282fded9.camel@linux.intel.com>
Subject: Re: [PATCH] gpio: Add driver for PC Engines APU2/APU3 GPIOs
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Florian Eckert <fe@dev.tdt.de>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 07 Aug 2018 22:18:19 +0300
In-Reply-To: <37e92da47c20e8c771afcdb14c5532d8@dev.tdt.de>
References: <20180801111243.2848-1-fe@dev.tdt.de>
         <CACRpkdbY3w-ptUOkv5TUZh+5oEGU+4BLO_6=12QecRveTSBKSQ@mail.gmail.com>
         <1846152.TW98f23PIX@debian64> <37e92da47c20e8c771afcdb14c5532d8@dev.tdt.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 13:18 +0200, Florian Eckert wrote:
> Hello Andy
> 
> I think this are the information you want to have.
> 

I was rather asking for something like TRM.

By schematics, I meant a simplified GPIO buffers and pin control
explained on hardware level.

Below has nothing to do with either, unfortunately.

> On 2018-08-04 20:22, Christian Lamparter wrote:
> > As for the APUs. The vendor (PC Engines) happily provides
> > PDFs and schematics for their boards:
> > <https://www.pcengines.ch/pdf/apu1.pdf>
> > <https://www.pcengines.ch/schema/apu1c.pdf>
> > <https://www.pcengines.ch/pdf/apu2.pdf>
> > <http://pcengines.ch/schema/apu2c.pdf>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
