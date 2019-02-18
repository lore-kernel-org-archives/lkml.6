Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481CB20645
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfBRNIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:08:13 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41756 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfBRNIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:08:12 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 22981CF2C7;
        Mon, 18 Feb 2019 14:16:04 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 4/6] Bluetooth: mediatek: pass a pointer to
 mtk_hci_wmt_sync
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <614e7741328e835071099ddcd4f9c2afd9528534.1550184473.git.sean.wang@mediatek.com>
Date:   Mon, 18 Feb 2019 14:08:10 +0100
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7A2615D4-1497-4BE2-8E89-66447370E31E@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <614e7741328e835071099ddcd4f9c2afd9528534.1550184473.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Pass a structure pointer to mtk_hci_wmt_sync rather than several arguments
> to avoid take up additional stack area and be better to read the code.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtkuart.c | 63 ++++++++++++++++++++++++++---------
> 1 file changed, 48 insertions(+), 15 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

