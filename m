Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D1ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2821221523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2821221523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389804AbeIUQkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:40:20 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:49404 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbeIUQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:40:20 -0400
Received: from [IPv6:2001:420:44c1:2579:30fd:5f16:92ce:7922] ([IPv6:2001:420:44c1:2579:30fd:5f16:92ce:7922])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 3J2Ogbhyu5fI03J2RgCWS4; Fri, 21 Sep 2018 12:51:58 +0200
Subject: Re: [PATCH v2 0/3] Add Amlogic video decoder driver
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20180911150938.3844-1-mjourdan@baylibre.com>
 <9c33c57e-2ce2-8752-b851-f85c03a7d761@xs4all.nl>
 <CAMO6nay7u4nMZcND6+g-GJAFsFcGrp_GDKBhVjeXVzpjF0ND4Q@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <8b8af340-8bd7-092a-4203-fd01fd0cc5c6@xs4all.nl>
Date:   Fri, 21 Sep 2018 12:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMO6nay7u4nMZcND6+g-GJAFsFcGrp_GDKBhVjeXVzpjF0ND4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEck6TuNwzgr83mchl9+l4kLTYNf2GS+y1z1zCoZkhyo2co3/0XhNNIy/OZ2qrg+2QmY8uIBRYakAVg0r3vLdOzI2pbRUqqVjwBtC/Tzl8XTtBVptZU8
 TLFeFfmCrQG5aE26sFCBBIR350nZgrCqIgypkMucavcB2p0RiyL3X5WTtyRMKm4i0acqVu1blMhtV0/xKyBJnryG2pImN6CC1QgSDileTTPJKOknhMafTn6z
 XPk/hsEI5c2oyMl3v72q3fsxO98hDV0UjiDgzmYOZs5C92jgh/m0b44brTy/eNY6K3iq8v4ylwdY1jURPu4FMYJPI0H6ALT8tCZa057UnpP/gS9S/sV/FcMj
 JZQBBz+EKjm5HWSlaXAOhyTOFxwMZoH++MKzbcZfBUJ/OJ3hNvZYlsxSr1hRmJulGKRF/WCrJsVo6jj6QWgqifVavThx3tVL6TDSVEgpL2mON/iRfovdPsRH
 qq/LRIb9j5zQpIVoXGbQGTOR0TYq/7UvJ/HAS5weJEtrgHKV3zcNdpp29OUqZ2E4yBgo2Ej9H2d3UCFcsyPXKeef/0jV1psswixRH6bwRLVt9I+eOJVgXsdD
 csUss20XKgzEiYsGsRl20kBPqnCuR104sQS4Q/1ct4i2tmXlrWb1GiavETvSPkQVFAEDQuA0obYkd534pAeCrToXPaOqLS/Uj6pM+h/ydyltI6fPxMmuFPoq
 gDcqaXkYXtk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/18 18:36, Maxime Jourdan wrote:
> 2018-09-17 16:51 GMT+02:00 Hans Verkuil <hverkuil@xs4all.nl>:
>> On 09/11/2018 05:09 PM, Maxime Jourdan wrote:
>>>  - Moved the single instance check (returning -EBUSY) to start/stop streaming
>>>  The check was previously in queue_setup but there was no great location to
>>>  clear it except for .close().
>>
>> Actually, you can clear it by called VIDIOC_REQBUFS with count set to 0. That
>> freed all buffers and clears this.
>>
>> Now, the difference between queue_setup and start/stop streaming is that if you
>> do this in queue_setup you'll know early on that the device is busy. It is
>> reasonable to assume that you only allocate buffers when you also want to start
>> streaming, so that it a good place to know this quickly.
>>
>> Whereas with start_streaming you won't know until you call STREAMON, or even later
>> if you start streaming with no buffers queued, since start_streaming won't
>> be called until you have at least 'min_buffers_needed' buffers queued (1 for this
>> driver). So in that case EBUSY won't be returned until the first VIDIOC_QBUF.
>>
>> My preference is to check this in queue_setup, but it is up to you to decide.
>> Just be aware of the difference between the two options.
>>
>> Regards,
>>
>>         Hans
> 
> I could for instance keep track of which queue(s) have been called
> with queue_setup, catch calls to VIDIOC_REQBUFS with count set to 0,
> and clear the current session once both queues have been reset ?

I see your point, this is rather awkward. The real problem here is that
we don't have a 'queue_free' callback. If we'd had that this would be
a lot easier.

In any case, I am dropping my objections to doing this in start/stop_streaming.

> You leverage another issue with min_buffers_needed. It's indeed set to
> 1 but this value is wrong for the CAPTURE queue. The problem is that
> this value changes depending on the codec and the amount of CAPTURE
> buffers requested by userspace.
> Ultimately I want it set to the total amount of CAPTURE buffers,
> because the hardware needs the full buffer list before starting a
> decode job.
> Am I free to change this queue parameter later, or is m2m_queue_init
> the only place to do it ?

It has to be set before the VIDIOC_STREAMON. After that you cannot
change it anymore.

But I don't think this is all that relevant, since this is something
that the job_ready() callback should take care of. min_buffers_needed
is really for hardware where the DMA engine cannot start unless that
many buffers are queued. But in that case the DMA runs continuously
capturing video, whereas here these are jobs and the DMA is only
started when you can actually execute a job.

Regards,

	Hans
