Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932428AbeDWUFz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:05:55 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34510 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbeDWUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:05:52 -0400
X-Google-Smtp-Source: AIpwx48+hbXVAzyIS6bZBZHKXON3Bu+BKuNZFUu08oDz6S9m3FW2dNIHhxsW7gqV79jfF3d+RmVPNXV+FO5ueeWE4nY=
MIME-Version: 1.0
In-Reply-To: <000000000000eeeeff056a79954c@google.com>
References: <000000000000eeeeff056a79954c@google.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 23 Apr 2018 13:05:31 -0700
Message-ID: <CAM_iQpWp7taVCr4h_zJQQadA_ZW1XNv3MNARBa4+YoNueGyY+Q@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Read in refcount_inc_not_zero
To: syzbot <syzbot+6a35cd2d9559c909d570@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, xiaolou4617@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: llc: fix NULL pointer deref for SOCK_ZAPPED
