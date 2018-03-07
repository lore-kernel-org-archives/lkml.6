Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeCGT0t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:26:49 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41546 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754333AbeCGT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:26:47 -0500
X-Google-Smtp-Source: AG47ELuCpKiZ5Ut6i0vxIRhMD4OZkbiNy/qzhz0AKjhLYmW6P33QzDdGHCEFJUnz/K7S2FQzbn1Wzw==
Date: Wed, 7 Mar 2018 13:26:44 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: display: Add Allwinner MIPI-DSI
 bindings
Message-ID: <20180307192644.7kowpqidew3jq2bw@rob-hp-laptop>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
 <5f183ae295c0190369ec576ecfb10c1d78f41eb3.1520344489.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f183ae295c0190369ec576ecfb10c1d78f41eb3.1520344489.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 02:55:59PM +0100, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> The Allwinner SoCs usually come with a DSI encoder. Add a binding for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 93 +++++++-
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt

Reviewed-by: Rob Herring <robh@kernel.org>
