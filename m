Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D9C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C480A218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfB0Hsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:48:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55272 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfB0Hsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:48:35 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 054E4CF2AF;
        Wed, 27 Feb 2019 08:56:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_qca: Pass boolean 'on/off' to
 qca_send_power_pulse()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190226194647.146078-2-mka@chromium.org>
Date:   Wed, 27 Feb 2019 08:48:33 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D48DD225-4ED7-4F63-A5E5-02D1920B3C71@holtmann.org>
References: <20190226194647.146078-1-mka@chromium.org>
 <20190226194647.146078-2-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> There are only two types of power pulses 'on' or 'off', pass a boolean
> instead of the power pulse 'command'.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v2:
> - added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
> ---
> drivers/bluetooth/hci_qca.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

