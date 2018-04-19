Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeDSRmp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:42:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40669 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeDSRmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:42:43 -0400
X-Google-Smtp-Source: AIpwx49iBZgVO8edB+YWowm9GhMJwxNjuJlS9VOP5yix8nONK8RVweVuNsWlRfj4auewTQHaNZ4DIg==
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvmem: meson-efuse: add write support
Organization: BayLibre
References: <20180316150113.9779-1-jbrunet@baylibre.com>
Date: Thu, 19 Apr 2018 10:42:40 -0700
In-Reply-To: <20180316150113.9779-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 16 Mar 2018 16:01:11 +0100")
Message-ID: <7hwox33xf3.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This changeset adds write support to meson efuse driver.
> The first patch just changes the way the nvmem data are allocated w/o
> any functional changes. The second patches actually adds write support.
>
> The memory being an OTP, it is safer if it remains read-only by default,
> which is why I also submitted this DT patch [0].
>
> If a user knows what he is doing, it should be easy to remove the
> read-only property from the board DT. This can be done in u-boot, before
> starting linux:
>
>  > fdt rm /efuse read-only
>
> Tested on the gxl libretech-cc

For the series,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
