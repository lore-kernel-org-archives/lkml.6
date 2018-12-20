Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F441C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C14521905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbeLTUXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:23:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbeLTUXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:23:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B52057FD50;
        Thu, 20 Dec 2018 20:23:24 +0000 (UTC)
Received: from flask (unknown [10.43.2.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 630175D78E;
        Thu, 20 Dec 2018 20:23:21 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 20 Dec 2018 21:23:21 +0100
Date:   Thu, 20 Dec 2018 21:23:21 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     tglx@linutronix.de, pbonzini@redhat.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]  x86/kvmclock : convert to SPDX identifiers
Message-ID: <20181220202320.GL25497@flask>
References: <1541149517-51960-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541149517-51960-1-git-send-email-peng.hao2@zte.com.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 20 Dec 2018 20:23:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-11-02 17:05+0800, Peng Hao:
> Update the verbose license text with the matching SPDX 
> license identifier.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/x86/kernel/kvmclock.c | 15 +--------------
>  1 files changed, 1 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 1e67646..a59325e 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -1,19 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0+ is deprecated in favor of GPL-2.0-or-later, so I have changed
it to that one and queued,

thanks.
