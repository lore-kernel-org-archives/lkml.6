Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934718AbeCHCB1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:01:27 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36460 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:01:25 -0500
X-Google-Smtp-Source: AG47ELvFbTwn8cX0KWbFm5djs9O5RFgbPy7QO4f55xNdfrT89i+Z0b7M0Seh8wn/52Nny1+qIbbkwg==
Date: Wed, 7 Mar 2018 20:01:24 -0600
From: Rob Herring <robh@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] thermal: exynos: remove separate thermal_exynos.h
 header file
Message-ID: <20180308020124.trvajkrsnbog5uqj@rob-hp-laptop>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180306144520epcas2p4950ac2762036882ccd097fd2bf629bbc@epcas2p4.samsung.com>
 <1520347435-22970-13-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520347435-22970-13-git-send-email-b.zolnierkie@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 03:43:55PM +0100, Bartlomiej Zolnierkiewicz wrote:
> thermal_exynos.h is used only by exynos_tmu.c so there is no need
> for a separate include file. Also while it remove unused defines.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c         |  5 +++--
>  include/dt-bindings/thermal/thermal_exynos.h | 28 ----------------------------
>  2 files changed, 3 insertions(+), 30 deletions(-)
>  delete mode 100644 include/dt-bindings/thermal/thermal_exynos.h

Reviewed-by: Rob Herring <robh@kernel.org>
