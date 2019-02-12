Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22591C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE505222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbfBLTwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:52:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43408 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfBLTwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:52:42 -0500
Received: from broadband.bt.com (unknown [IPv6:2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F2F1B26D932;
        Tue, 12 Feb 2019 19:52:39 +0000 (GMT)
Message-ID: <c227cc363297e7d0d9bd22a096e9b5f89fca8f5c.camel@collabora.com>
Subject: Re: [PATCH] ARM: dts: am335x: Add support for Bosch Guardian
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org
Date:   Tue, 12 Feb 2019 19:52:36 +0000
In-Reply-To: <20190212184915.GN5720@atomide.com>
References: <20190211122727.5582-1-martyn.welch@collabora.com>
         <20190212184915.GN5720@atomide.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-12 at 10:49 -0800, Tony Lindgren wrote:
> Hi,
> 
> * Martyn Welch <martyn.welch@collabora.com> [190211 04:27]:
> > The Bosch Guardian is a TI am335x based device.
> > 
> > It's hardware specifications are as follows:
> > 
> >  * 256 MB DDR3 memory
> >  * 512 MB NAND Flash
> >  * USB OTG
> >  * RS232
> >  * MicroSD external storage
> >  * LCD Display interface
> 
> Thanks applying into omap-for-v5.1/dt.
> 

Thanks Tony.

> Do you have some link for this device for more
> information?
> 

I'm not aware of any publicly available documentation at this time.

> > +/include/ "tps65217.dtsi"
> 
> I'll update this to use #include "tps65217.dtsi"
> while applying.
> 

OK, I found examples of both, guess I picked the wrong one :-)

Martyn

> Regards,
> 
> Tony

