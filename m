Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B85F2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390631AbfBOSn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:43:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfBOSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:43:28 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 82702B1D;
        Fri, 15 Feb 2019 18:43:26 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:43:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        Dan Williams <dan.j.williams@intel.com>, broonie@kernel.org,
        matthew.hart@linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        khilman@baylibre.com, enric.balletbo@collabora.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-Id: <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
In-Reply-To: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:

> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master boot bisection: next-20190215 on beaglebone-black
> 
> Summary:
>   Start:      7a92eb7cc1dc Add linux-next specific files for 20190215
>   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
>   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html
>   Result:     8dd037cc97d9 mm/shuffle: default enable all shuffling
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     beaglebone-black
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-7
>   Config:     multi_v7_defconfig+CONFIG_SMP=n
>   Test suite: boot
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 8dd037cc97d9226c97c2ee1abb4e97eff71e0c8d
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Fri Feb 15 11:28:30 2019 +1100
> 
>     mm/shuffle: default enable all shuffling

Thanks.

But what actually went wrong?  Kernel doesn't boot?


