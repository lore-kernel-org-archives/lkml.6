Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ADE208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ADE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbeKNWCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:02:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:33012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728141AbeKNWCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:02:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FD61B01B;
        Wed, 14 Nov 2018 11:59:07 +0000 (UTC)
Message-ID: <1542196718.3385.2.camel@suse.com>
Subject: Re: SMSC95xx driver updates (round 1)
From:   Oliver Neukum <oneukum@suse.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@lists.codethink.co.uk,
        steve.glendinning@shawell.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Wed, 14 Nov 2018 12:58:38 +0100
In-Reply-To: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
References: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2018-11-14 at 11:50 +0000, Ben Dooks wrote:
> This is a series of a few driver cleanups and some fixups of the code
> for the SMSC95XX driver. There have been a few reviews, and the issues
> have been fixed so this should be ready for merging.
> 
> I will work on the tx-alignment and the other bits of usbnet changes
> and produce at least two more patch series for this later.

That looks good to me.

	Regards
		Oliver

