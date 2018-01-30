Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeA3A7z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:59:55 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37545 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeA3A7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:59:54 -0500
X-Google-Smtp-Source: AH8x224IJ4mZikaxnpxZfcxHcP0uFqq2mVIQs1uCwhmh9p5ftm6lf0uQ9WkLcavt1k8ROCRV/EuqsfkH7XXUgvjiMBg=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1801290935160.1849@nanos>
References: <alpine.DEB.2.20.1801290935160.1849@nanos>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2018 16:59:53 -0800
X-Google-Sender-Auth: Ef7Nxe_h-ewM-gXgKWu5TucXb54
Message-ID: <CA+55aFy6FX6Ewg9exGH12PWnzSNKBfmc--v6H6UYpcSAEWUR8A@mail.gmail.com>
Subject: Re: [GIT pull] Timer core updates for 4.16
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 12:48 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
>   - A rather large rework of the hrtimer infrastructure which introduces
>     softirq based hrtimers to replace the spread of hrtimer/tasklet combos
>     which force the actual callback execution into softirq context.

I really would have liked to see more of the rationale for this - now
I'm left with just two example drivers, and a "you'll see the cleanups
this allows in future driver pulls".

But pulled, since the code doesn't look disgusting.

              Linus
