Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB93ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B87220849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B87220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeGUHx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:53:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeGUHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:53:58 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 24740707;
        Sat, 21 Jul 2018 07:02:17 +0000 (UTC)
Date:   Sat, 21 Jul 2018 09:02:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 09/10] staging:trl8192u: Rename TClasProc >
 t_clas_proc - Style
Message-ID: <20180721070215.GA20326@kroah.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
 <20180716190454.31489-10-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716190454.31489-10-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 08:04:53PM +0100, John Whitmore wrote:
> Rename the struct TS_COMMON_INFO member variable TClasProc to
> t_clas_proc. This change clears the checkpatch issue with CamelCase variable
> names. There should be no impact on runtime execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
>  drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Ah, I think the problem with the rejections was that I didn't pick up
this patch, because you mispelled the driver name :)

I filter for drivers to apply everything for that one at the same time
to make things easier on myself.  And this got dropped.  Please fix the
subject up and add it to your series and resend, that should hopefully
fix the problems.

thanks,

greg k-h
