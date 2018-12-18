Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7200BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A704218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeLRXuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:50:13 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40729 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeLRXuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:50:10 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id DDBDCCEE94;
        Wed, 19 Dec 2018 00:57:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1] Bluetooth: hci_serdev: Remove setting of
 HCI_QUIRK_RESET_ON_CLOSE.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181122125047.725-1-bgodavar@codeaurora.org>
Date:   Wed, 19 Dec 2018 00:50:08 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <153DF575-23E5-41FC-9EB5-AC95DD8DA46D@holtmann.org>
References: <20181122125047.725-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> HCI_QUIRK_RESET_ON_CLOSE quirk is required for BT v1.0 based devices,
> to send a reset command to the chip during hci device close. Serdev
> architecture is used for the latest BT chips, which doesn't require to
> send the reset command during close. If still chips required reset
> command during close, it would be better enabling it in the vendor
> probes or in proto setup.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> drivers/bluetooth/hci_serdev.c | 3 ---
> 1 file changed, 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

