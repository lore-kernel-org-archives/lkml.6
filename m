Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeBZPxm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:53:42 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:47033 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeBZPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:53:38 -0500
X-Google-Smtp-Source: AG47ELtxk6ucb51PwQqQ4gmwOWp05MtZN4iTnnRkWro9jPpi+SEVPoFbwazPI4jNt4smIWNGekyF2QxYgca7Aeb9vhg=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX_+N4WzXp+g+B9f5H9k1LCe2vyGUO-RRkOAiARerTWtw@mail.gmail.com>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <CAMuHMdX_+N4WzXp+g+B9f5H9k1LCe2vyGUO-RRkOAiARerTWtw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Feb 2018 16:53:17 +0100
Message-ID: <CANiq72k1DKUsko4-SiF2FzK1bSQypND0N8hdNN4sFVPFyNxSqg@mail.gmail.com>
Subject: Re: [PATCH 1/4] auxdisplay: charlcd: fix two-line command ^[[LN not
 marked as processed
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Robert Abel <rabel@robertabel.eu>,
        linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 9:34 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Feb 26, 2018 at 12:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
>> Signed-off-by: Robert Abel <rabel@robertabel.eu>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Good catch Robert! Picking it up for 4.17.

Cheers,
Miguel

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
