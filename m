Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7344C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 08:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D83C2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 08:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="arnBya7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfAAIfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 03:35:06 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59919 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfAAIfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 03:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=bPaS1/GtyQ8TRFtTv4R+ubdDNqPQotaD+lM39K0zqqI=;
        b=arnBya7SdLTSv2H8UYHn/MrlJKU31qCRMPyFBh9Mk21a9YCVxvSjgu8lqW5iPtGVYpcu796jjPcIHMccAPA1z4/8NZzuGrqIm7nNyHRsivd283cXjdfZgY0bO5pZn79GNejKt1olJ+76LFQRrre4QSfOViRCwe7OaeHa2hXoyIU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1geFVi-0004eY-Vn; Tue, 01 Jan 2019 09:34:50 +0100
Date:   Tue, 1 Jan 2019 09:34:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Murali Krishna Policharla <murali.policharla@broadcom.com>
Cc:     davem@davemloft.net, amritha.nambiar@intel.com,
        ecree@solarflare.com, ktkhai@virtuozzo.com,
        alexander.h.duyck@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
Message-ID: <20190101083450.GA17613@lunn.ch>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 12:12:14PM +0530, Murali Krishna Policharla wrote:
> Store newly configured mtu settings in the netdevice after mtu
> configuration is successful to the dsa switch.

Hi Murali

Please could you give more details. net/dsa/slave.c does not have a
ndo_change_mtu function, so i don't know what you mean by the
reference to DSA.

	  Thanks
		Andrew
