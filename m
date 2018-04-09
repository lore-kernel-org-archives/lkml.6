Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDINLd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:11:33 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:39471 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDINLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:11:32 -0400
X-Google-Smtp-Source: AIpwx49lck0oOkD0DuTqTz3tQ9FGQTxU5ztgf39PIPywzxmjhR3YaDYs4dpNjToU/LMLx1OflOAiCUIPN8AtK0VYydE=
MIME-Version: 1.0
In-Reply-To: <455c2ccbea2f83947630e3068ecadf4ab4434fb9.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au> <455c2ccbea2f83947630e3068ecadf4ab4434fb9.1522546571.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 15:11:31 +0200
X-Google-Sender-Auth: 7mxqnMdM9K9utuDRsL8ONfKFc7I
Message-ID: <CAMuHMdVqMqgWv9xiH35kpbr7exaLr73mQ9qS_WC5u+c6jZ+d6g@mail.gmail.com>
Subject: Re: [PATCH 07/12] block/swim: Remove extra put_disk() call from error path
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 1, 2018 at 3:41 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
