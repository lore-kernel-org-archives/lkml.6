Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7D85DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299EE2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ancPOg1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299EE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbeFLGdd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932626AbeFLGd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:33:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE9920660;
        Tue, 12 Jun 2018 06:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528785208;
        bh=09/+Zxsce0uUxYOdblz1k8o4ZgwyqUghzzhaLsT7U30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ancPOg1Jv4Y2aixK63fIFLBAnX3og1+tAeDrGjWsW8tfvs0jDyiu31+/x6UMq47Kv
         bhIKlmoDRbN+sU/B+87ZkHCmXUyuR/fY6zopT0jmgH8+Ve2TM6PWyC9lWWZmOsp5s+
         2Nm5fkUb2Eqob/r2utNFXLL3k8slLLQF7LRvqpiI=
Date:   Tue, 12 Jun 2018 08:33:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipack: add error handling for ioremap_nocache
Message-ID: <20180612063306.GG23073@kroah.com>
References: <1528772844-36988-1-git-send-email-jiazhouyang09@gmail.com>
 <e33e47ca-a948-1678-fe68-8cd8e7f01287@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e33e47ca-a948-1678-fe68-8cd8e7f01287@igalia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 07:00:55AM +0200, Samuel Iglesias Gonsálvez wrote:
> Hello Markus,
> 
> Thanks for the patch!
> 
> Patch is,
> 
> Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> 
> Greg, Would you mind picking this patch series through your char-misc
> tree?

Will do after 4.18-rc1 is out, thanks.

greg k-h
