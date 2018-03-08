Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966212AbeCHNMe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:12:34 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:43109 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935769AbeCHNM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:12:29 -0500
X-Google-Smtp-Source: AG47ELvGddLXSVGVRmwE0nNvTMPIttUvir35gXNgMc8gATnYRKsFedAMF3x+5NXla7mKvra4fKxHUZidX6kDqr0WYgg=
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSyxv=bm6tOF=_Qimiak6vf-ZF09pn=n9zwk_qdoZ7oJA@mail.gmail.com>
References: <20180305124054.09966cb0@canb.auug.org.au> <20180308130703.7365f733@canb.auug.org.au>
 <CAHC9VhSyxv=bm6tOF=_Qimiak6vf-ZF09pn=n9zwk_qdoZ7oJA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Mar 2018 21:12:28 +0800
Message-ID: <CADvbK_fpLHQEysz4XFAfkB3gnkXgDLitjPCQTYbAx3NMZhiXaw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the net-next tree
To: Paul Moore <paul@paul-moore.com>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 9:00 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 7, 2018 at 9:07 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> On Mon, 5 Mar 2018 12:40:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> Today's linux-next merge of the selinux tree got a conflict in:
>>>
>>>   net/sctp/socket.c
>>>
>>> between several refactoring commits from the net-next tree and commit:
>>>
>>>   2277c7cd75e3 ("sctp: Add LSM hooks")
>>>
>>> from the selinux tree.
>>>
>>> I fixed it up (I think - see below) and can carry the fix as
>>> necessary. This is now fixed as far as linux-next is concerned, but any
>>> non trivial conflicts should be mentioned to your upstream maintainer
>>> when your tree is submitted for merging.  You may also want to consider
>>> cooperating with the maintainer of the conflicting tree to minimise any
>>> particularly complex conflicts.
>>>
>>> --
>>> Cheers,
>>> Stephen Rothwell
>>
>> The resolution now looks like below (there were more changes to this
>> file in the net-next tree).  It will keep changing every time this file
>> is touched :-(
>
> Xin Long, does this still look okay to you?
Yes, it's good.

I forgot "struct sctp_af *af;" would be there there when submitting:

   commit 2c0dbaa sctp: add support for SCTP_DSTADDRV4/6 Information for sendmsg

and should have put some notes for David.

Thanks for your reminding.
