Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F37C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EB220C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EB220C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeHTU3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:29:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeHTU3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:29:47 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1FB5B8A5;
        Mon, 20 Aug 2018 17:13:18 +0000 (UTC)
Date:   Mon, 20 Aug 2018 19:13:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jiafei.pan@nxp.com, zhiqiang.hou@nxp.com
Subject: Re: [PATCH] mtd: m25p80: consider max message size when use the
 spi_mem_xx() API
Message-ID: <20180820171314.GB18339@kroah.com>
References: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 05:43:26PM +0800, Chuanhua Han wrote:
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v2:
> 	- Place the adjusted transfer bytes code in spi_mem_adjust_op_size()
> 	and  check spi_max_message_size(mem->spi) value before subtracting 
> 	opcode, addr and dummy bytes.
> *fixes:
> 	spi: Extend the core to ease integration of SPI memory controllers
> ---
>  drivers/spi/spi-mem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
