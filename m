Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD375C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE3420652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry09z9R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE3420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeICGgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICGgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:36:21 -0400
Received: from dragon (unknown [45.56.155.166])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 378E720652;
        Mon,  3 Sep 2018 02:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535941104;
        bh=pbjZzC2tS+sthbWo6zprvY3WsZMdV612n2jMfQL0FZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ry09z9R1o/YDZ8/FbC6TuiQP0jyi4siGF6LIodAyxFouQJr+LGLcZgvCG/drxlxN5
         +/OyFBrW8Kdg0k/DUBwE5teXmo2dp4zsEK/Z6FqUoVkTCsVdZNrPZzyjJ7c/dhdkpv
         T+fU5+BWEnhdBvB7yapgogmV8TjS+KH5CmBXi+1Q=
Date:   Mon, 3 Sep 2018 10:17:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: drop unnecessary DT node name NULL check
Message-ID: <20180903021715.GD3850@dragon>
References: <20180829200258.14463-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829200258.14463-1-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:02:58PM -0500, Rob Herring wrote:
> Checking the child node names is pointless as the DT node name can
> never be NULL, so remove it.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks.
