Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeC3JuK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbeC3JuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:50:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10AB21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 10:50:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Yixun Lan <yixun.lan@amlogic.com>, Hartmut Knaack <knaack.h@gmx.de>,
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
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: document the Meson AXG
 support
Message-ID: <20180330105001.5d9df535@archlinux>
In-Reply-To: <20180327150730.7ty6j76ym73vjth5@rob-hp-laptop>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
        <20180326084629.100070-3-yixun.lan@amlogic.com>
        <20180327150730.7ty6j76ym73vjth5@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 10:07:30 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Mar 26, 2018 at 04:46:28PM +0800, Yixun Lan wrote:
> > From: Xingyu Chen <xingyu.chen@amlogic.com>
> > 
> > Update the documentation to expicitly support the Meson-AXG SoC.
> > 
> > Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
> >  1 file changed, 1 insertion(+)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore it ;)

Thanks,

Jonathan
