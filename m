Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034246AbeCBHnQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:43:16 -0500
Received: from gloria.sntech.de ([95.129.55.99]:57258 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936128AbeCBHnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:43:15 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, dianders@google.com,
        groeck@chromium.org, briannorris@google.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] arm64: dts: rockchip: add usb3-phy otg-port support for rk3399.
Date: Fri, 02 Mar 2018 08:43:08 +0100
Message-ID: <1798650.vypR2cBVd9@phil>
In-Reply-To: <9229851.uS1UDVWbBb@phil>
References: <20171215110005.7564-1-enric.balletbo@collabora.com> <20171215110005.7564-3-enric.balletbo@collabora.com> <9229851.uS1UDVWbBb@phil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 16. Dezember 2017, 18:06:50 CET schrieb Heiko Stuebner:
> Am Freitag, 15. Dezember 2017, 12:00:03 CET schrieb Enric Balletbo i Serra:
> > Add the usb3 phyter for the USB3.0 OTG controller.
> > 
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> applied for 4.16

and reverted again for the 4.16 cycle due to the regressions it causes on
non-gru boards.

I've requeued it in my temporary 4.18 branch and will readd it once
the typec-phy changeset gets merged.


Heiko
