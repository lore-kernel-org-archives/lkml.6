Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDC420870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDC420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeG3NgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:36:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52650 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbeG3NgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:36:14 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6352FCF2C5;
        Mon, 30 Jul 2018 14:08:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v6 2/4] Bluetooth: Add new quirk for non-persistent setup
 settings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d20e070679bb40bff011f5a74f531e1b662d08a5.1532060309.git.sean.wang@mediatek.com>
Date:   Mon, 30 Jul 2018 14:01:31 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A25EEA4C-6A6D-4189-B259-2ABB8A4D1A59@holtmann.org>
References: <cover.1532060309.git.sean.wang@mediatek.com>
 <d20e070679bb40bff011f5a74f531e1b662d08a5.1532060309.git.sean.wang@mediatek.com>
To:     sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
> runs setup() after every open() and not just after the first open().
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> include/net/bluetooth/hci.h | 9 +++++++++
> net/bluetooth/hci_core.c    | 3 ++-
> 2 files changed, 11 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

