Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeDDXF1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:05:27 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:38718 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeDDXF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:05:26 -0400
X-Google-Smtp-Source: AIpwx4/AbLJB0hdn6+ib986lao9GS85ohUgq4yzu79SgzUVtCa98Tn3FgMRA9UhVBKOUUvZRDkHkIBQIbNnh0RxN/M4=
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 4 Apr 2018 18:05:04 -0500
Message-ID: <CAH2r5ms+u37sOrL9=hVG6cCKc3qAvgLJaXFKsB4aUihZwbvV=w@mail.gmail.com>
Subject: Noisy Sparse warnings
To: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been getting the following sparse warnings repeatedly on my
current Ubutu (17.10) when compiling the current mainline kernel:

./arch/x86/include/asm/nospec-branch.h:144:38: warning: Unknown escape '@'
./include/linux/string.h:239:1: error: attribute 'gnu_inline': unknown attribute

I get the same sparse error whether I use the default sparse that
Ubuntu ships (0.5.0) or the current sparse (0.5.2-rc1)

Ideas?


-- 
Thanks,

Steve
