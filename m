Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756392AbeDYTxr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:53:47 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45361 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeDYTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:53:45 -0400
X-Google-Smtp-Source: AIpwx48VI8Or58xw5tUbJB0O60Cyz9BiVq7YUymmbVXixRC9adIjsLct04THbJcO+UQd42Rxp+dW3YPhPcC9EbjN2T8=
MIME-Version: 1.0
In-Reply-To: <3050f0c1-549e-d4b9-50b5-468c11effea9@web.de>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de> <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
 <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de> <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
 <CAL_Jsq+MmUTMrd+jNqUB2=A-q3cCy7+QWOKG0iF6zM0hjCy3PQ@mail.gmail.com>
 <e508f3de-f21b-2510-2c6a-b810073ba1a7@web.de> <e06d1c0f-f60d-fc23-cd74-82f557dbc432@web.de>
 <7bbb9472-9c96-6012-68e6-4ec2773c7732@gmail.com> <4422f58a-ca7c-16e6-e0df-63faea50f553@web.de>
 <3d7cb4d3-5070-e878-51d3-59f9772f756b@gmail.com> <53ee2d0b-1867-5cad-667c-7f70085c645d@web.de>
 <e2eb2c23-d580-8c46-5bdb-a142b3791301@gmail.com> <c79a60b8-60a3-dd6e-76c3-d1fdfa003e49@gmail.com>
 <3050f0c1-549e-d4b9-50b5-468c11effea9@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Apr 2018 21:53:43 +0200
X-Google-Sender-Auth: ybG0X5WVcpOroYVObGC4kz2uLbQ
Message-ID: <CAMuHMdUNDcvKzOJ3JtWBQRVDF9d63K9Lot0-fKQcsaWTsadDvQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Wed, Apr 25, 2018 at 9:40 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
> What other pointers are we talking about?

There's also the issue that some data has been allocated using kmalloc(),
while others hasn't. The "other" pointers point to e.g. early bootmem or
memblock.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
