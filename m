Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935539AbeEISbq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:31:46 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:59806 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935435AbeEISbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:31:42 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.899
Subject: Re: [PATCH 3/4] rtc: ds1307: add calibration of_ for mt41txx chips.
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180508145611.49072-1-giulio.benetti@micronovasrl.com>
 <20180508145611.49072-3-giulio.benetti@micronovasrl.com>
 <20180508191956.GP10960@piout.net>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <4d1b1ead-9439-210e-f246-cb49219390f5@micronovasrl.com>
Date: Wed, 9 May 2018 20:31:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508191956.GP10960@piout.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Il 08/05/2018 21:19, Alexandre Belloni ha scritto:
> Hi,
> 
> There is a sysfs interface for calibration, please use it. this is
> especially useful since the calibration value probably depend on
> temperature so it has to be updated dynamically to be really useful.
> 
> See https://elixir.bootlin.com/linux/v4.16.7/source/Documentation/ABI/testing/sysfs-class-rtc#L68
> and https://elixir.bootlin.com/linux/v4.16.7/source/drivers/rtc/interface.c#L999
> 

Used sysfs now and just submitted V2 patchset.
Thanks for pointing me those links.

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
