Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B14DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BABB2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BABB2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeGZMN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:13:26 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:49509 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729097AbeGZMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:13:25 -0400
Received: from [IPv6:2001:983:e9a7:1:9ca6:a377:e357:d31a] ([IPv6:2001:983:e9a7:1:9ca6:a377:e357:d31a])
        by smtp-cloud8.xs4all.net with ESMTPA
        id idx9fTAVdoj71idxAfQ9fp; Thu, 26 Jul 2018 12:57:06 +0200
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20180724140621.59624-1-tfiga@chromium.org>
 <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl>
 <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a6af3dc9-1d09-a414-ce31-bc1b3e69894f@xs4all.nl>
Date:   Thu, 26 Jul 2018 12:57:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJhP1XMB+afqUmKC2ytLy8l6EYXn8tJw0uLr51HLLYCLRlndc1e2ErP3kTWFzAg8NcS95jN5mLA/FXpup5US2Wl6W3Bd/ukPvlU+eGc/FG3pBH3SE+Sf
 zPMNsLb3H6Y/4PypQ8USG9yfmC1pGbA5QLUSJT/hj0EnFDWKGHNH/42wwU/Kyzul0paRx0tdA78IyDGnFiNQyTRkO2AEZQIT8Y+80cQtS/yNFwm/TL5OyKr5
 /F+oqHxCasnCk1X8/Z6rofh8V+Ifedj7BeB2rVW5Ocxw2cDKHvyxJj+0GSqNKncwJNappaq/wRV4KKtQS+Ne2EZCDGVEi6DMHzNI8mckR+vJGW09BMebS1EI
 +v9cABh4ZNqyEiJOSiu8il7C2wO7I02KcVvbRm6W+hdf5Q8dzbNioS3CiqGq1F2I2phsmYE4RJCorheToJ8Mt77OlJ2gpt1duOP4W6Nzh36ZpqDIHhae6HfE
 bZrOJtcwUG/uegLgU3ptmWO4FA2q6bPh+uVFl0i71nmoY9w1GY6iG0lWtThqPYYXp2Yn6FkfkzSepWk00vE+l5vaVeJwT93xqMtPUXizNLX6AMi9LyaZSopW
 PxdN+B2o1Uq5Np7sbUb6l1UUgBW6uIV9OMSv20Lae4iZ77IdatAEDAXeYou11lpUJ+szmc4ZtUQnH8RY6MIRlzRbnFlqiMMOMcko7WZcIde0nxYlKL0rOz6f
 D3seJnKkqZ8JbHuUXyMHzD2fD8QraN5w6oepjgEn3T1eCkUfoNFnW+zujviOhWGBq3BkA5PTIyXpltuGX629qjkGSFkRNw79jjLJVFCOtD82BQc4ubzHcA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/18 12:20, Tomasz Figa wrote:
> Hi Hans,
> 
> On Wed, Jul 25, 2018 at 8:59 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> Hi Tomasz,
>>
>> Many, many thanks for working on this! It's a great document and when done
>> it will be very useful indeed.
>>
>> Review comments follow...
> 
> Thanks for review!
> 
>>
>> On 24/07/18 16:06, Tomasz Figa wrote:

> [snip]

>> Note that the v4l2_pix_format/S_FMT documentation needs to be updated as well
>> since we never allowed 0x0 before.
> 
> Is there any text that disallows this? I couldn't spot any. Generally
> there are already drivers which return 0x0 for coded formats (s5p-mfc)
> and it's not even strange, because in such case, the buffer contains
> just a sequence of bytes, not a 2D picture.

All non-m2m devices will always have non-zero width/height values. Only with
m2m devices do we see this.

This was probably never documented since before m2m appeared it was 'obvious'.

This definitely needs to be documented, though.

