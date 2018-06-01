Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeFATUm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753299AbeFATUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:20:39 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
Message-ID: <152788083877.225090.16757573144833344500@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clkdev: Remove duplicated negative index check from
 __of_clk_get()
Date: Fri, 01 Jun 2018 12:20:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51JL9rf027195

Quoting Geert Uytterhoeven (2018-05-18 03:58:40)
> __of_clk_get() calls of_parse_phandle_with_args(), which rejects
> negative indices since commit bd69f73f2c81eed9 ("of: Create function for
> counting number of phandles in a property").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Commit bd69f73f2c81eed9 is in v3.9.

Did you send this to Russell's patch tracker? Otherwise I can pick it up
to clk-next.
