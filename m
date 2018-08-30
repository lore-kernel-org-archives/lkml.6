Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DABC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBDD20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBDD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeH3OPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:15:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:8287 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbeH3OPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:15:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 03:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="69030182"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2018 03:14:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fvJxe-0002I0-Pj; Thu, 30 Aug 2018 18:13:58 +0800
Date:   Thu, 30 Aug 2018 18:12:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     kbuild-all@01.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        florian.meier@koalo.de, cristian.birsan@microchip.com
Subject: Re: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a
 WM8731)
Message-ID: <201808301856.vMNJerSs%fengguang.wu@intel.com>
References: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Codrin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on at91/at91-next]
[also build test WARNING on v4.19-rc1 next-20180830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Codrin-Ciubotariu/ASoC-Add-driver-for-PROTO-Audio-CODEC-with-a-WM8731/20180830-060610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/atmel/mikroe-proto.c:178:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
