Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965026AbeCHK3q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:29:46 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:46378 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeCHK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:29:44 -0500
X-Google-Smtp-Source: AG47ELtl81nEPv+dDWiKXjOOsEb/ba8+VfJZJw3iO2lb1jVuJUvCe7RJm2utgt7N1w0Eg/qOO8EzRg==
MIME-Version: 1.0
In-Reply-To: <20180308094807.9443-1-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 8 Mar 2018 19:29:21 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D1FMm4FTugstxk_6bE-QbLeNsMZM6EaVVfN_mu8_RQUA@mail.gmail.com>
Message-ID: <CAAFQd5D1FMm4FTugstxk_6bE-QbLeNsMZM6EaVVfN_mu8_RQUA@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] Rockchip ISP1 Driver
To: Jacob Chen <jacob-chen@iotwrt.com>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?B?6ZKf5Lul5bSH?= <zyc@rock-chips.com>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Jeffy <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jacob Chen <jacob2.chen@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 6:47 PM, Jacob Chen <jacob-chen@iotwrt.com> wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
>
> changes in V6:
>   - add mipi txrx phy support
>   - remove bool and enum from uapi header
>   - add buf_prepare op
>   - correct some spelling problems
>   - return all queued buffers when starting stream failed

Thanks Jacob.

For anyone planning to review, especially Hans, who pointed it out in
previous version, g_mbus_config is still there and we're working on
replacing it with something less controversial.

Best regards,
Tomasz
