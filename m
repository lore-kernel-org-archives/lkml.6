Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF01720823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfARJPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:15:03 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51196 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:15:02 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4DF8CCF2C3;
        Fri, 18 Jan 2019 10:22:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 2/2] bluetooth: btmrvl_sdio: lower log level of
 informational message
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190111205657.2792-2-stefan@agner.ch>
Date:   Fri, 18 Jan 2019 10:15:00 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, huxm@marvell.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8610ACAD-F828-441E-87F3-EE8B93EE7801@holtmann.org>
References: <20190111205657.2792-1-stefan@agner.ch>
 <20190111205657.2792-2-stefan@agner.ch>
To:     Stefan Agner <stefan@agner.ch>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

> The platform specific wake-up interrupt is optional. Don't print
> an error message in case it is missing, merely inform the user in
> this case.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

