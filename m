Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428795AbeCBOwp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:52:45 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39737 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428753AbeCBOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:52:41 -0500
X-Google-Smtp-Source: AG47ELvaDii4Bk2L0tpv+MEdEbAjQC2h/lkEy0W39jxuYjuAmOOZtf9zBhWdoDozj/WYMHD8qRfRQA==
Subject: Re: [PATCH v4 3/4] dt-bindings: display: amlogic: DT fix
 s/resets-names/reset-names/
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, Chanho Min <chanho.min@lge.com>
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <1519998993-14398-1-git-send-email-geert+renesas@glider.be>
 <1519998993-14398-4-git-send-email-geert+renesas@glider.be>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <d2be8243-caf1-32e3-bda2-b454a2cc147c@baylibre.com>
Date: Fri, 2 Mar 2018 15:52:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519998993-14398-4-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2018 14:56, Geert Uytterhoeven wrote:
> Fixes: 8cceda5349377e30 ("dt-bindings: Add bindings for the Amlogic Meson dw-hdmi extension")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v4:
>   - Add Acked-by,
> 
> v3:
>   - New.
> ---
>  Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
> index bf4a18047309a5f8..d8f6268849f43621 100644
> --- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
> @@ -43,7 +43,7 @@ Required properties:
>    and the Amlogic Meson venci clocks as described in
>    Documentation/devicetree/bindings/clock/clock-bindings.txt,
>    the clocks are soc specific, the clock-names should be "iahb", "isfr", "venci"
> -- resets, resets-names: must have the phandles to the HDMI apb, glue and phy
> +- resets, reset-names: must have the phandles to the HDMI apb, glue and phy
>    resets as described in :
>    Documentation/devicetree/bindings/reset/reset.txt,
>    the reset-names should be "hdmitx_apb", "hdmitx", "hdmitx_phy"
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
