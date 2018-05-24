Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751118AbeEXEL2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 00:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeEXEL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 00:11:27 -0400
Date: Thu, 24 May 2018 09:41:23 +0530
From: Vinod <vkoul@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Clemens Ladisch <clemens@ladisch.de>,
        Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] sound: Use octal not symbolic permissions
Message-ID: <20180524041123.GB26663@vkoul-mobl>
References: <b32d7b5f7827cc3283e4e46c3135144373404621.1527103197.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32d7b5f7827cc3283e4e46c3135144373404621.1527103197.git.joe@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 12:20, Joe Perches wrote:
> Convert the S_<FOO> symbolic permissions to their octal equivalents as
> using octal and not symbolic permissions is preferred by many as more
> readable.
> 
> see: https://lkml.org/lkml/2016/8/2/1945
> 
> Done with automated conversion via:
> $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
> 
> Miscellanea:
> 
> o Wrapped one multi-line call to a single line
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  sound/core/compress_offload.c             |  2 +-

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
