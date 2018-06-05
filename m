Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeFEWA1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:00:27 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37910 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeFEWAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:00:25 -0400
X-Google-Smtp-Source: ADUXVKKW/wutZJwvAF4ZOvGaSbMc+XpbhQKq8cEU0wz9PVMxB7vNpHU+g4CWTLb6k+TCR+v2z69kppY/bo5VR4exm0k=
MIME-Version: 1.0
In-Reply-To: <20180606075535.09b41c23@canb.auug.org.au>
References: <20180606075535.09b41c23@canb.auug.org.au>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 5 Jun 2018 15:00:24 -0700
Message-ID: <CABeXuvqG_DQMOwa0vrmJB+kx7DPbuMo=s-aS-DK7LdBy_ZGtTw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the y2038 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That patch belongs to Kees.

-Deepa

On Tue, Jun 5, 2018 at 2:55 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Arnd,
>
> Commit
>
>   0f0d83b99ef7 ("pstore: Convert internal records to timespec64")
>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell
