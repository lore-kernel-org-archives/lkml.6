Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeDJUou (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:44:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42553 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbeDJUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:44:47 -0400
X-Google-Smtp-Source: AIpwx481Iye6CoddmKWdedAbzWjU9DpCSIsR+w18WD7cctFO6ijoLnxsmE/Fkh+BVRnb6+6V/zpP7Q==
Date: Tue, 10 Apr 2018 13:44:46 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Apr 2018 13:41:36 PDT (-0700)
Subject: Re: [PATCH v2 1/2] mm: introduce ARCH_HAS_PTE_SPECIAL
In-Reply-To: <20180410160932.GB3614@bombadil.infradead.org>
CC: ldufour@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, jglisse@redhat.com, mhocko@kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        corbet@lwn.net, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, vgupta@synopsys.com, albert@sifive.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, rientjes@google.com
From: Palmer Dabbelt <palmer@sifive.com>
To: willy@infradead.org
Message-ID: <mhng-dc76549e-6083-49a7-af3f-2638193f6698@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 09:09:32 PDT (-0700), willy@infradead.org wrote:
> On Tue, Apr 10, 2018 at 05:25:50PM +0200, Laurent Dufour wrote:
>>  arch/powerpc/include/asm/pte-common.h                  | 3 ---
>>  arch/riscv/Kconfig                                     | 1 +
>>  arch/s390/Kconfig                                      | 1 +
>
> You forgot to delete __HAVE_ARCH_PTE_SPECIAL from
> arch/riscv/include/asm/pgtable-bits.h

Thanks -- I was looking for that but couldn't find it and assumed I'd just 
misunderstood something.
