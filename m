Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E70BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 00:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529FF21521
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 00:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529FF21521
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeFYAvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 20:51:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59540 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeFYAvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 20:51:50 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F1CBCBE;
        Mon, 25 Jun 2018 00:51:48 +0000 (UTC)
Date:   Mon, 25 Jun 2018 08:51:43 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] device: Add #define dev_fmt similar to #define pr_fmt
Message-ID: <20180625005142.GB23869@kroah.com>
References: <cover.1525878372.git.joe@perches.com>
 <3f213f4f9ee604c1797af67360d8da1836b34271.1525878372.git.joe@perches.com>
 <53ed025e7f188c931b99f83066457b2266e69cd6.camel@perches.com>
 <35e73723b9f982a400d5313df405972c09f9b374.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e73723b9f982a400d5313df405972c09f9b374.camel@perches.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 08:41:03AM -0700, Joe Perches wrote:
> On Tue, 2018-06-19 at 06:31 -0700, Joe Perches wrote:
> > Greg?  Ping?
> > 
> > The patches to impi have hit -next and the impi code
> > works differently without this patch.
> 
> Greg?
> 
> You are listed as the maintainer for this subsystem.
> Do you want me to  get this applied via someone else?

I am traveling in Asia right now, please give me a chance to catch up on
patches...

thanks,

greg k-h
