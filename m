Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeEORCe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:02:34 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38347 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeEORCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:02:32 -0400
X-Google-Smtp-Source: AB8JxZq7lIKCrCylF75b5SZl/E3H7px7Io8AqBHfvkJ9dgG4hiEls+Z1x3V6ufOB6fSjZanMgcSS0GrPHn9m4FO8G/I=
MIME-Version: 1.0
In-Reply-To: <20180515164229.4606-1-jbrunet@baylibre.com>
References: <20180515164229.4606-1-jbrunet@baylibre.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 15 May 2018 14:02:31 -0300
Message-ID: <CAOMZO5A20PRCgajpc7FaaWdGEGi13dV+dO9Z9SLDZEhxfs94Mw@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: use SPDX license identifiers consistently
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 1:42 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:

> diff --git a/drivers/clk/meson/clk-audio-divider.c b/drivers/clk/meson/clk-audio-divider.c
> index f7ab5b1db342..ac0743cd0f2f 100644
> --- a/drivers/clk/meson/clk-audio-divider.c
> +++ b/drivers/clk/meson/clk-audio-divider.c
> @@ -1,18 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+

Here you put GPL2.0+, but it should be GPL2.0 instead

>  /*
>   * Copyright (c) 2017 AmLogic, Inc.
>   * Author: Jerome Brunet <jbrunet@baylibre.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.

.... according to the original text.
