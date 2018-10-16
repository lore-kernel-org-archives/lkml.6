Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E16C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A2C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXttTodX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A2C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJPTXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbeJPTXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:23:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD7FA20881;
        Tue, 16 Oct 2018 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539689632;
        bh=4kW0fV/Z9bZztiPRYHUqhquBit67WAuh+T1LzOIVHHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXttTodXejWMfrLS9rMzs8xwo1qRSDrXOU72hsGQAKBnzGCC2guOswEOYXSKjCUQ5
         +kVMUPdgij1JbBmfe1N00DZ3AsxFQ471xbxhbbgtEx+VBCCiCbtFsWWdLvXYeMzHiz
         Q9YD3Eq7GG7KgFT4IBd83ff6dtzzsYnBBILgkhuk=
Date:   Tue, 16 Oct 2018 13:33:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v6 0/4] devres: provide and use
 devm_kstrdup_const()
Message-ID: <20181016113349.GA21084@kroah.com>
References: <20181014152010.2021-1-brgl@bgdev.pl>
 <CAMRc=MeMXKO_GWdVeH7yaa1qEyZBV-bsXhYzjC7LnU5UmHayNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeMXKO_GWdVeH7yaa1qEyZBV-bsXhYzjC7LnU5UmHayNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 05:21:16PM +0200, Bartosz Golaszewski wrote:
> niedz., 14 paź 2018 o 17:20 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> >
> > Hi Greg,
> >
> > this has been reviewed a lot and three first patches can be picked
> > up. Please take it through your tree.
> >
> 
> Except for patch 4/4 of course - it needs Thierry's Ack, but that can
> wait until the first three are merged.

first 3 are merged now.

greg k-h
