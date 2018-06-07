Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i9zYBeMNGVvjBgAAmS7hNA
	; Thu, 07 Jun 2018 10:55:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DB6BD608B8; Thu,  7 Jun 2018 10:55:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 101A86063F;
	Thu,  7 Jun 2018 10:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 101A86063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeFGKzD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:55:03 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:45736 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751472AbeFGKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:55:01 -0400
Received: from [IPv6:2001:420:44c1:2579:708b:15e9:d378:18bf] ([IPv6:2001:420:44c1:2579:708b:15e9:d378:18bf])
        by smtp-cloud9.xs4all.net with ESMTPA
        id QsZDf9EVABFh2QsZHfmf7C; Thu, 07 Jun 2018 12:55:00 +0200
Subject: Re: [RFC PATCH 2/2] media: docs-rst: Add encoder UAPI specification
 to Codec Interfaces
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Tomasz Figa <tfiga@chromium.org>
Cc: Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?=
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?=
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        todor.tomov@linaro.org, nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20180605103328.176255-1-tfiga@chromium.org>
 <20180605103328.176255-3-tfiga@chromium.org>
 <1528199628.4074.15.camel@pengutronix.de>
 <CAAFQd5DYu+Oehr1UUvvdmWk7toO0i_=NFgvZcAKQ8ZURKy51fA@mail.gmail.com>
 <1528208578.4074.19.camel@pengutronix.de>
 <CAAFQd5DqHj65AdzfYmvHWkqHnZntiiA2AhAfgHbLA3AuWvsOTQ@mail.gmail.com>
 <1528278003.3438.3.camel@pengutronix.de>
 <CAAFQd5A2hsgrmwJ3bgv6EDKqqy5Y86CnMcktrWa+YihWGjxtHg@mail.gmail.com>
 <41fd04f2-fc44-1792-81e6-a3d4d384adc5@xs4all.nl>
 <1528367543.3308.6.camel@pengutronix.de>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <f5aab078-3e10-151b-c6f8-fb3fe6952d16@xs4all.nl>
Date: Thu, 7 Jun 2018 12:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1528367543.3308.6.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIRCWUnWXMudS/XYfB0urAHQxWHSxyAazphAUbDZDga+4EEcnk6deXpDd6SGjlt73B3S0IJeLXiTvl4d7KfGctA9Me8cPo6xAB/+RFaUqvyd9biFFmhU
 rhdtNs74UNsNvLHmlngXo6YRwO46X1TxiMBZqgj49xxT08L3YkEzPCEUZrXs9KzbzaZ6C1X3tNdG6eKMWB+P7DbeoX5LzTwvBo50PRrysYW2+Fvzfue+MlH9
 /TC3VGvhyx6ehJcHWaXC1OXzewh7tkRVRBZ3wk54Spj8G+HqVAEuo1kL3NuUUyVihP5+ipeRrnHdoY0DZHewRcD3tlSalBM2A30yovxaQRBecPlqXtAnzwiJ
 Ti5j5VRtDn2DaTGHBSMY8SlyEtoNMkLWDmu4Wu67kkSZ+qoytEU5GBMysOjSActiQezDTaGRXupaC/b3YXa7pnAqBBjeXXpCvuCiXBoBZLDf8Lt3PUCEJBht
 b5at24MBuVEvF2kA55ORNIqMV6MMAR8f58vOLV2eWpAVkIRMlLJZn4i1z9qQK5aySaPaN2gdi6TX57p7wN9kVqkuCj5f3Qr3wp5Hx5mnucVFTdz27pOS65ow
 9QBVegD0+wiTWOux9/9GsQTuTE2y1mTGXjSjUyyr1rsU/Ob/LjJFSexh6iXrjlkP05hzEM2gxIosICYoOnW7LMhXK8XSdAiiVdwJfsihLSAM0wfX4awyfrnu
 eZ5WdKYtZ4gF2nSeXChMX/tueQ4IW/e09RPN6giytmZEVMxcY3ohLneKUEO4gXyDF1UqGGWJyn6wIXtMyqgPfNYHONIPV6044LAsHj3r6oBxJ4QdALy+FM4D
 QkxpqyDkhwrhIGPN692MpVu3JPv4o5xDrocfNQb9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 12:32, Philipp Zabel wrote:
> On Thu, 2018-06-07 at 09:27 +0200, Hans Verkuil wrote:
> [...]
>>>>>> I think it could be useful to enforce the same colorimetry on CAPTURE
>>>>>> and OUTPUT queue if the hardware doesn't do any colorspace conversion.
>>>>>
>>>>> After thinking a bit more on this, I guess it wouldn't overly
>>>>> complicate things if we require that the values from OUTPUT queue are
>>>>> copied to CAPTURE queue, if the stream doesn't include such
>>>>> information or the hardware just can't parse them.
>>>>
>>>> And for encoders it would be copied from CAPTURE queue to OUTPUT queue?
>>>>
>>>
>>> I guess iy would be from OUTPUT to CAPTURE for encoders as well, since
>>> the colorimetry of OUTPUT is ultimately defined by the raw frames that
>>> userspace is going to be feeding to the encoder.
>>
>> Correct. All mem2mem drivers should just copy the colorimetry from the
>> output buffers to the capture buffers, unless the decoder hardware is able to
>> extract that data from the stream, in which case it can overwrite it for
>> the capture buffer.
>>
>> Currently colorspace converters are not supported since the V4L2 API does
>> not provide a way to let userspace define colorimetry for the capture queue.
> 
> Oh, I never realized this limitation [1] ...
> 
>  "Image colorspace, from enum v4l2_colorspace. This information
>   supplements the pixelformat and must be set by the driver for capture
>   streams and by the application for output streams, see Colorspaces."
> 
> [1] https://linuxtv.org/downloads/v4l-dvb-apis-new/uapi/v4l/pixfmt-v4l2.html
> 
> It's just a bit unintuitive that the initialization sequence requires to
> set S_FMT(CAP) first and then S_FMT(OUT) but with colorspace there is
> information that flows the opposite way.
> 
>> I have a patch to add a new v4l2_format flag for that since forever, but
>> since we do not have any drivers that can do this in the kernel it has never
>> been upstreamed.
> 
> Has this patch been posted some time? I think we could add a mem2mem
> device to imx-media with support for linear transformations.

I don't believe it's ever been posted.

It's here:

https://git.linuxtv.org/hverkuil/media_tree.git/commit/?h=csc&id=d0e588c1a36604538e16f24cad3444c84f5da73e

Regards,

	Hans
