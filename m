Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeC0PHe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:07:34 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34205 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeC0PHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:07:32 -0400
X-Google-Smtp-Source: AG47ELvyp4mI88GahRw/n9Mj3uN3rGr7NLWjh7avVuEsO4FZ31dSN1hXmKIoB9lg1bVwQskvfHprPw==
Date: Tue, 27 Mar 2018 10:07:30 -0500
From: Rob Herring <robh@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: document the Meson AXG support
Message-ID: <20180327150730.7ty6j76ym73vjth5@rob-hp-laptop>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
 <20180326084629.100070-3-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326084629.100070-3-yixun.lan@amlogic.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 04:46:28PM +0800, Yixun Lan wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
> 
> Update the documentation to expicitly support the Meson-AXG SoC.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
