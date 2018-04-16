Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755066AbeDPNQ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:16:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36764 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755030AbeDPNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:16:54 -0400
X-Google-Smtp-Source: AIpwx4+uGQqGFerrfam8z1N3WbRflJQvBbCyKSKKGODodMByQHNuSJSD743VQTvoOCizbzUCV1rb2w==
Subject: Re: [PATCH 09/14] thermal: exynos: remove parsing of
 samsung,tmu_reference_voltage property
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101412epcas2p241ac78d221c7c288e79fc410dd90d6ab@epcas2p2.samsung.com>
 <1523873525-23718-10-git-send-email-b.zolnierkie@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <02ebf806-4c33-0bf2-8450-1452fdb7ec8b@linaro.org>
Date: Mon, 16 Apr 2018 15:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523873525-23718-10-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 12:12, Bartlomiej Zolnierkiewicz wrote:
> Since pdata reference_voltage values are SoC (not platform) specific
> just move it from platform data to struct exynos_tmu_data instance.
> Then remove parsing of samsung,tmu_reference_voltage property.
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
