Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FDDC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2AB20652
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2AB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeI2HNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:13:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeI2HNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:13:08 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2AE5ADB8;
        Sat, 29 Sep 2018 00:46:51 +0000 (UTC)
Date:   Fri, 28 Sep 2018 17:46:49 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Marek Belisko <marek.belisko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'STAGING - FLARION FT1000
 DRIVERS'
Message-ID: <20180929004649.GA28840@kroah.com>
References: <20180928220423.31573-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928220423.31573-1-joe@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 03:04:23PM -0700, Joe Perches wrote:
> Please fix this defect appropriately.
> 
> linux-next MAINTAINERS section:
> 
> 	13899	STAGING - FLARION FT1000 DRIVERS
> 	13900	M:	Marek Belisko <marek.belisko@gmail.com>
> 	13901	S:	Odd Fixes
> -->	13902	F:	drivers/staging/ft1000/
> 
> Commit that introduced this:
> 
> commit a0138163cfbfdfbdc20e4477c77bd7046bd66bb4
>  Author: Joe Perches <joe@perches.com>
>  Date:   Tue Jul 5 15:21:34 2011 -0700
>  
>      MAINTAINERS: Add remaining staging entries
>      
>      Add the staging entries from various TODO files
>      to MAINTAINERS.  Add a few web links as well.
>      
>      Miscellaneous staging typo section header fix.
>      
>      Signed-off-by: Joe Perches <joe@perches.com>
>      Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>  
>   MAINTAINERS | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 68 insertions(+), 1 deletion(-)

So you are going to fix this, considering you created the problem?

This is an odd request to make of yourself in public, or was this a
script gone wrong?

confused,

greg k-h
