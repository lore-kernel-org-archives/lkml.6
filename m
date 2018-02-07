Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbeBGLe0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:34:26 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:38454 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753796AbeBGLeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:34:23 -0500
Date: Wed, 7 Feb 2018 12:31:18 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: WARNING: proc registration bug in clusterip_tg_check
Message-ID: <20180207113118.GD14261@breakpoint.cc>
References: <089e082d13a0cf25ed05648bf8b3@google.com>
 <945c8517a87c671825b61223088064ea2ad0a8cb.1517999262.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945c8517a87c671825b61223088064ea2ad0a8cb.1517999262.git.pabeni@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> wrote:

[ pruning CC list ]

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master
> 
> I can't reproduce the issue locally, so asking the syzbot to test the 
> tentive fix for me (and hoping I did not mess with the tag/format) 

I can reproduce it.

CLUSTERIP has multiple other bugs that need to be fixed, I'll look into
this asap.
