Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FCEC65BA7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9804820652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9804820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJCNrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:47:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44716 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeJCNrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:47:52 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 67473CF353;
        Wed,  3 Oct 2018 09:08:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2] btsdio: Do not bind to non-removable BCM43430
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181002095704.22472-1-acho@suse.com>
Date:   Wed, 3 Oct 2018 09:00:48 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, jlee@suse.com
Content-Transfer-Encoding: 7bit
Message-Id: <B1BB2FA6-9753-4924-B4E0-8CDE462A802A@holtmann.org>
References: <DE21BFD5-3A79-4D64-9DB1-4A2DCDBBE359@holtmann.org>
 <20181002095704.22472-1-acho@suse.com>
To:     "Cho, Yu-Chen" <acho@suse.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu-Chen,

> BCM43430 devices soldered onto the PCB (non-removable)
> use an UART connection for bluetooth.
> But also advertise btsdio support on their 3th sdio function.
> 
> Signed-off-by: Cho, Yu-Chen <acho@suse.com>
> ---
> drivers/bluetooth/btsdio.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)

patch (with slight modifications) has been applied to bluetooth-next tree.

Regards

Marcel

