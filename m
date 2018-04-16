Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755141AbeDPNSg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:18:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39803 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754751AbeDPNSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:18:34 -0400
X-Google-Smtp-Source: AIpwx48w74Mo9nAutCFeHknz9osrut70pBZCbkR/iVYxaUB2wYjjMb8nSiz2XOaClxynrCwy9CMPWw==
Subject: Re: [PATCH 10/14] thermal: exynos: remove parsing of samsung,tmu_gain
 property
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101415epcas1p1b1108c9d654a7b2832179b5c1f49ff4a@epcas1p1.samsung.com>
 <1523873525-23718-11-git-send-email-b.zolnierkie@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c858e8a1-b6da-39d5-61d3-041beafc7c41@linaro.org>
Date: Mon, 16 Apr 2018 15:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523873525-23718-11-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 12:12, Bartlomiej Zolnierkiewicz wrote:
> Since pdata gain values are SoC (not platform) specific just move
> it from platform data to struct exynos_tmu_data instance. Then
> remove parsing of samsung,tmu_gain property.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
