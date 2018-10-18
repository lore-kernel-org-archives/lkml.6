Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEC4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521EE21477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5p35uWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521EE21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeJRNSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbeJRNSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:18:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61F1208E4;
        Thu, 18 Oct 2018 05:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539839976;
        bh=cEdlRidKNCm9lHhxjpTJhaeqpQO1CBb2sBEco2Tl+Yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5p35uWRRA8qRrUe5dNUoVzD0V5tUrOlILGlpltx37iDu7Z0ySqz+EaZ+3FIT991l
         rVPZYcGW8hA3OQjAWoVXkPf036X0ihguvt3ipahGYFSiM8ohgnO93cDpQx7D71npgk
         P+7FyudmXuZxF+qKz5MYA/xmhXgR9gOELZs4Fp4E=
Date:   Thu, 18 Oct 2018 07:19:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH 2/7] tty: Remove trailing whitespace
Message-ID: <20181018051933.GA26505@kroah.com>
References: <20181016232130.728-1-tobin@kernel.org>
 <20181016232130.728-3-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016232130.728-3-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:21:25AM +1100, Tobin C. Harding wrote:
> From: "Tobin C. Harding" <me@tobin.cc>
> 
> Currently files under drivers/tty/ contain trailing whitespace.  This is
> easy to fix and easy to review so lets do it now before we do other
> kernel-docs cleanups.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

This patch is an example of the from and signed-off-by line not
matching.  Seems like it happened on every-other-one.

Perhaps your git setup was wrong for when you committed the patches?

thanks,

greg k-h
