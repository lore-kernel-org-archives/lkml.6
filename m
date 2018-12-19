Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F572080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeLSMoS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:44:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36317 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbeLSMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:44:18 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id C164CCEEAE;
        Wed, 19 Dec 2018 13:51:55 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] Bluetooth: hci_bcm: Handle specific unknown packets
 after firmware loading
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181219112228.9735-1-pawel.mikolaj.chmiel@gmail.com>
Date:   Wed, 19 Dec 2018 13:44:15 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Content-Transfer-Encoding: 8BIT
Message-Id: <EACA869F-7A07-4585-9DFA-54094C9F7CE8@holtmann.org>
References: <20181219112228.9735-1-pawel.mikolaj.chmiel@gmail.com>
To:     =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

> The Broadcom controller on aries S5PV210 boards sends out a couple of
> unknown packets after the firmware is loaded.  This will cause
> logging of errors such as:
> 	Bluetooth: hci0: Frame reassembly failed (-84)
> 
> This is probably also the case with other boards, as there are related
> Android userspace patches for custom ROMs such as
> https://review.lineageos.org/#/c/LineageOS/android_system_bt/+/142721/
> Since this appears to be intended behaviour, treated them as diagnostic
> packets.
> 
> Note that this is another variant of commit 01d5e44ace8a
> ("Bluetooth: hci_bcm: Handle empty packet after firmware loading")
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> 
> ---
> Changes from v2:
>   - Rebased against latest bluetooth-next tree
> 
> Changes from v1:
>   - Rename UNKNOWN to TYPE49
>   - Rename UNKNOWN2 to TYPE52
> ---
> drivers/bluetooth/hci_bcm.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

