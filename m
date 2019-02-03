Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8891BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5983D2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549195837;
	bh=tidcR5MKzQQHvz4ezqehlh2N3Ttzwk+I7r50Ksstnjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rxu7PQ5Mq01PAamH0C2uKVzJ8Cj1JQqT8HDnkCJKJ3K8PztarYxwj7+SF6yQ5x4S5
	 r0dnT5GDSeqNGcgoKCpLLEk68H4z/3EZ4PUDVuttWKe8GnliDlrIcLfM/nlm1lPbJ4
	 G1+fzKrf/4GT7mT6iyHrO59dOU38d6I7VVPWpVzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfBCMKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:10:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfBCMKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:10:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F78B2083B;
        Sun,  3 Feb 2019 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549195814;
        bh=tidcR5MKzQQHvz4ezqehlh2N3Ttzwk+I7r50Ksstnjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y5lRzd87K1wtMWdrn8kqtBsVVP2xj4JDv/BxAlgDNQ9IuFxPTHxm/mCO3/RmCrvyz
         OU0BG+hH9ZxxNrbqYYfvQkO7Sw+bG6zhoJ9dHl3LQUMVneMSHS3FXi6pTjydFQ9CUr
         8XwYJ+tkfEhhbNm4AJbaXw2KxGhg6p4ep/eh0Es0=
Date:   Sun, 3 Feb 2019 13:10:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: allow to select i.MX nvmem driver for i.MX 7D
Message-ID: <20190203121012.GA12301@kroah.com>
References: <20190203094337.5063-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203094337.5063-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 09:43:37AM +0000, Srinivas Kandagatla wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> The imx-ocotp nvmem driver supports the i.MX 7D SoC too. Allow to select
> the imx-ocotp driver even if only the i.MX 7D SoC has been selected.
> 
> Fixes: 711d45477931 ("nvmem: octop: Add i.MX7D support")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Hi Greg, 
> If its not too late, can you take this patch for 5.1.

Not too late at all, now queued up.

greg k-h
