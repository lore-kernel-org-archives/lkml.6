Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D57C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC172156B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC172156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbeHGNki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:40:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:21376 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbeHGNki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:40:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 04:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="61261028"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2018 04:26:26 -0700
Message-ID: <3a50932025929d1b318cb42c05a727892603d31d.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] i2c: npcm7xx: add i2c controller master mode only
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tali Perry <tali.perry1@gmail.com>, avifishman70@gmail.com,
        tmaimon77@gmail.com, venture@google.com, yuenn@google.com,
        brendanhiggins@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, arnd@arndb.de, wsa@the-dreams.de,
        pierre-yves.mordret@st.com, cedric.madianga@gmail.com,
        baolin.wang@spreadtrum.com, jarkko.nikula@linux.intel.com,
        hdegoede@redhat.com, rmk+kernel@armlinux.org.uk,
        ard.biesheuvel@linaro.org, thor.thayer@linux.intel.com,
        geert@linux-m68k.org, heikki.krogerus@linux.intel.com,
        tglx@linutronix.de
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 07 Aug 2018 14:26:25 +0300
In-Reply-To: <20180807110709.31847-3-tali.perry1@gmail.com>
References: <20180807110709.31847-1-tali.perry1@gmail.com>
         <20180807110709.31847-3-tali.perry1@gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 14:07 +0300, Tali Perry wrote:
> Nuvoton NPCM7XX I2C Controller
> NPCM7xx includes 16 I2C contollers. THis driver operates the
> controller.
> This module also includes a slave mode, which will be submitted later
> on.
> 
> Any feedback would be appreciated.  
> 
> v2 -> v1:
> 	- run check patch in strict mode.
> 	- use linux crc.
> 	- define regs in constant offset without base.
> 	- remove debug prints.
> 	- no declerations for local functions.
> 	
> v1: initial version

I don't know / remember why I'm in Cc list here, but you can go through
my other reviews and find style recommendations for your code as well.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
