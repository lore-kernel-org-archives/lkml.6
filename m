Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeBBCoq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 21:44:46 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:33152 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeBBCoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 21:44:30 -0500
X-Google-Smtp-Source: AH8x226hBA8BXH8tt2xjf6+2CPDhkGgX5YK/x7wj9MFlromtwCk/Rl4AAtAF+Xa93KtgH6wHLQb6iiR0q2yzMcGSsiw=
MIME-Version: 1.0
In-Reply-To: <CAPM=9twxZtrNO8r_cQtXrMjkZ1jfvRD_3-dVPXAkLObE99DBFg@mail.gmail.com>
References: <CAPM=9tzdZucx_zkMESOfTV5tp9tP+g_tVkCmcQ7R9vYLaXq3Gw@mail.gmail.com>
 <CA+55aFzZiPJEoOViZh4hdKC=y9iEv8xAU_aCE2SxBqENZNO9_w@mail.gmail.com> <CAPM=9twxZtrNO8r_cQtXrMjkZ1jfvRD_3-dVPXAkLObE99DBFg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2018 18:44:29 -0800
X-Google-Sender-Auth: qYiQB9nSvP72TGuOwqmsdiOjWqo
Message-ID: <CA+55aFyEEKa48WADO0-5=vdGxGDug801u4C6+Cn7Gg6RoxCWZA@mail.gmail.com>
Subject: Re: [git pull] drm pull for v4.16-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 6:22 PM, Dave Airlie <airlied@gmail.com> wrote:
>
> Turned out I was running on wayland instead of X.org and my cut-n-paste from
> gedit to firefox got truncated, wierd. I'll go annoy some people, and make sure
> it doesn't happen again.

Heh, so there's some Wayland clipboard buffer limit.

But that reminds me: is there any *standard* tool to programmatically
feed into the clipboard?

I occasionally do things like

    git shortlog A..B | xsel

in order to then paste it into some browser window or other.

And sure, that works well. But I do it seldom enough that I never
remember the command, and half the time it's not even installed
because I've switched machines or something, and xsel is always some
add-on.

What's the thing "real" X people do/use?

           Linus
