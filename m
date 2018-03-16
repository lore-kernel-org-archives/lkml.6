Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeCPW5d convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbeCPW5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:57:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375A620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180220151531.3379003-1-arnd@arndb.de>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180220151531.3379003-1-arnd@arndb.de>
Message-ID: <152124105054.242365.69354305607503548@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: hisilicon: mark wdt_mux_p[] as const
Date: Fri, 16 Mar 2018 15:57:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2018-02-20 07:15:21)
> The symbol is in the __initconst section but not marked init, which
> caused a warning when building with LTO.
> 
> This makes it 'const' as was obviously intended.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next
