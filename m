Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030810AbeCANdp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:33:45 -0500
Received: from gloria.sntech.de ([95.129.55.99]:47378 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030670AbeCANdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:33:41 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        dcastagna@google.com, hoegsberg@google.com, tfiga@chromium.org,
        Sandy Huang <hjc@rock-chips.com>, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: vop: Init vskiplines in scl_vop_cal_scale()
Date: Thu, 01 Mar 2018 14:33:37 +0100
Message-ID: <126662348.ZcAOZAFD3X@diego>
In-Reply-To: <20180223062250.10470-1-jeffy.chen@rock-chips.com>
References: <20180223062250.10470-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 23. Februar 2018, 07:22:50 CET schrieb Jeffy Chen:
> Currently we are calling scl_vop_cal_scale() to get vskiplines for yrgb
> and cbcr. So the cbcr's vskiplines might be an unexpected value if the
> second scl_vop_cal_scale() didn't update it.
> 
> Init vskiplines in scl_vop_cal_scale() to avoid that.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied to drm-misc-next with Sean Paul's Ack


Heiko
