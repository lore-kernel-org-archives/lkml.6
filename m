Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755293AbeDZWpa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:45:30 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:32960 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeDZWp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:45:26 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: panel: lvds: Fix path to display timing bindings
Date: Fri, 27 Apr 2018 01:45:39 +0300
Message-ID: <101662296.DZBr8NQOBO@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1524642578-2885-1-git-send-email-geert+renesas@glider.be>
References: <1524642578-2885-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday, 25 April 2018 10:49:38 EEST Geert Uytterhoeven wrote:
> Fixes: 14da3ed8dd08c581 ("devicetree/bindings: display: Document common
> panel properties")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/display/panel/panel-common.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> b/Documentation/devicetree/bindings/display/panel/panel-common.txt index
> 557fa765adcb9450..5d2519af4bb5ca5e 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
> @@ -38,7 +38,7 @@ Display Timings
>    require specific display timings. The panel-timing subnode expresses
> those timings as specified in the timing subnode section of the display
> timing bindings defined in
> -  Documentation/devicetree/bindings/display/display-timing.txt.
> +  Documentation/devicetree/bindings/display/panel/display-timing.txt.
> 
> 
>  Connectivity


-- 
Regards,

Laurent Pinchart
