Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28DAC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D75E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D75E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeGIJTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:19:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754077AbeGIJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:19:01 -0400
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 362F8D35;
        Mon,  9 Jul 2018 09:19:00 +0000 (UTC)
Date:   Mon, 9 Jul 2018 11:18:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaya Durga <rjdurga@gmail.com>
Cc:     devel@driverdev.osuosl.org, jonathankim@gctsemi.com,
        linux-kernel@vger.kernel.org, deanahn@gctsemi.com,
        root <root@boss.chennai.cdac.in>, quytelda@tamalin.org
Subject: Re: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
Message-ID: <20180709091857.GA4636@kroah.com>
References: <20180709084406.6129-1-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709084406.6129-1-rjdurga@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:14:06PM +0530, Jaya Durga wrote:
> From: root <root@boss.chennai.cdac.in>

That's an odd author name :)

> 
> CHECK: Macro argument reuse 'gdm' - possible side-effects?
> 
> convert GDM_TTY_READY to gdm_tty_ready static function
> to fix checkpath check
> 
> Signed-off-by: Jaya Durga <rjdurga@gmail.com>

It doesn't match this one either :(

Please fix...

greg k-h
