Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965600AbeBUPG5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:06:57 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37350 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932826AbeBUPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:06:55 -0500
X-Google-Smtp-Source: AH8x22562eTome5z0dn21v2TpbZdvINlHDpjHJ/8OOWTmEdIayj6ZQMGCbaFm52VPnzHnKhH6g9GUgkUnHALmwU1AYs=
MIME-Version: 1.0
In-Reply-To: <20180221144909.13461-3-enric.balletbo@collabora.com>
References: <20180221144909.13461-1-enric.balletbo@collabora.com> <20180221144909.13461-3-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 17:06:54 +0200
Message-ID: <CAHp75Vf3yRUf7sOsRaiC_HCDBGUWg5mmzuE5PbhoeAuhYANcVA@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/chrome: cros_ec_debugfs: Add PD port info to debugfs
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, groeck@chromium.org, gwendal@chromium.org,
        Shawn Nematbakhsh <shawnn@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 4:49 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Shawn Nematbakhsh <shawnn@chromium.org>
>
> Add info useful for debugging USB-PD port state.

This patch mixes up at least three things.
Split it accordingly or drop unrelated changes.

-- 
With Best Regards,
Andy Shevchenko
