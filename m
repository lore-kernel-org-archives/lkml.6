Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934214AbeCGW20 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:28:26 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37297 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933426AbeCGW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:28:24 -0500
X-Google-Smtp-Source: AG47ELu96yhnZRraDUZp0DDEWJuqkyzYQuaA/9q+RO5reemBgtAoEiwVSHHhpvpkWqkmZvIA64WeLQ==
Date: Wed, 7 Mar 2018 16:28:22 -0600
From: Rob Herring <robh@kernel.org>
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: linus.walleij@linaro.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        srv_heupstream@mediatek.com, liguo.zhang@mediatek.com,
        yingjoe.chen@mediatek.com, hongkun.cao@mediatek.com,
        biao.huang@mediatek.com, yt.shen@mediatek.com,
        hongzhou.yang@mediatek.com, erin.lo@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/4] arm64: dts: mt2712: add pintcrl file
Message-ID: <20180307222822.7uxuibviglidhp4j@rob-hp-laptop>
References: <1520249745-6757-1-git-send-email-zhiyong.tao@mediatek.com>
 <1520249745-6757-2-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520249745-6757-2-git-send-email-zhiyong.tao@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 07:35:42PM +0800, Zhiyong Tao wrote:
> This patch adds pinctrl file for mt2712.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h | 1123 +++++++++++++++++++++++++
>  1 file changed, 1123 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h

Reviewed-by: Rob Herring <robh@kernel.org>
