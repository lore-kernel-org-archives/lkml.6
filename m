Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519308764; cv=none;
        d=google.com; s=arc-20160816;
        b=hn6N22u/Z9pV6PTYMP4bKIjIu4YO0GkOd+n3q7PpJlhSonrRtiWy/S/KDgJDEweOKQ
         7+zeK6J7boGl9kBS5ejacSGn7T7m/idBCId5YsCQYWcUD4hqa/VrE81qwDVfcCYccqS0
         /cPt/5CWT/MsXGw9RjC/dhFqccyJ4F8onM50ZxlBrrpJYe+F4EOl5JLn8TukBJVhLE5x
         iAbTo4FTIzjW6U/seW7PtTMFa8aVHZ8fydGJU3WztaFcRrwIF5SP9o3rUZitLRNMkL6z
         ZrHPb82fTAkTPTPW6+641edtwF6zycsdU1y+EI0D5RWsuK/Wy1CT1gtq6sJxSwe03W3H
         s2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=aKJFfG4wsMng7qV6luft7LTn0ZuMm6S+gP/CavxQMb4=;
        b=saEIbNL5vR4B+cj7I7Z67NyNsNa3Z0ih4yXQrL2sQep6zajIaTiWbvxoD2FC88JOAd
         /+UFKQ7rIIlPMepaE+8F/hskKRxVjvRQ5/gYVM93oKMjrtfr3cIC15+Ao835z5eXaQu5
         tYHLOUcWAyONLCkjTjB8/BJZE5whUq9NBHmY1D1WXQIkyW3KuHCdKjJ4otjjhgMSQZQD
         AzvnWwqqtk+q5tXUwZvmSun4g3XO8GpLAzCbjAVbbrcRBT8C3sm4foISIXBB8wl5f5tS
         U9dnQ+FKhv44q1UYjIClQn5AtxLQLtnNakwZXJuZUBJ5zYl0ZWLMN1CjP0cPadzKEb8T
         ocgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=PuvprHqF;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=PuvprHqF;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x2240ZS/o5ddBLlBjZ/QYMI4UArYJuhxCLT38WEYgs7V6UWbHRfAmQAInLCF4m3W24/QgntRhEw==
MIME-Version: 1.0
In-Reply-To: <28466b36-b5d3-4f60-a45e-b75d79c2a3cb@arm.com>
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
 <28466b36-b5d3-4f60-a45e-b75d79c2a3cb@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 22 Feb 2018 23:12:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CzOJ0oS8LLcKP-DgyXSXgzafg5CWPAvnR-QDPS+DZAUg@mail.gmail.com>
Message-ID: <CAAFQd5CzOJ0oS8LLcKP-DgyXSXgzafg5CWPAvnR-QDPS+DZAUg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
To: Robin Murphy <robin.murphy@arm.com>, Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>,
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
X-GMAIL-MSGID: =?utf-8?q?1593110707024384742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 10:45 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> [sorry, I had intended to reply sooner but clearly forgot]
>
>
> On 16/02/18 00:13, Tomasz Figa wrote:
>>
>> On Fri, Feb 16, 2018 at 2:14 AM, Robin Murphy <robin.murphy@arm.com>
>> wrote:
>>>
>>> On 15/02/18 04:17, Tomasz Figa wrote:
>>> [...]
>>>>>
>>>>>
>>>>> Could you elaborate on what kind of locking you are concerned about?
>>>>> As I explained before, the normally happening fast path would lock
>>>>> dev->power_lock only for the brief moment of incrementing the runtime
>>>>> PM usage counter.
>>>>
>>>>
>>>>
>>>> My bad, that's not even it.
>>>>
>>>> The atomic usage counter is incremented beforehands, without any
>>>> locking [1] and the spinlock is acquired only for the sake of
>>>> validating that device's runtime PM state remained valid indeed [2],
>>>> which would be the case in the fast path of the same driver doing two
>>>> mappings in parallel, with the master powered on (and so the SMMU,
>>>> through device links; if master was not powered on already, powering
>>>> on the SMMU is unavoidable anyway and it would add much more latency
>>>> than the spinlock itself).
>>>
>>>
>>>
>>> We now have no locking at all in the map path, and only a per-domain lock
>>> around TLB sync in unmap which is unfortunately necessary for
>>> correctness;
>>> the latter isn't too terrible, since in "serious" hardware it should only
>>> be
>>> serialising a few cpus serving the same device against each other (e.g.
>>> for
>>> multiple queues on a single NIC).
>>>
>>> Putting in a global lock which serialises *all* concurrent map and unmap
>>> calls for *all* unrelated devices makes things worse. Period. Even if the
>>> lock itself were held for the minimum possible time, i.e. trivially
>>> "spin_lock(&lock); spin_unlock(&lock)", the cost of repeatedly bouncing
>>> that
>>> one cache line around between 96 CPUs across two sockets is not
>>> negligible.
>>
>>
>> Fair enough. Note that we're in a quite interesting situation now:
>>   a) We need to have runtime PM enabled on Qualcomm SoC to have power
>> properly managed,
>>   b) We need to have lock-free map/unmap on such distributed systems,
>>   c) If runtime PM is enabled, we need to call into runtime PM from any
>> code that does hardware accesses, otherwise the IOMMU API (and so DMA
>> API and then any V4L2 driver) becomes unusable.
>>
>> I can see one more way that could potentially let us have all the
>> three. How about enabling runtime PM only on selected implementations
>> (e.g. qcom,smmu) and then having all the runtime PM calls surrounded
>> with if (pm_runtime_enabled()), which is lockless?
>
>
> Yes, that's the kind of thing I was gravitating towards - my vague thought
> was adding some flag to the smmu_domain, but pm_runtime_enabled() does look
> conceptually a lot cleaner.

Great, thanks. Looks like we're in agreement now. \o/

Vivek, does this sound reasonable to you?

Best regards,
Tomasz
