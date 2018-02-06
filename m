Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeBFSm7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:42:59 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:47526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbeBFSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:42:50 -0500
Date: Tue, 06 Feb 2018 13:42:45 -0500 (EST)
Message-Id: <20180206.134245.680837561909396767.davem@davemloft.net>
To: keescook@chromium.org
Cc: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiggers3@gmail.com, james.morse@arm.com, keun-o.park@darkmatter.ae,
        labbott@redhat.com, linux-mm@kvack.org, mingo@kernel.org
Subject: Re: [PATCH v2] socket: Provide put_cmsg_whitelist() for constant
 size copies
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAGXu5j+JnJKQocO4LxshbPZ0HPO+sQ71D+iCtCJN1YJzKn2G0g@mail.gmail.com>
References: <CAGXu5j+VnhgXFajjxR7HJkN=Z6r3Kfw-+Gg2x37AacOD6C+Wdg@mail.gmail.com>
        <20180206.111949.1986970583522698316.davem@davemloft.net>
        <CAGXu5j+JnJKQocO4LxshbPZ0HPO+sQ71D+iCtCJN1YJzKn2G0g@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Feb 2018 05:36:02 +1100

> Making put_cmsg() inline would help quite a bit with tracking the
> builtin_const-ness, and that could speed things up a little bit too.
> Would you be opposed to inlining?

Nope.
