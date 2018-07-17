Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83433ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C7920693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C7920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeGQRKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:10:05 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:36481 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729620AbeGQRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:10:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1F0DB18012879;
        Tue, 17 Jul 2018 16:36:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail93_397fbe20bb92d
X-Filterd-Recvd-Size: 1340
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Jul 2018 16:36:35 +0000 (UTC)
Message-ID: <85129bed442d10a94e196d9381a474d936982c16.camel@perches.com>
Subject: Re: [PATCH] usb: phy: fix copyright issue of phy-fsl-usb.c
From:   Joe Perches <joe@perches.com>
To:     Pengbo Mu <pengbo.mu@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 17 Jul 2018 09:36:33 -0700
In-Reply-To: <1531811402-44183-1-git-send-email-pengbo.mu@nxp.com>
References: <1531811402-44183-1-git-send-email-pengbo.mu@nxp.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 15:10 +0800, Pengbo Mu wrote:
> Fixed the copyright issue of drivers/usb/phy/phy-fsl-usb.c.
[]
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
[]
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2007,2008 Freescale semiconductor, Inc.
> + * Copyright 2007,2008 Freescale Semiconductor, Inc.

What issue?

There are ~60K files in linux and ~50K of them
have "(c)" or "(C)" in them.

