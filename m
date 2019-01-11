Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E2C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0EE20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547190594;
	bh=9dCRXPyshwFx+reFqqLD7R0sW/lvd5bDiJv7rzwl8jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A6DwasA6FJ75UkcQanFN1VEFAveuJyqnGsRIBqKB8tRHAjZzu3qVuM3SCnczsSQZ9
	 jgYvhP54McW7s1gSBNQbB7cxoM26qnptCJhj0LuyMD6ULr7o2Mkn23LHpLEPOXhiOl
	 ycXDg/wD/9vVReOstQxKeU4Wbi4q6DfxnHE+r0bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfAKHJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbfAKHJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:09:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 017B620870;
        Fri, 11 Jan 2019 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547190592;
        bh=9dCRXPyshwFx+reFqqLD7R0sW/lvd5bDiJv7rzwl8jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCbpf/Bt6SID3ky8KAsHIA2yBU0EoXgGCSfn9OR3WB2aVjx9PmJli48tnxC315krh
         E0SQAR/jyb+yf7833kgZD4lVLHCYFioGmVqqLRomzXa0KVu5oJ9im7YLhdVAUZczpQ
         H6O0uoC4JbvjzzHWFMieE+1dzmenu2kbuUsEU/9Q=
Date:   Fri, 11 Jan 2019 08:09:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     Breno Leitao <leitao@debian.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190111070950.GA3023@kroah.com>
References: <20190108230731.GC20519@roeck-us.net>
 <20190109143811.GB29274@kroah.com>
 <20190109194048.GA11505@roeck-us.net>
 <20190110065207.GA17195@kroah.com>
 <20190110131743.GE20217@kroah.com>
 <1547130295@msgid.manchmal.in-ulm.de>
 <1547133048@msgid.manchmal.in-ulm.de>
 <20190110154039.GA26814@roeck-us.net>
 <20190110182948.GB7748@kroah.com>
 <1547160861@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547160861@msgid.manchmal.in-ulm.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:55:45PM +0100, Christoph Biedl wrote:
> Greg Kroah-Hartman wrote...
> 
> > Ok, Breno and Christoph, what should I do here?  Should I drop this
> > patch in the tree or add this new one?  Ideally I can fix this soon as I
> > don't like having broken trees out there...
> 
> Whatever Breno says - I don't feel competent enough to decide what's
> right here.

Ok, I'm reverting it and adding back the patch that I accidentally
dropped thinking it was the broken one.

thanks,

greg k-h
