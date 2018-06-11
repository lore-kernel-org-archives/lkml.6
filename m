Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CphKBytMHlsaKQAAmS7hNA
	; Mon, 11 Jun 2018 10:17:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5B713607A4; Mon, 11 Jun 2018 10:17:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C884B60541;
	Mon, 11 Jun 2018 10:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C884B60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeFKKRO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:17:14 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:41367 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932745AbeFKKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:17:12 -0400
Received: from [IPv6:2001:983:e9a7:1:7ce8:99dc:ae9f:cb92] ([IPv6:2001:983:e9a7:1:7ce8:99dc:ae9f:cb92])
        by smtp-cloud8.xs4all.net with ESMTPA
        id SJsqf7VRRatLZSJsrfq8SM; Mon, 11 Jun 2018 12:17:11 +0200
Subject: Re: [PATCH v7 0/6] Add ChromeOS EC CEC Support
To: Neil Armstrong <narmstrong@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc: airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <04598b47-5099-6695-da43-6e7148145cfa@xs4all.nl>
 <55c2c02d-5675-0821-97ec-6a805659b807@baylibre.com>
 <898f025f-9c59-be61-a2b4-5fbbcbc659c2@cisco.com> <20180611060308.GB5278@dell>
 <87562fc8-6c5b-1c9d-4ee4-fd17b652087f@baylibre.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <f1c53c6d-a431-6dd2-8fb1-904fd9c8c7c4@xs4all.nl>
Date: Mon, 11 Jun 2018 12:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87562fc8-6c5b-1c9d-4ee4-fd17b652087f@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFzV9Xh6J9zKHfuHdIf85eqUN7rHrcUuXEFhzKVmEF9QZf04CMynwW6eiVmmC9cSVZ/NYGJD1n+V9Eq4+qTPoo2BBV/XdxDgfXsjBpyAUjLiUGR8PI1C
 pso8Z5yi1ejhaqIBKp8xqIZa76T0GlGZGUwGvnt7Zse6TLsrlwc7PZtuZ8/UCKXVeC6WonK48LgpUnTf7kk1yxBgjB5rYbLn6iVgiQ0FdhH9LbKJg9FbPfqZ
 PGo1fyZP27zxcKHmE5B6xUdkyl6HDvzyjkg7FIE8obLoxhn5g/Ulsz4njyORNrhbAFl1Ll6d6/ia8/wKG1M1/1xHkfs22vFZNkVTAjY3Tcibt711Bfd1jaou
 eWUOsetJzZp1LzheMW9Dcyxpn4FzP5rvVV3WC6uVE4ToxDVWOzatIkv3jD3b5UoHPCRzDcfOABjllAteCXTkLeqFlaRoLIGgpSv2nFOru1Hm65gq4IzrktmV
 ZsHNhZP8iB1tT2Q5ylsqP1znOH2wP23q59CF3YA9gxrUUVIVQ+P6j01+8VymSyasEAVWJDeKXCZaV3L47Oidbwq0NjeABRf9tHPvatIuHuoYhC6JKoezR0/f
 kFmoKVpFI40mPOMP9d47kxxX399nN/gXHpnXjEbCT64gkpOGPJCqD6pxriF+VoC4ORG+0/bRFSf3pBz0MntFGCaRu10FhyfuVuouM9DD+rf8ffmNF93gVBgI
 eTT0DQs/Q9GfyxUxYC/KbOnQXQ52Ssvq7tprF0JlFEhoIX3zvx7q9N++OXzh4IUtLs33Psy3uKHO3SO8TkhB8RiZt3HegcJXvY09O2BpLHEFVBWaUihfkkYe
 bm6eH23noTfrmWCnyVFSw5aLiOdZpdnaYwxe0zOtcP4/jgMjy7mF/S8Uawxnmw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/18 10:56, Neil Armstrong wrote:
> Hi Lee,
> 
> On 11/06/2018 08:03, Lee Jones wrote:
>> On Fri, 08 Jun 2018, Hans Verkuil wrote:
>>> On 08/06/18 10:17, Neil Armstrong wrote:
>>>> On 08/06/2018 09:53, Hans Verkuil wrote:
>>>>> On 06/01/2018 10:19 AM, Neil Armstrong wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> The new Google "Fizz" Intel-based ChromeOS device is gaining CEC support
>>>>>> through it's Embedded Controller, to enable the Linux CEC Core to communicate
>>>>>> with it and get the CEC Physical Address from the correct HDMI Connector, the
>>>>>> following must be added/changed:
>>>>>> - Add the CEC sub-device registration in the ChromeOS EC MFD Driver
>>>>>> - Add the CEC related commands and events definitions into the EC MFD driver
>>>>>> - Add a way to get a CEC notifier with it's (optional) connector name
>>>>>> - Add the CEC notifier to the i915 HDMI driver
>>>>>> - Add the proper ChromeOS EC CEC Driver
>>>>>>
>>>>>> The CEC notifier with the connector name is the tricky point, since even on
>>>>>> Device-Tree platforms, there is no way to distinguish between multiple HDMI
>>>>>> connectors from the same DRM driver. The solution I implemented is pretty
>>>>>> simple and only adds an optional connector name to eventually distinguish
>>>>>> an HDMI connector notifier from another if they share the same device.
>>>>>
>>>>> This looks good to me, which brings me to the next question: how to merge
>>>>> this?
>>>>>
>>>>> It touches on three subsystems (media, drm, mfd), so that makes this
>>>>> tricky.
>>>>>
>>>>> I think there are two options: either the whole series goes through the
>>>>> media tree, or patches 1+2 go through drm and 3-6 through media. If there
>>>>> is a high chance of conflicts in the mfd code, then it is also an option to
>>>>> have patches 3-6 go through the mfd subsystem.
>>>>
>>>> I think patches 3-6 should go in the mfd tree, Lee is used to handle this,
>>>> then I think the rest could go in the media tree.
>>>>
>>>> Lee, do you think it would be possible to have an immutable branch with patches 3-6 ?
>>>>
>>>> Could we have an immutable branch from media tree with patch 1 to be merged in
>>>> the i915 tree for patch 2 ?
>>>>
>>>> Or patch 1+2 could me merged into the i915 tree and generate an immutable branch
>>>
>>> I think patches 1+2 can just go to the i915 tree. The i915 driver changes often,
>>> so going through that tree makes sense. The cec-notifier code is unlikely to change,
>>> and I am fine with that patch going through i915.
>>>
>>>> for media to merge the mfd branch + patch 7 ?
>>>
>>> Patch 7? I only count 6?
>>>
>>> If 1+2 go through drm and 3-6 go through mfd, then media isn't affected at all.
>>> There is chance of a conflict when this is eventually pushed to mainline for
>>> the media Kconfig, but that's all.
>>
>> What are the *build* dependencies within the set?
> 
> Here are the hard the build dependency :
> 
> Patch 2 depends on Patch 1
> Patch 5 depends on Patch 4
> Patch 6 depends on Patches 1 & 4

Ah, I missed the dependency of patch 6 on patch 1. So the whole series needs
to be merged as a single unit.

> 
>>
>> I'd be happy to send out a pull-request for either all of the patches,
>> or just the MFD changes once I've had chance to review them.
>>
> 
> Great, thanks !
> 
> Neil
> 

I'm OK if this goes through the mfd tree.

Regards,

	Hans
