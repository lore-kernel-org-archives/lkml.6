Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeEAVbW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750743AbeEAVbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:31:17 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Dietrich <marvin24@gmx.de>, Marcel Ziswiler <marcel@ziswiler.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180426235818.10018-4-digetx@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180426235818.10018-1-digetx@gmail.com>
 <20180426235818.10018-4-digetx@gmail.com>
Message-ID: <152521027630.138124.3736014507579667653@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 3/4] clk: tegra20: Set correct parents for CDEV1/2 clocks
Date: Tue, 01 May 2018 14:31:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2018-04-26 16:58:17)
> Parents of CDEV1/2 clocks are determined by muxing of the corresponding
> pins. Pinctrl driver now provides the CDEV1/2 clock muxes and hence
> CDEV1/2 clocks could have correct parents. Set CDEV1/2 parents to the
> corresponding muxes to fix the parents.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
