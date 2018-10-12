Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA33FC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3FD2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3FD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbeJLXUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:20:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729079AbeJLXUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:20:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50D2EACEA;
        Fri, 12 Oct 2018 15:47:43 +0000 (UTC)
Message-ID: <1539358728.2802.3.camel@suse.com>
Subject: Re: usbnet private-data accessor functions
From:   Oliver Neukum <oneukum@suse.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, davem@davemloft.net,
        netdev@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@lists.codethink.co.uk,
        bjorn@mork.no, steve.glendinning@shawell.net,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Fri, 12 Oct 2018 17:38:48 +0200
In-Reply-To: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2018-10-12 at 10:16 +0100, Ben Dooks wrote:
> I have been looking at the usbnet drivers and the possibility of some
> code cleanups. One of the things I've found is that changing the way
> the drivers use the private data with the usbnet structure is often
> hand-coded each time is needed.

Where is the improvement? You are just hiding how the data is passed.
It may look more pleasant to you, but that is a subjective impression.
I would suggest that if you want a nicely named way to get at private
data, add a field to the appropriate data structure.

	Regards
		Oliver

