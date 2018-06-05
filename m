Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeFESEw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:04:52 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:37300 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeFESEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:04:50 -0400
X-Google-Smtp-Source: ADUXVKIOerJhETV0S8mMjkXVKzFjgmEdwPx8+3xD2wp+H8uEnFuSZX+k5Xb5+y889zujIJi5yI6LQi0lPgGfSlDTMzQ=
MIME-Version: 1.0
In-Reply-To: <20180605175429.9072-6-enric.balletbo@collabora.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com> <20180605175429.9072-6-enric.balletbo@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Jun 2018 15:04:49 -0300
Message-ID: <CAOMZO5ByhMV9_gRHLmGiSNJtCvKEOk==ZMz2O2=tokZh2ps4xg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] Input: cros_ec_keyb - Switch to SPDX identifier.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Tue, Jun 5, 2018 at 2:54 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2:
> - [6/9] Do not remove last paragraph.
>
>  drivers/input/keyboard/cros_ec_keyb.c | 34 ++++++++++-----------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 79eb29550c34..91b2839c12df 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -1,25 +1,15 @@
> -/*
> - * ChromeOS EC keyboard driver
> - *
> - * Copyright (C) 2012 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and

Original text says GPL-2.0...

> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0+

but here you add a GPL-2.0+ type.
