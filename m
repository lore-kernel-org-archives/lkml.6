Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60767C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F820843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866F820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJ2AZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:25:12 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46854 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeJ2AZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:25:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id ECC099E6A2F;
        Sun, 28 Oct 2018 15:40:12 +0000 (GMT)
Date:   Sun, 28 Oct 2018 15:40:11 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Rob Herring <robh@kernel.org>
Cc:     Oskari Lemmela <oskari@lemmela.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Message-ID: <20181028154011.04efdecf@archlinux>
In-Reply-To: <20181024135633.GA342@bogus>
References: <20181023185330.10472-1-oskari@lemmela.net>
        <20181023185330.10472-5-oskari@lemmela.net>
        <20181024135633.GA342@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018 08:56:33 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> > The AXP803 ADC is compatible with AXP813 ADC, but add
> > specific compatible for it.
> > 
> > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

This doesn't seem to have any dependencies with the other patches
so applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore.  However I am a little curious to know
why we would add the ID and then not use it (that I can see)?

Thanks,

Jonathan
