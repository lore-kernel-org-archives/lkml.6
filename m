Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeENQlV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:41:21 -0400
Received: from muru.com ([72.249.23.125]:41980 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752988AbeENQlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:41:19 -0400
Date: Mon, 14 May 2018 09:41:15 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: MMC performance degradation due to too many requests
Message-ID: <20180514164115.GL98604@atomide.com>
References: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180514 11:31]:
> Hi Everyone,
> 
> I am debugging a performance degradation issue in some SD cards which
> happened around 4.13 kernel on TI's AM335x-evm.
> 
> I compare the time taken for a simple dd command (after dropping
> caches) to run between kernel versions 4.13 and 4.14. I see that there
> is a consistent 15-20% reduction in speed. The amount of decrease
> depends on the card used.

Care to run git bisect between v4.13 and v4.14? Seems like that
should work just fine between that range for boot and performance
testing.

Regards,

Tony
