Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96584C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5601420835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5601420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeHaUXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:23:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbeHaUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:23:05 -0400
Received: from localhost (unknown [72.28.92.217])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11EDFC0C;
        Fri, 31 Aug 2018 16:14:52 +0000 (UTC)
Date:   Fri, 31 Aug 2018 09:14:50 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nitin Gupta <nitin.gupta981@gmail.com>
Cc:     ldv-project@linuxtesting.org, devel@driverdev.osuosl.org,
        Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: SKylake Edac support in linux 2.6.32.696 kernel build
Message-ID: <20180831161450.GB26043@kroah.com>
References: <CAB3_1NuNyrBYx2M1iKOYb+rTRXW+p1gB-1VTaBymVBvRHvDSMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3_1NuNyrBYx2M1iKOYb+rTRXW+p1gB-1VTaBymVBvRHvDSMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 04:46:41PM +0530, Nitin Gupta wrote:
> Hi All
> 
> I  started back porting  Skylake Edac driver from 4.8 kernel to 2.6.696
> kernel

Ick, why would you ever want to do that?  Just use a newer kernel
please.  If you really want to do this, you are on your own.

good luck!

greg k-h
