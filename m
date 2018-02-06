Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbeBFWYo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:24:44 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:42685 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbeBFWYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:24:42 -0500
X-Google-Smtp-Source: AH8x227YeGTe6KimcleZgz9Wj7mbxpHsKYq4s+XenesVbns50frCJDMwhrKRhH7mFiBZaFhNGTFN9FtusfkudflkQLA=
MIME-Version: 1.0
In-Reply-To: <20180207091643.6b71df0a@canb.auug.org.au>
References: <20180206091130.75c0f1ae@vento.lan> <20180207091643.6b71df0a@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Feb 2018 14:24:41 -0800
X-Google-Sender-Auth: TE2OrhLOJH8yc3tL8hOxrEpIawk
Message-ID: <CA+55aFwUGSP+GpiPf=PSftpmQ4gnrbgvQG-h0jj6HKoiQ=cJTA@mail.gmail.com>
Subject: Re: [GIT PULL for v4.16-rc1] media updates
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 2:16 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>      See: https://lkml.org/lkml/2018/1/1/547
>
> Looks like you missed this when doing the merge :-(

Gaah. I noticed the actual conflicts, and then didn't actually notice
that there had been some other __poll_t noise too.

Will apply your patch.

           Linus
