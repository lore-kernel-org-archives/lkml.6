Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDC3ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDBF208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDBF208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbeISMJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:09:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43764 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeISMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:09:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id m84-v6so3932770lje.10;
        Tue, 18 Sep 2018 23:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eTv9Oh0cnzsBkTpYGiDDxRzP2FV70E3x3cQbx6YJ1Yw=;
        b=DSp4IkyMi7aR0md2ist8V9rVCS/1Gfnv4It+xznXm4W50j9tA0EhW8MmSKq+I2mv1z
         z7cG7/K6mF57WLw4H2o8wDMaRucdFI1e00Aowk9Bwfj4rMh5YOMw/XI4k4VsTz+cKVKa
         FKcvVSMOuFdHtItb9d4ZpzFuye5l5HyE356OQwmXYT/aGeuCI3pRQbg7WAD6bMA16XS1
         1fs+O+35P1ZYge7jGPVoToMsabXhsm9PJ/VGw2OG60D8Xo7u0NzYrK0UWLXy9S0rbdLA
         fKPfo/hR0fxc84xMZ9wgFd7gG5hLW8hiV92e8dMbA5SJar5lOQfUQwZ9Pz5oWIoy/mVm
         y1VA==
X-Gm-Message-State: APzg51AxB/eek+75xwAlj5XchpABhwy6fdxkgk4GO5Ta2BYzmNTlpepR
        yulBAFKl78M0/FlYqkXLCRU=
X-Google-Smtp-Source: ANB0VdZ4g9jlZVC4soVTXzIbM2vuN0o722iKcVSfFemReRLjnd+zOoBkqL/eWwFBldq1V6GhfA5jjg==
X-Received: by 2002:a2e:5810:: with SMTP id m16-v6mr22332584ljb.134.1537338770124;
        Tue, 18 Sep 2018 23:32:50 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 36-v6sm3782856lja.65.2018.09.18.23.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 23:32:49 -0700 (PDT)
Date:   Wed, 19 Sep 2018 09:32:47 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        sboyd@kernel.org, mazziesaccount@gmail.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 7/7] regulator: bd718xx: rename bd71837 to 718xx
Message-ID: <20180919063247.GC2295@localhost.localdomain>
References: <6b3e7b3aeef67d85083f49894e0b0fe482fc08c4.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
 <201809181853.7HyPgIo6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809181853.7HyPgIo6%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

On Tue, Sep 18, 2018 at 06:13:48PM +0800, kbuild test robot wrote:
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on regulator/for-next]
> [also build test ERROR on next-20180913]
> [cannot apply to v4.19-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/regulator-mfd-dt_bindings-bd718x7-Support-ROHM-bd71847/20180914-210454
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> config: x86_64-randconfig-s4-09181517 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> drivers/regulator/bd718x7-regulator.c:364:16: error: implicit declaration of function 'of_match_ptr'; did you mean 'hash_ptr'? [-Werror=implicit-function-declaration]
>        .of_match = of_match_ptr("BUCK1"),
>                    ^~~~~~~~~~~~
>                    hash_ptr

This error is not introduced in this patch series. The already in-tree
implementation of bd71837 driver has this bug already. I'll send a
trivial patch to Mark for adding the missing include.

Br,
	Matti Vaittinen
