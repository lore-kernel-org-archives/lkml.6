Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbeEHNby (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:31:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33570 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754754AbeEHNbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:31:52 -0400
X-Google-Smtp-Source: AB8JxZpnvKaH8uDrAlrUmV9vHTrebA54khjhSF5a1cGhb9Z8v058VcDAirPg/3YMLx3qs9peWQuH4g==
Date: Tue, 8 May 2018 09:06:43 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: syzbot <syzbot+e4a5bbd54260c93014f9@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Subject: Re: INFO: rcu detected stall in sctp_generate_heartbeat_event
Message-ID: <20180508120643.GM4977@localhost.localdomain>
References: <000000000000062c1c056bacd39f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000062c1c056bacd39f@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 12:35:02AM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    90278871d4b0 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=119a7237800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aea320d3af5ef99d
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4a5bbd54260c93014f9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.

A reproducer will be welcomed. With just these traces, I don't think
we have enough information.

  Marcelo
