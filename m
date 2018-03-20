Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeCTO3C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:29:02 -0400
Received: from muru.com ([72.249.23.125]:32772 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751261AbeCTO3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:29:01 -0400
Date: Tue, 20 Mar 2018 07:28:57 -0700
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv2 2/8] drm/omap: add manual update detection helper
Message-ID: <20180320142857.GX5799@atomide.com>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
 <20180208183035.8461-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208183035.8461-3-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180208 18:31]:
> In preparation for manually updated display support, such as DSI
> command mode panels, this adds a simple helper to see if a connector
> is manually updated.

Tested-by: Tony Lindgren <tony@atomide.com>
