Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92C0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713EC254D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713EC254D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeFYGmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:42:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeFYGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:42:37 -0400
Received: from localhost (unknown [106.38.54.61])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 69B562C;
        Mon, 25 Jun 2018 06:42:36 +0000 (UTC)
Date:   Mon, 25 Jun 2018 14:42:32 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 5/8] Input: cros_ec_keyb - Switch to SPDX identifier.
Message-ID: <20180625064232.GB4233@kroah.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-6-enric.balletbo@collabora.com>
 <CAOMZO5ByhMV9_gRHLmGiSNJtCvKEOk==ZMz2O2=tokZh2ps4xg@mail.gmail.com>
 <7085d0bb-557c-0796-d3ae-756e000a7950@collabora.com>
 <20180625015717.GA30408@kroah.com>
 <5926a3f2-3646-f9e1-619a-255e619f41f0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5926a3f2-3646-f9e1-619a-255e619f41f0@collabora.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 08:23:38AM +0200, Enric Balletbo i Serra wrote:
> Hi Grek,
> 
> On 25/06/18 03:57, Greg KH wrote:
> > On Tue, Jun 05, 2018 at 08:14:24PM +0200, Enric Balletbo i Serra wrote:
> >> Hi Fabio,
> >>
> >> On 05/06/18 20:04, Fabio Estevam wrote:
> >>> Hi Enric,
> >>>
> >>> On Tue, Jun 5, 2018 at 2:54 PM, Enric Balletbo i Serra
> >>> <enric.balletbo@collabora.com> wrote:
> >>>> Adopt the SPDX license identifier headers to ease license compliance
> >>>> management.
> >>>>
> >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>>> ---
> >>>>
> >>>> Changes in v2:
> >>>> - [6/9] Do not remove last paragraph.
> >>>>
> >>>>  drivers/input/keyboard/cros_ec_keyb.c | 34 ++++++++++-----------------
> >>>>  1 file changed, 12 insertions(+), 22 deletions(-)
> >>>>
> >>>> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> >>>> index 79eb29550c34..91b2839c12df 100644
> >>>> --- a/drivers/input/keyboard/cros_ec_keyb.c
> >>>> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> >>>> @@ -1,25 +1,15 @@
> >>>> -/*
> >>>> - * ChromeOS EC keyboard driver
> >>>> - *
> >>>> - * Copyright (C) 2012 Google, Inc
> >>>> - *
> >>>> - * This software is licensed under the terms of the GNU General Public
> >>>> - * License version 2, as published by the Free Software Foundation, and
> >>>
> >>> Original text says GPL-2.0...
> >>>
> >>>> - * may be copied, distributed, and modified under those terms.
> >>>> - *
> >>>> - * This program is distributed in the hope that it will be useful,
> >>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>>> - * GNU General Public License for more details.
> >>>> - *
> >>>> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> >>>> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> >>>> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> >>>> - * but everything else (including deghosting) is done here.  The main
> >>>> - * motivation for this is to keep the EC firmware as simple as possible, since
> >>>> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> >>>> - * expensive.
> >>>> - */
> >>>> +// SPDX-License-Identifier: GPL-2.0+
> >>>
> >>> but here you add a GPL-2.0+ type.
> >>>
> >>
> >> Right, but the module license is set to GPL which means GNU Public License v2 or
> >> later, see [1]. So, there is a mismatch. In such cases I assumed GPL-2.0+ as the
> >> default. These mismatches are common so I think that should be fine for the
> >> authors, if someone is disagree just let me know and I will change.
> > 
> > NO!
> > 
> > The license text is what you need to follow as almost everyone gets the
> > MODULE_LICENSE() stuff wrong.  You can not follow the MODULE_LICENSE
> > marking for determining GPLv2 vs. GPLv2+ at this point in time.  After
> > we get the SPDX stuff all cleaned up then we can go and fix up the
> > MODULE_LICENSE mismatch.
> > 
> > So again, always defer to the license text in the file, NOT the
> > MODULE_LICENSE() marking.
> > 
> 
> Many thanks for your feedback, Dmitry already told me that I was doing wrong
> this and I sent another version following the license text, so this patchset was
> superseded for v3 [1].
> 
> [1] https://patchwork.ozlabs.org/cover/925906/

Ah, good, sorry for the noise then, I didn't see that series.

greg k-h
