Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030866AbeCANe5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:34:57 -0500
Received: from gloria.sntech.de ([95.129.55.99]:47434 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030700AbeCANe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:34:56 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, dmitry.torokhov@gmail.com,
        briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        tfiga@chromium.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] drm/rockchip: Add device links for master and components
Date: Thu, 01 Mar 2018 14:34:49 +0100
Message-ID: <1621728.R05mi6GW7F@diego>
In-Reply-To: <20180207175309.21095-1-enric.balletbo@collabora.com>
References: <20180207175309.21095-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 7. Februar 2018, 18:53:09 CET schrieb Enric Balletbo i Serra:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Since we are trying to access components' resources in the master's
> suspend/resume PM callbacks(e.g. panel), add device links to correct
> the suspend/resume and shutdown ordering.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc-next
[after confering on #dri-devel on fixes vs. next]

Thanks
Heiko
