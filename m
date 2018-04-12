Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeDLUqm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:46:42 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43015 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbeDLUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:46:38 -0400
X-Google-Smtp-Source: AIpwx48udx3BCzzeOG79F+QGBfehzEZ88Q6phQ/7tsCCX5kpVtJNu05qK4yPNxn3D2Z25TwTtrRskA==
Date: Thu, 12 Apr 2018 13:46:36 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
        paulus@samba.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v4] mm: remove odd HAVE_PTE_SPECIAL
In-Reply-To: <1523533733-25437-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1804121346250.22780@chino.kir.corp.google.com>
References: <20180411110936.GG23400@dhcp22.suse.cz> <1523533733-25437-1-git-send-email-ldufour@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018, Laurent Dufour wrote:

> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
> CONFIG_ARCH_HAS_PTE_SPECIAL.
> 
> There is no functional change introduced by this patch
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
