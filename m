Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 62snLS2JGVulTwAAmS7hNA
	; Thu, 07 Jun 2018 19:36:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A6054606DD; Thu,  7 Jun 2018 19:36:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 07486601C3;
	Thu,  7 Jun 2018 19:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07486601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeFGTgK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:36:10 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:53051 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752041AbeFGTgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:36:08 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id R0hWfky7gtLaAR0hafwkSS; Thu, 07 Jun 2018 21:36:07 +0200
Subject: Re: [RFC PATCH 1/2] media: docs-rst: Add decoder UAPI specification
 to Codec Interfaces
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>
Cc: dave.stevenson@raspberrypi.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?=
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?=
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        todor.tomov@linaro.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20180605103328.176255-1-tfiga@chromium.org>
 <20180605103328.176255-2-tfiga@chromium.org>
 <CAAoAYcOJ5Q2rHqGEmcStxxXj423a3ddKOSzvwRV6R5-UxhM+Hg@mail.gmail.com>
 <b767d9d7-5a26-f6f8-3978-81e8d60769c2@xs4all.nl>
 <CAAFQd5BSq+kz0xxrFVFKhA4XFJE1hF8NHomQSGqYzNo+Swdyyw@mail.gmail.com>
 <3c852dec2279fa95af268357a438d442ddb70d44.camel@ndufresne.ca>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9a07ec24-79c9-e6c8-edf7-7da962635148@xs4all.nl>
Date: Thu, 7 Jun 2018 21:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3c852dec2279fa95af268357a438d442ddb70d44.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfERH9PQ4RrhBfiy3Zy8mOud/HEDwmzDxrXa5dVOU6fovkL2rlzq+dv6u0XPT5TC9/2ZDchEsfozehpoXeH71rYjciLPIEre8/gBbAzrK7r/vb9TwCnOq
 QAAHUJGYh7wwodSto0/XoJqTb8PBm+RotOS5SGCHy0cNqCoHK73ZJPpoELBWVxVm3bP0u/h8tmnhQdps0d8ZQpZajRY5zWkluDzUvUVbWEIwOzD7aGpcJJmA
 ara3l0WR6NBuUktbDZmNtLkzMucdnbbPbWUWeVWFUKaDPeZM6g1Pj3DMHs3ja7QHxwhuFTyD+/4TMKaO7Oby8Nc1yb8L6w7odp34AOldDH5TTk+sQ3BdllZt
 SETx+pSCTu6jxB8i/Cq26QV61+XZBjIHH/62bR8mVgyDx/AtA1HVoVYvhU9NwQJp6jeWdozRFvgNVpzdyNK77++wzTjlmyhbf2NIJdyvugascqX1KpKqQmoj
 yjx0x9hsW8cTlKX68vQZo3QHhNKJUX0D7XITpzlt5qqnr7JOSDCI2z6vgn1Ux0hMphMgF+iMV2UujmCMP8FfpoC84qnn/5umDVwPJCUZMWCpVSEMVuB2cG7H
 YfNi4ZYkjfw9igm+fskSW7XOUHlPk5g6/aQQWfc5YjS4zYrlebkcNpNkf6KHPZqrpunXwnKw7Gxboogh/qlkk/bMqRI5mfehpP1dK3wNeeOW6sg9e3Xd27qN
 ltBHzRnBDliNwE9w/wmtHN2RRl1l0/zZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 07:53 PM, Nicolas Dufresne wrote:
> Le jeudi 07 juin 2018 à 16:30 +0900, Tomasz Figa a écrit :
>>>> v4l2-compliance (so probably one for Hans).
>>>> testUnlimitedOpens tries opening the device 100 times. On a normal
>>>> device this isn't a significant overhead, but when you're allocating
>>>> resources on a per instance basis it quickly adds up.
>>>> Internally I have state that has a limit of 64 codec instances (either
>>>> encode or decode), so either I allocate at start_streaming and fail on
>>>> the 65th one, or I fail on open. I generally take the view that
>>>> failing early is a good thing.
>>>> Opinions? Is 100 instances of an M2M device really sensible?
>>>
>>> Resources should not be allocated by the driver until needed (i.e. the
>>> queue_setup op is a good place for that).
>>>
>>> It is perfectly legal to open a video node just to call QUERYCAP to
>>> see what it is, and I don't expect that to allocate any hardware resources.
>>> And if I want to open it 100 times, then that should just work.
>>>
>>> It is *always* wrong to limit the number of open arbitrarily.
>>
>> That's a valid point indeed. Besides the querying use case, userspace
>> might just want to pre-open a bigger number of instances, but it
>> doesn't mean that they would be streaming all at the same time indeed.
> 
> We have used in GStreamer the open() failure to be able to fallback to
> software when the instances are exhausted. The pros was it fails really
> early, so falling back is easy. If you remove this, it might not fail
> before STREAMON. At least in GStreamer, it too late to fallback to
> software.  So I don't have better idea then limiting on Open calls.

It should fail when you call REQBUFS. That's the point at which you commit
to allocating resources. Everything before that is just querying things.

STREAMON is way too late, but REQBUFS/CREATE_BUFS (i.e. when queue_setup
is called) is a good point. You already allocate memory there, you can
also claim the m2m hw resource(s) you need.

Regards,

	Hans
