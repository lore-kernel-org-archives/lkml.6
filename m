Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbeBGSBF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:01:05 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33371 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753963AbeBGSBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:01:03 -0500
X-Google-Smtp-Source: AH8x2257xKxvi+cWJCwiNTxE9TWmKW/SkAXM4ZvLQ5BupW3jqqBa5dglXc8rEtefPbkwEfP2aic7Fg==
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        alban.browaeys@gmail.com, ming.lei@redhat.com, ivan@ludios.org,
        169364@studenti.unimore.it, holger@applied-asynchrony.com,
        efault@gmx.de, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 0/1] block, bfq: handle requeues of I/O requests
Date: Wed,  7 Feb 2018 19:00:49 +0100
Message-Id: <20180207180050.5639-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
fixed version, after bug reports and fixes in [1].

Thanks,
Paolo

[1] https://lkml.org/lkml/2018/2/5/599


Paolo Valente (1):
  block, bfq: add requeue-request hook

 block/bfq-iosched.c | 109 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 25 deletions(-)

--
2.15.1
