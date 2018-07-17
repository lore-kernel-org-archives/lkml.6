Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E079CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996A720863
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996A720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeGQHvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:51:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeGQHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:51:03 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0C6932D;
        Tue, 17 Jul 2018 07:19:52 +0000 (UTC)
Date:   Tue, 17 Jul 2018 09:19:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pengbo Mu <pengbo.mu@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: phy: fix copyright issue of phy-fsl-usb.c
Message-ID: <20180717071950.GA12255@kroah.com>
References: <1531811402-44183-1-git-send-email-pengbo.mu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531811402-44183-1-git-send-email-pengbo.mu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:10:02PM +0800, Pengbo Mu wrote:
> Fixed the copyright issue of drivers/usb/phy/phy-fsl-usb.c.

I still fail to understand what exactly the "copyright issue" is here.
Can you provide some details please.

Ideally you would have your lawyer sign off on this patch, as they know
this type of law better than we do :)

thanks,

greg k-h
