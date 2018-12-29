Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8825CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA7F2145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jfl/MDRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeL2SdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:33:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeL2SdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JxQRG8Zo29ppJdE9Tan2PVoOVDdpEGD7g60FdqOiVQw=; b=jfl/MDRTM3pQl25aesD8OUzdS
        OfBu5REdM1InjhzCV6lWBy4wAOPm9+rbOg01EjzrrJaFm1NZaNIqjGomXbpNl1pdJd9Mn7ZIK9pRC
        Ps/qw38tO0VEXp/H2r2zfEn1fvL8zJOGFPP1IIVE28Zk8cgYMHWOC9u5zhqYw1FfHmQARW20CyIdu
        qf8gP1lEAmuA/3J0bzYmXlaQM3EmGrhrdAy+7R6DDbvfKYASBFJuonsY8QfhkPEYl1bexN49tWMq7
        kTx74/9dXqVE/TAYHaASatgxR3DEgPyeWaew49hB9zWqhmHiNnE3pETqUF0UsYLLIQN6SI7t9nDon
        BkUgTzOnQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gdJPv-0000Gv-TO; Sat, 29 Dec 2018 18:32:59 +0000
Date:   Sat, 29 Dec 2018 10:32:59 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: net: fix bad references to network drivers
Message-ID: <20181229183259.GB6310@bombadil.infradead.org>
References: <20181229180518.GA8680@personal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229180518.GA8680@personal>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 07:05:18PM +0100, Otto Sabart wrote:
> Fix "reference to nonexisting document" warnings.
> 
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>

Fixes: b255e500c8dc ("net: documentation: build a directory structure for drivers")