> 
>> What if you set the format to 0x0 but the stream does not have meta data with
>> the resolution? How does userspace know if 0x0 is allowed or not? If this is
>> specific to the chosen coded pixel format, should be add a new flag for those
>> formats indicating that the coded data contains resolution information?
> 
> Yes, this would definitely be on a per-format basis. Not sure what you
> mean by a flag, though? E.g. if the format is set to H264, then it's
> bound to include resolution information. If the format doesn't include
> it, then userspace is already aware of this fact, because it needs to
> get this from some other source (e.g. container).
> 
>>
>> That way userspace knows if 0x0 can be used, and the driver can reject 0x0
>> for formats that do not support it.
> 
> As above, but I might be misunderstanding your suggestion.

So my question is: is this tied to the pixel format, or should we make it
explicit with a flag like V4L2_FMT_FLAG_CAN_DECODE_WXH.

The advantage of a flag is that you don't need a switch on the format to
know whether or not 0x0 is allowed. And the flag can just be set in
v4l2-ioctls.c.

>>> +STREAMOFF-STREAMON sequence on it is intended solely for changing buffer
>>> +sets.
>>
>> 'changing buffer sets': not clear what is meant by this. It's certainly not
>> 'solely' since it can also be used to achieve an instantaneous seek.
>>
> 
> To be honest, I'm not sure whether there is even a need to include
> this whole section. It's obvious that if you stop feeding a mem2mem
> device, it will pause. Moreover, other sections imply various
> behaviors triggered by STREAMOFF/STREAMON/DECODER_CMD/etc., so it
> should be quite clear that they are different from a simple pause.
> What do you think?

Yes, I'd drop this last sentence ('Similarly...sets').

>>> +2.  After all buffers containing decoded frames from before the resolution
>>> +    change point are ready to be dequeued on the ``CAPTURE`` queue, the
>>> +    driver sends a ``V4L2_EVENT_SOURCE_CHANGE`` event for source change
>>> +    type ``V4L2_EVENT_SRC_CH_RESOLUTION``.
>>> +
>>> +    * The last buffer from before the change must be marked with
>>> +      :c:type:`v4l2_buffer` ``flags`` flag ``V4L2_BUF_FLAG_LAST`` as in the
>>
>> spurious 'as'?
>>
> 
> It should be:
> 
>     * The last buffer from before the change must be marked with
>       the ``V4L2_BUF_FLAG_LAST`` flag in :c:type:`v4l2_buffer` ``flags`` field,
>       similarly to the

Ah, OK. Now I get it.

>> I wonder if we should make these min buffer controls required. It might be easier
>> that way.
> 
> Agreed. Although userspace is still free to ignore it, because REQBUFS
> would do the right thing anyway.

It's never been entirely clear to me what the purpose of those min buffers controls
is. REQBUFS ensures that the number of buffers is at least the minimum needed to
make the HW work. So why would you need these controls? It only makes sense if they
return something different from REQBUFS.

> 
>>
>>> +7.  If all the following conditions are met, the client may resume the
>>> +    decoding instantly, by using :c:func:`VIDIOC_DECODER_CMD` with
>>> +    ``V4L2_DEC_CMD_START`` command, as in case of resuming after the drain
>>> +    sequence:
>>> +
>>> +    * ``sizeimage`` of new format is less than or equal to the size of
>>> +      currently allocated buffers,
>>> +
>>> +    * the number of buffers currently allocated is greater than or equal to
>>> +      the minimum number of buffers acquired in step 6.
>>
>> You might want to mention that if there are insufficient buffers, then
>> VIDIOC_CREATE_BUFS can be used to add more buffers.
>>
> 
> This might be a bit tricky, since at least s5p-mfc and coda can only
> work on a fixed buffer set and one would need to fully reinitialize
> the decoding to add one more buffer, which would effectively be the
> full resolution change sequence, as below, just with REQBUFS(0),
> REQBUFS(N) replaced with CREATE_BUFS.

What happens today in those drivers if you try to call CREATE_BUFS?

Regards,

	Hans
