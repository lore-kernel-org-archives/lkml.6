Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbeEaEAc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:00:32 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35079 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeEaEAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:00:30 -0400
X-Google-Smtp-Source: ADUXVKLeSv4naMicya1inxaDbiSf3bZfud15Wze5CE8+h0FHYqUdIhnoYU5js9iFyQgszIIBISS5TQ==
Date: Wed, 30 May 2018 23:00:27 -0500
From: Rob Herring <robh@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 05/10] panel/hv070wsa-100: add DT bindings
Message-ID: <20180531040027.GA20068@rob-hp-laptop>
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
 <CGME20180530121626eucas1p288656bbbace0c333decadff418e13c34@eucas1p2.samsung.com>
 <1527682561-1386-6-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527682561-1386-6-git-send-email-m.purski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 02:15:56PM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>

"dt-bindings: display: ..." is preferred subject prefix.

> 
> The patch adds bindings to BOE HV070-WSA WSVGA panel.
> Bindings are compatible with simple panel bindings.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../devicetree/bindings/display/panel/boe,hv070wsa-100.txt         | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> new file mode 100644
> index 0000000..bfc20ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> @@ -0,0 +1,7 @@
> +BOE HV070WSA-100 7.01" WSVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "boe,hv070wsa-100"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

You have to state exactly which properties apply. Does this panel have a 
backlight? 1 supply, 2 supplies, no supplies?

Rob
