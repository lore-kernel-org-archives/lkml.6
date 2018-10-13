Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EABC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A262D20835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy2P3MYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A262D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeJMQiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeJMQiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:38:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 501EA20835;
        Sat, 13 Oct 2018 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539421307;
        bh=v+mGCHm2nxfVC29xDeXhxFkbiXlZzCOaAmqW54JEQS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fy2P3MYJYbNLVQEVp/8VOaOIQdPTiVCYKuhjSWbDNRm1sjheWjKESUmS4jv5enKir
         SFivHw5OV3EWvX+eHEjTtCO9R2qu2l5apSk67gO8jAEGjXenB7mG4+ruDWqttrsmCk
         E9nlETbq6ZIBGEVAO+I3gdcxwY6jv+dK7e+1xTaA=
Date:   Sat, 13 Oct 2018 11:01:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 3.18.123
Message-ID: <20181013090145.GA14822@kroah.com>
References: <20181013085007.GA1293@kroah.com>
 <871s8uw7b0.fsf@turtle.gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s8uw7b0.fsf@turtle.gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 10:59:47AM +0200, Sven Joachim wrote:
> On 2018-10-13 10:50 +0200, Greg KH wrote:
> 
> > I'm announcing the release of the 3.18.124 kernel.
> 
> $Subject inadvertently says 3.18.123, something wrong with your scripts?

It's a manual thing, yeah, my fault, let me redo this...

