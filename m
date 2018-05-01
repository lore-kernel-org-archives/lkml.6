Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeEAVbC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750743AbeEAVbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:31:00 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180430112804.GA5770@ulmo>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180426235818.10018-1-digetx@gmail.com> <20180430094821.GC2476@ulmo>
 <20180430112804.GA5770@ulmo>
Message-ID: <152521025891.138124.9469961084981688474@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 0/4] Restore ULPI USB on Tegra20
Date: Tue, 01 May 2018 14:30:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thierry Reding (2018-04-30 04:28:04)
> On Mon, Apr 30, 2018 at 11:48:21AM +0200, Thierry Reding wrote:
> > 
> > as far as I can tell there aren't any build dependencies between the
> > above, so technically these could all be merged through the individual
> > trees. There's a runtime dependency from patch 2 on patch 1 and from
> > patch 3 on patch 2, though I don't think they will cause any actual
> > failures at runtime.
> > 
> > But I can also pick this up into the Tegra tree and send out pull
> > requests to you for v4.18 (at around v4.17-rc6), if that's what you
> > prefer.
> 
> Marc just pointed out to me on IRC that this fixes a regression that was
> introduced in v4.17-rc1.
> 
> Can you guys pick this up into your -fixes branches? Again, I volunteer
> to collect these into a separate branch and submit via ARM SoC (the DTS
> patch is crucial in enabling the fix) with your Acked-bys if that's the
> preferred option.
> 

Will it go via ARM SoC? I can ack 1 and 3 and it can go that way.
