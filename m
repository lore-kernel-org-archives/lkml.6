Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDMRVA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:21:00 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40462 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeDMRU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:20:59 -0400
X-Google-Smtp-Source: AIpwx4/rpOnYjStkK+ei1LnS4W6z9tEPgs7ZfH+0QAydCMHoZbd0FJLOTbL+aTdwU1oQq9+VqRB2tw==
Date: Fri, 13 Apr 2018 12:20:55 -0500
From: Rob Herring <robh@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: interrupt-controller: New binding for
 Meson-AXG SoC
Message-ID: <20180413172055.waibtio6qbltdv4a@rob-hp-laptop>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
 <20180408145700.23520-3-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408145700.23520-3-yixun.lan@amlogic.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 02:56:59PM +0000, Yixun Lan wrote:
> Update the dt-binding documentation to support new compatible string
> for the GPIO interrupt controller which found in Amlogic's Meson-AXG SoC.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
