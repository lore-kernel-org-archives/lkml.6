Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D116256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB3520857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB3520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeG3S6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:58:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45795 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeG3S6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:58:13 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fkBs0-0003My-Q2; Mon, 30 Jul 2018 18:22:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Jul 2018 18:22:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org
Subject: Re: [Linux-kernel] [PATCH 0/4] ASoC: Tegra30 TDM support
In-Reply-To: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
Message-ID: <e7961b55c10610a7e137edee2995add9@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-27 13:59, Jorge Sanjuan wrote:
> This patchset adds support for TDM audio on Tegra30 hardware.
> It adds the DAI's `set_tdm_slot` callback and enables a tegra
> pcm to have up to 8 channels.
> 
> It also includes support for other audio formats supported by
> the Tegra30 HW and fixes a broken macro needed for setting the
> TDM on the registers.
> 
> Based on Linux 4.18-rc3 tag.
> 
> Edward Cragg (4):
>   ASoC: tegra: i2s: Fix typo/broken macro
>   ASoC: tegra: Add a TDM configuration callback
>   ASoC: tegra: Allow 32-bit and 24-bit samples
>   ASoC: tegra: i2s: Add support for more than 2 channels
> 
>  sound/soc/tegra/tegra30_i2s.c | 72 
> ++++++++++++++++++++++++++++++++++++-------
>  sound/soc/tegra/tegra30_i2s.h |  2 +-
>  2 files changed, 62 insertions(+), 12 deletions(-)

Just as a note, Ed Cragg has moved on from Codethink and I've not
got a new address for him. We've been cleaning some of the work Ed,
Jorge, Terry and myself have been doing.

-- 
Ben

