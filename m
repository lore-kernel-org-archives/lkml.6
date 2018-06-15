Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9788E208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9788E208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756610AbeFOVt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:49:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54505 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753688AbeFOVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:49:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 416vKZ3zQdz1qtPl;
        Fri, 15 Jun 2018 23:49:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 416vKY3QG1z1qsdH;
        Fri, 15 Jun 2018 23:49:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id vsz3E36mvodG; Fri, 15 Jun 2018 23:49:47 +0200 (CEST)
X-Auth-Info: VX7u6Mp7EKiIcN2y1y4kiCQNBoGmomY2fjTmXEO1/AQ=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 15 Jun 2018 23:49:46 +0200 (CEST)
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <638457fd-85da-8fec-d146-517c43f71813@denx.de>
Date:   Fri, 15 Jun 2018 23:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 10:58 PM, Leonard Crestez wrote:
> On Fri, 2018-06-15 at 16:47 -0300, Fabio Estevam wrote:
> 
>> On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
>> <leonard.crestez@nxp.com> wrote:
>>> The FBDEV driver uses the same name and both can't be registered at the
>>> same time. Fix this by renaming the drm driver to mxsfb-drm
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>
>> Stefan sent the same patch a few days ago:
>> http://www.spinics.net/lists/dri-devel/msg179489.html
> 
> In that thread there is a proposal for removing the old fbdev/mxsfb
> driver entirely.
> 
> That would break old DTBs, isn't this generally considered bad? Also,
> are we sure the removal of fbdev/mxsfb wouldn't lose any features?
> 
> What my series does is make both drivers work with the same kernel
> image and turns the choice into a board-level dtb decision. Supporting
> everything at once seems desirable to me and it allows for a very
> smooth upgrade path.

Having two drivers in the kernel with different set of bugs is always bad.

> The old driver could be removed later, after all users are converted.

Both drivers were in for long enough already. And let's be realistic,
how many MX23/MX28 users of old DTs with new kernels are there who
cannot update the DT as well ?

IMO keeping the old FBDEV driver in is just an excuse to postpone the
long overdue DT update and I dislike that. Update any remaining DTs and
nuke the FBDEV driver already.

-- 
Best regards,
Marek Vasut
