Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C11C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4352083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4352083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeHaX42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:56:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaX41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:56:27 -0400
Received: from localhost (unknown [72.28.92.217])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 50FF7D1D;
        Fri, 31 Aug 2018 19:47:28 +0000 (UTC)
Date:   Fri, 31 Aug 2018 12:47:27 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nitin Gupta <nitin.gupta981@gmail.com>
Cc:     ldv-project@linuxtesting.org, devel@driverdev.osuosl.org,
        Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: SKylake Edac support in linux 2.6.32.696 kernel build
Message-ID: <20180831194727.GA8631@kroah.com>
References: <CAB3_1NuNyrBYx2M1iKOYb+rTRXW+p1gB-1VTaBymVBvRHvDSMA@mail.gmail.com>
 <20180831161450.GB26043@kroah.com>
 <CAB3_1Ns_Zg0FLn4Yo2kOMtZVQvh-mNeGUqGOe2Hi5HEXJqXQBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3_1Ns_Zg0FLn4Yo2kOMtZVQvh-mNeGUqGOe2Hi5HEXJqXQBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:22:06PM +0530, Nitin Gupta wrote:
> Hi Greg
> 
> Thanks for your comments  but somehow i cant use the latest kernel .

Why not?  What is not working properly for you?  It will be easier to
fix that than to work with a crazy half-backported mess that you will be
the sole person responsible for.

thanks,

greg k-h
