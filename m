Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D09C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B4021848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfA2PMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:12:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35654 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfA2PMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:12:54 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 154F7CF2C3;
        Tue, 29 Jan 2019 16:20:42 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: btusb: btusb_intel_cmd_timeout: use sleeping
 functions
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190128230809.173975-1-rajatja@google.com>
Date:   Tue, 29 Jan 2019 16:12:52 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rajatxjain@gmail.com, dtor@google.com
Content-Transfer-Encoding: 7bit
Message-Id: <6C7BB33E-760F-47E3-8B7D-1F0F58CD2FBE@holtmann.org>
References: <20190128230809.173975-1-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> The btusb_intel_cmd_timeout() is called from workqueue contexts,
> so use the helper functions that can sleep.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel

