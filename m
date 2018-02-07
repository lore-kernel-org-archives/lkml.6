Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeBGNJ5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:09:57 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:33851 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeBGNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:09:52 -0500
X-Google-Smtp-Source: AH8x224o5xIu935k2pTqSE3LWnGxIYin9u85BXCjBh/Y7isZN53zFxTiB6utLOB8QvthBRiV+zuiZDD5LM9QqRBGMJU=
MIME-Version: 1.0
In-Reply-To: <20180122160546.51611-1-andriy.shevchenko@linux.intel.com>
References: <20180122160546.51611-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 14:09:51 +0100
Message-ID: <CACRpkdZDYJUdeWv1OxNoHi34AhWTjcfA8czVNf4qNry2hnz0Bw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] seq_file: Introduce DEFINE_SHOW_ATTRIBUTE() helper macro
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 5:05 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The DEFINE_SHOW_ATTRIBUTE() helper macro would be useful for current
> users, which are many of them, and for new comers to decrease code
> duplication.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Obviously a good idea.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
