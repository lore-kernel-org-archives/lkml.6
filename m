Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4EFC65BD5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A92064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kxOUATVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72A92064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJOSOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:14:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WTD3xfRYv1ApDIxJhuY1AMGTI6RLdtW1XwqBXJBrQVk=; b=kxOUATVSfi8zbi4eCPyG3Hojy
        xIa8dXU7fnmqRCUqYgdi1bcOwYmuYdkL3vQmITCGP0cdfvKaMbhNX+WFm1tNE8L41/zMOIvzrxblU
        H6Zbi7Y22qWGnplni6NgkNgoULsPKTuCA3pB1IVfHL74VO8Olf2C4Qq9A4DhBbTZ49kDyQNHQAbYg
        B49YYtSP2AdPYqPNgy9GTDuQwDoBNPv96YI8P8uWO0aJRiR1ztL9tgu5CZeAlCgZsWQU0dJgyBHBm
        7oI66XYUU3KZAtlXDrPy1yVRgAxcrE4dHHsPjJyKUdBi6BWDxO9aHT4hDLW6dqhNpmkgRauVDyBWM
        zR7LIF+3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gC08D-0004ST-Qp; Mon, 15 Oct 2018 10:29:49 +0000
Date:   Mon, 15 Oct 2018 03:29:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 00/11] staging: gasket: fixes
Message-ID: <20181015102949.GA11341@infradead.org>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 09:59:16PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Various fixes for gasket/apex drivers.

I still can't find any explanation in the staging tree or in your
comments what gasket even is.
