Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DD0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B042218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeLRXuT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:50:19 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51887 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeLRXuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:50:12 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 50B2CCEE94;
        Wed, 19 Dec 2018 00:57:50 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4329B1 UART bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181205204116.23815-1-pawel.mikolaj.chmiel@gmail.com>
Date:   Wed, 19 Dec 2018 00:50:11 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D9A3BC60-B413-45A8-98D2-51207FE2AF46@holtmann.org>
References: <20181205204116.23815-1-pawel.mikolaj.chmiel@gmail.com>
To:     =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

> This patch adds the device ID for the BCM 4329 combo module used
> in the Samsung Aries based phones (Galaxy S and it's variants).
> 
> ```
> [   11.508980] Bluetooth: hci0: BCM: chip id 41
> [   11.518975] Bluetooth: hci0: BCM: features 0x04
> [   11.550132] Bluetooth: hci0: BCM4329B1
> [   11.557046] Bluetooth: hci0: BCM4329B1 (002.002.023) build 0000
> [   13.737071] Bluetooth: hci0: BCM4329B1 (002.002.023) build 0744
> ```
> 
> Output from hciconfig
> 
> ```
> hci0:   Type: Primary  Bus: UART
>        BD Address: 43:29:B1:55:00:00  ACL MTU: 1021:6  SCO MTU: 64:1
>        UP RUNNING
>        RX bytes:1675 acl:0 sco:0 events:145 errors:0
>        TX bytes:20426 acl:0 sco:0 commands:146 errors:0
>        Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x83
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH SNIFF
>        Link mode: SLAVE ACCEPT
>        Name: 'aries'
>        Class: 0x000000
>        Service Classes: Unspecified
>        Device Class: Miscellaneous,
>        HCI Version: 2.1 (0x4)  Revision: 0x2e8
>        LMP Version: 2.1 (0x4)  Subversion: 0x4217
>        Manufacturer: Broadcom Corporation (15)
> ```
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> drivers/bluetooth/btbcm.c | 1 +
> 1 file changed, 1 insertion(+)

please update this patch so it applies cleanly against latest bluetooth-next tree.

Regards

Marcel

