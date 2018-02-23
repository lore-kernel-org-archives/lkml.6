Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeBWWEo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:04:44 -0500
Received: from muru.com ([72.249.23.125]:58092 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbeBWWEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:04:43 -0500
Date: Fri, 23 Feb 2018 14:04:40 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
Message-ID: <20180223220440.GC5593@atomide.com>
References: <20180209161456.18951-1-tony@atomide.com>
 <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [180214 10:24]:
> Subject: [PATCH] genirq: Add wakeup sysfs node to show IRQ wakeup state
> 
> Surprisingly there is no simple way to see if the IRQ line in question
> is wakeup source or not.

Finally got around trying this one. Yeah it's nice and it seems
that this is how we could also allow add support for showing the
time when the wakeirq triggered and was actually seen by the irq
subsystem. I think that's what people have been after for a
while :)

It seems we should do both /sys/kernel/irq/*/wakeup and also
have a name for the dedicated wakeirqs. I'll send out my
kasprintf updated patch shortly.

Regards,

Tony
