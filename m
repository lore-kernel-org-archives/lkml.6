Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66657C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6952183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550637666;
	bh=/Yyd7I0Wg4mOw7vS1iKD+S5/pwF8pLp84IOc7Vlgtfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H1+i9soYI2IxCIMsV05Xp7DzAJ2V5dDwAOa/fILA7fvY4HysXapmokb7e5PKJB4Q5
	 P8WscFNvdec4J+Pn7RJJgZdOvXIVRNRLjX/105m7XyZ2D7k41OzHp5DXLKT7559kW+
	 M1u/q/O60LpdDcVTPqewcfYGUMUV/ivMAMYcbb4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfBTElF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfBTElE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:41:04 -0500
Received: from localhost (unknown [106.200.226.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4552521773;
        Wed, 20 Feb 2019 04:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550637664;
        bh=/Yyd7I0Wg4mOw7vS1iKD+S5/pwF8pLp84IOc7Vlgtfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x14noWMfqL94/5s40S/jDQIx0ve2ycQ7d7AmfQ+ntc7vjkwdASsedG9OO/+NmRAES
         9AhGQZcJzHCQhzqSnM87VvtLTVr6moUMsxPZlndNj/UIi23uwZVxxRhGE61mkGS6B5
         AaN53C709dvGrbzVTKErm2ZZDiGjAMxtbkHAH7MI=
Date:   Wed, 20 Feb 2019 10:10:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190220044055.GD21884@vkoul-mobl>
References: <20190220093136.73779781@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220093136.73779781@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-19, 09:31, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   a968b5e9d587 ("net: dsa: qca8k: Enable delay for RGMII_ID mode")
> 
> Fixes tag
> 
>   Fixes: 40269aa9f40a ("net: dsa: qca8k: disable delay for RGMII mode")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean:
> 
>   Fixes: 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode")

Yes looks like I messed up the commit id.. Not sure why :(

Dave would you like to drop this and me sending updated patch or
something else..

Sorry about the miss

-- 
~Vinod
