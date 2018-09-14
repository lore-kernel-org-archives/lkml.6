Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F310C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D011F20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D011F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeINKzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 06:55:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46860 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeINKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 06:55:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so6478802ljj.13;
        Thu, 13 Sep 2018 22:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uszMwO+KdUnnXlY4+Z2gMYYrNrxM8ow7LChkc2Pk+Iw=;
        b=tGKKdtmMm77n8Y0x6wde7WsWupdITOLhE2LnHtSCyQ1lF7VzbfwTg73ht4xomMNFWa
         cyXpIK5VINYkR4ZKfkSrfNufm6OLk2k0Ao+mUXjZvzlOBUaKskdXa7AVAyNtTkP+B/8p
         8h3yf2HdpaBfJYv8hTA42Ciq0R/IkF6Gdd3Mgm7h5b2bzCaFc3MKyKpmXuxmZVaKzm8E
         Gu5CVFqZhQAfEQBSh149SIA/+vvoenWaVe5juFQxO6+pgy6nhdpQJfccFSagQPucnm+m
         AxPLFkmyEzsIeJRZxotDq1oH6pJzSILzcNMicGFHeEvlnUh+F+UIsY8npTMbV4wR3j+8
         dOIQ==
X-Gm-Message-State: APzg51A8C+sfaL3A9KgiwLZQify2JHLjduxmwmvnCp52G7BiBYLZVGfJ
        o+/S+Y8kvjxB8cWMk++uscs=
X-Google-Smtp-Source: ANB0VdagXBRAkpmPZ7DEPLOFdbBwcIJaQeFeueVaQ8uCYKsv5QdnY368Ip58GpSZRfiswXL04HLnsg==
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr6241341ljh.95.1536903738503;
        Thu, 13 Sep 2018 22:42:18 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id m8-v6sm1041455ljj.10.2018.09.13.22.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 22:42:17 -0700 (PDT)
Date:   Fri, 14 Sep 2018 08:42:11 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, sboyd@kernel.org,
        mazziesaccount@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH v2 5/7] regulator/mfd: bd718xx: rename bd71837/bd71847
 common instances
Message-ID: <20180914054211.GA2295@localhost.localdomain>
References: <74dc36388bc48a59191cc212094c85b157fd5197.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
 <201809140420.mcXVA0yk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809140420.mcXVA0yk%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 04:39:28AM +0800, kbuild test robot wrote:
> Hi Matti,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on regulator/for-next]
> [also build test ERROR on next-20180913]
> [cannot apply to v4.19-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/regulator-mfd-dt_bindings-bd718x7-Support-ROHM-bd71847/20180914-000129
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> config: i386-randconfig-s0-201836 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> Note: the linux-review/Matti-Vaittinen/regulator-mfd-dt_bindings-bd718x7-Support-ROHM-bd71847/20180914-000129 HEAD 0df8e57cacf59e85ad40a25fbb1bd7e842608be8 builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/regulator/bd71837-regulator.c:407:18: error: 'BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM' undeclared here (not in a function)
>        .n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/regulator/bd71837-regulator.c:735:18: error: initializer element is not constant
>        .n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sorry all. I've messed up the series. The
BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM definition is used already in
[PATCH v2 5/7] but only added to header in patch [PATCH v2 6/7].

I'll fix this and send out v3.

Br,
	Matti Vaittinen

