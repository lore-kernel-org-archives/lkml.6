Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeDHGNw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 02:13:52 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44237 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeDHGNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:13:51 -0400
X-Google-Smtp-Source: AIpwx4/k0Pv0HuE8cIho60Vg0Iqw72MjpsQqY/MZWKWMOBp5o1tsupe/8A3Q1uZYVKWC8Q8bnjCK52cV901G/VDkwVk=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 8 Apr 2018 14:13:49 +0800
Message-ID: <CADvbK_dCWw5D572zB8Ohvv1+xcrTJNjmjjfqmjQAsfHZGRSFyg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 7, 2018 at 7:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com> wrote:
>>
>> Everything passes the selinux-testsuite, but there are a few known
>> merge conflicts.  The first is with the netdev tree and is in
>> net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully Stephen
>> Rothwell has already done the heavy lifting in resolving the merge for
>> you, and the SCTP folks have given his merge patch a thumbs-up.
>
> I ended up re-doing the merge, and it looks like some more sctp
> changes happened after Stephen's merge anyway, so mine didn't end up
 > quite like his.
>
You're right, a sctp fix went into net-next after Stephen's that merge.
https://patchwork.ozlabs.org/patch/884469/ (v1)
https://patchwork.ozlabs.org/patch/884971/ (v2)

Which caused the resolution to have changed again.

I've checked the new resolution on your tree, the SCTP part is all good.

Thanks.
