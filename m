Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A259C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB03A21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549538839;
	bh=BZFClE1FZmNqJi6eVi+lYGKeWxDiKJ/CLagJLam3MSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VdQncx13A4MHOiZWjV2Bu0bRc3m1Ycuq0MBP3sD99ASm9ARfCtwpi9b39z9ifkuqh
	 pwp2zumd04KFtDO6/B7wjj5g+oj+YA6isKPjhL/PxxVwpI8hY2N97YLOb8EVT+Dyuc
	 EcYftP7yQH0TOhHjlJE6Z5nD2OZPwbsgPxO4Mxmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBGL1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:27:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfBGL1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:27:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715E221872;
        Thu,  7 Feb 2019 11:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549538836;
        bh=BZFClE1FZmNqJi6eVi+lYGKeWxDiKJ/CLagJLam3MSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFFkVElz1Z2oJB85Qogi28MvoWj3gIDxKn/kUdLJF/r+UyE8cW6/Z/Ov8Lwj34l/I
         356QJBC/V1vJKO5y1Z9id/eOisDcXj4Jiujqto7sR0/5UY3EX+f2he1fpuRyRRADGJ
         ZMpdOcsf3tFfgLa5bVOxJaQPQyMJrjkPBP9TtQkA=
Date:   Thu, 7 Feb 2019 12:27:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 4.4 "rcu: Force boolean subscript for expedited stall warnings"
Message-ID: <20190207112714.GB3120@kroah.com>
References: <25bfaa1ef3f24272b7351f409e69f2f6a05f11c8.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25bfaa1ef3f24272b7351f409e69f2f6a05f11c8.camel@nokia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:51:50AM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> Hi,
> 
> Can you pick this tiny one-liner patch to 4.4.y?
> Fixes unexpected null byte in RCU "expedited stall" message.
> 
> 
> commit ec3833ed02ae6ef2a933ece9de7cbab0c64c699e
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Mon Jan 11 16:29:29 2016 -0800
> 
>     rcu: Force boolean subscript for expedited stall warnings

Now queued up, thanks.

greg k-h
