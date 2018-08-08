Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22849C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14FC2154E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14FC2154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeHHHqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:46:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHHHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:46:42 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63C12BBF;
        Wed,  8 Aug 2018 05:28:48 +0000 (UTC)
Date:   Wed, 8 Aug 2018 07:28:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Schiffer <mschiffer@universe-factory.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>, Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 4.14 222/246] ext4: fix check to prevent initializing
 reserved inodes
Message-ID: <20180808052845.GB20034@kroah.com>
References: <20180801165011.700991984@linuxfoundation.org>
 <20180801165022.329322870@linuxfoundation.org>
 <0360c726-c139-345b-a478-82b33a7aa804@universe-factory.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0360c726-c139-345b-a478-82b33a7aa804@universe-factory.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:17:30AM +0200, Matthias Schiffer wrote:
> On 08/01/2018 06:52 PM, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> It seems this patch is still missing from the 4.4.y and 4.9.y branches.

Maybe because no one has provided a working backport?  :)
