Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x224L32ST4P+DW52TFzMQyBIcbpqD+XAWhe+MiJNgFNoFDKbqS1xBMu3815gHnspbYf8Gol+c
ARC-Seal: i=1; a=rsa-sha256; t=1519320289; cv=none;
        d=google.com; s=arc-20160816;
        b=W+FhkMkxgehB0eSojIE29m/yhkZZGJRAfRr0CDhFJOPS4sQVjhZfZQwieMov78Buen
         HhJRs8pJrsWq8he/1aRxAw8ADCoNPqUPmB8aYXVjFNhLI3+1adHv6C8pWx1VOqfcjPLk
         A0jsvOhJ3hpJMaBVI/7kI8O82Iiv89izFVqJQeajWNOvAUzW27KFQIl8GLGSb0WjCIMc
         sdPnXVwfkN0K6v1oATjHd3ntXIfImXXwO/sMs6EGOaB6Om9AZuwHaizy3b3WPOr2sG4N
         d+rP2wBYW50Nc0ybcSrQ7nFbapjSbnUGcssMM+ZVBiJDOxIkFxC1YvgOk02aLIHGcpo8
         vCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Xfz+ex09fSEvfTa9ezSmai/dbBFgPMQKx5ZGo+VcfL0=;
        b=GqxyGeK0yGADiqmtXpBIz7/laLb8RziE4vkyNooTBd2d8/Wh3rv1c+0CJHxo/zx08V
         6/jsf3v/tDpmIAxoK0e2vLtGBGT313NMyeJw4vqw01JLVZeyeIqyN+2qdVP2AtiHAkRJ
         yfq5+rCZNu1F3X8cRBCoWdrcUeoM4IMdAjBuL/Xvnlc08VNwzn9DcuhEnVoaf2XQTGG1
         TA/gQ5GBxRSB9W9vYJ+zN3/pmTi+D2Xg5mkB64zRSG2n0ipd7W14HOGE1wHawAyPcQpg
         GKWggY02YDXggM7VUDDtJmV0+gvob31sHC22JnVLT9/PUTyCBBWPQu1lyY+WUOoLk0BB
         edWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ai42tmjq;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CuKBTKr1;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ai42tmjq;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CuKBTKr1;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05C70607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CzOJ0oS8LLcKP-DgyXSXgzafg5CWPAvnR-QDPS+DZAUg@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
 <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
 <CAF6AEGuNZJKtwGZ5mLfqNND2jtU+HYM11UONfAtVTzoM0QVpdg@mail.gmail.com>
 <CAAFQd5BZJ1G0RG32hYErNzPRvisBhhiSNCBsjbzfm0WzO=DnsQ@mail.gmail.com>
 <CAFp+6iHaycK=CcE1S15EeuMkaw8LnW0ebptU0hM6tUtWdeEOtA@mail.gmail.com>
 <CAAFQd5Afj-Bj+3wHwmF2tT7y=46EsYEtO_mXfY6stXBgHutEUg@mail.gmail.com>
 <CAFp+6iGX6pr+MdPSSHHG=qOnhHky_8OHiDqAcJ9UudEUv=JMHg@mail.gmail.com>
 <CAAFQd5DiwAugGnPOTw0+XrEfef9x-n-vx59JFuXpNawjiXHwCw@mail.gmail.com>
 <CAFp+6iEW0faeHDfzN_F1bRrHGcVo3sPCk4HSY=t9dnEvHkDkYw@mail.gmail.com>
 <b003ecda-1cbe-4e5f-872b-107154ac40e5@arm.com> <CAAFQd5AmG1zSm+CouXOCJbs8SNGFk1-RqfU1nWGjMGJMB-qfvw@mail.gmail.com>
 <CAAFQd5A9B-di9svtiJbvk2hz1U1xo61rTY5vt6AD+KR5iMcG-A@mail.gmail.com>
 <7406f1ce-c2c9-a6bd-2886-5a34de45add6@arm.com> <CAAFQd5DkLtq2w00=Zd4sMDB4QOWqi7R-zgydECJXLdTmaHty+g@mail.gmail.com>
 <28466b36-b5d3-4f60-a45e-b75d79c2a3cb@arm.com> <CAAFQd5CzOJ0oS8LLcKP-DgyXSXgzafg5CWPAvnR-QDPS+DZAUg@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Thu, 22 Feb 2018 22:54:46 +0530
