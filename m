Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754621AbeCGTel (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:34:41 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:39083 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbeCGTek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:34:40 -0500
X-Google-Smtp-Source: AG47ELsaEf2Dbqeuzz+epcEThqLpgHIoEqNOnUrwuy1MjGpEEtGKrbuJUEp4/OsdVgRht2Wrx1LKEg==
Date: Wed, 7 Mar 2018 13:34:38 -0600
From: Rob Herring <robh@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: kishon@ti.com, heiko@sntech.de, groeck@chromium.org,
        gwendal@chromium.org, kernel@collabora.com, vicencb@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: phy-rockchip-typec: move extcon
 property to be optional.
Message-ID: <20180307193438.fogti4jodn2jgsb5@rob-hp-laptop>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301152515.20940-3-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 04:25:11PM +0100, Enric Balletbo i Serra wrote:
> The extcon property is used to detect the cable-state but some boards
> just connect the type-c phy to a regular USB-A connector without any
> power-delivery and thus no controller reporting the cable-state.
> So the extcon property is not really a required property, move it to be
> optional instead.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> 
> Changes in v2:
> - [2/6] Rewrite the justification as suggested by Heiko Stuebner.
> 
>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 2 ++
>  1 file changed, 2 insertions(+)

And extcon should be deprecated IMO.

Reviewed-by: Rob Herring <robh@kernel.org>
