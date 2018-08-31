Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2C9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCBC205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCBC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeHaNzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:55:14 -0400
Received: from mout.perfora.net ([74.208.4.196]:42621 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbeHaNzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:55:14 -0400
Received: from localhost.localdomain ([89.217.215.226]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LhMFq-1fZro81lSq-00mZgr;
 Fri, 31 Aug 2018 11:48:16 +0200
Message-ID: <1535708890.8035.42.camel@ziswiler.com>
Subject: Re: [PATCH v3] ARM: dts: pxa: add mioa701 board description
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     kbuild test robot <lkp@intel.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     kbuild-all@01.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 31 Aug 2018 11:48:10 +0200
In-Reply-To: <201808311515.Fq0HyEql%fengguang.wu@intel.com>
References: <20180830195941.6118-1-robert.jarzmik@free.fr>
         <201808311515.Fq0HyEql%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Bm+DHpQEFh4KR/j4GpUXN6iQnlc/wya0WvDlsyMi5ZhzN57a9Hi
 2MRYIZM5K/q7vsbiDQ0niRBOP2EaGrl+opaQQbcIa3WlQFUFe34uMaWQTwQ5MUFgeyhvt27
 bOa4EvcPMgdUvZE/rrxpxqhuognffRLcNB718z7FVMkJYT79anUQhSKcLGYW63EU//PYI7p
 m+axAi8cqwedSwBBAgqEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FBN88cBj098=:dLQfINheibEzwBimRT927a
 n5V1MRvSbSop5VLlRcDgUQw5uMJqu0aqabtg01wYi98dH0/N8pbNXfg4iada6Uoy30kgNT4aY
 +Nzpg5Kt/1eycvlIIJoJsVkqKS502ltDKS9Iu5GlOvI4madB7s1wj6PgV60eAi0hHXHjuF25y
 iQeESQRNmpCEj1+PWK5ZTvqc4YBnladzja1vPyKHHML8Q6GHUOpkbpJ0F++VGEUW1yPBIQZBA
 gHlZHvNa5zTIlgaTV86zih4lLths+NJWiy0GcWfka37kx6eEKWqOCmub9c92xNteqCLbpuWjJ
 NnmQqEszLLkj7kM43IyjlxvoW8nIgVvbvw/G1EKVjeTN6lWx5CRMmZZDxFH75GoVPtEpA4CVQ
 6+Q/JfrCIEkujbcgyOCbq5+6blojEMUGpavCZQnpopbuQoFffd7KG+Lupkexcy/BPEH3uAmAv
 H+JT9BBvPGOFAPUkPV946Mtdzjs8XjZhNSPQFcD7xbMvt88v/Z9893JkALWexn3dY0pjtlgRW
 SJW+3oYWHhK09gxZ9pZDWiwtLyIhnMDk3+3lfWeTRuAevLZsx1zTEDhuuiaDvAMOWzFG5whfw
 5BTuAWvS2HG92h2sAwQYWbdbXdfG/FNMQZcohxiM9CqlPuwBgDM0rd8aZgU2Uh8iyce4s4PQg
 NMrqcyR9/b/XEk1/I7WPCIV/rOPXn3l4EV4oDM7FanvjNbPGYNz+ElQwIMkEhbZkk+ewi3CZG
 /HvBy/XlQqOYloOz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 15:45 +0800, kbuild test robot wrote:
> Hi Robert,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.19-rc1 next-20180831]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Robert-Jarzmik/ARM-d
> ts-pxa-add-mioa701-board-description/20180831-134244
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.gi
> t for-next
> config: arm-keystone_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master
> /sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> > > Error: arch/arm/boot/dts/mioa701.dts:47.10-11 syntax error
> 
>    FATAL ERROR: Unable to parse input tree

I guess it just missed the dependency on the following:

https://lore.kernel.org/lkml/20180830195912.6025-1-robert.jarzmik@free.
fr/

> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
