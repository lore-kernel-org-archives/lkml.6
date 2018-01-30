Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeA3TNB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:13:01 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45008 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeA3TM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:12:58 -0500
X-Google-Smtp-Source: AH8x225XjrlL1C3MikQgVA0fK4YlzvgQklLTBDr57fwpnNyfLhEgfD6TS2NLfBDJJ/xscpQD81cwTg==
Message-ID: <1517339575.3153.11.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson: add axg misc bit to the mpll driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 30 Jan 2018 20:12:55 +0100
In-Reply-To: <20180119154236.9797-1-jbrunet@baylibre.com>
References: <20180119154236.9797-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-01-19 at 16:42 +0100, Jerome Brunet wrote:
> On axg, the rate of the mpll is stuck as if sdm value was 4 and could not
> change (expect for mpll2 strangely). Looking at the vendor kernel, it
> turns out a new magic bit from the undocumented HHI_PLL_TOP_MISC register
> is required.
> 
> Setting this bit solves the problem and the mpll rates are back to normal
> 
> Fixes: 78b4af312f91 ("clk: meson-axg: add clock controller drivers")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to clk-meson next/drivers
