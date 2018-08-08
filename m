Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97353C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF6421719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF6421719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHHI5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:57:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeHHI5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:57:02 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51808BE6;
        Wed,  8 Aug 2018 06:38:48 +0000 (UTC)
Date:   Wed, 8 Aug 2018 08:38:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [GIT PULL] FSI fixes for 4.19
Message-ID: <20180808063844.GA22291@kroah.com>
References: <683a481141c6ee4b85e6128e62ea5131b74bbe3f.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683a481141c6ee4b85e6128e62ea5131b74bbe3f.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:50:53PM +1000, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> This adds two FSI fixes to what you already have in your tree
> 
>   - Fix a NULL dereference in the scom driver
> 
>   - Fix a command buffer size issue in the sbefifo driver that
>     breaks some operations with POWER system debugger (cronus)
> 
> Cheers,
> Ben.
> 
> The following changes since tag fsi-updates-2018-07-27:
> 
>   fsi: Prevent multiple concurrent rescans (2018-07-27 09:58:12 +1000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-08-08

PUlled and pushed out, thanks.
greg k-h
