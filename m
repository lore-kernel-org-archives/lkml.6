Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeE3PQh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:16:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8167 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeE3PQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:16:36 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 May 2018 08:16:35 -0700
Subject: Re: [PATCH] ASoC: core: Fix return code shown on error for hw_params
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <1527693178-5038-1-git-send-email-jonathanh@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <cecd3b0d-b4b4-9b22-13be-3f6c51264cfe@nvidia.com>
Date: Wed, 30 May 2018 16:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527693178-5038-1-git-send-email-jonathanh@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/05/18 16:12, Jon Hunter wrote:
> The call to hw_params for a component fails the error code is held by
> the variable '__ret' but the error message displays the value held by
> the variable 'ret'. Fix the return code shown when hw_params fails for
> a component.

Sorry, just resent this as I realise the description does not read correctly!

Jon

-- 
nvpublic
