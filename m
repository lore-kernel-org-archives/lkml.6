Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D331CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 01:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42562184C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 01:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfBZBs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 20:48:57 -0500
Received: from ozlabs.org ([203.11.71.1]:33359 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBZBs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 20:48:56 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 447hYX0Wmnz9s5c;
        Tue, 26 Feb 2019 12:48:48 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Souptick Joarder <jrdr.linux@gmail.com>, bamv2005@gmail.com,
        shuah@kernel.org, davem@davemloft.net, benh@kernel.crashing.org,
        paulus@samba.org, adobriyan@gmail.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@linux.ibm.com, boqun.feng@gmail.com,
        john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] tools: testing: selftests: Remove duplicate headers
In-Reply-To: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
References: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
Date:   Tue, 26 Feb 2019 12:48:47 +1100
Message-ID: <87tvgr1fr4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Souptick Joarder <jrdr.linux@gmail.com> writes:
> Remove duplicate headers which are included twice.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
...
>  tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -

I took this hunk via the powerpc tree.

> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> index 167135b..af1b802 100644
> --- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> +++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> @@ -11,7 +11,6 @@
>  #include <sys/wait.h>
>  #include <unistd.h>
>  #include <setjmp.h>
> -#include <signal.h>
>  
>  #include "ebb.h"


cheers
