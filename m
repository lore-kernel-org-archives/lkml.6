Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B6EC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF472087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfASTvF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:51:05 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34341 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbfASTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:51:04 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 939CCCF350;
        Sat, 19 Jan 2019 20:58:48 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4 2/5] usb: assign ACPI companions for embedded USB
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190118223407.64818-2-rajatja@google.com>
Date:   Sat, 19 Jan 2019 20:51:01 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <77FFC08C-D038-4BBE-9153-FBA1701D3168@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190118223407.64818-1-rajatja@google.com>
 <20190118223407.64818-2-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> USB devices permanently connected to USB ports may be described in ACPI
> tables and share ACPI devices with ports they are connected to. See [1]
> for details.
> 
> This will allow us to describe sideband resources for devices, such as,
> for example, hard reset line for BT USB controllers.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/other-acpi-namespace-objects#acpi-namespace-hierarchy-and-adr-for-embedded-usb-devices
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Rajat Jain <rajatja@google.com> (changed how we get the usb_port)
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> ---
> v4: Add Acked-by and Tested-by in signatures.
> v3: same as v1
> v2: same as v1
> 
> drivers/usb/core/usb-acpi.c | 44 +++++++++++++++++++++++++++++--------
> 1 file changed, 35 insertions(+), 9 deletions(-)

same question here. Which tree is suppose to take this?

Regards

Marcel

