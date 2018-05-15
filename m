Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeEOR6d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753039AbeEOR6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:58:31 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180515164229.4606-1-jbrunet@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180515164229.4606-1-jbrunet@baylibre.com>
Message-ID: <152640711006.34267.13271626390751114709@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: meson: use SPDX license identifiers consistently
Date: Tue, 15 May 2018 10:58:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FHwcOn013378

Quoting Jerome Brunet (2018-05-15 09:42:29)
> diff --git a/drivers/clk/meson/clk-audio-divider.c b/drivers/clk/meson/clk-audio-divider.c
> index f7ab5b1db342..ac0743cd0f2f 100644
> --- a/drivers/clk/meson/clk-audio-divider.c
> +++ b/drivers/clk/meson/clk-audio-divider.c
> @@ -1,18 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+

This is GPL2 or later.

>  /*
>   * Copyright (c) 2017 AmLogic, Inc.
>   * Author: Jerome Brunet <jbrunet@baylibre.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.

But this looks like GPL2 only because there isn't an "or later" part of
the text. Is it intentional to relicense to GPL2+ instead of GPL2 only?
If so, please add that into the commit text.
