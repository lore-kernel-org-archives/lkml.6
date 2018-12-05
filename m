Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C4BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C2B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc4QTkY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C2B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeLEK6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeLEK6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:58:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318A020672;
        Wed,  5 Dec 2018 10:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544007514;
        bh=roLF+T4P29OISalOJhu5LUTS1jfyxnFbdcdzPy5Tj8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc4QTkY384wbWMRG7dLcmmIW4DrB0jXKeFgRK6H5ZDVj5XhSnUubqH78iLy2D5YNc
         RJnF0bAgkojKosuxnFuw/HNUZYGxmtG/rMPdOjp8iyCARoY5p4WZZP6XSqE5eJJs+x
         kRi2tbv+u1iTpcW3K9jYHWTukm7c8sdzO7s/8C8g=
Date:   Wed, 5 Dec 2018 11:58:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: fix kerneldoc header for struct binder_buffer
Message-ID: <20181205105832.GC16376@kroah.com>
References: <20181203202457.228972-1-tkjos@google.com>
 <20181203202457.228972-2-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203202457.228972-2-tkjos@google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:24:55PM -0800, Todd Kjos wrote:
> Fix the incomplete kerneldoc header for struct binder_buffer.
> 
> Change-Id: If3ca10cf6d90f605a0c078e4cdce28f02a475877

No need for this here :)

