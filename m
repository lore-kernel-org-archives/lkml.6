Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162678AbeCAWio (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:38:44 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:37914 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162639AbeCAWim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:38:42 -0500
X-Google-Smtp-Source: AG47ELuk4l+CBS3G6TxQIjkq+puca2JbqhgV0UHx/TjtoSrYhAt3d+e6aygrjAKZI9/lKDhk1rwWTg==
Date: Thu, 1 Mar 2018 16:38:40 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: vendor: Add Huarui Lighting
Message-ID: <20180301223840.qlqnvf665s6w77dm@rob-hp-laptop>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
 <3c76eb1522834b4f6516f9539fec142da939ee9c.1519204731.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c76eb1522834b4f6516f9539fec142da939ee9c.1519204731.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:20:30AM +0100, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Huarui Lighting makes display panel, add it to the list of panels.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
