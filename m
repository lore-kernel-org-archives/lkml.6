Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeDMRS5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:18:57 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37584 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeDMRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:18:55 -0400
X-Google-Smtp-Source: AIpwx4+lbqrhOGtEYg382Dht2ip9O8Z0S6RjOVFMtQ110l0V+5aF36cBIEfVz3IGOApuTi0mJrkjhQ==
Date: Fri, 13 Apr 2018 12:18:53 -0500
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
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: fix the double
 quotes
Message-ID: <20180413171853.5blruiakambnzsgr@rob-hp-laptop>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
 <20180408145700.23520-2-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408145700.23520-2-yixun.lan@amlogic.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 02:56:58PM +0000, Yixun Lan wrote:
> The double quotes seems not ASCII type, fix it here.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt  | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
