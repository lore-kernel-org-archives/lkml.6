Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeEPIJJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:09:09 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36156 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEPIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:09:03 -0400
X-Google-Smtp-Source: AB8JxZrFSyX2z9iFaN05Y0w+g9vbRChjmjBO0migM4Ow1IcMlNWI5h1PVoOWm2CN5JKwXVnZ5aePQw==
MIME-Version: 1.0
References: <20180308094807.9443-1-jacob-chen@iotwrt.com> <20180308094807.9443-10-jacob-chen@iotwrt.com>
In-Reply-To: <20180308094807.9443-10-jacob-chen@iotwrt.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 16 May 2018 17:08:49 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BZm6+s=o1xEu_+E56R-k+ujAFxfytjA+N_SAcU=4A9FA@mail.gmail.com>
Message-ID: <CAAFQd5BZm6+s=o1xEu_+E56R-k+ujAFxfytjA+N_SAcU=4A9FA@mail.gmail.com>
Subject: Re: [PATCH v6 09/17] media: rkisp1: add rockchip isp1 core driver
To: Jacob Chen <jacob-chen@iotwrt.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?B?6ZKf5Lul5bSH?= <zyc@rock-chips.com>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Jeffy <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen Jacob <jacob2.chen@rock-chips.com>,
        =?UTF-8?B?6ZmI5Z+O?= <cc@rock-chips.com>,
        Allon Huang <allon.huang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob, Shunqian,

On Thu, Mar 8, 2018 at 6:49 PM Jacob Chen <jacob-chen@iotwrt.com> wrote:
[snip]
> +static const struct of_device_id rkisp1_plat_of_match[] = {
> +       {
> +               .compatible = "rockchip,rk3288-cif-isp",
> +               .data = &rk3288_isp_clk_data,
> +       }, {
> +               .compatible = "rockchip,rk3399-cif-isp",
> +               .data = &rk3399_isp_clk_data,
> +       },
> +       {},
> +};

We need MODULE_DEVICE_TABLE() here.

Best regards,
Tomasz
