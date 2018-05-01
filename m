Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756068AbeEAQR1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:17:27 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39511 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755035AbeEAQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:17:25 -0400
X-Google-Smtp-Source: AB8JxZq7WmTkW3fz3vZdfNozd2C24rzWwbK0T38DXaCu+AUjHABt96REbP5QQAPi9Mr4jQjbVjXN1Q==
Date: Tue, 1 May 2018 11:17:23 -0500
From: Rob Herring <robh@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 04/21] bindings: display: Add compatible for A64 DE2
 pipeline
Message-ID: <20180501161723.GA376@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430114058.5061-5-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 05:10:41PM +0530, Jagan Teki wrote:
> Allwinner A64 has DE2 pipeline similar to other Allwinner
> SOC's like A83T, H3/H5.

'dt-bindings: ' for the subject prefix.

> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
