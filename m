Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeCIMyb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:54:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeCIMy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:54:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF7621771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AG47ELuBqcbeed8Z3BJATyPYRW9DXU96Xa5mRIySPLSQTQMxgcLrZaMiibjc64mQe5vWhyk5++nXQQjaXzDd7wwVAhg=
MIME-Version: 1.0
In-Reply-To: <20180307172711.15697-1-s.nawrocki@samsung.com>
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
 <20180307172711.15697-1-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 9 Mar 2018 13:54:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdgsNwcVQ0FZLDR_q8Dz1AkSEBaG-1Mij7TKSLpSRJLpw@mail.gmail.com>
Message-ID: <CAJKOXPdgsNwcVQ0FZLDR_q8Dz1AkSEBaG-1Mij7TKSLpSRJLpw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property
 to hdmi device node
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 6:27 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> This property is required for specifying link between the HDMI IP block
> and the SoC's audio subsystem.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Subject prefix:
ARM: dts: exynos: Add..... to Exynos5250

Please fix it here and in other places. For arm64 prefix is slightly
different (arm64: dts: exynos:). I did not notice that in your last
patches and applied them but please take care about this in future.

In case you forget how the prefix should look like - run "git log
--oneline -- arch/arm/boot/dts/exynos*" or "git log --oneline --
arch/arm64/boot/dts/exynos/".

BR,
Krzysztof
