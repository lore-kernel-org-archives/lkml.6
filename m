Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F288C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDA321773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547115393;
	bh=UUN0BFWrYDrWtsvQF8JHK7lJnWRXlz59CtISKc+9Jvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TU1SAaFRxX1MsENI8bdRwdVDA0AdcJ3FJehp2GSH9CfwZPma1a9YnLTHYrK5cK3gA
	 lf2qbuvXa3MtRZ9mtqRYlXL8dH3jKabv1Y8WHMrJIsXkyTWqJocuiwocGeTkHxsKd+
	 YuL8Cf9HABs8NhtTBHKDoXqDMCiB4lcP0QckM8aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfAJKQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:16:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbfAJKQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:16:31 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D08A214DA;
        Thu, 10 Jan 2019 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547115391;
        bh=UUN0BFWrYDrWtsvQF8JHK7lJnWRXlz59CtISKc+9Jvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dcM2Y+wXfxKFrbGpMBajdxu5R8cQeD4fHEj4xIjepooipOyvBwoZb7xtTJHLDLTZw
         YdJICy/pWyVo+jRrQUDCFsztjxbykab1bCub+LuYtAGnu2r9MbfbpZqo2jng8QlI04
         c0Cg50E2NO/qXlmReetVjzJLrEdnD5ls3I/aXMMg=
Date:   Thu, 10 Jan 2019 11:16:18 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI
 controller driver
Message-ID: <20190110111601.1dad05a0@bbrezillon>
In-Reply-To: <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
        <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
        <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 21:47:48 +0300
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> On 01/08/2019 07:16 AM, Mason Yang wrote:
> 
> > Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>  
> 
>    You now need to add:
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

May I ask why?
