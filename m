Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeBPIED (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:04:03 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37238 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbeBPIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:04:01 -0500
X-Google-Smtp-Source: AH8x225usmS2dFkx3Sblu6KKg8dcKugy4kvH8+yW8Bg436xu85awfAWqFgYbaioWZlAsnXm5mbWAyg==
Subject: Re: [PATCH] ARM: cpuidle: Delete an error message for a failed memory
 allocation in arm_idle_init_cpu()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <7f419639-edfc-adb8-1dd2-d16b0dbfe19d@users.sourceforge.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <582de86a-d0bd-3f2d-0cbd-cf0a7ca924d8@linaro.org>
Date: Fri, 16 Feb 2018 09:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7f419639-edfc-adb8-1dd2-d16b0dbfe19d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2018 16:46, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 16:40:38 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
