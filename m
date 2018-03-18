Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754867AbeCRXuH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 19:50:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54963 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754781AbeCRXuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 19:50:04 -0400
X-Google-Smtp-Source: AG47ELsuEdohhwO+9NEnwEvwYKE0vuhMAOAfDzlz+EmtIIg/hyd4Jt4NAg4hYgZs6SpgvnhFMLXCpg==
Subject: Re: [PATCH v1 10/19] arm: dts: mt7623: remove useless property
 pinctrl-names at node switch@0
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <9c8c23657d9812e24c6f07b7477a6ac0ebdd1c68.1519378872.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <06ea08cd-0b31-49e4-0008-df9933c709cb@gmail.com>
Date: Mon, 19 Mar 2018 00:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9c8c23657d9812e24c6f07b7477a6ac0ebdd1c68.1519378872.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 11:16 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The property pinctrl-names is totally superfluous. It would be good to
> remove the property to keep the node neatness. There is actually
> unnecessary to set up any pins for data path TRGMII between main SoC and
> MT7530. Furthermore, it's more reasonable for the pin setup of control
> path MDIO bus is being placed inside the node of ethernet controller.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Pushed to v4.16-next/dts32

Thanks!

> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 6b760be..f2d3cfb 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -151,7 +151,6 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0>;
> -			pinctrl-names = "default";
>  			reset-gpios = <&pio 33 0>;
>  			core-supply = <&mt6323_vpa_reg>;
>  			io-supply = <&mt6323_vemc3v3_reg>;
> 
