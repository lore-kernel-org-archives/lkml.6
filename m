Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755520AbeDCL7Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:59:24 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:37266 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755456AbeDCL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:59:22 -0400
X-Google-Smtp-Source: AIpwx48x8Zj0RYrRJeFjy1FNyjr9+5uBRzJxPSSV2zLvNBeIupaS/IDO8azKdXypKTRrrRJvFK3stJ5CT9ejwgJhcec=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180403144349.7db7f5e0@canb.auug.org.au>
References: <20180403144349.7db7f5e0@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Apr 2018 07:59:19 -0400
Message-ID: <CAHC9VhTFbYC68eS_S3N+Q6h6JFdNBuYC5SUAdYp=TS91kkm3Xg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the security tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: James Morris <jmorris@namei.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 12:43 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Paul,
>
> Today's linux-next merge of the selinux tree got a conflict in:
>
>   include/linux/lsm_hooks.h
>
> between commit:
>
>   22402b0b736d ("security: convert security hooks to use hlist")
>
> from the security tree and commit:
>
>   72e89f50084c ("security: Add support for SCTP security hooks")
>
> from the selinux tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

That looks right, thanks Stephen.

-- 
paul moore
www.paul-moore.com
