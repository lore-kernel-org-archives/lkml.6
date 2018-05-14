Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeENMte (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:49:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37792 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbeENMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:49:33 -0400
X-Google-Smtp-Source: AB8JxZrJq8In87Jkej02APHbR5/qtTv6YQR+Nogx5iNajnJDxG1IajDh3fuIQ4m7Tg09+gmlALRuog==
Date: Mon, 14 May 2018 14:49:28 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clocksource/drivers/mips-gic-timer: Add pr_fmt and
 reword pr_* messages
Message-ID: <20180514124928.GF29062@mai>
References: <1513781406-27292-1-git-send-email-matt.redfearn@mips.com>
 <1522316943-2542-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522316943-2542-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 10:49:03AM +0100, Matt Redfearn wrote:
> Several messages from the MIPS GIC driver include the text "GIC", "GIC
> timer", etc, but the format is not standard. Add a pr_fmt of
> "mips-gic-timer: " and reword the messages now that they will be
> prefixed with the driver name.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---

Applied, thanks for the head up.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
