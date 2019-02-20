Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DE72146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfBTGcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:32:31 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:10097 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfBTGcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:32:31 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="27999167"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 19 Feb 2019 23:32:30 -0700
Received: from localhost (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Tue, 19 Feb 2019
 23:32:29 -0700
Date:   Wed, 20 Feb 2019 07:32:14 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     kbuild test robot <lkp@intel.com>, <alexandre.belloni@bootlin.com>,
        <me@jue.yt>, <linux-kernel@vger.kernel.org>, <kbuild-all@01.org>,
        <andriy.shevchenko@linux.intel.com>,
        Juergen Fitschen <jfi@ssv-embedded.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20190220063214.7edblwnh3ih354kp@M43218.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        kbuild test robot <lkp@intel.com>, alexandre.belloni@bootlin.com,
        me@jue.yt, linux-kernel@vger.kernel.org, kbuild-all@01.org,
        andriy.shevchenko@linux.intel.com,
        Juergen Fitschen <jfi@ssv-embedded.de>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
 <20190115224351.rtbqaqro5pl3dvov@ninjato>
 <20190215091847.pkagndsndjzumzwd@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190215091847.pkagndsndjzumzwd@ninjato>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 15, 2019 at 10:18:47AM +0100, Wolfram Sang wrote:
> On Tue, Jan 15, 2019 at 11:43:51PM +0100, Wolfram Sang wrote:
> > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] undefined!
> > > >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undefined!
> > 
> > That needs to be fixed. Rest looks good to me!
> 
> Ludovic, do you have time to fix it? I would really like to apply this
> series for the next merge window.
> 

Sorry it's in my todo list but I didn't have time to handle it. I'll try
to fix it beginning of next week.

Regards

Ludovic



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

