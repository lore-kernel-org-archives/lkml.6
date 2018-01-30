Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeA3N6t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:58:49 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:41438 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751720AbeA3N6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:58:48 -0500
Date: Tue, 30 Jan 2018 14:55:56 +0100
From: Florian Westphal <fw@strlen.de>
To: syzbot <syzbot+a40f0d7f9436d6cbd874@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in do_ip_setsockopt
Message-ID: <20180130135556.GK5906@breakpoint.cc>
References: <001a11427588ccc4700563c78a58@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11427588ccc4700563c78a58@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: possible deadlock in do_ip_getsockopt
