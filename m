Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0144DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECC4208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECC4208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeH0V5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:57:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbeH0V5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:57:05 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0A2AC96;
        Mon, 27 Aug 2018 18:09:26 +0000 (UTC)
Date:   Mon, 27 Aug 2018 19:55:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Anckaert <michael.anckaert@sinax.be>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: netlogic: Fixed comments to include
 SPDX-License-Identifier
Message-ID: <20180827175551.GA11842@kroah.com>
References: <20180811163643.GA9735@winston.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811163643.GA9735@winston.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 06:36:43PM +0200, Michael Anckaert wrote:
> This patch fixes some issues with missing SPDX-License-Identifier comments. 

Never add SPDX identifiers unless you REALLY know what you are doing.
It is VERY dangerous to add incorrect identifiers, which is what you did
here :(

Not good.

greg k-h
