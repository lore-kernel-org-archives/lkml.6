Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DB9C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833AB217BF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833AB217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeHUSRn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:17:43 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38855 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:17:43 -0400
Received: from [172.20.13.211] (unknown [94.75.125.194])
        by mail.holtmann.org (Postfix) with ESMTPSA id B7211CF355;
        Tue, 21 Aug 2018 17:04:16 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: mediatek: Fix memory leak
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180814151031.GA25096@embeddedor.com>
Date:   Tue, 21 Aug 2018 16:57:11 +0200
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E5153D2C-A52F-4BA8-8B79-A19338BDC12D@holtmann.org>
References: <20180814151031.GA25096@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

> In case memory resources for *fw* were allocated, release them before
> return.
> 
> Addresses-Coverity-ID: 1472611 ("Resource leak")
> Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> drivers/bluetooth/btmtkuart.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

