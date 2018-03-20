Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeCTObv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:31:51 -0400
Received: from muru.com ([72.249.23.125]:32814 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCTObs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:31:48 -0400
Date: Tue, 20 Mar 2018 07:31:34 -0700
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv2 0/8] omapdrm: DSI command mode panel support
Message-ID: <20180320143134.GZ5799@atomide.com>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomi,

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180208 10:31]:
> Hi,
> 
> These are the remaining patches from my previous patchset to get
> Droid 4 (omap4) display working. The patches have been rebased to
> current master branch from Torvalds (581e400ff935). Since N950
> (omap3) is broken even with the workaround I moved it to the end,
> so that it can be skipped.

Seems like the first three patches of these could be applied
for v4.17 separate from the rotation and omap3 related issues?

Regards,

Tony
