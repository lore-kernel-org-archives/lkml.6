Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAECC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB45216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbkqWefS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB45216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeKLT7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbeKLT7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:59:09 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3439B2087A;
        Mon, 12 Nov 2018 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542017198;
        bh=j+2eqOVpAHbjXzpSWUaXNty5gUpFdCDhO26JSoCxMcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbkqWefSSWhNF775BkQYdz5Q5T32IqtB+1YsuNXVsOb/zsrkPuJ9/2X3t/PW6le7k
         1RSYqyEKJBwhtvWKu61CRL2qUqpZ+47mfAyyJ9FBGUv3msCs21u31xBURuTXmwYL94
         kiuHlraGOS/JU6E9yd+mdKh1VgpN1GH3EdQyBViM=
Date:   Mon, 12 Nov 2018 15:36:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] soundwire: intel: constify snd_soc_dai_ops structures
Message-ID: <20181112100629.GC2477@vkoul-mobl>
References: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540647284-26728-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540647284-26728-2-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-10-18, 15:34, Julia Lawall wrote:
> The snd_soc_dai_ops structures are only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
> const as well.

Applied, thanks

-- 
~Vinod
