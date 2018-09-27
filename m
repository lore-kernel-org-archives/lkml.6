Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3910C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE8220666
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE8220666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeI0RH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:07:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47744 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:07:57 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 71371CF16A;
        Thu, 27 Sep 2018 12:57:31 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4335C0 UART bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1536083457-28895-1-git-send-email-christianshewitt@gmail.com>
Date:   Thu, 27 Sep 2018 12:50:14 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C0E733D2-AA4B-4B17-BF3A-D998EB231968@holtmann.org>
References: <1536083457-28895-1-git-send-email-christianshewitt@gmail.com>
To:     Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

> This patch adds the device ID for the AMPAK AP6335 combo module used
> in the 1st generation WeTek Hub Android/LibreELEC HTPC box. The WiFI
> chip identifies itself as BCM4339, while Bluetooth identifies itself
> as BCM4335 (rev C0):
> 
> ```
> [    4.864248] Bluetooth: hci0: BCM: chip id 86
> [    4.866388] Bluetooth: hci0: BCM: features 0x2f
> [    4.889317] Bluetooth: hci0: BCM4335C0
> [    4.889332] Bluetooth: hci0: BCM4335C0 (003.001.009) build 0000
> [    9.778383] Bluetooth: hci0: BCM4335C0 (003.001.009) build 0268
> ```
> 
> Output from hciconfig:
> 
> ```
> hci0:	Type: Primary  Bus: UART
> 	BD Address: 43:39:00:00:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
> 	UP RUNNING
> 	RX bytes:7567 acl:234 sco:0 events:386 errors:0
> 	TX bytes:53844 acl:77 sco:0 commands:304 errors:0
> 	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> 	Link policy: RSWITCH SNIFF
> 	Link mode: SLAVE ACCEPT
> 	Name: 'HUB'
> 	Class: 0x0c0000
> 	Service Classes: Rendering, Capturing
> 	Device Class: Miscellaneous,
> 	HCI Version: 4.0 (0x6)  Revision: 0x10c
> 	LMP Version: 4.0 (0x6)  Subversion: 0x6109
> 	Manufacturer: Broadcom Corporation (15)
> ```
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> drivers/bluetooth/btbcm.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

