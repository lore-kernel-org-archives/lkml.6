Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeBVKL5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:11:57 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40141 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeBVKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:11:55 -0500
X-Google-Smtp-Source: AH8x227Fe2LbY2hh6wYUQOJt4B0DhVQwNHK5P6rWUhhuPvbhLUewyVPMrxuaJIvCOcgVAeKE6A7kjA==
Subject: Re: [PATCH 06/13] clocksource: Remove metag generic timer driver
To: James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20180221233825.10024-1-jhogan@kernel.org>
 <20180221233825.10024-7-jhogan@kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aa34648c-5fff-b47f-674c-135611d0ff75@linaro.org>
Date: Thu, 22 Feb 2018 11:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221233825.10024-7-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2018 00:38, James Hogan wrote:
> Now that arch/metag/ has been removed, remove the metag generic
> per-thread timer driver. It is of no value without the architecture
> code.
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-metag@vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
