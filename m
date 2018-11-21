Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3291C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FE02148E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYzQBs0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FE02148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeKUQmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeKUQmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:42:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD89C2145D;
        Wed, 21 Nov 2018 06:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542780570;
        bh=f5TBPQfhMwVNMoe0+TDI3N5j0J2pHnXV0q3Ds9ZQRTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYzQBs0h74XnemKDTWRtdhV58ejTTxlZgmJcWOGZjC+nVnL475gZp7ZaBZ7zRCpMC
         Hl3BspC8V/ukJRwzKIfDhcAvKqOki8tl7pRDlrkmPlvw9me5WTa0Kiw54rl9tJsiEm
         T2Qe30uxxPYCSd2RWD+Q73tRarcEI5c/ra1uNQq8=
Date:   Wed, 21 Nov 2018 07:09:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        David Lin <dtwlin@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Parenthesis alignment
Message-ID: <20181121060927.GA27771@kroah.com>
References: <1542569289-19899-1-git-send-email-sicilia.cristian@gmail.com>
 <20181120094358.GA8089@kroah.com>
 <CACU=YuXesdrT2keMHe33fHRiq0PPKwcQMnp6fGCXgCTbz-kmQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACU=YuXesdrT2keMHe33fHRiq0PPKwcQMnp6fGCXgCTbz-kmQw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:42:05PM +0100, Cristian Sicilia wrote:
> Thanks for note
> 
> Can make sense do the patch for function that stay in the line but is not
> aligned, or is better doesn't change anything?
> Like this:
> 
>  static ssize_t gb_camera_debugfs_capabilities(struct gb_camera *gcam,
> -               char *buf, size_t len)
> +                                             char *buf, size_t len)

If you really want to, sure :)

greg k-h
