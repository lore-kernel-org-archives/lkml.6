Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512EAC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E40217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfAYHvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:51:12 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55016 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfAYHvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:51:11 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 103E4CF172;
        Fri, 25 Jan 2019 08:58:57 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v6 1/4] usb: split code locating ACPI companion into port
 and device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190124232814.252661-1-rajatja@google.com>
Date:   Fri, 25 Jan 2019 08:51:08 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        rajatxjain@gmail.com, dtor@google.com,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        sukumar.ghorai@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <7A631FFF-3C46-48B9-AAC6-F60F7B06D17D@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190124232814.252661-1-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> In preparation for handling embedded USB devices let's split
> usb_acpi_find_companion() into usb_acpi_find_companion_for_device() and
> usb_acpi_find_companion_for_port().
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> ---
> v6: same as v4
> v5: same as v4
> v4: Add Acked-by and Tested-by in signatures.
> v3: same as v1
> v2: same as v1
> 
> drivers/usb/core/usb-acpi.c | 133 +++++++++++++++++++-----------------
> 1 file changed, 72 insertions(+), 61 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

