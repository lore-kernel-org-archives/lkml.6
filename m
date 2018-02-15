Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755246AbeBOJaE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:30:04 -0500
Received: from gloria.sntech.de ([95.129.55.99]:55986 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755145AbeBOJaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:30:02 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wadim Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH 1/3] ARM: dts: rockchip: phycore: Remove 1.8 GHz operation point
Date: Thu, 15 Feb 2018 10:29:52 +0100
Message-ID: <2724471.chboOZt3hh@diego>
In-Reply-To: <a8de3d85-c4e6-eed6-d2e3-6d9b7318a9c2@phytec.de>
References: <1518515074-22526-1-git-send-email-d.schultz@phytec.de> <7871181.EPqc8gR4GV@diego> <a8de3d85-c4e6-eed6-d2e3-6d9b7318a9c2@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am Mittwoch, 14. Februar 2018, 16:32:44 CET schrieb Daniel Schultz:
> On 02/14/2018 09:07 AM, Heiko Stübner wrote:
> > Am Dienstag, 13. Februar 2018, 10:44:32 CET schrieb Daniel Schultz:
> >> Rockchip recommends to run the CPU cores only with operations points of
> >> 1.6 GHz or lower.
> >> 
> >> Removed the cpu0 node with too high operation points and use the default
> >> values instead.
> >> 
> >> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> > 
> > applied all 3 for 4.17
> 
> Thanks! I think I should have mentioned this earlier, but can you please add
> ARM: dts: rockchip: phycore: Remove 1.8 GHz operation point
> to the stable tree v4.14?

I've moved that patch to the fixes branch and added the necessary
Fixes and cc-stable tags, so it should eventually reach stable kernels
as well.


Heiko
