Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755688AbeEAMzX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:55:23 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37243 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754970AbeEAMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:55:21 -0400
X-Google-Smtp-Source: AB8JxZpcZyqX/xIFPRYwQlW2I1uBFxz4yI4SvEG6h15VcFizfT5UlLhgkXl1DqkaIPZ6uQQLkiRcuQ==
Date: Tue, 1 May 2018 07:55:19 -0500
From: Rob Herring <robh@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: net: meson-dwmac: new compatible
 name for AXG SoC
Message-ID: <20180501125519.GA14984@rob-hp-laptop>
References: <20180428102111.18384-1-yixun.lan@amlogic.com>
 <20180428102111.18384-2-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428102111.18384-2-yixun.lan@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 10:21:10AM +0000, Yixun Lan wrote:
> We need to introduce a new compatible name for the Meson-AXG SoC
> in order to support the RMII 100M ethernet PHY, since the PRG_ETH0
> register of the dwmac glue layer is changed from previous old SoC.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/net/meson-dwmac.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
