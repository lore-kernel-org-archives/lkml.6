Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeCKRnf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 13:43:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33241 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbeCKRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 13:43:33 -0400
X-Google-Smtp-Source: AG47ELs5t7Dphj1Tw+aMZk2d6fggYwUiorZvaaCn6njDd4MgGkVcf5qxNO7v28cRyw7VLEcsaYSWrw==
Date: Sun, 11 Mar 2018 18:43:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 6/6] ARM: dts: exynos: Enable HDMI audio support on
 exynos5800-peach-pi
Message-ID: <20180311174328.zosfqmgqmkion3i7@kozik-lap>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172450epcas1p2b845a521afbadc81da991330bdbc588c@epcas1p2.samsung.com>
 <20180309172250.23019-6-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172250.23019-6-s.nawrocki@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 06:22:50PM +0100, Sylwester Nawrocki wrote:
> This patch adds new cpu, codec subnodes according to the updated
> "google,snow-audio-max98091" DT bindings and the I2S clock tree
> configuration so sound on the HDMI interface can be also supported.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> NOTE:
> I couldn't test this patch as I have no access to Peach-pi Chromebook.
> I think it shouldn't be applied unless someone actually tests it.
> 
> Changes since v1:
>  - edited commit summary line.
> ---
>  arch/arm/boot/dts/exynos5800-peach-pi.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
