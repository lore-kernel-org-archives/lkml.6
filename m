Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033384AbeCARQb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:16:31 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34465 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033102AbeCARPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:15:48 -0500
X-Google-Smtp-Source: AG47ELv7/G7elxbvcPK9dnPeZzENfX3ePvsUksABuFYx65lQx/fq1XgMMicjfqbKvj2FJyQWVdOm2g==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc: Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 0/2] kasan: a couple of test fixes
Date: Thu,  1 Mar 2018 18:15:41 +0100
Message-Id: <cover.1519924383.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first one fixes the invalid-free test crashing the kernel, and the
second one fixes the memset tests working incorrectly due to compiler
optimizations.

Andrey Konovalov (2):
  kasan: fix invalid-free test crashing the kernel
  kasan: disallow compiler to optimize away memset in tests

 lib/Makefile     | 1 +
 lib/test_kasan.c | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.16.2.395.g2e18187dfd-goog
