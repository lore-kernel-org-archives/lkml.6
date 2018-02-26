Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeBZJD1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:03:27 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35861 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeBZJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:03:23 -0500
X-Google-Smtp-Source: AG47ELv9AiVKDeR2wy4FAt66luq52hwlb65DS7jZs+p8mfLkUSNJgnFoAXLU9yKWQDs8VnRUL8mghjF1mzdhVMCzuCU=
MIME-Version: 1.0
In-Reply-To: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
References: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 10:03:22 +0100
X-Google-Sender-Auth: Z1BLUHvOF3n4CPh7ICDAns0LG1k
Message-ID: <CAMuHMdUj63OQnJWz=Q57dbc1XKOnq+_et5-E_4yQjTZt+c++GQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] of: remove kbasename() from core
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Mon, Feb 26, 2018 at 3:22 AM,  <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> Struct device_node full_name no longer includes the full path
> name.

Is this now also true on systems with real Open Firmware?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
