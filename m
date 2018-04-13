Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeDMX0o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 19:26:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34709 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeDMX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 19:26:43 -0400
X-Google-Smtp-Source: AIpwx4+LgxNeP2/XmxiFqe0Kp0I3L7jqXboOuoQlDxrtnwnWFzPkGESyApgv3IGSjRmZpGJorBQv5//xAIfR5Y2HNlE=
MIME-Version: 1.0
In-Reply-To: <20180412222101.GA242548@decatoncale.mtv.corp.google.com>
References: <20180412222101.GA242548@decatoncale.mtv.corp.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2018 16:26:41 -0700
X-Google-Sender-Auth: f-TH17v3t9_w11lAFNeovMhMN4Q
Message-ID: <CA+55aFwSStqgd-i86ubpLRWPiYTyC=Km--t2C0TF1UqMUv0kgg@mail.gmail.com>
Subject: Re: [GIT PULL] chrome-platform updates for v4.17
To: Benson Leung <bleung@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, dtor@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Olof Johansson <olof@lixom.net>, Guenter Roeck <linux@roeck-us.net>,
        enric.balletbo@collabora.com, Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 3:21 PM, Benson Leung <bleung@google.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git tags/chrome-platform-for-linus-4.17

Please don't do this to me.

You're sending me a pull request in the second half of the second week
of the merge window, and none of this has been in linux-next as far as
I can tell.

I don't even check linux-next as of when the merge window opened - I
check it as of "one week into the merge window".

Ok, ok, I do in fact find two of the commits in linux-next, but even
they have been rebased for some reason.

The others? I can't find them even in some rebased form.

I'll take this for now, but next time I see this kind of "late in the
merge window, absolutely zero exposure anywhere else", I'll just skip
the whole pull request. Don't do it.

                 Linus
