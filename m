Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7555BC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438D820645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438D820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeJCEnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:43:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeJCEnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:43:00 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36826412;
        Tue,  2 Oct 2018 21:57:18 +0000 (UTC)
Date:   Tue, 2 Oct 2018 14:57:17 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxime Desroches <desroches.maxime@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Staging: rts5208: xd.c: Fixed all braces issues of
 the file
Message-ID: <20181002215717.GB22348@kroah.com>
References: <20180929180027.19815-1-desroches.maxime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929180027.19815-1-desroches.maxime@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 02:00:27PM -0400, Maxime Desroches wrote:
> Fixed all the braces issues of the xd.c file
> 
> Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
> ---
>  drivers/staging/rts5208/xd.c | 232 ++++++++++++++---------------------
>  1 file changed, 92 insertions(+), 140 deletions(-)

Again, missing earlier patches.

Please fix this up and resend as a proper series of patches, properly
numbered.

thanks,

greg k-h
