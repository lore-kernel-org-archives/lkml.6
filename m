Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeA3JH2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:07:28 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:40632 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751219AbeA3JH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:07:26 -0500
Date: Tue, 30 Jan 2018 10:04:33 +0100
From: Florian Westphal <fw@strlen.de>
To: syzbot <syzbot+ed1af231da07c4aee030@syzkaller.appspotmail.com>
Cc: fw@strlen.de, kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in xt_find_table_lock
Message-ID: <20180130090433.GI5906@breakpoint.cc>
References: <089e082603c4d3bea10563fa816b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089e082603c4d3bea10563fa816b@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: possible deadlock in do_ip_getsockopt
