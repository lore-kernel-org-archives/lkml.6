Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754730AbeCGThw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:37:52 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38698 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753949AbeCGTht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:37:49 -0500
X-Google-Smtp-Source: AG47ELv+5bsznWWDiBuhiKOXCsOuIXRd7oO7/VtRRkfbMM5BPSA+2yVWTe4hlXb4r+vy0KghPvRdZg==
Date: Wed, 7 Mar 2018 13:37:48 -0600
From: Rob Herring <robh@kernel.org>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 05/16] dt-bindings: display: sun4i-drm: Add
 compatibles for H3 HDMI pipeline
Message-ID: <20180307193748.5uvdab2rbndhuvog@rob-hp-laptop>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
 <20180301213442.16677-6-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301213442.16677-6-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 10:34:31PM +0100, Jernej Skrabec wrote:
> Add missing compatibles for H3 HDMI pipeline. These compatibles can also
> be used with H5 SoC.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
