Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeCEVIV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:08:21 -0500
Received: from gloria.sntech.de ([95.129.55.99]:42146 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752440AbeCEVIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:08:20 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.egorov@phytec.de
Subject: Re: [PATCH] ARM: dts: rockchip: Add dp83867 CLK_OUT muxing
Date: Mon, 05 Mar 2018 22:08:14 +0100
Message-ID: <2707703.8mZIocJ1Ne@diego>
In-Reply-To: <3380975.Amu1WGHSQ5@diego>
References: <1520253911-46218-1-git-send-email-d.schultz@phytec.de> <3380975.Amu1WGHSQ5@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. März 2018, 21:25:30 CET schrieb Heiko Stübner:
> Am Montag, 5. März 2018, 13:45:11 CET schrieb Daniel Schultz:
> > The CLK_O_SEL default is synchronous to XI input clock, which is 25 MHz.
> > Set CLK_O_SEL to channel A transmit clock so we have 125 MHz on CLK_OUT.
> > 
> > Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> 
> applied for 4.17

had to move it to 4.18 though.

The change to the dt-binding header goes through the networking
tree and will only get merged for 4.17-rc1 .

So devicetree changes in a different branch aren't available at this
point.

One commonly practiced alternative is that you provide a v2
with the actual hex values instead of the constants for 4.17
and a follow-up patch replacing them with the constants
that I can apply for 4.18.


Heiko
