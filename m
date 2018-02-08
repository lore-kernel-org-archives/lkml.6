Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBHKxf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:53:35 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:20854 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeBHKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:53:33 -0500
Subject: Re: [PATCHv1 00/14] omapdrm: DSI command mode panel support
To: Pavel Machek <pavel@ucw.cz>
CC: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
 <5c747b23-c586-4997-cf92-2725483343c5@ti.com> <20180208094105.GB4595@amd>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <7202f913-8048-885a-ac90-eeb49a3bed31@ti.com>
Date: Thu, 8 Feb 2018 12:53:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208094105.GB4595@amd>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/18 11:41, Pavel Machek wrote:
> Hi!
> 
>> I've also picked patches 7-12.
> 
> It seems that part of the support made it to v4.16. Is it supposed to
> be complete?
> 
> I still have these in my tree, and result works on Nokia N9. Is there
> any way I can help with the merge?

I picked the patches that seemed safe to pick. I think we can do another
review round if someone rebases and posts the patches. Although I see
that they have conflicts with other patches that have been posted, so
we'll see how it goes.

Btw, you seem to have something in your tree that was not in the series.
Nothing in the series touches mipi_display.h.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
