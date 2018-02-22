Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeBVN7u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:59:50 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:50883 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932564AbeBVN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:59:45 -0500
X-Google-Smtp-Source: AG47ELs9zNBN7AHLuas3eHvxzx+fBRAByDGD/mud2V3AmOhQM7QiVPAIXywrydoNK8orir3yK5w1P7XKEzkTU0kkLu0=
MIME-Version: 1.0
In-Reply-To: <20180210092702.4393-1-marcus.folkesson@gmail.com>
References: <20180210092702.4393-1-marcus.folkesson@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 14:59:44 +0100
Message-ID: <CACRpkdaGeqCOhSwzNZh4AObEB16SHgY+X9eB8G4chSdytbVv_w@mail.gmail.com>
Subject: Re: [PATCH] watchdog: coh901327: make license text and module licence match
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:27 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:

> Licence text is specifying "GPLv2" but the MODULE_LICENSE is set to "GPLv2
> or later".
>
> See include/linux/module.h:
> "GPL"                           [GNU Public License v2 or later]
> "GPL v2"                        [GNU Public License v2]
>
> When on it, add SPDX identifier tag.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
