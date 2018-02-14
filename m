Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeBNIHo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:07:44 -0500
Received: from gloria.sntech.de ([95.129.55.99]:39686 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754530AbeBNIHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:07:42 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: rockchip: phycore: Remove 1.8 GHz operation point
Date: Wed, 14 Feb 2018 09:07:31 +0100
Message-ID: <7871181.EPqc8gR4GV@diego>
In-Reply-To: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
References: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 13. Februar 2018, 10:44:32 CET schrieb Daniel Schultz:
> Rockchip recommends to run the CPU cores only with operations points of
> 1.6 GHz or lower.
> 
> Removed the cpu0 node with too high operation points and use the default
> values instead.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

applied all 3 for 4.17


Thanks
Heiko
