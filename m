Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeEPJms (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:42:48 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:39448 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEPJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:42:46 -0400
X-Google-Smtp-Source: AB8JxZqjRlrEOmD2GUDqt3I5KAFEljnvo4R5BgN1sWaIHUeWCOESm530QldkNlZYIPhL/0RIn4xtirRT8PEZBUcvCFw=
MIME-Version: 1.0
References: <0000000000004f4075056c410b96@google.com>
In-Reply-To: <0000000000004f4075056c410b96@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 16 May 2018 11:42:32 +0200
Message-ID: <CAG_fn=V_sXGGYpi+DAqE3BUJBTWUc59vLeLQxUmBgsiMDjMUGw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in __sctp_v6_cmp_addr
To: syzbot+85490c30c260afff22f2@syzkaller.appspotmail.com
Cc: David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
