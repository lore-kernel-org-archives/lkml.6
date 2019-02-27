Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757BDC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C7D21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfB0Hse convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:48:34 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35287 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfB0Hsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:48:33 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5B34ACF2AE;
        Wed, 27 Feb 2019 08:56:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 0/2] Reduce delay after sending baudrate request for
 WCN3990
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190226200848.154216-1-mka@chromium.org>
Date:   Wed, 27 Feb 2019 08:48:31 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <45D9EB4B-C81A-4970-9ED1-3737A0AF771F@holtmann.org>
References: <20190226200848.154216-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> The current 300ms delay after a baudrate change is extremely long.
> For WCM3990 it is sufficient to wait 10ms after the baudrate change
> request has been sent over the wire.
> 
> Also use msleep() instead of a set_current_state() / schedule_timeout()
> combo.
> 
> Matthias Kaehlcke (2):
>  hci_qca: Use msleep() instead of open coding it
>  hci_qca: Reduce delay after sending baudrate request for WCN3990
> 
> drivers/bluetooth/hci_qca.c | 30 +++++++++++++++++++++---------
> 1 file changed, 21 insertions(+), 9 deletions(-)

patch 1/2 has been applied to bluetooth-next tree. The patch 2/2 fails to apply.

Regards

Marcel

