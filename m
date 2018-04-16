Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeDPQHr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeDPQHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:07:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904A6217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180409105438.2402477-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180409105438.2402477-1-arnd@arndb.de>
Message-ID: <152389486496.51482.1409018821443408273@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: cs2000: mark resume function as __maybe_unused
Date: Mon, 16 Apr 2018 09:07:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2018-04-09 03:54:34)
> When power management is disabled, we get a harmless warning:
> 
> drivers/clk/clk-cs2000-cp.c:544:12: error: 'cs2000_resume' defined but not used [-Werror=unused-function]
> 
> Marking the function as __maybe_unused lets the compiler silently
> drop it instead.
> 
> Fixes: eade4ccdb087 ("clk: cs2000: set pm_ops in hibernate-compatible way")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-fixes
