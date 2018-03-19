Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755009AbeCSBdC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:33:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55464 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbeCSBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:32:59 -0400
X-Google-Smtp-Source: AG47ELtTt75NLBFzJ+hR/qHcInBLQ0UBvZNnUKt4bwU9+qNi0LmgcXaZlUgtAxBBE7HY4aHHNRPIqg==
Subject: Re: [PATCH v2 1/5] dt-bindings: soc: update MT2712 power dt-bindings
To: Weiyi Lu <weiyi.lu@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
Cc: James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
 <20180312070342.4335-3-weiyi.lu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a80922c9-3feb-c3f1-d1f1-1673a57d5795@gmail.com>
Date: Mon, 19 Mar 2018 02:32:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312070342.4335-3-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/12/2018 08:03 AM, Weiyi Lu wrote:
> Add new power domains(MFG_SC1/MFG_SC2/MFG_SC3)
> for MT2712 according to ECO design change.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Pushed to v4.16-next/soc

Thanks!

> ---
>  include/dt-bindings/power/mt2712-power.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/power/mt2712-power.h b/include/dt-bindings/power/mt2712-power.h
> index 92b46d772fae..2c147817efc2 100644
> --- a/include/dt-bindings/power/mt2712-power.h
> +++ b/include/dt-bindings/power/mt2712-power.h
> @@ -22,5 +22,8 @@
>  #define MT2712_POWER_DOMAIN_USB		5
>  #define MT2712_POWER_DOMAIN_USB2	6
>  #define MT2712_POWER_DOMAIN_MFG		7
> +#define MT2712_POWER_DOMAIN_MFG_SC1	8
> +#define MT2712_POWER_DOMAIN_MFG_SC2	9
> +#define MT2712_POWER_DOMAIN_MFG_SC3	10
>  
>  #endif /* _DT_BINDINGS_POWER_MT2712_POWER_H */
> 
