Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeBRTFU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 14:05:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52663 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBRTFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 14:05:19 -0500
X-Google-Smtp-Source: AH8x225Pc3ML1YR3F7tlMMiSOWY/KoD2+fzvAm7IhQR6unvvlDicN2oS/2E7rmrVaCD1H4QGEh85wkASYUAEgntTGsk=
MIME-Version: 1.0
In-Reply-To: <20180217193955.shfhvp3afwiurzfm@gmail.com>
References: <20180217193955.shfhvp3afwiurzfm@gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sun, 18 Feb 2018 20:04:37 +0100
Message-ID: <CAOFm3uHHzfV3R3Q9AyhzDLp0uKNHpSTp2MsY3uSL+YsBL6w+dg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Replace licenses with SPDX identifiers
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: w@1wt.eu, Geert Uytterhoeven <geert@linux-m68k.org>, triad@df.lth.se,
        robin@protonic.nl, Paul Burton <paul.burton@mips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel,

On Sat, Feb 17, 2018 at 8:39 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Walleij <triad@df.lth.se>
> Cc: Robin van der Gracht <robin@protonic.nl>
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---

<snip>

> diff --git a/include/linux/cfag12864b.h b/include/linux/cfag12864b.h
> index b454dfce60d9..aa960efc32f6 100644
> --- a/include/linux/cfag12864b.h
> +++ b/include/linux/cfag12864b.h
> @@ -1,25 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0

Per the doc [1] you should be using instead this in a .h:
/* SPDX-License-Identifier: GPL-2.0 */

I know this can be surprising. This has been discussed on list quite
lot and the doc has some rationale.

<snip>

> diff --git a/include/linux/ks0108.h b/include/linux/ks0108.h
> index cb311798e0bc..2a1c985fedea 100644
> --- a/include/linux/ks0108.h
> +++ b/include/linux/ks0108.h
> @@ -1,25 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0

Same comment as above.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst

-- 
Cordially
Philippe Ombredanne
