Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeCRMxm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:53:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42694 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754603AbeCRMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:53:01 -0400
X-Google-Smtp-Source: AG47ELtLR7o/atCWfs0NnhEGfofCb6RgYoh9cAMqYqxkpx7Bi5UYQanEEboQAsLeKUGd3mvWfSKK7A==
Date: Sun, 18 Mar 2018 07:52:57 -0500
From: Rob Herring <robh@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 6/9] dt-bindings: add device tree binding for
 Allwinner H6 main CCU
Message-ID: <20180318033523.kxtlewiwtboebtqe@rob-hp-laptop>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-7-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316140215.28663-7-icenowy@aosc.io>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 10:02:12PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 main CCU uses the internal oscillator of the SoC, which
> is different with old SoCs' main CCU.
> 
> Add device tree binding for the Allwinner H6 main CCU.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Extracted in v4.
> 
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
