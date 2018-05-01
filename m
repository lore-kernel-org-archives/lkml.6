Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeEAIge (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:36:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44269 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbeEAIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:36:31 -0400
X-Google-Smtp-Source: AB8JxZoy2Z/+GNmRA++Lwrc5/yHzJyOj41J+0PPuyAa9YL9EKT/ak1LqZsv0TGWR6t90mv4LbBHxlA==
Date: Tue, 1 May 2018 10:36:26 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/timer-atmel-pit: properly handle
 error cases
Message-ID: <20180501083626.GE27619@mai>
References: <20180425101439.28908-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180425101439.28908-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 12:14:39PM +0200, Alexandre Belloni wrote:
> smatch now reports a possible leak:
> 
> smatch warnings:
> drivers/clocksource/timer-atmel-pit.c:183 at91sam926x_pit_dt_init() warn: possible memory leak of 'data'
> 
> Ensure data is freed before exiting with an error.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied for 4.17-rc

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
