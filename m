Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5AEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69D320645
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfBRNGI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:06:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59299 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfBRNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:06:08 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0DA33CF2C7;
        Mon, 18 Feb 2019 14:13:59 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 2/6] Bluetooth: mediatek: trivial typo fix
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <fe55645efb173ef11cad6e43c194b400226b7a2f.1550184473.git.sean.wang@mediatek.com>
Date:   Mon, 18 Feb 2019 14:06:05 +0100
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E7DDB747-D3D7-4D31-BEA9-9277D95C2687@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <fe55645efb173ef11cad6e43c194b400226b7a2f.1550184473.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> add a trivial typo fix from speicfic to specific
> 
> Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtkuart.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

