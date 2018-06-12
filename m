Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B50EDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69475208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN1ukVyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69475208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeFLIDV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933315AbeFLIDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:03:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C44208AE;
        Tue, 12 Jun 2018 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528790598;
        bh=Kok2t1LiWypHhTbaYMkD04ZBkpcBBLi9amdzMXgnSe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BN1ukVyMT5iJjsp9vMxWOQ8CZSpgDK7OY8OnpZAAe39MmHReEZqrUYYDOXMdY0D6o
         RS/e81hb1U0elKOsaYZWlPZ7sE5SIhp52U5ram4/vCszWYMuuflOq55HbMYq9Co6oK
         5qfNvgc/c9z9gkbyql26Tga11NwP3ki6brT7ozO0=
Date:   Tue, 12 Jun 2018 10:02:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Message-ID: <20180612080256.GA17399@kroah.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180605152524.GA23280@kroah.com>
 <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
 <MWHPR02MB2816ACB30A1142BD1B83F25CA77F0@MWHPR02MB2816.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR02MB2816ACB30A1142BD1B83F25CA77F0@MWHPR02MB2816.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 07:03:39AM +0000, Anurag Kumar Vulisha wrote:
> Hi Greg,
> 
> Please let me know if you have any comments on this patch. 

It is the middle of the merge window, I can not do anything with any
patches until after 4.18-rc1 is out.

Please be patient.

thanks,

greg k-h
