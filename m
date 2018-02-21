Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeBUTGt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:06:49 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43132 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbeBUTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:06:26 -0500
X-Google-Smtp-Source: AH8x227WtkpzJqsZR2uiExE3whdBpjFRLqAb7BN1F5xZdkJCcvqwKpQJjn3TdSyS62Sx64xJFfN+WnwGXuj7HYVRhq8=
MIME-Version: 1.0
In-Reply-To: <20180221170748.27505-4-enric.balletbo@collabora.com>
References: <20180221170748.27505-1-enric.balletbo@collabora.com> <20180221170748.27505-4-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 21:06:25 +0200
Message-ID: <CAHp75VeMonZAy+XOPytFDoix1DY7X+7Gsta=JVEW5_6y39o92w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] platform/chrome: cros_ec_sysfs: use
 permission-specific DEVICE_ATTR variants
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 7:07 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Use DEVICE_ATTR variants for read/write attributes. This simplifies the
> source code, improves readbility, and reduces the chance of
> inconsistencies.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v1:
> - New in this series. Suggested by Andy Shevchenko.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>


-- 
With Best Regards,
Andy Shevchenko
