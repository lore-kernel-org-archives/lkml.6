Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeDDIX3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:23:29 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:32943 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeDDIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:23:27 -0400
X-Google-Smtp-Source: AIpwx49ZFXWD4SbRn/tpwlaKbPzj9O7jhnI4ZnhccFstx+scJdXfUWViJt3dpK7CXcFrLs6Sqfswh8Djq0RwOwv3bSk=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180330120411.035c9242@canb.auug.org.au>
References: <20180330120411.035c9242@canb.auug.org.au>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 4 Apr 2018 10:23:25 +0200
Message-ID: <CAJfpegtd6V2KrdVjrubs8dPnsUkdE7A=ftajOr6d3DzkfNTqVA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the overlayfs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 3:08 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Miklos,
>
> Commit
>
>   cbf293becfa4 ("ovl: cleanup setting OVL_INDEX")
>
> is missing a Signed-off-by from its author.

Hi Steven,

AFAIK for trivial work we are not required to get a signoff from the author.

Thanks,
Miklos
