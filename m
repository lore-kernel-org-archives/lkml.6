Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390BB21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfvkZCJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390BB21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJQArx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbeJQArx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:47:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A96205C9;
        Tue, 16 Oct 2018 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539708995;
        bh=bpIiuMoHABd1NvhcN0Sb55imnmjbULaq35fiLx8YC/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfvkZCJf2WnI61NpBEsxSBq1iX58IdZrcLd8C5enri7DdZcJf5QnRfgwYqncP6ueV
         mW2iml9IZqKEiXSoMl2LKZeHbGLKdITkUarGRMD6/URHegvgSDGpI/NIS3IsaSOmSt
         WNkRGxiNSnmEp7KjXlYO7b5zywwrGyTTS3YCLe/k=
Date:   Tue, 16 Oct 2018 18:56:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [GIT PULL] IDA/IDR fixes for 4.19
Message-ID: <20181016165632.GF9547@kroah.com>
References: <20181015204017.GA10953@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015204017.GA10953@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 01:40:17PM -0700, Matthew Wilcox wrote:
> 
> Hi Greg,
> 
> I have two tiny fixes, one for the IDA test-suite and one for the IDR
> documentation license.
> 
> The following changes since commit f0a7d1883d9f78ae7bf15fc258bf9a2b20f35b76:
> 
>   afs: Fix clearance of reply (2018-10-15 15:31:47 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/willy/linux-dax.git ida-fixes-4.19-rc8

How about you at least test these in linux-next?  Putting things on top
of the most recent change is a huge tip-off that this branch got no
testing :(

greg k-h
