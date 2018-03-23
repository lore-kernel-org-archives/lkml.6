Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeCWMda convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:33:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33226 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751793AbeCWMd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:33:29 -0400
Date: Fri, 23 Mar 2018 12:33:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: kbuild test robot <lkp@intel.com>
CC: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>,
        <kbuild-all@01.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/11] Move cdc ad7746 driver out of staging to mainline
 iio
Message-ID: <20180323133315.0000248c@huawei.com>
In-Reply-To: <201803231808.uRqN5zpa%fengguang.wu@intel.com>
References: <1521642539-4845-12-git-send-email-hernan@vanguardiasur.com.ar>
        <201803231808.uRqN5zpa%fengguang.wu@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 18:21:58 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Hernán,
> 
> Thank you for the patch! Yet something to improve:
I guess you have figured this out already, but you missed updating the make
files in your patch.

Jonathan
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.16-rc6 next-20180322]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Hern-n-Gonzalez/Move-ad7746-out-of-staging/20180323-163331
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-randconfig-u0-03231537 (attached as .config)
> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> make[5]: *** No rule to make target 'drivers/staging/iio/cdc/ad7746.c', needed by 'drivers/staging/iio/cdc/ad7746.o'.  
>    make[5]: Target '__build' not remade because of errors.
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
