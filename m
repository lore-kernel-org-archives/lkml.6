Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD5ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65B82154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 15:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoK5I7Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65B82154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeIVVSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 17:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbeIVVSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 17:18:39 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EBE3214C1;
        Sat, 22 Sep 2018 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537629882;
        bh=rZ0JxpZ4eawR60v9L581NKZ4BNRGKo7gd813gDf5jg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QoK5I7FzfdJy4u7mD82/F26iOS3vXkaEW9GQmCcdnEnm4yNFA97i3gJXvCi5i/PaC
         lPt1/WcZtvFtxE2Bnlsf7BSr+zE4ZSH63ST1TsKchBMvtj7fr6S64Qt23VmpFWK3jT
         jjUEFo4U9cE1+nzQF/1X9aBBbdJnNl4i1JPfzZvU=
Date:   Sat, 22 Sep 2018 16:24:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        himanshujha199640@gmail.com,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: Re: [PATCH v5] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180922162437.224e574c@archlinux>
In-Reply-To: <20180917061933.GA15262@bogus>
References: <20180915095752.8116-1-songqiang.1304521@gmail.com>
        <20180917061933.GA15262@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> > 
> >  .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
> >  MAINTAINERS                                   |   7 +  
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Hi Song,

Please make sure to pick up the various Acks, Reviewed-bys etc for later versions.

I've added this to the version I applied.

Thanks,

Jonathan
> 
> >  drivers/iio/proximity/Kconfig                 |  11 ++
> >  drivers/iio/proximity/Makefile                |   2 +
> >  drivers/iio/proximity/vl53l0x-i2c.c           | 180 ++++++++++++++++++
> >  5 files changed, 212 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> >  create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c  

