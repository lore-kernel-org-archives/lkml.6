Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7941AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A242184C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545209280;
	bh=fDSlzQJaubGqEoTWbrQil7H0//PV0rDf8cMUpQR2lMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FhNp7FvbMpQ7hxl5gZkj5mQJAvyfOy4h4uuXVFvQdNJE+32n7mH7Du0+/m9bWQRvi
	 2iWKT5WpQb6stWBTjgKD4s4Q7GqfX+hH3kDVhVVnL+NqoX9niWIvbWiOP3kjCkYkxJ
	 TWqYpkG/UXUmopRg+UyKW4lP5W+EFH6yi1UOE770=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeLSIr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLSIr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:47:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E80EC2133F;
        Wed, 19 Dec 2018 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545209278;
        bh=fDSlzQJaubGqEoTWbrQil7H0//PV0rDf8cMUpQR2lMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDwvzT/IwlD/V8OH70S4TzrsubYickraokKXgyaSjmvxpvQbSdfvf2hsBMTkIVQcM
         MoAMrN5pXDBTlzGBLWVQUZi5DgqIfzaL63qCoHitgBa9hjHQeAKXJlRrnYZfrkQZhB
         XiJWJb4sCurY2Mv9sZz2Ooa5YCv+cUnMMjYAfnsw=
Date:   Wed, 19 Dec 2018 09:47:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kilobyte@angband.pl, darrick.wong@oracle.com,
        chouryzhou@tencent.com, david@fromorbit.com, arve@android.com,
        joel@joelfernandes.org, Martijn Coenen <maco@android.com>,
        dan.carpenter@oracle.com, tkjos@google.com
Subject: Re: [PATCH v3] binder: implement binderfs
Message-ID: <20181219084756.GA26777@kroah.com>
References: <20181214121114.8785-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214121114.8785-1-christian@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 01:11:14PM +0100, Christian Brauner wrote:
> As discussed at Linux Plumbers Conference 2018 in Vancouver [1] this is the
> implementation of binderfs.

<snip>

Looks good to me, thanks so much for doing this, now queued up!

greg k-h
