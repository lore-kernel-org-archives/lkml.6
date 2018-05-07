Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeEGFvh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 01:51:37 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38404 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbeEGFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 01:51:34 -0400
X-Google-Smtp-Source: AB8JxZq2X5SdrJ+lW1OmHEf/e77HqKjbPP+SS+wSJv5napt0V5HyX981JiqcN1zoBPBv0IorjYpO6A==
Date: Mon, 7 May 2018 07:51:30 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Cc: linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@spreadtrum.com>,
        Orson Zhai <orson.zhai@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] clocksource/drivers/sprd: Fix Kconfig dependency
Message-ID: <20180507055130.GA19313@mai>
References: <1525350452-14433-1-git-send-email-chunyan.zhang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525350452-14433-1-git-send-email-chunyan.zhang@spreadtrum.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:27:32PM +0800, Chunyan Zhang wrote:
> SPRD arch doesn't select SPRD_TIMER, so this config would not
> appear even if ARCH_SPRD is set and COMPILE_TEST is not.
> 
> Fix the Kconfig selection rule by letting the SPRD arch to select.

Instead of changing this Kconfig, please fix the arch's Kconfig by selecting
SPRD_TIMER.



-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
