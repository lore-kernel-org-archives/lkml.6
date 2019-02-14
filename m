Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA07218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550159405;
	bh=Wv/BCpGIJVvO6rl6l5LWOImRuGPX/bnxZgWsmxG8Er0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FeauC//gvnWeS0JFR749abbB0nmrhbOvKkBIdWSfS3T+vCbYC9ZW69+SbDA4VGExv
	 2UV6PEW4DGrM1RnhkHzl/L0IYnYSTYYMh6dZx1eo/oIOKaizhMbkARlhrl+ioZAVI7
	 DszUjKxyYSuEcWwrBq+IjCzp5gV+/Hf/a/pmGmZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502276AbfBNPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395120AbfBNPuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:50:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4A8218FF;
        Thu, 14 Feb 2019 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550159402;
        bh=Wv/BCpGIJVvO6rl6l5LWOImRuGPX/bnxZgWsmxG8Er0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6xGFTovxFHPmkqzE7kjv8ZfjfoZzEXW1TUHUHKC+9efiMTspOTWJFbudLNvwNNAD
         oq5eHgeRRY+M96Xbumf6VS/CDP+TQgKgnd2ndaWYi9B9t0VyD4JqhE3X3y7sjUwrn8
         +6Nkt2Il7rMDePt6yNtuEPThn2JS3auoTYQYTBPw=
Date:   Thu, 14 Feb 2019 16:49:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Hesse <list@eworm.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Linux 4.20.8
Message-ID: <20190214154959.GC9910@kroah.com>
References: <20190212201812.GB11553@kroah.com>
 <20190214155335.6112f334@leda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214155335.6112f334@leda>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:53:35PM +0100, Christian Hesse wrote:
> Greg KH <gregkh@linuxfoundation.org> on Tue, 2019/02/12 21:18:
> > I'm announcing the release of the 4.20.8 kernel.
> 
> Versions 4.20.7 and 4.20.8 are missing signatures in git notes. Can you
> please add (or push) them? Thanks!

The tarballs would not have been created if the git note was not there.

So are you sure it isn't present?

Hm, odd, it doesn't look like it is, wow, I really messed this one up...

Ok, both notes now regenerated.  That's what I get for trying to do 4
releases at the same time :(

greg k-h
