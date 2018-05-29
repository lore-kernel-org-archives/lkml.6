Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbeE2LvX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:51:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33712 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933158AbeE2LvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:51:22 -0400
X-Google-Smtp-Source: ADUXVKIcY3QQNDKoeT3U+3CHnX/UAxyT0fqIyaXxVTQ6QtDsXNdikhcYKX7NBpWCvk+WyBgD7hrRM5obd6JdQbsfF/s=
MIME-Version: 1.0
In-Reply-To: <acb5453112ab7c7b801cf4f1669e351b391e77e8.1527587352.git-series.maxime.ripard@bootlin.com>
References: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
 <acb5453112ab7c7b801cf4f1669e351b391e77e8.1527587352.git-series.maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 May 2018 13:51:21 +0200
Message-ID: <CACRpkdZF=CwrviJfAVcwh5U6E_mLvVUcBwYh6bFbq0t8zH1z+Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] drm/panel: Add Ilitek ILI9881c panel driver
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:49 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> The LHR050H41 panel is the panel shipped with the BananaPi M2-Magic, and is
> based on the Ilitek ILI9881c Controller. Add a driver for it, modelled
> after the other Ilitek controller drivers.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
