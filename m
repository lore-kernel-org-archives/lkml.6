Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694DCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F65F2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwxvfArV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F65F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbeKGVe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbeKGVez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:34:55 -0500
Received: from localhost (unknown [104.153.224.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DBE2085B;
        Wed,  7 Nov 2018 12:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541592291;
        bh=tb7GngE8PU/78Ql5VjoSsgc+a6PQ1cdcVmu2cptw7NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwxvfArVHV++2CQ/4qW9BIO61MQdm9o+8d2GovFRLllYVow/WDMZg+np0EDaFv0mF
         kCPwps2E7fcRqMLU2XQq2aaGpWZLSNszkGnz7UNc5iY5yH1n0VwJR7dsGPB08xAp89
         o2wKnmWOZ4Y+kjH/vFsJuBEhSDI7b/a04vY0HTGU=
Date:   Wed, 7 Nov 2018 12:33:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?La=EDs?= Pessine do Carmo <laispc19@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: sm750fb: Add spaces around '+'
Message-ID: <20181107113304.GB31662@kroah.com>
References: <20181107002804.25345-1-laispc19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181107002804.25345-1-laispc19@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:28:04PM -0200, Laís Pessine do Carmo wrote:
> Add spaces around '+' to correct the following checkpath.pl warnings:
> 
> WARNING: line over 80 characters
> +                       write_dpPort(accel, *(unsigned int *)(pSrcbuf +
> (j * 4)));
> 
> WARNING: line over 80 characters
> +                       memcpy(ajRemain, pSrcbuf+ul4BytesPerScan,
> ulBytesRemain);

No need to line-wrap these warning lines next time.

thanks,

greg k-h
