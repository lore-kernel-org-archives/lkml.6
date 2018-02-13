Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964996AbeBMNyi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:54:38 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33588 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964846AbeBMNyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:54:37 -0500
X-Google-Smtp-Source: AH8x227AOQOvmXiFTxwGMJINFvyj7rwwmG+oD4HothiGdiVtd1m1hR4BddVSUMFTSTkP08SzPYHxzw==
Subject: Re: [PATCH 3/4] drm/tve200: Do not use deprecated
 drm_driver.{enable|disable)_vblank
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>, gustavo@padovan.org,
        Dave Airlie <airlied@linux.ie>, Sean Paul <seanpaul@chromium.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1518425574-32671-1-git-send-email-andr2000@gmail.com>
 <1518425574-32671-4-git-send-email-andr2000@gmail.com>
 <CACRpkdasQOCzm-7dTG8TSki1mpAjwmGRvv+w+ukxt7NDs8R6+g@mail.gmail.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <a777ecbf-151d-9983-f7d1-6fe3a7646de1@gmail.com>
Date: Tue, 13 Feb 2018 15:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdasQOCzm-7dTG8TSki1mpAjwmGRvv+w+ukxt7NDs8R6+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 03:51 PM, Linus Walleij wrote:
> On Mon, Feb 12, 2018 at 9:52 AM, Oleksandr Andrushchenko
> <andr2000@gmail.com> wrote:
>
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Do not use deprecated drm_driver.{enable|disable)_vblank callbacks,
>> but use drm_simple_kms_helpe's pipe callbacks instead.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
> The new way of doing these abstractions seem good, so if people
> agree on the general subject (other patches in the series I guess)
fair enough, thank you
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
