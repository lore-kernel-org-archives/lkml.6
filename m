Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519287260; cv=none;
        d=google.com; s=arc-20160816;
        b=fT6WH6Z0ybt1N3fVFAvdowmAsWK+kA3/p99Qbjo4n5KmFSQMYobe2Iq+YDPNf3xA70
         VMopLclmi8t24Sqq17QbKi4P/y0U5ewjuBD6v73OldJ+UsgOB5WCupce7eg07K5718RM
         2kJCdrehJv8gwZZAuper585zIQS8EAAraVJ8zqBXMe5K0XJM+USdAKIg5JLbpRjUGz8d
         Tia3hVcR6Pn82JzmNErPujDVwGIDe09+eYIVOymoJvTY3WaG72C65rhH9tJSoxu5q/Pu
         MXZv5P0o7qfUz3+w2HyM268hBOCJMpnxpLfk2fSqIrv5ZbaZ8ZUxqmQJglISBTTTBS+y
         pVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UPe2xENpwVEV7++/tpPycq87ZBVkgIZnCE2KZfW7dpo=;
        b=J9ASscLPHB7RL2OS9MD5/1+HEe3MqRssEjQo+AJF0NgbbAKyt7R55ViV+UJ8Y2krTM
         L+v7dE5qI9+9QklkCfBYGlvdvGAQf4Ie+G4KNIvVS/eWO6DgcgNwtZhi7aXjq8PgTOPi
         XwYlBqI11ARXvCr7F5E5woX5v2A1WZt9XZcshp8VWQ21VNySpQ7gyA26ArFCrhSAUvAY
         0lGY+8dbesm7lHrewwDUamMTvvHzsubTC4l+zrFB3ntQriTHddZ2dHMAikEI9DczOeFf
         J4wbIEB8KjEZtp0pRdnvtEvvdPPC5FxLDfyajnxxl1mouWU7WQsZ1yfI/Ji+jMAJGPhH
         0bRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=OhBFNeM+;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=OhBFNeM+;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x226SIjNdgCOQdhZXkrk1QOCiJUG+u2cMOhbFuRp0qBHB9MPQP2QEW8p5WatICe6rxs5k1h0OKg==
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DkLtq2w00=Zd4sMDB4QOWqi7R-zgydECJXLdTmaHty+g@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
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
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 22 Feb 2018 17:13:56 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CQoDqunAunwoVo7W=QXa=ET=eJ2s_j9j+3YgAR2EGgCg@mail.gmail.com>
Message-ID: <CAAFQd5CQoDqunAunwoVo7W=QXa=ET=eJ2s_j9j+3YgAR2EGgCg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, jcrouse@codeaurora.org,
	Vivek Gautam <vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1593088158935654402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 9:13 AM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Fri, Feb 16, 2018 at 2:14 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 15/02/18 04:17, Tomasz Figa wrote:
>> [...]
>>>>
>>>> Could you elaborate on what kind of locking you are concerned about?
>>>> As I explained before, the normally happening fast path would lock
>>>> dev->power_lock only for the brief moment of incrementing the runtime
>>>> PM usage counter.
>>>
>>>
>>> My bad, that's not even it.
>>>
>>> The atomic usage counter is incremented beforehands, without any
>>> locking [1] and the spinlock is acquired only for the sake of
>>> validating that device's runtime PM state remained valid indeed [2],
>>> which would be the case in the fast path of the same driver doing two
>>> mappings in parallel, with the master powered on (and so the SMMU,
>>> through device links; if master was not powered on already, powering
>>> on the SMMU is unavoidable anyway and it would add much more latency
>>> than the spinlock itself).
>>
>>
>> We now have no locking at all in the map path, and only a per-domain lock
>> around TLB sync in unmap which is unfortunately necessary for correctness;
>> the latter isn't too terrible, since in "serious" hardware it should only be
>> serialising a few cpus serving the same device against each other (e.g. for
>> multiple queues on a single NIC).
>>
>> Putting in a global lock which serialises *all* concurrent map and unmap
>> calls for *all* unrelated devices makes things worse. Period. Even if the
>> lock itself were held for the minimum possible time, i.e. trivially
>> "spin_lock(&lock); spin_unlock(&lock)", the cost of repeatedly bouncing that
>> one cache line around between 96 CPUs across two sockets is not negligible.
>
> Fair enough. Note that we're in a quite interesting situation now:
>  a) We need to have runtime PM enabled on Qualcomm SoC to have power
> properly managed,
>  b) We need to have lock-free map/unmap on such distributed systems,
>  c) If runtime PM is enabled, we need to call into runtime PM from any
> code that does hardware accesses, otherwise the IOMMU API (and so DMA
> API and then any V4L2 driver) becomes unusable.
>
> I can see one more way that could potentially let us have all the
> three. How about enabling runtime PM only on selected implementations
> (e.g. qcom,smmu) and then having all the runtime PM calls surrounded
> with if (pm_runtime_enabled()), which is lockless?
>

Sorry for pinging, but any opinion on this kind of approach?

Best regards,
Tomasz

>>
>>> [1]
>>> http://elixir.free-electrons.com/linux/v4.16-rc1/source/drivers/base/power/runtime.c#L1028
>>> [2]
>>> http://elixir.free-electrons.com/linux/v4.16-rc1/source/drivers/base/power/runtime.c#L613
>>>
>>> In any case, I can't imagine this working with V4L2 or anything else
>>> relying on any memory management more generic than calling IOMMU API
>>> directly from the driver, with the IOMMU device having runtime PM
>>> enabled, but without managing the runtime PM from the IOMMU driver's
>>> callbacks that need access to the hardware. As I mentioned before,
>>> only the IOMMU driver knows when exactly the real hardware access
>>> needs to be done (e.g. Rockchip/Exynos don't need to do that for
>>> map/unmap if the power is down, but some implementations of SMMU with
>>> TLB powered separately might need to do so).
>>
>>
>> It's worth noting that Exynos and Rockchip are relatively small
>> self-contained IP blocks integrated closely with the interfaces of their
>> relevant master devices; SMMU is an architecture, implementations of which
>> may be large, distributed, and have complex and wildly differing internal
>> topologies. As such, it's a lot harder to make hardware-specific assumptions
>> and/or be correct for all possible cases.
>>
>> Don't get me wrong, I do ultimately agree that the IOMMU driver is the only
>> agent who ultimately knows what calls are going to be necessary for whatever
>> operation it's performing on its own hardware*; it's just that for SMMU it
>> needs to be implemented in a way that has zero impact on the cases where it
>> doesn't matter, because it's not viable to specialise that driver for any
>> particular IP implementation/use-case.
>
> Still, exactly the same holds for the low power embedded use cases,
> where we strive for the lowest possible power consumption, while
> maintaining performance levels high as well. And so the SMMU code is
> expected to also work with our use cases, such as V4L2 or DRM drivers.
> Since these points don't hold for current SMMU code, I could say that
> the it has been already specialized for large, distributed
> implementations.
>
> Best regards,
> Tomasz
