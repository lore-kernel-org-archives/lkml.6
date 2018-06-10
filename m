Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id umF+FP0pHVvWfgAAmS7hNA
	; Sun, 10 Jun 2018 13:40:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DFDF360791; Sun, 10 Jun 2018 13:40:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em+slDnw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 23825600D0;
	Sun, 10 Jun 2018 13:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23825600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeFJNki (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 09:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753524AbeFJNkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 09:40:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33F72088E;
        Sun, 10 Jun 2018 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528638036;
        bh=NNDf48HNRvgwMhI3UKXEs8oEMIBFVkunbYS/Y2VJQ4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Em+slDnwADDGnsrDFZDo8sYQ7XPyxP3jC2eycE+6IqnA8RVZLhEcEZ0lflGjwMcMg
         5tGOrg1n5qiaZQlAuns/vvgAM/OwOXpn/0Mr2+hVL3x86xhbgmGurh9op8t13KST11
         zeHJzsSjLyGc1t54zlta3xj+HJ5J2+MVT9XCtPWM=
Date: Sun, 10 Jun 2018 14:40:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Paolo Cretaro <paolocretaro@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 4/9] iio: cros_ec: Switch to SPDX identifier.
Message-ID: <20180610144031.57213b84@archlinux>
In-Reply-To: <20180605092209.22887-5-enric.balletbo@collabora.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
        <20180605092209.22887-5-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Jun 2018 11:22:04 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
This code has seen quite a few contributors, I'd like at least
some of them to agree they are happy with this change.

There hasn't been much general resistance in general to SPDX
headers replacing text, but there has been some, so I've been
asking this for all the IIO related SPDX patches.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      | 23 ++++--------------
>  .../common/cros_ec_sensors/cros_ec_sensors.c  | 24 ++++++-------------
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 18 ++++----------
>  .../cros_ec_sensors/cros_ec_sensors_core.h    | 12 ++--------
>  drivers/iio/light/cros_ec_light_prox.c        | 18 ++++----------
>  drivers/iio/pressure/cros_ec_baro.c           | 18 ++++----------
>  6 files changed, 26 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 063e89eff791..e7350ddec328 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -1,21 +1,8 @@
> -/*
> - * Driver for older Chrome OS EC accelerometer
> - *
> - * Copyright 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the memory mapper cros-ec interface to communicate
> - * with the Chrome OS EC about accelerometer data.
> - * Accelerometer access is presented through iio sysfs.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Driver for older Chrome OS EC accelerometer
> +//
> +// Copyright (C) 2017 Google, Inc.
> +// Author: Gwendal Grignou <gwendal@chromium.org>
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 705cb3e72663..3dbc90baf6bb 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -1,20 +1,10 @@
> -/*
> - * cros_ec_sensors - Driver for Chrome OS Embedded Controller sensors.
> - *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the cros-ec interface to communicate with the Chrome OS
> - * EC about sensors data. Data access is presented through iio sysfs.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Driver for Chrome OS Embedded Controller sensors.
> +//
> +// Copyright (C) 2016 Google, Inc.
> +//
> +// This driver uses the cros-ec interface to communicate with the ChromeOS
> +// EC about sensors data. Data access is presented through iio sysfs.
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index a620eb5ce202..05221994197c 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -1,17 +1,7 @@
> -/*
> - * cros_ec_sensors_core - Common function for Chrome OS EC sensor driver.
> - *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Common functions for ChromeOS EC sensor driver.
> +//
> +// Copyright (C) 2016 Google, Inc.
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> index 2edf68dc7336..a9935489030e 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> @@ -1,16 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * ChromeOS EC sensor hub
>   *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> + * Copyright (C) 2016 Google, Inc.
>   */
>  
>  #ifndef __CROS_EC_SENSORS_CORE_H
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 8e8a0e7f78d1..8635e1c18cd5 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -1,17 +1,7 @@
> -/*
> - * cros_ec_light_prox - Driver for light and prox sensors behing CrosEC.
> - *
> - * Copyright (C) 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Driver for light and prox sensors behind ChromeOS EC.
> +//
> +// Copyright (C) 2017 Google, Inc.
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 4599fde4dd25..8e134d65d18d 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -1,17 +1,7 @@
> -/*
> - * cros_ec_baro - Driver for barometer sensor behind CrosEC.
> - *
> - * Copyright (C) 2017 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Driver for barometer sensor behind ChromeOS EC.
> +//
> +// Copyright (C) 2017 Google, Inc.
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
