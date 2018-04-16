Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbeDPMQQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754098AbeDPMQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:16:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAA621834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx48z6TLe/caGzy8Z90w9VjhlKekOtTYzqDRYnioKhZpF/7sudO8mUunLKiqJYUD7ItToYq0wT+Pt08cy5DlKGP0=
MIME-Version: 1.0
In-Reply-To: <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180416101425epcas1p46ab4d827e3a64c5c16b32a17f63dd9d0@epcas1p4.samsung.com>
 <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com> <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 16 Apr 2018 14:16:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc2DoUgorHct30hkK4W8AsAGWrdUxtCYT4oeekJ-FhaAw@mail.gmail.com>
Message-ID: <CAJKOXPc2DoUgorHct30hkK4W8AsAGWrdUxtCYT4oeekJ-FhaAw@mail.gmail.com>
Subject: Re: [PATCH 13/14] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 12:12 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Remove no longer needed samsung thermal properties.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi                 |  2 +-
>  arch/arm/boot/dts/exynos4.dtsi                    |  2 +-
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 20 --------------------
>  arch/arm/boot/dts/exynos5250.dtsi                 |  2 +-
>  arch/arm/boot/dts/exynos5410.dtsi                 |  8 ++++----
>  arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi | 21 ---------------------
>  arch/arm/boot/dts/exynos5420.dtsi                 | 10 +++++-----
>  arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi | 20 --------------------
>  arch/arm/boot/dts/exynos5440.dtsi                 |  6 +++---
>  9 files changed, 15 insertions(+), 76 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
>  delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi

Thanks for splitting. Looks good. I'll take both (#13 and #14) after
thermal changes hit mainline (so probably for v4.19).
https://patchwork.kernel.org/bundle/krzk/for-v4.19/

Best regards,
Krzysztof
