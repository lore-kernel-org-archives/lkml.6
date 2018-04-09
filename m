Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754449AbeDIUaB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:30:01 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44272 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeDIU35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:29:57 -0400
X-Google-Smtp-Source: AIpwx4/XNUsYsoST5LeF4fuIiJYZ5CE6drvPZaa3Mp9FtXnfdcybPHq/vUPCemGJLdR9zLBzLrvLnA==
Date: Mon, 9 Apr 2018 15:29:55 -0500
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 5/8] dt-bindings: panel: common: document orientation
 property
Message-ID: <20180409202955.ztkmpbl2wz4igfo7@rob-hp-laptop>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
 <20180330171822.25896-6-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330171822.25896-6-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 07:18:19PM +0200, Sebastian Reichel wrote:
> Merge "rotation" property description into common panel
> binding.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  .../devicetree/bindings/display/panel/panel-common.txt       | 12 ++++++++++++
>  Documentation/devicetree/bindings/display/panel/panel.txt    |  4 ----
>  2 files changed, 12 insertions(+), 4 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/panel.txt

Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for consolidating.

Rob
