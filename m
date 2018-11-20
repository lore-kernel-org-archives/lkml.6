Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DE4C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76C120685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76C120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbeKTRoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:44:07 -0500
Received: from ms.tdt.de ([195.243.126.94]:42799 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730564AbeKTRoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:44:07 -0500
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 567F6204CA;
        Tue, 20 Nov 2018 07:16:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Nov 2018 08:16:28 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh@kernel.org>, jdelvare@suse.com,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 1/2] hwmon: (adcxx) add devictree bindings
 documentation
In-Reply-To: <20181119012555.GA7856@roeck-us.net>
References: <20181115135013.30723-1-fe@dev.tdt.de>
 <20181115135013.30723-2-fe@dev.tdt.de> <20181117144040.GA8016@bogus>
 <20181119012555.GA7856@roeck-us.net>
Message-ID: <b6ee9998a565333f5105be46426b289c@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

>> 
>> Needs a better description of what this h/w is.
>> 
>> ADCs go in iio/adc/
>> 
> FWIW, the hwmon driver for this chip series would be a perfect 
> candidate
> for a conversion to an iio driver. The driver predates the existence of
> iio.
> 
> Florian, any interest doing that ? It is quite likely that the chip 
> isn't
> used for hardware monitoring.

I will have a look on the next week about your suggestion to port this 
device
to iio/adc.

   - Florian


