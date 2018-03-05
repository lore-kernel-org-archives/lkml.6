Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964915AbeCENat (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:30:49 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:40549 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbeCENaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:30:46 -0500
X-Google-Smtp-Source: AG47ELuq5D03g6z3uXNuOtZzlj2270oiDUE6CLDSFEkXjqc/OjJIHO1Svl2eaKA3NTbwQ40ydyCisQ==
MIME-Version: 1.0
In-Reply-To: <20180301101837.27969-4-jeffy.chen@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com> <20180301101837.27969-4-jeffy.chen@rock-chips.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 5 Mar 2018 22:30:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DLJwjdream_T4910L9qWbV1n5wivnn3xDCNFFuYqauVQ@mail.gmail.com>
Message-ID: <CAAFQd5DLJwjdream_T4910L9qWbV1n5wivnn3xDCNFFuYqauVQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 03/14] iommu/rockchip: Request irqs in rk_iommu_probe()
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

On Thu, Mar 1, 2018 at 7:18 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Move request_irq to the end of rk_iommu_probe().
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> Loop platform_get_irq() as Robin suggested.
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
