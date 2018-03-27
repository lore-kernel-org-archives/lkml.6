Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeC0NOD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:14:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37010 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbeC0NOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:14:02 -0400
X-Google-Smtp-Source: AIpwx48Ouci7b6Z7npI8mNorYR20Y2T4V9GYphKHOeheLzIWWMqYzzM4BXXZFv5c0uPYt50pV1mHdV+j6neCUZPHlLc=
MIME-Version: 1.0
In-Reply-To: <20180304124551.22565-1-brgl@bgdev.pl>
References: <20180304124551.22565-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:14:01 +0200
Message-ID: <CACRpkdZyjKJXfqKkiqWAmYoqLW5i28HTaRRsx_a1jk076cJdmg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: fix a potential crash when creating debugfs entries
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 4, 2018 at 1:45 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> If we failed to create the top debugfs directory, we must not try to
> create the child nodes. We currently only check if gpio_mockup_dbg_dir
> is not NULL, but it can also contain an errno if debugfs is disabled
> in build options. Use IS_ERR_OR_NULL() instead.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Patch applied.

Yours,
Linus Walleij
