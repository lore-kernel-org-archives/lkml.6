Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7EAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DA921906
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZfutT256"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DA921906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeF2HIi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:08:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbeF2HIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1AhVz3NWTTH4SlYJS27ydvoKbvYaCPDuc6nih+TwmHc=; b=ZfutT256vpFi+g/yorj6A4nha
        7KNPApqN6owifYncanV/3ydmVkECn1OKZQifNW7sTyrDDS5eZD2do5fBdxQ3EdwW9TSNfqX1eomLm
        focdiK6XVhBN8TJirNmyJdg6/Qsj4X5HvfCf/G154e6Fl2Tk2aUVM9qfvZv+QRGMb1Yx1UV4jmvz3
        Txk8UvnvVvmwmRh3Ol0lBFCKRv5MfJE8b04062zrRfiknn74VW2fJSxf09ngx42Ai0vEO7kW6Pzj1
        ZvHc05aiWYiVoOlQSdpdkn2gx1nBodIRSmAfYlYOeK9GJPcw/p4xlkXX9E9aLpVw3UkU1rjm3agwM
        sRljtxRNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYnWC-0003QO-RS; Fri, 29 Jun 2018 07:08:32 +0000
Date:   Fri, 29 Jun 2018 00:08:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong@andestech.com>
Cc:     palmer@sifive.com, hch@infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zongbox@gmail.com, greentime@andestech.com
Subject: Re: [PATCH v2 1/4] RISC-V: Add conditional macro for zone of DMA32
Message-ID: <20180629070832.GA12956@infradead.org>
References: <cover.1529915117.git.zong@andestech.com>
 <3d8fcfce1e99fe1f07c11b535319164ee2511c02.1529915117.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8fcfce1e99fe1f07c11b535319164ee2511c02.1529915117.git.zong@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:49:37PM +0800, Zong Li wrote:
> The DMA32 is for 64-bit usage.
> 
> Signed-off-by: Zong Li <zong@andestech.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
