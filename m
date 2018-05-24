Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965085AbeEXIXU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:23:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53257 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeEXIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:23:16 -0400
X-Google-Smtp-Source: AB8JxZorLgr8341pg1o4ZHVIwrVH0hIj5KpmZgMH/bu8KtkRXwSxhAW6D4Qf8HwalSS/Z7eYmlZjcy9KIcJ4aUGADxw=
MIME-Version: 1.0
In-Reply-To: <20180328175957.23904-1-labbott@redhat.com>
References: <20180328175957.23904-1-labbott@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 10:23:14 +0200
Message-ID: <CACRpkdZWtdePWwGZ=1w_8CTz3STt+cVJv7hQAigYHFi1gm6fKA@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: Remove VLA from stmpe driver
To: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 7:59 PM, Laura Abbott <labbott@redhat.com> wrote:

> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
>
> The number of GPIOs on the supported chips is fairly small
> so stack allocate to a known upper bound and spit out a warning
> if any new chips have more gpios.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Patch applied with the review tags!

Yours,
Linus Walleij
