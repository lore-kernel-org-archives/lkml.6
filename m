Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933922AbeCGQeh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:34:37 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34147 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933545AbeCGQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:34:34 -0500
X-Google-Smtp-Source: AG47ELswTCgjGLqaHHgXs9162ARYY41Ey/IAn0ajqeIA+u6R3B1n1vZH9hf81Qr1EHMWzFQd0C14MowYLX/b9jjAyNY=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CADvbK_cMVBWO7zgnyG=L8T5cTKfjyUXQAAv+a2ne5WVZ9TBJ4g@mail.gmail.com>
References: <20180305124054.09966cb0@canb.auug.org.au> <CADvbK_cMVBWO7zgnyG=L8T5cTKfjyUXQAAv+a2ne5WVZ9TBJ4g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Mar 2018 11:34:31 -0500
Message-ID: <CAHC9VhST6LhUj6H28Ws96EaRzkp4FN91h46iGKpd2Yk44H7Jpw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the net-next tree
To: Xin Long <lucien.xin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 2:03 AM, Xin Long <lucien.xin@gmail.com> wrote:
> On Mon, Mar 5, 2018 at 9:40 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi Paul,
>>
>> Today's linux-next merge of the selinux tree got a conflict in:
>>
>>   net/sctp/socket.c
>>
>> between several refactoring commits from the net-next tree and commit:
>>
>>   2277c7cd75e3 ("sctp: Add LSM hooks")
>>
>> from the selinux tree.
>>
>> I fixed it up (I think - see below) and can carry the fix as
> The fixup is great!  the same as I mentioned in:
> https://patchwork.ozlabs.org/patch/879898/
> for net-next.git
>
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
>
> [net-next,0/9] sctp: clean up sctp_sendmsg, this patchset was just applied
> in net-next. So I just guess it might not yet be there when selinux tree was
> being submitted.

The selinux/next branch is based on v4.16-rc1 and doesn't feed into
the netdev tree, it goes straight to Linus during the merge window so
unfortunately I think we may need to carry this for some time and
relay this fix-up patch up to Linus during the merge window.

-- 
paul moore
www.paul-moore.com
