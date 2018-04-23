Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeDWVwg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:52:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37698 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeDWVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:52:32 -0400
X-Google-Smtp-Source: AIpwx4/OC8T8bexlADyn/spxgVb8Ax2d/JVrvMtpz9kh44NJLRk35RL5aM7vemMjDXN8jjGbkPHClSrhZkJpCQeVu38=
MIME-Version: 1.0
In-Reply-To: <20180424073840.39b99c2e@canb.auug.org.au>
References: <20180424073840.39b99c2e@canb.auug.org.au>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Apr 2018 16:52:05 -0500
Message-ID: <CAH2r5mtHjjMZy8zWcUKFmKsF3X4b1iEt-otbGpiu0-n2G9bohw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the cifs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: CIFS <linux-cifs@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed - thx

On Mon, Apr 23, 2018 at 4:38 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commits
>
>   dee4bf3f21d8 ("cifs: smbd: Don't use RDMA read/write when signing is used")
>   553018657de2 ("ifs: smbd: Avoid allocating iov on the stack")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
