Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeDMRji (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:39:38 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44297 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMRjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:39:36 -0400
X-Google-Smtp-Source: AIpwx49yVjcu7Jz6Eu0wAAd/ZypoB+ZiKh/jbnw5W2PjBuy8BdfDt+/0LwEZRZJ+NrQqQ0Upb136ng==
Date: Fri, 13 Apr 2018 12:39:34 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: display: bridge: lvds-transmitter: add
 ti,ds90c185
Message-ID: <20180413173934.uq7xhbkrq4g77jch@rob-hp-laptop>
References: <20180409105918.20792-1-peda@axentia.se>
 <20180409105918.20792-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409105918.20792-2-peda@axentia.se>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 12:59:14PM +0200, Peter Rosin wrote:
> Start list of actual chips compatible with "lvds-encoder".
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
