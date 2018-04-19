Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeDSRlZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:41:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36714 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbeDSRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:41:23 -0400
X-Google-Smtp-Source: AIpwx4/A34bgtHTM3S06LCfO0IIrDb0t0OhXZcLuZ5EmCH5ZOyloivxLMYz0fPAW/qiIP5tTVKNTrw==
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] ARM64: dts: meson: hhi syscon and clock controllers
Organization: BayLibre
References: <20180315115545.1884-1-jbrunet@baylibre.com>
Date: Thu, 19 Apr 2018 10:41:20 -0700
In-Reply-To: <20180315115545.1884-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 15 Mar 2018 12:55:41 +0100")
Message-ID: <7h1sfb5c1r.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The HHI register region provides more than just clocks. Several drivers may
> need to access this region, such as the clock controllers and the display
> driver.
>
> Meson-gx clock controllers has been developed and merged before we knew the
> hhi could be needed elsewhere, which is why it requests the region directly.
> Meson-axg was built following the model of meson-gx.
>
> To fix this situation, the clock controller should be a child of the hhi
> system controllers. The hhi system controller node already exists on meson-gx.
> It needs to be added on the axg.
>
> This changeset depends on [0]. This dependency has been merged in
> clk-next. A topic branch is available here [1]

As the dependencies are now merged for v4.17, applying this to
v4.18/dt64,

Thanks,

Kevin
