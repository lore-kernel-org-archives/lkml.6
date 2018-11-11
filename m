Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BEBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1505F208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1505F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeKLGpM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:45:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54982 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbeKLGpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:45:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 22C2920757; Sun, 11 Nov 2018 21:55:33 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6112820714;
        Sun, 11 Nov 2018 21:55:32 +0100 (CET)
Date:   Sun, 11 Nov 2018 21:55:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH] mtd: rawnand: Add All 1.8V AC chips have a broken
 GET_FEATURES(TIMINGS)
Message-ID: <20181111215531.7ee18d98@xps13>
In-Reply-To: <1540449871-7224-2-git-send-email-masonccyang@mxic.com.tw>
References: <1540449871-7224-1-git-send-email-masonccyang@mxic.com.tw>
        <1540449871-7224-2-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Thu, 25 Oct 2018 14:44:31 +0800:

> From: Mason Yang <masonccyang@mxic.com.tw>
> 
> Make sure we flag all 1.8V broken chips as not supporting this features.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---

Applied to nand/next (with the title slightly modified).

Thanks,
Miquèl
