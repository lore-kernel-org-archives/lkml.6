Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A9CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B4720881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B4720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeG3KcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:32:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15146 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeG3KcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:32:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5ed3220000>; Mon, 30 Jul 2018 01:58:10 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Jul 2018 01:58:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Jul 2018 01:58:13 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 30 Jul
 2018 08:58:11 +0000
Subject: Re: [PATCH 1/4] ASoC: tegra: i2s: Fix typo/broken macro
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@lists.codethink.co.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-2-jorge.sanjuan@codethink.co.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f9e2eaad-bd5c-2e3d-f2a7-d7ea5f3a237c@nvidia.com>
Date:   Mon, 30 Jul 2018 09:58:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727125931.9794-2-jorge.sanjuan@codethink.co.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/07/18 13:59, Jorge Sanjuan wrote:
> From: Edward Cragg <edward.cragg@codethink.co.uk>
> 
> Fix typo in macro TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK.
> 
> Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  sound/soc/tegra/tegra30_i2s.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/tegra/tegra30_i2s.h b/sound/soc/tegra/tegra30_i2s.h
> index 774fc6ad2026..2e561e946de2 100644
> --- a/sound/soc/tegra/tegra30_i2s.h
> +++ b/sound/soc/tegra/tegra30_i2s.h
> @@ -173,7 +173,7 @@
>  /* Number of slots in frame, minus 1 */
>  #define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_SHIFT		16
>  #define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK_US	7
> -#define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK		(TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOT_MASK_US << TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOT_SHIFT)
> +#define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK		(TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK_US << TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_SHIFT)
>  
>  /* TDM mode slot enable bitmask */
>  #define TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_SHIFT	8

Thanks for fixing.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
