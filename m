Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF230ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FC820858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FC820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeGUHwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:52:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeGUHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:52:22 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDD14AF8;
        Sat, 21 Jul 2018 07:00:42 +0000 (UTC)
Date:   Sat, 21 Jul 2018 09:00:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 07/14] staging:rtl8192u: Remove typedef and rename struct
 RT_DOT11D_INFO - Style
Message-ID: <20180721070040.GA10620@kroah.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
 <20180720202142.26312-8-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720202142.26312-8-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 09:21:35PM +0100, John Whitmore wrote:
> Removed the typedef from structure RT_DOT11D_INFO. This change clears the
> checkpatch issue with declaring new types.
> 
> Rename the structure from RT_DOT11D_INFO to rt_dot11d_info.
> 
> Coding style changes which should not impact runtime execution of code.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/dot11d.c        | 14 +++++++-------
>  drivers/staging/rtl8192u/ieee80211/dot11d.h        | 11 ++++++-----
>  .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |  2 +-
>  3 files changed, 14 insertions(+), 13 deletions(-)

This patch fails to apply as well.

I've applied the series up to here.  Please rebase what I didn't take
from this, and the last patch from the other series, and resend.

thanks,

greg k-h
