Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeCPGAd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:00:33 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:17176 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeCPGAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:00:32 -0400
Subject: Re: [PATCH v2 1/6] phy: rockchip-typec: fall back to working in
 host-mode if extcon is missing.
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-2-enric.balletbo@collabora.com>
 <20019382.PXhIOVQJGo@diego>
CC: <groeck@chromium.org>, <gwendal@chromium.org>, <kernel@collabora.com>,
        <vicencb@gmail.com>, <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <32f24fca-7d89-6edf-26a4-8dc7d1d1ea31@ti.com>
Date: Fri, 16 Mar 2018 11:29:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20019382.PXhIOVQJGo@diego>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 14 March 2018 01:44 PM, Heiko Stübner wrote:
> Hi Kishon,
> 
> Am Donnerstag, 1. März 2018, 16:25:10 CET schrieb Enric Balletbo i Serra:
>> Right now the rockchip type-c phy does fail probing when no extcon is
>> detected. Some boards get the cable-state via the extcon interface and
>> have this supported, other boards seem to use the fusb302 chip or
>> another but the driver currently does not seem to utilize the extcon
>> interface to report the cable-state. And, other, just connect the type-c
>> to a standard USB-A port so use no controller at all. A missing extcon
>> shouldn't fail to probe, instead, should just fall back to working in
>> host-mode if it cannot get the extcon.
>>
>> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
>> support for rk3399") Reported-by: Vicente Bergas <vicencb@gmail.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> I did revert the original commit mentioned in the fixes tag for 4.16-rc
> but it would nevertheless be really cool if these 2 patches (code + binding)
> could make it into your tree for 4.17 :-)
> 
> And ideally also with the other 5 patches from Enric starting at
> 	[PATCH v3 1/6] phy: rockchip-typec: deprecate some DT properties for various register fields.
> 
> from 2018-02-16.

merged now, thanks!

-Kishon
