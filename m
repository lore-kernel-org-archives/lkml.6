Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03CEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8713218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbeLRXtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:49:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50112 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeLRXtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:49:45 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8810BCEE81;
        Wed, 19 Dec 2018 00:57:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] net/bluetooth: Change to use DEFINE_SHOW_ATTRIBUTE macro
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181105145619.6395-1-tiny.windzz@gmail.com>
Date:   Wed, 19 Dec 2018 00:49:43 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, keescook@chromium.org,
        gustavo@embeddedor.com, dvlasenk@redhat.com,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <89EE12B3-8784-4E50-86F5-ACEC00EC6A47@holtmann.org>
References: <20181105145619.6395-1-tiny.windzz@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> net/bluetooth/l2cap_core.c  | 12 +-----------
> net/bluetooth/rfcomm/core.c | 12 +-----------
> net/bluetooth/rfcomm/sock.c | 12 +-----------
> net/bluetooth/sco.c         | 12 +-----------
> 4 files changed, 4 insertions(+), 44 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

