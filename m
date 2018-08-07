Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B82C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A4221888
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A4221888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbeHGKUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:20:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeHGKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:20:47 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1614EC9A;
        Tue,  7 Aug 2018 08:07:37 +0000 (UTC)
Date:   Tue, 7 Aug 2018 10:07:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arkadiusz Lis <areklis909@gmail.com>
Cc:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: One Laptop Per Child: fix
 SPDX-License-Identifier issue
Message-ID: <20180807080734.GB20615@kroah.com>
References: <1533575300-5001-1-git-send-email-areklis909@gmail.com>
 <1533584152-5792-1-git-send-email-areklis909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533584152-5792-1-git-send-email-areklis909@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:35:52PM +0200, Arkadiusz Lis wrote:
> Add SPDX-License-Identifier to the source files.
> Remove redundant, old license.
> 
> Signed-off-by: Arkadiusz Lis <areklis909@gmail.com>
> ---
>  drivers/staging/olpc_dcon/olpc_dcon.c        | 5 +----
>  drivers/staging/olpc_dcon/olpc_dcon_xo_1.c   | 5 +----
>  drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c | 5 +----
>  3 files changed, 3 insertions(+), 12 deletions(-)

WHat changed from v1?  Always put that below the --- line.

Please redo with a v3 now.

thanks,

greg k-h
