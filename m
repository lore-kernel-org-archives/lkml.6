Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeDSENs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:13:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40515 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeDSENq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:13:46 -0400
X-Google-Smtp-Source: AIpwx49A/4htsQrCX9Yqa/ieuGsIdxL7m4biceByunL8WLKBpbTs3l++NxLP86iNOp7z8u3ueotTvg==
Date: Thu, 19 Apr 2018 09:43:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Power Management List <linux-pm@vger.kernel.org>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: brcmstb-avs-cpufreq: remove development
 debug support
Message-ID: <20180419041342.GE24576@vireshk-i7>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-2-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418155643.36464-2-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-18, 08:56, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> This debug code was helpful while developing the driver, but it isn't
> being used for anything anymore.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig.arm           |  10 --
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 323 +---------------------------------
>  2 files changed, 1 insertion(+), 332 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
