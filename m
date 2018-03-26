Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeCZWZP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:25:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36965 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbeCZWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:25:06 -0400
X-Google-Smtp-Source: AIpwx4+/Cmy3PH9AiK3Zo4TODSXtEC8fAfSJwabNX9aN8KgdKaBL94TOJ4cebwOZTmhBzEemfpw+Wg==
Date: Mon, 26 Mar 2018 17:25:04 -0500
From: Rob Herring <robh@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: clock: axg-aoclkc: New binding for
 Meson-AXG SoC
Message-ID: <20180326222504.mdsmhxfqlf2fkv3x@rob-hp-laptop>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
 <20180323143816.200573-4-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323143816.200573-4-yixun.lan@amlogic.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:38:12PM +0800, Yixun Lan wrote:
> Update the dt-binding documentation to support new compatible string
> for the Amlogic's Meson-AXG SoC.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
