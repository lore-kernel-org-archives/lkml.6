Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE69C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A8C21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A8C21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeI0X0o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:26:44 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:49957 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728505AbeI0X0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:26:44 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 19:26:43 EDT
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.85)
          with esmtps (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1g5Ze1-0037nk-DM>; Thu, 27 Sep 2018 19:00:05 +0200
Received: from z92e7.pia.fu-berlin.de ([87.77.146.231] helo=[10.146.231.3])
          by inpost2.zedat.fu-berlin.de (Exim 4.85)
          with esmtpsa (TLSv1.2:AES128-SHA:128)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1g5Ze0-001IwI-Qx>; Thu, 27 Sep 2018 19:00:05 +0200
Subject: Re: [PATCH] ata: add Amiga Gayle PATA controller driver
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Tejun Heo <tj@kernel.org>, Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
References: <CGME20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3@epcas2p3.samsung.com>
 <19df19ad-47e8-1f17-6b7f-39365cd0d4df@physik.fu-berlin.de>
 <4c590675-71dc-d7f1-b40f-3b0ee124082a@physik.fu-berlin.de>
 <2435240.vCYXG2Zeag@amdc3058>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <08866634-04fb-e8fe-08bf-003d6a982b5a@physik.fu-berlin.de>
Date:   Thu, 27 Sep 2018 19:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2435240.vCYXG2Zeag@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: 87.77.146.231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej!

Any chance you had a chance working on the libata port of the Buddha
driver? The Amiga 4000 here is equipped with a Buddha and I'm happy
to help testing the driver:

root@elgar:~> lszorro
00: Phase 5 Digital Products CyberSCSI/Blizzard 1220
01: Village Tronic Ariadne Ethernet Card
02: individual Computers X-Surf 100 Z-II/ZIII Ethernet
03: individual Computers Buddha IDE Controller
04: Phase 5 Digital Products CyberVision 64
root@elgar:~>

Adrian

On 3/1/18 11:52 AM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, March 01, 2018 10:55:48 AM John Paul Adrian Glaubitz wrote:
>> Hello!
> 
> Hi,
> 
>> On 02/18/2018 05:18 PM, John Paul Adrian Glaubitz wrote:
>>> Is there any progress on this? Is it just the SDPX headers now that
>>> are missing?
>>
>> Would it be okay if re-send the patch with the SPDX headers added?
>>
>> Or can we get the patch merged, then I'll send a patch to add the
>> SPDX headers?
> 
> I'll post updated version later today, sorry for the delay (I've been
> busy with other things and the patch is not v4.16 material anyway).
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

