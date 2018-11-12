Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894E52175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894E52175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sw-optimization.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeKLRwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:52:04 -0500
Received: from mx18lb.world4you.com ([81.19.149.128]:58504 "EHLO
        mx18lb.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeKLRwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:52:04 -0500
Received: from [81.19.149.40] (helo=webmail.world4you.com)
        by mx18lb.world4you.com with esmtpa (Exim 4.91)
        (envelope-from <eas@sw-optimization.com>)
        id 1gM78Y-0003WL-Ou; Mon, 12 Nov 2018 08:59:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Nov 2018 08:59:58 +0100
From:   Eric Schwarz <eas@sw-optimization.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH 0/4] patches for FPGA
In-Reply-To: <1541613108-29660-1-git-send-email-atull@kernel.org>
References: <1541613108-29660-1-git-send-email-atull@kernel.org>
Message-ID: <3c40d1758b4ad0a71f826c5423ea4eeb@sw-optimization.com>
X-Sender: eas@sw-optimization.com
User-Agent: World4You Webmail
X-SA-Do-Not-Run: Yes
X-AV-Do-Run: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

Am 07.11.2018 18:51, schrieb Alan Tull:

> Hi Greg,
> 
> Please take these four small fpga fixes patches.  They
> have been reviewed on the mailing list and apply
> cleanly on current linux-next and char-misc-testing.
> 
> Thanks,
> Alan
> 
> Anatolij Gustschin (1):
> fpga: altera-cvp: fix 'bad IO access' on x86_64
> 
> Andreas Puhm (1):
> fpga: altera-cvp: Fix registration for CvP incapable devices
> 
> Mike Looijmans (1):
> zynq-fpga: Only route PR via PCAP when required
> 
> YueHaibing (1):
> fpga: dfl: fme: remove set but not used variable 'priv'
> 
> drivers/fpga/altera-cvp.c | 15 +++++++++++++--
> drivers/fpga/dfl-fme-pr.c |  2 --
> drivers/fpga/zynq-fpga.c  |  4 ++++
> 3 files changed, 17 insertions(+), 4 deletions(-)

How is the backporting strategy for FPGA manager related bugfixes and 
drivers?

Best regards
Eric
