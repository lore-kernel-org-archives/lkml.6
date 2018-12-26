Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B9D2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeLZKm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 05:42:27 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:58564 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbeLZKm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 05:42:27 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gc6dp-0007uD-66; Wed, 26 Dec 2018 11:42:21 +0100
Date:   Wed, 26 Dec 2018 11:42:21 +0100
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Write in __xfrm_policy_unlink
Message-ID: <20181226104221.pojiahsinsspkkxf@breakpoint.cc>
References: <000000000000f16b5e05714225b8@google.com>
 <0000000000003878ad057d97d241@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003878ad057d97d241@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com> wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    ce28bb445388 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1673fb1b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=67a2081147a23142
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d971dd21eb26567036b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134dcc7400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126986ed400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9d971dd21eb26567036b@syzkaller.appspotmail.com

I've fixed this one.  Chances are that at least some of the other
reports are duplicates of this one.

I will continue to look at other reports over the next few days and plan
to send out fixes and test cases next week.
