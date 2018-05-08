Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeEHBoz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:44:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34611 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753605AbeEHBox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:44:53 -0400
X-Google-Smtp-Source: AB8JxZpLFHyotA29yAQpWVNUEZe3Z9TL3Xl7PC/uMiInYJiUnPBdTVIo851meBklLIzPdr8dc/GwGw==
Date: Tue, 8 May 2018 03:44:49 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Cc: linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@spreadtrum.com>,
        Orson Zhai <orson.zhai@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V2] clocksource/drivers/sprd: Fix Kconfig dependency
Message-ID: <20180508014449.GG19313@mai>
References: <1525683887-17584-1-git-send-email-chunyan.zhang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525683887-17584-1-git-send-email-chunyan.zhang@spreadtrum.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 05:04:47PM +0800, Chunyan Zhang wrote:
> SPRD arch doesn't select SPRD_TIMER, so this config would not
> appear even if ARCH_SPRD is set but COMPILE_TEST not.
> 
> Fix the dependency of this config with SPRD arch, and set a
> default value for it, also leave other choices for EXPERT.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---

Applied, thanks.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
