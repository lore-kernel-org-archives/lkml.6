Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933630AbeE2Lwa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:52:30 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32769 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933372AbeE2Lw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:52:26 -0400
X-Google-Smtp-Source: AB8JxZrZwJwUK9FuWyXiehlJk6ivZ3zDeAX6uqpS1c5XFQIDESwLwwxWBIUDNfSXZ/PTOevVoBb7qmZI7/Vh1I8e36E=
MIME-Version: 1.0
In-Reply-To: <eba350219d6521c5c84986c68f7f0045dcac9aea.1527587352.git-series.maxime.ripard@bootlin.com>
References: <cover.e73f3ed1a9adc36fc1648d563cd967ec99219839.1527587352.git-series.maxime.ripard@bootlin.com>
 <eba350219d6521c5c84986c68f7f0045dcac9aea.1527587352.git-series.maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 May 2018 13:52:25 +0200
Message-ID: <CACRpkdaBQk9WbH8c=wZuJ1E_2trn9kVQogpBRNA9jQpcwkXhXA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display
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

> The BananaPi M2M has an optional 1280x720 DSI panel. Since that panel is
> optional, we can only show a DT patch that would show how to enable it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

This looks very nice.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
