Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeDKHsh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:48:37 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:44949 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeDKHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:48:35 -0400
X-Google-Smtp-Source: AIpwx49greqZ/sMeVZni/+speXC4MUXwpW6+JyrhvVEWsalpCY6QxEOR8eFAMwJkZbWBwuMQ08kJ+Gkzi7yzrCHF7J4=
MIME-Version: 1.0
In-Reply-To: <20180411061824.GA28791@la.guarana.org>
References: <001a114292fadd3e2505607060a8@google.com> <20180409040433.GJ685@sol.localdomain>
 <20180409055636.GA2551@la.guarana.org> <20180411061824.GA28791@la.guarana.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 11 Apr 2018 09:48:14 +0200
Message-ID: <CACT4Y+ZO0h7MEiHpHA+grE77FaCTr+DJv6EucWVPwBSJHPgxLg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in pfkey_add
To: Kevin Easton <kevin@guarana.org>
Cc: Eric Biggers <ebiggers3@gmail.com>, David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot
        <bot+5022a34ca5a3d49b84223653fab632dfb7b4cf37@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 8:18 AM, Kevin Easton <kevin@guarana.org> wrote:
> On Mon, Apr 09, 2018 at 01:56:36AM -0400, Kevin Easton wrote:
>> On Sun, Apr 08, 2018 at 09:04:33PM -0700, Eric Biggers wrote:
>> ...
>> >
>> > Looks like this is going to be fixed by
>> > https://patchwork.kernel.org/patch/10327883/ ("af_key: Always verify length of
>> > provided sadb_key"), but it's not applied yet to the ipsec tree yet.  Kevin, for
>> > future reference, for syzbot bugs it would be helpful to reply to the original
>> > bug report and say that a patch was sent out, or even better send the patch as a
>> > reply to the bug report email, e.g.
>> >
>> >     git format-patch --in-reply-to="<001a114292fadd3e2505607060a8@google.com>"
>> >
>> > for this one (and the Message ID can be found in the syzkaller-bugs archive even
>> > if the email isn't in your inbox).
>>
>> Sure, I can do that.
>
> I recalled one reason I _didn't_ do this - the message ID is retrievable
> from the archived email, but because the archive is Google Groups the
> message recipients aren't (only masked).
>
>     - Kevin
>

Hi Kevin,

This was mailed to other lists too:

To: davem@, herbert@, linux-kernel@vger.kernel.org,
netdev@vger.kernel.org, steffen.klassert@,
syzkaller-bugs@googlegroups.com

In the groups UI there is a drop down menu with "Show Original" option
which shows raw email which include Message-ID: header.
