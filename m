Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755417AbeCVNKq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:10:46 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:44608 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755039AbeCVNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:10:44 -0400
X-Google-Smtp-Source: AG47ELulwswlERwh2dHj01CeDPHcgvwxJAlyV3s6w3bCP2ySlJalyBTenrQbz2ibe3lEOS28PEl9+9wy5WOv8ysL404=
MIME-Version: 1.0
In-Reply-To: <20180322124823.GB19440@mtr-leonro.local>
References: <94eb2c0bc3aa8b2432056623c735@google.com> <20180322124823.GB19440@mtr-leonro.local>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 22 Mar 2018 14:10:21 +0100
Message-ID: <CACT4Y+Ya8iMgV=7YGgsO2XnusF9tnGcHHPF5U5oNjQz_eJ+vMw@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in process_one_req
To: Leon Romanovsky <leonro@mellanox.com>
Cc: syzbot <syzbot+3b4acab09b6463472d0a@syzkaller.appspotmail.com>,
        danielj@mellanox.com, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes.berg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        monis@mellanox.com, Paolo Abeni <pabeni@redhat.com>,
        parav@mellanox.com, roland@purestorage.com,
        syzkaller-bugs@googlegroups.com, yuval.shaia@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is actively happening several times per day, if such bug is
closed syzbot will open another bug on the next crash.
This bug has a reproducer, why do you think it is invalid?
