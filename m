Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B42ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE6C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE6C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeGRIzj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:55:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40487 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbeGRIzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:55:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5EE3B207AC; Wed, 18 Jul 2018 10:18:54 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2008D20720;
        Wed, 18 Jul 2018 10:18:54 +0200 (CEST)
Date:   Wed, 18 Jul 2018 10:18:53 +0200
From:   =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mylene.josserand@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        maxime.ripard@free-electrons.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Input: Add Cypress Gen5 Touchscreen driver
Message-ID: <20180718101854.31006b81@dell-desktop.home>
In-Reply-To: <20180704162158.euiw2v3hyv3hzofn@penguin>
References: <20180703094309.18514-1-mylene.josserand@bootlin.com>
        <20180704162158.euiw2v3hyv3hzofn@penguin>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Wed, 4 Jul 2018 16:21:58 +0000
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Mylène,
> 
> On Tue, Jul 03, 2018 at 11:43:07AM +0200, Mylène Josserand wrote:
> > Hello,
> > 
> > Here is a V6 series to add the driver of the touchscreen Cypress,
> > TrueTouch Generation 5.
> > Based on v4.18-rc3.
> > 
> > This patch series has already been posted in several iterations:
> >     - v1: Sent on 2017/05/29
> >     - v2: Sent on 2017/08/18
> >     - v3: Sent on 2017/09/27
> >     - v4: Sent on 2017/12/01
> >     - v5: Sent on 2017/12/20
> > 
> > I did not have any comments the last 4 versions.
> > And no reviews on my v5 during 6 months. Could I have any updates
> > or feedback on my series to know why it is not merged (to be able to
> > correct what is wrong)?  
> 
> Sorry, I must have missed the v5, sorry about that.

No problem.

> 
> I probably asked this question before, but just to make sure - I see
> references to HID in the patch - the device is really not HID
> compatible? Is there any hope it could be made work with i2c-hid +
> hid-multitouch?

I do not think it is HID compatible but let me check the i2c-hid and
hid-multitouch drivers to confirm that (or not).

I will let you know in next few days.

Thank you,
Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
