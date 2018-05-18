Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeERXn5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 19:43:57 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33551 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeERXnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 19:43:53 -0400
X-Google-Smtp-Source: AB8JxZpBgi4nMNh4Gd2ipaubhM5tnZRum87z4bfZA4p5xmo83naR1y3leMIqM3GmjOOH4RJScivrIQA/1HdZdSIhaKs=
MIME-Version: 1.0
In-Reply-To: <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 19 May 2018 00:43:32 +0100
Message-ID: <CAJwJo6bVOS9YJUtS-BndbwiNT+VhypxkuifQPE1c-A_BogxT1A@mail.gmail.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-18 23:41 GMT+01:00 Dmitry Safonov <0x7f454c46@gmail.com>:
> What I did - was running x86 selftests and ssh'ing at the same moment.
> Will try it again if it'll fire by any chance.

No, I've tried a couple of times (after reboot as it's ONCE), but it looks
hard to reproduce by hands without some automation or something.

Thanks,
             Dmitry
