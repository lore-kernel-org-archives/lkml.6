Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E486ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D962084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D962084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeGUHfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:35:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeGUHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:35:38 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3C888707;
        Sat, 21 Jul 2018 06:44:03 +0000 (UTC)
Date:   Sat, 21 Jul 2018 08:44:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: add SPDX license tag
Message-ID: <20180721064400.GA17385@kroah.com>
References: <20180720151126.5e62a2ec@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720151126.5e62a2ec@xeon-e3>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 03:11:26PM -0700, Stephen Hemminger wrote:
> Replace short statement in comment with proper SPDX
> license tag.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/uio/uio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks for this, care to fix up all of the drivers/uio/ files for this?
Or if not, I can...

thanks,

greg k-h
