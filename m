Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC29C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DA6218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeLRXt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:49:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38686 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbeLRXtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:49:55 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8F4BFCEE94;
        Wed, 19 Dec 2018 00:57:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] bluetooth: Remove unnecessary smp_mb__after_atomic()
 barriers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181127112225.6177-1-andrea.parri@amarulasolutions.com>
Date:   Wed, 19 Dec 2018 00:49:53 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E1EF7686-BED9-4E96-988E-8B22B2646D78@holtmann.org>
References: <20181127112225.6177-1-andrea.parri@amarulasolutions.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

> The barriers are redundant because atomic_test_and_clear_bit() already
> provides the required full ordering for the cases in question (that is,
> when the bit is cleared).
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
> drivers/bluetooth/btusb.c     |  8 ++------
> drivers/bluetooth/hci_intel.c | 16 ++++------------
> 2 files changed, 6 insertions(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

