Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeBSUCs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:02:48 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37967 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753699AbeBSUCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:02:46 -0500
X-Google-Smtp-Source: AH8x224XKzExp6R1mj2JtgwZ5iIS5gfxWu3nQ6NbCXdjGhuEU64KuLebTBa2iA/Ag+5SXwpYCDxbQw==
Date: Mon, 19 Feb 2018 14:02:43 -0600
From: Rob Herring <robh@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, William wu <wulf@rock-chips.com>,
        hl@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 2/6] dt-bindings: phy-rockchip-typec: deprecate some
 register properties.
Message-ID: <20180219200243.mluxhx35wimphydc@rob-hp-laptop>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
 <20180216120956.19034-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216120956.19034-2-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 01:09:52PM +0100, Enric Balletbo i Serra wrote:
> As now the following register properties are in the driver, document as
> deprecated these properties and recommend to not use them on new bindings.
> 
> The deprecated properties are:
> 
> - rockchip,typec-conn-dir : the register of type-c connector direction
> - rockchip,usb3tousb2-en : the register of type-c force usb3 to usb2
>                            enable control.
> - rockchip,external-psm : the register of type-c phy external psm clock
>                           selection.
> - rockchip,pipe-status : the register of type-c phy pipe status.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v2:
> - Apply the nit suggested by Heiko Stuebner.
> Changes since v1:
> - This patch is new on these series and is just a documentation update
>   due patch [1/6]
> 
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 33 +++++-----------------
>  1 file changed, 7 insertions(+), 26 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
