Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbeA3TML (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:12:11 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:40460 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeA3TMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:12:09 -0500
X-Google-Smtp-Source: AH8x226w5r2Js33FdNkEhdhGT89yBeB++F+4xUl1Fci+Cy5qV8BVVZ6ghnWn7btYexQVOchbrPySRA==
Message-ID: <1517339526.3153.10.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson: axg: fix the od shift of the sys_pll
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 30 Jan 2018 20:12:06 +0100
In-Reply-To: <20180119020926.246887-1-yixun.lan@amlogic.com>
References: <20180119020926.246887-1-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-01-19 at 10:09 +0800, Yixun Lan wrote:
> According to datasheet, the od shift of sys_pll is 16,
> fix the typo which introduced at previous commit.
> 
> Fixes: 78b4af312f91 ('clk: meson-axg: add clock controller drivers')
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to clk-meson next/drivers after fixing the commit message a bit
Thx

Jerome
