Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC2FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB06218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfAXLlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:41:35 -0500
Received: from regular1.263xmail.com ([211.150.99.135]:57680 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfAXLle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:41:34 -0500
Received: from hjc?rock-chips.com (unknown [192.168.167.243])
        by regular1.263xmail.com (Postfix) with ESMTP id 475A8232;
        Thu, 24 Jan 2019 19:41:28 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.10.78] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P6946T139739286767360S1548330085920447_;
        Thu, 24 Jan 2019 19:41:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b2501d3e642a3f47abaf66ef1f8223c0>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [v8, 2/3] drm/rockchip: Add support for Rockchip Soc RGB output
 interface
To:     Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>, eddie.cai.linux@gmail.com
Cc:     linux-rockchip@lists.infradead.org, seanpaul@chromium.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180830211207.10480-3-heiko@sntech.de>
 <alpine.DEB.2.21.1901180131510.1647@nanos.tec.linutronix.de>
 <1636679.fMryThW7k8@phil>
From:   "sandy.huang" <hjc@rock-chips.com>
Message-ID: <40ab531f-7ef9-8625-a574-a479a9ead535@rock-chips.com>
Date:   Thu, 24 Jan 2019 19:41:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1636679.fMryThW7k8@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi heiko and thomas,

the SPDX license identifier is updated by the following patch, please 
help to review, thanks.

https://patchwork.kernel.org/patch/10776935/

在 2019/1/18 下午8:34, Heiko Stuebner 写道:
> Hi Thomas,
>
> Am Freitag, 18. Januar 2019, 01:40:03 CET schrieb Thomas Gleixner:
>> On Thu, 30 Aug 2018, Heiko Stuebner wrote:
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
>>> @@ -0,0 +1,173 @@
>>> +//SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
>>> + * Author:
>>> + *      Sandy Huang <hjc@rock-chips.com>
>>> + *
>>> + * This software is licensed under the terms of the GNU General Public
>>> + * License version 2, as published by the Free Software Foundation, and
>>> + * may be copied, distributed, and modified under those terms.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>> The licensing in this file and in the corresponding header is broken.
>>
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.h
>>> @@ -0,0 +1,20 @@
>>> +//SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
>>> + * Author:
>>> + *      Sandy Huang <hjc@rock-chips.com>
>>> + *
>>> + * This software is licensed under the terms of the GNU General Public
>>> + * License version 2, as published by the Free Software Foundation, and
>>> + * may be copied, distributed, and modified under those terms.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>> Both files use the SPDX license identifier for GPL v2 or later, but the
>> license notice is clearly v2 only.
>>
>> So the copyright holder needs to decide which one. And please remove the
>> boiler plate text. It's redundant.
> Not sure how to proceed as I haven't seen Sandy around for quite a bit,
> but the first versions didn't have a SPDX header and were GPL2-only (v1-v4)
> and the SPDX header was added in v5.
>
> So as a stopgap measure, I'd guess we could assume that the copyright
> intended GPL2-only?
>
>
>> Please fix ASAP, add a Fixes tag and cc stable so the inconsistency is
>> fixed in 4.20 as well.
> ok, once we have the direction of change set.
>
>
> Heiko
>
>
>
>
>


