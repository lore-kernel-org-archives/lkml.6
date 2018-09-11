Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61018C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A05204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A05204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeIKOz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:55:26 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12600 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:55:26 -0400
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="20447646"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 11 Sep 2018 02:56:52 -0700
Received: from [10.159.245.112] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Tue, 11 Sep 2018
 02:56:51 -0700
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
To:     Lee Jones <lee.jones@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Radu Pirea <radu.pirea@microchip.com>
CC:     <broonie@kernel.org>, <alexandre.belloni@bootlin.com>,
        <richard.genoud@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell> <20180911084548.GC4185@dell>
 <20180911090132.GB25161@kroah.com> <20180911094430.GG4185@dell>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <743b5545-e942-b6f4-4ce6-8e10950a05fc@microchip.com>
Date:   Tue, 11 Sep 2018 11:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911094430.GG4185@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 at 11:44, Lee Jones wrote:
> On Tue, 11 Sep 2018, Greg KH wrote:
> 
>> On Tue, Sep 11, 2018 at 09:45:48AM +0100, Lee Jones wrote:
>>> On Mon, 10 Sep 2018, Lee Jones wrote:
>>>
>>>> Enjoy!
>>>>
>>>> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>>>>
>>>>    Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
>>>>
>>>> for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
>>>>
>>>>    tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> Immutable branch between MFD, SPI and TTY due for the v4.20 merge window
>>>
>>> Due to a comedy of errors, I'm voiding this pull-request.
>>
>> Um, I can't do that as my tree can not be rebased :(
> 
> Oh dear. :(
> 
>> I can take follow-on patches, so I will go apply the patch posted so
>> that my tree builds again.  I recommend you just apply it as well.
> 
> What a pickle.  As per my last email, it looks as though this set was
> applied under false pretences.  The MFD patch which was carrying my
> Ack was doing so incorrectly.  The author mistakenly applied it to the
> wrong patch.  After re-review (actually initial review) I wish to NACK
> the implementation.

What? We discussed this to the bone!

Radu followed all the recommendations, collected all the feedback from 
major subsystems SPI and USART, resent the series again.

It was then forgotten. Wrong series was finally applied (which could 
trigger 0-day reports, I warn you)... and now we are discussing about 
the implementation of *v2* (we're at v12)!

> My suggestion would be to sit tight, rather than do anything rash and
> see how this plays out.  After which we can fix your tree.

Come on, Greg's tree is fixed now. We can catch-up with v11..v12 changes 
with patches and cleanup the mess together.

Just one misalignment with one patch merged for v4.19-rc1, fixed the 
same day, cannot generate such a reaction after months of development.

Best regards,
-- 
Nicolas Ferre
