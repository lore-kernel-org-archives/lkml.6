Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCCEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1DB20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551288725;
	bh=vzw0nurzRaTwhOn0DJdCTcULvBeuLVhGnI7UblXfuf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bduqxWmKr0bhgeULErQCfdrpdWglnhcrHA1WTdryHzQkNKZWQjRZQ2HPjb2wTVGWm
	 udAprQPTEEn+VoezJbPEekqAYEbOiEta7GRC5USZJhSlUZa5sD0yjJpBiOeGvyhTin
	 tx3iRfpzye54cVf/tgBXRmpHHvHfZKMyhiq3uxw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfB0RcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbfB0RcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:32:01 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC9E720C01;
        Wed, 27 Feb 2019 17:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551288721;
        bh=vzw0nurzRaTwhOn0DJdCTcULvBeuLVhGnI7UblXfuf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZAyoMoftXoh8/sD7Svs0vmili4FM40e5TXnOPxz8gvVpgZ86zJgVVwrmv4GTcwvE
         Efxh6jSXhJhyYNZsYR8NNsb5hcWSBqGmchsiSP6OHO919udNhLJIV4rYW5RE0dY0SH
         hGHT8QEX4ZFXL49uy0kb0te3CQpEjTvz7Dfgjf+8=
Date:   Wed, 27 Feb 2019 12:31:59 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [PATCH AUTOSEL 4.20 10/77] ASoC: soc-core: Hold client_mutex
 around soc_init_dai_link()
Message-ID: <20190227173159.GI10616@sasha-vm>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-10-sashal@kernel.org>
 <20190215115756.GC7897@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190215115756.GC7897@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:57:56AM +0000, Mark Brown wrote:
>On Thu, Feb 14, 2019 at 09:07:48PM -0500, Sasha Levin wrote:
>
>> Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
>> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
>I just suggested not backporting the above fix for which this is an
>incremental fix.

Dropped as well, thanks.

--
Thanks,
Sasha
