Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeCKRoP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 13:44:15 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:54971 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbeCKRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 13:44:13 -0400
X-Google-Smtp-Source: AG47ELuG0XDyv8f0s+wflbWNwP9showRpzJ8WPxTVSz0NVmtKIt2ukeY6ZAaRB2DKjBg7ZME5cKdug==
Date: Sun, 11 Mar 2018 18:44:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 3/6] ARM: dts: exynos: Update of the max98095 node in
 exynos5250-snow.dts
Message-ID: <20180311174409.wx5zfskvh7zbnivz@kozik-lap>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172414epcas1p36b0c39ad993afcad7f8cf8941cc6bf68@epcas1p3.samsung.com>
 <20180309172250.23019-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172250.23019-3-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 06:22:47PM +0100, Sylwester Nawrocki wrote:
> This patch adds missing clocks, clock-names properties so the CODEC can
> properly handle its master clock. Without this change sound on exynos5250-snow
> doesn't work.
> Missing #sound-dai-cells property is also added so it is possible to specify
> the DAI links properly for HDMI audio support.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - edited commit summary line.
> ---
>  arch/arm/boot/dts/exynos5250-snow.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
