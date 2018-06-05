Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeFEL5n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:57:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48988 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeFEL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:57:42 -0400
Subject: Re: [PATCH 1/9] platform/chrome: cros_ec: Switch to SPDX identifier.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <20180605092209.22887-2-enric.balletbo@collabora.com>
From: Emilio Pozuelo Monfort <emilio.pozuelo@collabora.co.uk>
Message-ID: <2c125b86-bd33-a9a1-d0f3-706043e685c5@collabora.co.uk>
Date: Tue, 5 Jun 2018 13:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605092209.22887-2-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 05/06/18 11:22, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/platform/chrome/cros_ec_debugfs.c     | 22 +++-------------
>  drivers/platform/chrome/cros_ec_lightbar.c    | 22 +++-------------
>  drivers/platform/chrome/cros_ec_lpc.c         | 26 +++----------------
>  drivers/platform/chrome/cros_ec_lpc_mec.c     | 26 +++----------------
>  drivers/platform/chrome/cros_ec_lpc_reg.c     | 26 +++----------------
>  drivers/platform/chrome/cros_ec_proto.c       | 19 +++-----------
>  drivers/platform/chrome/cros_ec_sysfs.c       | 22 +++-------------
>  drivers/platform/chrome/cros_ec_vbc.c         | 24 ++++-------------
>  .../platform/chrome/cros_kbd_led_backlight.c  | 19 +++-----------
>  9 files changed, 37 insertions(+), 169 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index c62ee8e610a0..67c62934368a 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -1,21 +1,7 @@
> -/*
> - * cros_ec_debugfs - debug logs for Chrome OS EC
> - *
> - * Copyright 2015 Google, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program. If not, see <http://www.gnu.org/licenses/>.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Debug logs for ChromeOS EC.
> +//
> +// Copyright (C) 2012 Google, Inc.

Copy paste error, s/2012/2015/ ?

Cheers,
Emilio
