Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A38C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD5320658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD5320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIEPv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:51:56 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:42612 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeIEPv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:51:56 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 1EDBB5C0753; Wed,  5 Sep 2018 11:20:11 +0000 (UTC)
Date:   Wed, 5 Sep 2018 11:20:11 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: u300: add missing check for kmalloc
Message-ID: <20180905112011.GB11536@osadl.at>
References: <1535106534-983-1-git-send-email-hofrat@osadl.org>
 <CACRpkdYdGeuFt7c+VJ=4bP+Ekgeq4_srRXD_+eQdkJcgBF6XmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYdGeuFt7c+VJ=4bP+Ekgeq4_srRXD_+eQdkJcgBF6XmQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:09:21AM +0200, Linus Walleij wrote:
> On Fri, Aug 24, 2018 at 12:33 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> 
> >  kmalloc return for bigrxbuf_virtual was not being checked - in case
> > of failure set status, cleanup bigtxbuf_virtual and baile out.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: c7c8c78fdf6e ("ARM: 5667/3: U300 SSP/SPI board setup and test")
> 
> I will delete this testchip instead. It is not in use.
>
well that will for sure eliminate this bug reliably ;)

thx!
hofrat 
