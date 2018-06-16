Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B422C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057682088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl+oKT/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057682088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeFPIET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 04:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754036AbeFPIEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 04:04:15 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 953812088E;
        Sat, 16 Jun 2018 08:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529136255;
        bh=NpJ9YO8IfJpxZcE96gmpUf4r//PdawalmC3IXkDqMeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cl+oKT/KmBdZhy/wpbGkr5xVQ1AevBln0tOAbWSlef+Cl0sbQ4hOlsA5h2Ttcamw5
         1XSJTgwp7VV8omzW2dCytoIP5eP3oJVddBqcmp4LJz2jw8/FSSPDSSKP635eap85bj
         U4/YvKMUBxJkXzZMa8LowJuBwvNiYUtvTORtZvLY=
Date:   Sat, 16 Jun 2018 10:03:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 6/7] vmw_balloon: update copyright message
Message-ID: <20180616080352.GA20457@kroah.com>
References: <20180613135412.81660-1-namit@vmware.com>
 <20180613135412.81660-7-namit@vmware.com>
 <20180614052413.GB29739@kroah.com>
 <F8F02A0A-133F-458A-9492-30C3ABD8C592@vmware.com>
 <81730.1529094918@turing-police.cc.vt.edu>
 <5151EA1B-D065-44D1-995C-47B791F574E1@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5151EA1B-D065-44D1-995C-47B791F574E1@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 08:38:57PM +0000, Nadav Amit wrote:
> at 1:35 PM, valdis.kletnieks@vt.edu wrote:
> 
> > On Thu, 14 Jun 2018 05:33:46 -0000, Nadav Amit said:
> > 
> >>>> In addition, updating the year and adding a license tag.
> > 
> >>>> +// SPDX-License-Identifier: GPL-2.0
> > 
> >>> You still have a lot of boiler-plate text in here that can be removed.
> >>> Please do so.
> > 
> >> But what else do you want me to remove? This is a standard GPL license. If I
> >> am required to remove the GPL license, I will have to run checks to ensure
> >> it is appropriate.
> > 
> > You mean the checks that you should have done when you stuck the SPDX
> > tag on the file?
> > 
> > (Hint: Think of the SPDX tag as a '#include gplv2.license.blurb" :)
> 
> I matched the SPDX to the license we have, tut I don’t know whether my
> company regards an SPDX tag as a sufficient means to protect copyrights,
> which allows to remove all the rest of the text.

Copyrights have nothing to do with SPDX lines, please don't get
copyrights and licenses confused, they are two totally different things.

Removing the license boilerplate and only using a SPDX line for the
license marking does not change the copyright of a file at all.  And if
you use the correct SPDX line, it will not change the license of the
file at all either.

If your company's lawyers have any questions about this, I am glad to
discuss this with them and point them at the lawyers that created the
SPDX group.

But really, your company lawyers already know all about this, you should
not have any problems at all.  If you are worried about this, please
contact your open source group and they will be glad to help out.  I
have names if you want me to send them to you off-list :)

thanks,

greg k-h
