Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D320C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24152054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24152054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeLKFCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:02:04 -0500
Received: from anchovy2.45ru.net.au ([203.30.46.146]:54496 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeLKFCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:02:04 -0500
Received: (qmail 15972 invoked by uid 5089); 11 Dec 2018 05:02:02 -0000
Received: by simscan 1.2.0 ppid: 15844, pid: 15845, t: 0.0583s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 11 Dec 2018 05:02:01 -0000
Subject: Re: [PATCH V4 2/2] iio: light: isl29018: add optional vdd/vdda
 regulator operation support
To:     Anson Huang <anson.huang@nxp.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1544498291-2716-1-git-send-email-Anson.Huang@nxp.com>
 <1544498291-2716-2-git-send-email-Anson.Huang@nxp.com>
 <d07b5970-5825-2ea6-9e27-538386927923@electromag.com.au>
 <DB3PR0402MB39161ED492C863BB48D48E2FF5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <0b08c0d1-afe2-5ade-9333-2eb7d57d4db6@electromag.com.au>
 <DB3PR0402MB3916588612090716E066D2ABF5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <312e5c0c-e92f-a337-3730-2fd73c99f48a@electromag.com.au>
Date:   Tue, 11 Dec 2018 13:02:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3916588612090716E066D2ABF5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 12:29 pm, Anson Huang wrote:
>> G'day Anson,
>>
>> Just pulled up the datasheet for this chip.
>>
>> The absolute max for Vdda is speced as Vddd ±0.5 With a note that Vdda
>> should be externally shorted to Vddd.
> The data sheet says vdda should be connected to vdd externally, then I think we should just
> use one regulator vdd, then it will be much easier for the driver, what do you think?
> 

Yes I think that makes sense.



-- 
Regards
Phil
