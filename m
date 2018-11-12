Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B098F223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp8RFHXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B098F223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeKMFko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:40:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17632223B0;
        Mon, 12 Nov 2018 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542051963;
        bh=4gS6tFRFtIH3h/jpMafBKUFC9wfciwslQbKsRaZT+9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hp8RFHXrb43Y2D2vSp1BgkW4y2N0fZXAJE0V7M3gr4d4r6h5wnNH4yTYYg3laaK0x
         tOKtGjS04js4P/+6PluenFHbtnZnfeE4BlGeh4IxIO0etMUdIsVz/H6n9iLzQVn6W2
         l9GeiyU3SiulI+2TMXBmIuTB8OxReQl4BWW9QyHM=
Date:   Mon, 12 Nov 2018 11:46:02 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RESEND 0/2] fpga fixes for 4.20
Message-ID: <20181112194602.GA3329@kroah.com>
References: <1542051514-5205-1-git-send-email-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542051514-5205-1-git-send-email-atull@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 01:38:32PM -0600, Alan Tull wrote:
> Hi Greg,
> 
> Here's a reposting of the two small fixes for fpga, please
> take them in.  They've been reviewed on the mailing list
> and apply cleanly on today's char-misc-test.

This isn't a bugfix, they should just go into my "next" branch to be
merged for the next -rc1 release, right?  I thought that is what I said
last time...

thanks,

greg k-h
