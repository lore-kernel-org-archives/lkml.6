Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC572C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864932177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfA2Jlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:41:51 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:55648 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbfA2Jlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:41:50 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1goPto-0004nY-Or; Tue, 29 Jan 2019 10:41:44 +0100
Date:   Tue, 29 Jan 2019 10:41:44 +0100
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in __xfrm_policy_bysel_ctx
Message-ID: <20190129094144.bln4dnirr5kz3dl4@breakpoint.cc>
References: <0000000000007b129305809553da@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007b129305809553da@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    085c4c7dd2b6 net: lmc: remove -I. header search path
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12347128c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> dashboard link: https://syzkaller.appspot.com/bug?extid=e6e1fe9148cffa18cf97
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.

net-next doesn't contain the fixes for the rbtree fallout yet, so
this might already be fixed (fingers crossed).
