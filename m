Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E3CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8904214FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8904214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbeHGJ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:26:33 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:44023 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388581AbeHGJ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:26:33 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id mwBKfJV22EJtcmwBNf4P0x; Tue, 07 Aug 2018 09:13:34 +0200
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
Message-ID: <e0da6268-c7f6-1048-83b9-a7e67cfe000e@xs4all.nl>
Date:   Tue, 7 Aug 2018 09:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMrWev36GF+g/YWCUtXiFb5HE2J2KggqZp8aJ/viLGrcymOKiYFeTNaz6WjjNUrfBFHk+SBMsFj92zJDG/unks0aVUZR6FW0CHSAjmSQuH44iDyvRDi8
 WKR5BRYVFJBEJw2Xxavce+vXBCgqv6yhSatxi8u2/674nvbz+uBmUCHsGdacFRft0ruZRr85gHO3w/NPFdN1jbxAQlQ4wK8Giw3p/It9QgQ0FCo6e/fheXeh
 XNup/8+TEG1lEShoAtgPg8Mo6tS9j0P+LREA5HW4wC1bCGs2JKiBSzEPpG9HwSEDRMfBwZGPJlGYwgeqrctGotmda9d5yW8AOe9SunsWe/H9MpAXK/5YA23j
 07Klf+0alwTxJhK5PSfMigrj/eko7WystqizUvhvh/noEMKAQD4WEVhjbhDO75RF9ksDSXqWdIODr+yj/JcjPbyyVArRgGaD/k1ONX2F7lM/CaM7HizREk5y
 yiDYL88HnvK/2qmlfwcBqyaqCfMEM7NUz7YXshalQ23aP+fdtoyRywYhSp1RZyb8jzykSClqA8rN1Zw78YMp4L91FnLtb0Cz1LLA3pvuOEu4kCHHMhVOXxJ3
 d2xvyWAthPQXiHzzHmV5LYgpCSMe2tcE2mCOWgFtvLrg/RBgAnrEmyKpj5JPBiEIxD6MsTqvf4UCKMjpJH1UdeIxY88kj3aZ0W9WkMRZNOM+/+Q+4APpehcL
 mpOa/GoZOZw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 12:20 PM, Tomasz Figa wrote:
> Hi Hans,
> 
> On Wed, Jul 25, 2018 at 8:59 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>> +
>>> +14. Call :c:func:`VIDIOC_STREAMON` to initiate decoding frames.
>>> +
>>> +Decoding
>>> +========
>>> +
>>> +This state is reached after a successful initialization sequence. In this
>>> +state, client queues and dequeues buffers to both queues via
>>> +:c:func:`VIDIOC_QBUF` and :c:func:`VIDIOC_DQBUF`, following standard
>>> +semantics.
>>> +
>>> +Both queues operate independently, following standard behavior of V4L2
>>> +buffer queues and memory-to-memory devices. In addition, the order of
>>> +decoded frames dequeued from ``CAPTURE`` queue may differ from the order of
>>> +queuing coded frames to ``OUTPUT`` queue, due to properties of selected
>>> +coded format, e.g. frame reordering. The client must not assume any direct
>>> +relationship between ``CAPTURE`` and ``OUTPUT`` buffers, other than
>>> +reported by :c:type:`v4l2_buffer` ``timestamp`` field.
>>
>> Is there a relationship between capture and output buffers w.r.t. the timestamp
>> field? I am not aware that there is one.
> 
> I believe the decoder was expected to copy the timestamp of matching
> OUTPUT buffer to respective CAPTURE buffer. Both s5p-mfc and coda seem
> to be implementing it this way. I guess it might be a good idea to
> specify this more explicitly.

What about an output buffer producing multiple capture buffers? Or the case
where the encoded bitstream of a frame starts at one output buffer and ends
at another? What happens if you have B frames and the order of the capture
buffers is different from the output buffers?

In other words, for codecs there is no clear 1-to-1 relationship between an
output buffer and a capture buffer. And we never defined what the 'copy timestamp'
behavior should be in that case or if it even makes sense.

Regards,

	Hans
