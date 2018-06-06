Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeFFAE1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 20:04:27 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:42968 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeFFAE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 20:04:26 -0400
X-Google-Smtp-Source: ADUXVKIRIFhi2QVVR9zFSABSRsWulAkCHlFtv9LHn7jyXtgYKOzCIiyWhGefbCFDhJiO6vJCxq7a7PUINA3N1P4WClE=
MIME-Version: 1.0
In-Reply-To: <20180606091707.18a8f2f0@canb.auug.org.au>
References: <20180606075535.09b41c23@canb.auug.org.au> <CABeXuvqG_DQMOwa0vrmJB+kx7DPbuMo=s-aS-DK7LdBy_ZGtTw@mail.gmail.com>
 <20180606091707.18a8f2f0@canb.auug.org.au>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 5 Jun 2018 17:04:25 -0700
Message-ID: <CABeXuvoQJ0sSpJCjfeKR+s1esS3kq34F0k=S87GMOC2B5XKxug@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the y2038 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, you meant that it has keescook@chromium.org author sign-off, but
it needs mine because I applied it.

Please add

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

I also updated it in my tree.

Thanks,
- Deepa

On Tue, Jun 5, 2018 at 4:17 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Deepa,
>
> On Tue, 5 Jun 2018 15:00:24 -0700 Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>
>> That patch belongs to Kees.
>
> But you committed it to the tree ...
>
> --
> Cheers,
> Stephen Rothwell
