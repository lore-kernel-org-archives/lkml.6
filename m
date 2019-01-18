Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AA7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C903E2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547805368;
	bh=sRlCbnQFNBRReK1M6md8KBfMLmWTVUudICvMIGNRAP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AbaLj8ZdX8IJW5/lEhfDHYrPbO/mnUqA6QahyQrfeFCOX1m9Yq7tQ5Mbt3S2CtVUV
	 gjYMadzVnZB50fOhv6uWXBLd5MY84/mvsdee4W6a39BMfA3x9wBpFaK+Zii6KXaUEO
	 b+OxgYL0JeRhffouO5bdFkxr8yF1K6aDk/H5KMEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfARJ4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfARJ4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:56:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A1A2086D;
        Fri, 18 Jan 2019 09:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547805366;
        bh=sRlCbnQFNBRReK1M6md8KBfMLmWTVUudICvMIGNRAP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaViWgCNOnE2m7/u5A2gik5bGey5zzUy0JXS6/InJcbaFUcE7zkSh+z0FOpfFbolR
         uzuq8S+bhNNKVmQF4EZKE6QJwCPdS5teE+qpj80HD10k6flmq1KtVUQL/9BiyVcSxS
         iGg+D/RoxC6/ooetTkPHk1/rHe+xQEdpkSZzpfm8=
Date:   Fri, 18 Jan 2019 10:56:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] Misc ION cleanups and adding unmapped heap
Message-ID: <20190118095604.GA28982@kroah.com>
References: <20190111180523.27862-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:05:09PM -0600, Andrew F. Davis wrote:
> Hello all,
> 
> This is a set of (hopefully) non-controversial cleanups for the ION
> framework and current set of heaps. These were found as I start to
> familiarize myself with the framework to help in whatever way I
> can in getting all this up to the standards needed for de-staging.

I've applied the first 10 of these to the tree, thanks.

greg k-h
