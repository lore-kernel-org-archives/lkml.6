Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758648AbeBPQzD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:55:03 -0500
Received: from muru.com ([72.249.23.125]:57304 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755519AbeBPQzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:55:01 -0500
Date: Fri, 16 Feb 2018 08:54:57 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
Message-ID: <20180216165456.GV6364@atomide.com>
References: <20180209161456.18951-1-tony@atomide.com>
 <CAHp75VcSRxLZJxmqXWpAGypvZa6W2cEAiTF2muJWqdaOYu_TpA@mail.gmail.com>
 <CAJZ5v0gRtkBf7uu4C_k7ivNGo=JM0bB1PAdr_6Nbbs39OPevHw@mail.gmail.com>
 <CAHp75VcVNDV9FmPFTBHsJRoiHtOviwC68Wk+aCqhqteZw41ZzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcVNDV9FmPFTBHsJRoiHtOviwC68Wk+aCqhqteZw41ZzQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [180216 10:40]:
> Sorry, I was thinking that Tony may test it first to see if it does
> what he wants.

Well using dev_name() for the wakeirq name might still conflict
with the device IO interrupt. But yeah I'll give it a try.

Regards,

Tony
