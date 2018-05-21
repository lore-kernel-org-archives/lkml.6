Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeEUSJd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:09:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:58044 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbeEUSJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:09:28 -0400
Date: Mon, 21 May 2018 14:09:24 -0400 (EDT)
Message-Id: <20180521.140924.2255125685012645769.davem@davemloft.net>
To: syzbot+f116bc1994efe725d51b@syzkaller.appspotmail.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, roopa@cumulusnetworks.com
Subject: Re: INFO: rcu detected stall in corrupted
From: David Miller <davem@davemloft.net>
In-Reply-To: <00000000000007eb20056cbb245f@google.com>
References: <00000000000007eb20056cbb245f@google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: syzbot <syzbot+f116bc1994efe725d51b@syzkaller.appspotmail.com>
Date: Mon, 21 May 2018 11:05:02 -0700

>  find_match+0x244/0x13a0 net/ipv6/route.c:691
>  find_rr_leaf net/ipv6/route.c:729 [inline]
>  rt6_select net/ipv6/route.c:779 [inline]

Hmmm, endless loop in find_rr_leaf or similar?
