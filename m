Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeDHMpu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 08:45:50 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33407 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeDHMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 08:45:48 -0400
X-Google-Smtp-Source: AIpwx48CJ3OwAWuDJfK4ysmjx3YI/HkdsTObHTnhYOsOkjJBtRtevLGwLL60ueifE7EB7EoJiRzCrw==
From: Paul Moore <paul@paul-moore.com>
To: Xin Long <lucien.xin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: <selinux@tycho.nsa.gov>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 08 Apr 2018 08:45:45 -0400
Message-ID: <162a54a7ca8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CADvbK_dCWw5D572zB8Ohvv1+xcrTJNjmjjfqmjQAsfHZGRSFyg@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
 <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
 <CADvbK_dCWw5D572zB8Ohvv1+xcrTJNjmjjfqmjQAsfHZGRSFyg@mail.gmail.com>
User-Agent: AquaMail/1.14.2-840 (build: 101400201)
Subject: Re: [GIT PULL] SELinux patches for v4.17
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w38Cjt45024745

On April 8, 2018 2:13:51 AM Xin Long <lucien.xin@gmail.com> wrote:
On Sat, Apr 7, 2018 at 7:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com> wrote:

Everything passes the selinux-testsuite, but there are a few known
merge conflicts.  The first is with the netdev tree and is in
net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully Stephen
Rothwell has already done the heavy lifting in resolving the merge for
you, and the SCTP folks have given his merge patch a thumbs-up.

I ended up re-doing the merge, and it looks like some more sctp
changes happened after Stephen's merge anyway, so mine didn't end up
quite like his.
You're right, a sctp fix went into net-next after Stephen's that merge.
https://patchwork.ozlabs.org/patch/884469/ (v1)
https://patchwork.ozlabs.org/patch/884971/ (v2)

Which caused the resolution to have changed again.

I've checked the new resolution on your tree, the SCTP part is all good.

Thanks for double checking that Xin.

--
paul moore
www.paul-moore.com
