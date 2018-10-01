Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C18DC0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F053D205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F053D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbeJARjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:39:14 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:33032 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbeJARjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:39:14 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 3781F200796;
        Mon,  1 Oct 2018 10:55:54 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 7016720332; Mon,  1 Oct 2018 11:32:38 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:32:38 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Harald Welte <laforge@gnumonks.org>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: pcmcia: cm4000_cs: Replace mdelay with
 usleep_range in set_protocol
Message-ID: <20181001093238.GA7482@light.dominikbrodowski.net>
References: <1521384597-23195-1-git-send-email-baijiaju1990@gmail.com>
 <20180318151210.GB3523@nataraja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318151210.GB3523@nataraja>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 04:12:10PM +0100, Harald Welte wrote:
> Hi Jia-Ju Bai,
> 
> On Sun, Mar 18, 2018 at 10:49:57PM +0800, Jia-Ju Bai wrote:
> > This is found by a static analysis tool named DCNS written by myself.
> 
> nice catch!
> 
> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> 
> Acked-by: Harald Welte <laforge@gnumonks.org>

Applied to pcmcia-next.

Thanks,
	Dominik
