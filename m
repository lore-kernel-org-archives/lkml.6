Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAA0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A90217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfAYHvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:51:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47087 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfAYHvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:51:16 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6BDB0CF182;
        Fri, 25 Jan 2019 08:59:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v6 3/4] Bluetooth: Allow driver specific cmd timeout
 handling
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190124232814.252661-3-rajatja@google.com>
Date:   Fri, 25 Jan 2019 08:51:14 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <08DB08CC-00B5-4D59-92F8-49C27127282B@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190124232814.252661-1-rajatja@google.com>
 <20190124232814.252661-3-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> Add a hook to allow the BT driver to do device or command specific
> handling in case of timeouts. This is to be used by Intel driver to
> reset the device after certain number of timeouts.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v6: Dropped the "sent command" parameter from cmd_timeout()
> v5: Drop the quirk, and rename the hook function to cmd_timeout()
> v4: same as v1
> v3: same as v1
> v2: same as v1
> 
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_core.c         | 3 +++
> 2 files changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

