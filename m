Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754787AbeDPM5w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:57:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40305 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754471AbeDPM5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:57:51 -0400
X-Google-Smtp-Source: AIpwx48vo1KzFavtKS9+z7IANKP5WeQHalEK1ekQMALCD9LLi8wBjEbXnEsaKyyniiyWbwfzjXgHPA==
Subject: Re: [PATCH 06/14] thermal: exynos: remove parsing of
 samsung,tmu_[first,second]_point_trim properties
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101403epcas2p23c050a54c2cc8af9c8be76061d560937@epcas2p2.samsung.com>
 <1523873525-23718-7-git-send-email-b.zolnierkie@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <56dc5d6f-5345-2df5-109e-29109917d55e@linaro.org>
Date: Mon, 16 Apr 2018 14:57:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523873525-23718-7-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> All SoCs use the same values (25, 85) for trim points (except
> Exynos5440 which currently specifices value 70 for the second trim
> point -> it seems to be a mistake because documentation uses value
> 85 and two points based trimming has never been used by the driver
> for this SoC anyway) so just make it explicit and remove parsing of
> samsung,tmu_[first,second]_point_trim properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
