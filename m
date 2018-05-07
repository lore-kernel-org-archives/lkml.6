Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeEGH6w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:58:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37896 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeEGH6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:58:49 -0400
X-Google-Smtp-Source: AB8JxZpR+iZQPJ3kPNKt7ELjzdX6YKbg/A6Tgl1Iq39lmetMsf08JoLjcDF5gZX6TtZOFZ4TJ1T3EX1/B0w+cb8BdXU=
MIME-Version: 1.0
In-Reply-To: <201805051336.iU9Fsl3b%fengguang.wu@intel.com>
References: <795030fce89ec55d015602fbf4594838a22a9094.1525420581.git.baolin.wang@linaro.org>
 <201805051336.iU9Fsl3b%fengguang.wu@intel.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 7 May 2018 15:58:48 +0800
Message-ID: <CAMz4kuJarMyBjONArUQ9h=f30Ltm1rBXRDQwe=VczFVTjxktnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: sprd: Add Spreadtrum DMA configuration
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 May 2018 at 13:54, kbuild test robot <lkp@intel.com> wrote:
> Hi Eric,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on slave-dma/next]
> [also build test WARNING on next-20180504]
> [cannot apply to linus/master v4.17-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/dmaengine-sprd-Optimize-the-sprd_dma_prep_dma_memcpy/20180505-071137
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/dma/sprd-dma.c:780:57: sparse: mixing different enum types
>    drivers/dma/sprd-dma.c:780:57:     int enum dma_slave_buswidth  versus
>    drivers/dma/sprd-dma.c:780:57:     int enum sprd_dma_datawidth
>    drivers/dma/sprd-dma.c:787:57: sparse: mixing different enum types
>    drivers/dma/sprd-dma.c:787:57:     int enum dma_slave_buswidth  versus
>    drivers/dma/sprd-dma.c:787:57:     int enum sprd_dma_datawidth
>
> vim +780 drivers/dma/sprd-dma.c

Sorry, It's one mistake. Eric will fix it in next version.

-- 
Baolin.wang
Best Regards
