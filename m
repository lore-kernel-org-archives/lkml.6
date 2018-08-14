Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57352C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D432083C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D432083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeHNKEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:04:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbeHNKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:04:31 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF9C79D3;
        Tue, 14 Aug 2018 07:18:36 +0000 (UTC)
Date:   Tue, 14 Aug 2018 09:18:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, arjan@linux.intel.com,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
Message-ID: <20180814071834.GB24616@kroah.com>
References: <20180608095154.22413-1-feng.tang@intel.com>
 <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
 <20180612084234.gjzq66xsqblryrkm@shbuild888>
 <CAPDyKFq8WZhQQ9EBjfuVvu=YHB9AdwvMHwyKOY5Wxku1V5PtmA@mail.gmail.com>
 <20180802091539.m5k7cdoad6hfkdfy@shbuild888>
 <20180814063959.45bddz42ytz3e4jb@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814063959.45bddz42ytz3e4jb@shbuild888>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 02:39:59PM +0800, Feng Tang wrote:
> Hi Greg, Ulf
> 
> Could you help to review this? many thanks!

Review what?  I see no patch here.  And why would I need to review a mmc
patch in the middle of the merge window?

totally confused,

greg k-h
