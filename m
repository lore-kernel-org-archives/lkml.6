Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2C8C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8CA214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547013934;
	bh=nSkW3iVbBKomjqszqSUntquVoWyZ1ff2xHtneWABQ6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XfJffFz3TRvoQur0lJsYrE0GR7E+j++GLfpfBWUSSmhWh2SInNDFDByCSDCOq7iV4
	 NDuAPLg5Anndyh8Phj95emuv0zQCekKGw0ZRA8Yix+Mvoq41VyXwbx1L3QDNTdUxmu
	 yRXe7GhPdTUMXWj/gOKXA7kISpoBqlRNgFEoraAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfAIGFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbfAIGFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:05:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060E120883;
        Wed,  9 Jan 2019 06:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547013932;
        bh=nSkW3iVbBKomjqszqSUntquVoWyZ1ff2xHtneWABQ6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+yDZqjy7+3gyGvn4p7bZGUFiwg3Nv3ZR4crzWgyRCu5eOdD9WbAC3xstzl3uJKSr
         6Q/2SFDr1SdFhiPQCsAwq7xplKzkiid0QcZHCv8wJJXpIzut908ZJphJ50scrfSuQz
         6MQ9oGj4Nyc7MzkaTdp1WHfkNDE3qtgqYWfRapNk=
Date:   Wed, 9 Jan 2019 07:05:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitrii Tcvetkov <demfloro@demfloro.ru>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190109060529.GA5961@kroah.com>
References: <20190107104437.308206189@linuxfoundation.org>
 <43Z2dr6ySKz7VMT@mx.demfloro.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43Z2dr6ySKz7VMT@mx.demfloro.ru>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 07:39:44PM +0000, Dmitrii Tcvetkov wrote:
> Hello, 
> 
> Don't have anything against listed patches, just curious: doesn't upstream commit 
> 574823bfab82d9d8fa47f422778043fbb4b4f50e 
> (Change mincore() to count "mapped" pages rather than "cached" pages) 
> need to be backported as a security fix for CVE-2019-5489[1] to stable kernels?
> 
> [1] https://www.openwall.com/lists/oss-security/2019/01/07/2

Please read the email thread for that patch on the linux kernel mailing
list as to why it is not to be applied at this point in time.

If you are worried about this issue, please weigh in on that thread.

thanks,

greg k-h
