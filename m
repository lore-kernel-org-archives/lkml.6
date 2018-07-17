Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ADDECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9D920864
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9D920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeGQHLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:11:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeGQHLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:11:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB1E6CF7;
        Tue, 17 Jul 2018 06:40:46 +0000 (UTC)
Date:   Tue, 17 Jul 2018 08:40:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pengbo Mu <pengbo.mu@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, "yinbo.zhu" <yinbo.zhu@nxp.com>
Subject: Re: [PATCH] usb: phy: fix phy-fsl-usb.c's copyright issue
Message-ID: <20180717064043.GB1789@kroah.com>
References: <1531808756-989-1-git-send-email-pengbo.mu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531808756-989-1-git-send-email-pengbo.mu@nxp.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:25:56PM +0800, Pengbo Mu wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

Also, you need to sign off on it, _and_ we need a valid name here for
the author and sign-off.

thanks,

greg k-h
