Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50012C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0224D208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0224D208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeGLNYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:24:34 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36264 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeGLNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:24:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41RGcz5MMmz1r2nW;
        Thu, 12 Jul 2018 15:14:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41RGcz3vnNz1qqkJ;
        Thu, 12 Jul 2018 15:14:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id JfXtJywpVqNE; Thu, 12 Jul 2018 15:14:57 +0200 (CEST)
X-Auth-Info: OjOejmuXTNwL+TVbyIOj8T6Zw5IcUFcMSgOMkm7281g=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 12 Jul 2018 15:14:57 +0200 (CEST)
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
 <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
 <fd22085f646d97f66cff5b7f22785500@agner.ch>
 <6fdba55b-0be6-9e28-d87a-43d876a1fd09@denx.de>
 <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
 <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <039b2914-3393-5e81-82a6-7d517c5818a9@denx.de>
Date:   Thu, 12 Jul 2018 15:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 03:03 PM, Leonard Crestez wrote:
> On Thu, 2018-07-12 at 11:21 +0200, Stefan Agner wrote:
>> On 10.07.2018 11:11, Marek Vasut wrote:
>>> On 07/10/2018 11:06 AM, Stefan Agner wrote:
>>>> This is one of the situation where states quo is kinda the worst
>>>> situation.
>>>>
>>>> Currently imx_v6_v7_defconfig and mxs_defconfig actually still uses
>>>> CONFIG_FB_MXS.
>>>>
>>>> I understand that you'd rather prefer to move forward. I suggest we do
>>>> it in steps.
>>>>
>>>> In 4.19:
>>>>
>>>> - Change DRM driver.name to mxsfb-drm so we avoid conflicts for now
>>>
>>> But this will break mesa if it depends on mxsfb name for ie. etnaviv
>>> binding.
>>
>> Does it? grep -r -e mxsfb in libdrm and mesa master returns nothing.
>>
>> There is also .name in struct drm_driver, which is already set to
>> mxsfb-drm... Is that the one exposed to user space?
> 
> Running etnaviv+x11 with a renamed mxsfb driver works fine on imx6sx-
> sdb.
> 
> Tools like modetest already need -M mxsfb-drm, the drm_driver.name
> seems to be what matters.
> 
>> - Remove CONFIG_FB_MXS from imx_v6_v7_defconfig/mxs_defconfig now, and
>> only enable CONFIG_DRM_MXSFB=y
> 
> If one of the drivers is renamed then they can coexist: since the
> bindings are distinct one driver will return a probe error and the
> other will bind successfully. This can even be adjusted so that it
> doesn't even print ugly scary errors.
> 
> This can last until somebody implements support for old bindings in the
> drm driver and then FB_MXS can just be deleted.

So why don't we just convert the DT bindings on boards supported
upstream and zap the old driver ? What is the problem with that?

Realistically, how many MXS boards in the field use old DT and new kernel ?

-- 
Best regards,
Marek Vasut
