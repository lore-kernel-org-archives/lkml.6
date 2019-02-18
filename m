Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B79C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF3D2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfBRNJe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:09:34 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57406 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfBRNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:09:33 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 45467CF2C7;
        Mon, 18 Feb 2019 14:17:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 5/6] Bluetooth: mediatek: update the common setup between
 MT7622 and other devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <9ea118140651636b3b868e28004d474ded4af5b6.1550184473.git.sean.wang@mediatek.com>
Date:   Mon, 18 Feb 2019 14:09:31 +0100
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B862A902-56CD-4397-9326-BAB3CB71D60F@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <9ea118140651636b3b868e28004d474ded4af5b6.1550184473.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Update the setup sequence on MT7622 to apply the same flow with MT7663U
> and MT7668U USB [1] as much as possible. These additional commands are
> required to parse the corresponding event to determine what current state
> the Bluetooth device is on and thus it's necessary to extend
> mtk_hci_wmt_sync to support the reading status in the same patch.
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtkuart.c | 204 +++++++++++++++++++++++++++++++---
> 1 file changed, 190 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