X-Gmail-Original-Message-ID: <CAFp+6iF3cEV60NrFMXZqP=enrVNtP9PPLTUOXhasRp2jc2Qd0w@mail.gmail.com>
Message-ID: <CAFp+6iF3cEV60NrFMXZqP=enrVNtP9PPLTUOXhasRp2jc2Qd0w@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
To: Tomasz Figa <tfiga@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, jcrouse@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1593122792148770160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, Feb 22, 2018 at 7:42 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Thu, Feb 22, 2018 at 10:45 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> [sorry, I had intended to reply sooner but clearly forgot]
>>
>>
>> On 16/02/18 00:13, Tomasz Figa wrote:
>>>
>>> On Fri, Feb 16, 2018 at 2:14 AM, Robin Murphy <robin.murphy@arm.com>
>>> wrote:
>>>>
>>>> On 15/02/18 04:17, Tomasz Figa wrote:
>>>> [...]
>>>>>>
>>>>>>
>>>>>> Could you elaborate on what kind of locking you are concerned about?
>>>>>> As I explained before, the normally happening fast path would lock
>>>>>> dev->power_lock only for the brief moment of incrementing the runtime
>>>>>> PM usage counter.
>>>>>
>>>>>
>>>>>
>>>>> My bad, that's not even it.
>>>>>
>>>>> The atomic usage counter is incremented beforehands, without any
>>>>> locking [1] and the spinlock is acquired only for the sake of
>>>>> validating that device's runtime PM state remained valid indeed [2],
>>>>> which would be the case in the fast path of the same driver doing two
>>>>> mappings in parallel, with the master powered on (and so the SMMU,
>>>>> through device links; if master was not powered on already, powering
>>>>> on the SMMU is unavoidable anyway and it would add much more latency
>>>>> than the spinlock itself).
>>>>
>>>>
>>>>
>>>> We now have no locking at all in the map path, and only a per-domain lock
>>>> around TLB sync in unmap which is unfortunately necessary for
>>>> correctness;
>>>> the latter isn't too terrible, since in "serious" hardware it should only
>>>> be
>>>> serialising a few cpus serving the same device against each other (e.g.
>>>> for
>>>> multiple queues on a single NIC).
>>>>
>>>> Putting in a global lock which serialises *all* concurrent map and unmap
>>>> calls for *all* unrelated devices makes things worse. Period. Even if the
>>>> lock itself were held for the minimum possible time, i.e. trivially
>>>> "spin_lock(&lock); spin_unlock(&lock)", the cost of repeatedly bouncing
>>>> that
>>>> one cache line around between 96 CPUs across two sockets is not
>>>> negligible.
>>>
>>>
>>> Fair enough. Note that we're in a quite interesting situation now:
>>>   a) We need to have runtime PM enabled on Qualcomm SoC to have power
>>> properly managed,
>>>   b) We need to have lock-free map/unmap on such distributed systems,
>>>   c) If runtime PM is enabled, we need to call into runtime PM from any
>>> code that does hardware accesses, otherwise the IOMMU API (and so DMA
>>> API and then any V4L2 driver) becomes unusable.
>>>
>>> I can see one more way that could potentially let us have all the
>>> three. How about enabling runtime PM only on selected implementations
>>> (e.g. qcom,smmu) and then having all the runtime PM calls surrounded
>>> with if (pm_runtime_enabled()), which is lockless?
>>
>>
>> Yes, that's the kind of thing I was gravitating towards - my vague thought
>> was adding some flag to the smmu_domain, but pm_runtime_enabled() does look
>> conceptually a lot cleaner.
>
> Great, thanks. Looks like we're in agreement now. \o/
>
> Vivek, does this sound reasonable to you?

Yea, sound good to me. I will respin the patches.

Thanks & Regards
Vivek

>
> Best regards,
> Tomasz



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
