Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeESN4D (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 09:56:03 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44165 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeESN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 09:56:00 -0400
X-Google-Smtp-Source: AB8JxZo2aF/X8CmEYp+2lW12aBJgGK0FX2rGEXdsz1vdCbSn6a93+NzLOtuYo8OcugrWwmNEZ9lgsQ==
Date: Sat, 19 May 2018 09:55:52 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, jic23@kernel.org, benjamin.gaignard@st.com,
        fabrice.gasnier@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 4/9] counter: 104-quad-8: Add Generic Counter
 interface support
Message-ID: <20180519135539.GA31866@sophia>
References: <881ede525a87ef68fad76cc757ce0ba72df03e5a.1526487615.git.vilhelm.gray@gmail.com>
 <201805192140.de07sSol%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201805192140.de07sSol%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 09:16:55PM +0800, kbuild test robot wrote:
>Hi William,
>
>I love your patch! Perhaps something to improve:
>
>[auto build test WARNING on linus/master]
>[also build test WARNING on v4.17-rc5 next-20180517]
>[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
>url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Introduce-the-Counter-subsystem/20180519-151353
>reproduce:
>        # apt-get install sparse
>        make ARCH=x86_64 allmodconfig
>        make C=1 CF=-D__CHECK_ENDIAN__
>
>
>sparse warnings: (new ones prefixed by >>)
>
>>> drivers/counter/104-quad-8.c:803:26: sparse: symbol 'quad8_ops' was not declared. Should it be static?
>
>Please review and possibly fold the followup patch.

Ah, yes it should be static -- looks like I made a minor mistake. I'll
squash the fix into the next revision of this patchset.

Thank you,

William Breathitt Gray

>
>---
>0-DAY kernel test infrastructure                Open Source Technology Center
>https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
