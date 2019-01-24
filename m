Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4359C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4A7218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="X2raicFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfAXQWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:22:05 -0500
Received: from cock.li ([185.100.85.212]:40002 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfAXQWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:22:05 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548346920; bh=6U6uNVlpd7CYoXF44MZ7NfZCzc0Yb5OeucO0RChR2zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X2raicFjmxgUC2fzZHU3lmI4IhTR+25iV9XBD+RlIsKANpUOHveKYIbryJ/VuXsG5
         WP/t6TLFZ4+Laf7cX+6AFOFJu4SpFBECWYwQiptdNwf6Vzdr0IKojF4eqB1G8vnQs1
         LTdnFzkma7phsAuB8pOAgFWBmU5fjJuAN5bVLekUGT6oUYwwlnwC9dkRu+p6k4b3R+
         OjRiuVwdo4fnsQf3HwiYvhrSFA0C4fwVUPrpvMsMCXdqRdbUAdB5UahYndGPV/CXNJ
         Rbm9NMNKEwKQ3yrrGvPEcUXgQUXws//U48SEtaOxrMZprf+U8skVsEmpShpWr9H3WI
         ptgIMYTrnNbGg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Jan 2019 16:22:00 +0000
From:   linuxgpletc@redchan.it
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Ivan Ivanov <qmastery16@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gentoo-user@lists.gentoo.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, rms@gnu.org
Subject: Re: GRSec is vital to Linux security
In-Reply-To: <3efc6268-747d-0841-4249-5804fa9095ca@metux.net>
References: <fe8a4e103943d671ff0ce2c4f09609f9@redchan.it>
 <CAAaskFDMjUzonLeHPmiy_VcB=jvQfF9giEaWcmNLKHDTqQt4BA@mail.gmail.com>
 <3efc6268-747d-0841-4249-5804fa9095ca@metux.net>
Message-ID: <a4ae3c98c10eeac39c404b60a0e4d538@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-24 15:31, Enrico Weigelt, metux IT consult wrote:
> Do you have some actual proposals / patches ?

Sue Open Source Security / Bradly Spengler for copyright infringement. 
Seek his profits as damages. I doubt you'll be able to get specific 
performance since the GPL is not a contact in this instance. (If you 
registered your copyright prior to the violation you can alternatively 
go for statutory damages + attoneys fees btw)

He is _blatantly_ violating your copyright by adding an additional 
restrictive term regarding the distribution of his non-separable 
derivative work of the linux kernel code.
