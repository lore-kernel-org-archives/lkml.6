Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59096ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AAD20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AAD20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbeGWQkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:40:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbeGWQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:40:43 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A23640B;
        Mon, 23 Jul 2018 15:38:55 +0000 (UTC)
Date:   Mon, 23 Jul 2018 17:38:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Bornyakov <brnkv.i1@gmail.com>
Cc:     devel@driverdev.osuosl.org, jnjoseph@google.com,
        linux-kernel@vger.kernel.org, rspringer@google.com
Subject: Re: [PATCH] staging: gasket: use vzalloc instead of vmalloc/memset
Message-ID: <20180723153853.GA10528@kroah.com>
References: <20180723150538.3520-1-brnkv.i1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723150538.3520-1-brnkv.i1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 06:05:38PM +0300, Ivan Bornyakov wrote:
> Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> ---
>  drivers/staging/gasket/gasket_page_table.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

I can not take patches without any changelog text at all, sorry.

greg k-h
