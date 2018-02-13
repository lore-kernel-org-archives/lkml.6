Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964984AbeBMNvw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:51:52 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43833 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964943AbeBMNvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:51:50 -0500
X-Google-Smtp-Source: AH8x2269tUs5oTUqWfMNvPGhhuRWSqkJRuGR9X3k/WK+AOlYWVqj1Vr2LpdLk/YXvgKLAk4w9en6GUN2cqGslbQLG/Q=
MIME-Version: 1.0
In-Reply-To: <1518425574-32671-4-git-send-email-andr2000@gmail.com>
References: <1518425574-32671-1-git-send-email-andr2000@gmail.com> <1518425574-32671-4-git-send-email-andr2000@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2018 14:51:49 +0100
Message-ID: <CACRpkdasQOCzm-7dTG8TSki1mpAjwmGRvv+w+ukxt7NDs8R6+g@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/tve200: Do not use deprecated drm_driver.{enable|disable)_vblank
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>, gustavo@padovan.org,
        Dave Airlie <airlied@linux.ie>, Sean Paul <seanpaul@chromium.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 9:52 AM, Oleksandr Andrushchenko
<andr2000@gmail.com> wrote:

> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Do not use deprecated drm_driver.{enable|disable)_vblank callbacks,
> but use drm_simple_kms_helpe's pipe callbacks instead.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

The new way of doing these abstractions seem good, so if people
agree on the general subject (other patches in the series I guess)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
