Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8933121531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8933121531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeI1BkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:40:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbeI1BkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:40:01 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B1F31205;
        Thu, 27 Sep 2018 19:20:14 +0000 (UTC)
Date:   Thu, 27 Sep 2018 21:20:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kirill Kapranov <kirill.kapranov@compulab.co.il>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4.14 31/64] spi: fix IDR collision on systems with both
 fixed and dynamic SPI bus numbers
Message-ID: <20180927192012.GA12817@kroah.com>
References: <CADVatmMTY0NHJFUOeScJGv=Jb=gCQwgrbeTmW6vkedw8rj1ELw@mail.gmail.com>
 <5055ed3a-2f29-505d-ccb3-0e0a35d8fb73@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5055ed3a-2f29-505d-ccb3-0e0a35d8fb73@compulab.co.il>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:04:20PM +0300, Kirill Kapranov wrote:
> Hi Greg,
> 
> Sudip is absolutely right, the patch he mentioned,
>  04b2d03a7565 ("spi: Fix double IDR allocation with DT aliases"),
> MUST be added too with the mine.
> 
> Sudip, thank you for reminding.

Thanks, I'll go queue this up now.

greg k-h
