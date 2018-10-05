Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CBC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65769213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65769213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeJFGbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:31:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeJFGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:31:52 -0400
Received: from localhost (unknown [104.153.224.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7D0116727;
        Fri,  5 Oct 2018 23:30:54 +0000 (UTC)
Date:   Fri, 5 Oct 2018 16:30:37 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] GPIO fix for v4.19
Message-ID: <20181005233037.GC25152@kroah.com>
References: <CACRpkdaVEmTDBFgf-fdw9uXJYyQ5DC_uL+agTB1zFVia1hzhuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaVEmTDBFgf-fdw9uXJYyQ5DC_uL+agTB1zFVia1hzhuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:05:59PM +0200, Linus Walleij wrote:
> Hi Greg,
> 
> here is a single and hopefully final GPIO fix for the v4.19 series.
> Details in the signed tag.
> 
> Please pull it in!

Now merged, thanks.

greg k-h
