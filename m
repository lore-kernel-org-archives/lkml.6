Return-Path: <robdclark@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519306237; cv=none;
        d=google.com; s=arc-20160816;
        b=AxfzeavprO0I8u8PPy+wjuQl646HCFgCG/Mhto/kIIsCReDsJwoUzzWWbEltArQqIb
         qixZYRi8bKLuSlOk6aF5IRyct6m5/WMDPaEQeGm8nToWryfvo3ZhksdyIJlhaL6rbdBN
         hSY7b0J5eykiN97iGwGXbG7gDfr99hLpXQVsbfujrWgFHVPJiF4xihQstUEutKWWuXZQ
         QJmPUNjc3ozTvGnVJ/QiNZdz6e+5zNp2BnoN5au3dZa8kB27fWPJY25xTjp0SUSgBclE
         R8wIwZ0zBrmCocI2aliLm4kfbjbubeH7HR/pA6CkZzn1vpKaJIib6pQCa+jYL33Fo1M4
         OUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=nQ0pzz3DscSiLHgEor+6L44bgNqEqtnGsHdNflsCcws=;
        b=C12N1lc4GjLyP57v3y5iN0xea8umB5Eh716EuX8cD9F+VVZt/Q5O25lH2UST8MMmGS
         seMw4xPJiYcwcYybvT3Qc56GXeVCWLo/W2cxcF91LQQ+m4kh+M2sEkxUFTErEFf7e4bM
         uO3yyFmUol8iET/I8VtCNicjnwhL0iEo8CCaaDYEDt5hI3deht8Co9vAVQhVT633jQLH
         CbeLpS9H4BdR4pCnfzngH5a2XzFWhvV2xtixVZU/In/rxydIFHXAgoj450T5ZM0dn7vy
         bU7qqM2X9my5CXyhOsIobwwLlhE1bclUE8h46m1IQHUAENP2L0A17nBEYwa3skxLiVrN
         xu2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=P8TriEc7;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=P8TriEc7;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224U93SJEKZU1hvK0j0QS8SgrRc27icKqCD7gKDGkVKCoJdEP33Mr/R8YwKr1Eoxj/fRUdpMJscRqKTlXKN3lVI=
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CQoDqunAunwoVo7W=QXa=ET=eJ2s_j9j+3YgAR2EGgCg@mail.gmail.com>
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
 <CAAFQd5CQoDqunAunwoVo7W=QXa=ET=eJ2s_j9j+3YgAR2EGgCg@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 22 Feb 2018 08:30:35 -0500
Message-ID: <CAF6AEGvspue=27t3-n2hwuHh+1RNCrqiE6vLsh6fqR9CA=N8pg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls
 with runtime suppliers
To: Tomasz Figa <tfiga@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>,
	Linux PM <linux-pm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>,
	freedreno <freedreno@lists.freedesktop.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1593108057154142888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 3:13 AM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Fri, Feb 16, 2018 at 9:13 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>> On Fri, Feb 16, 2018 at 2:14 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>> On 15/02/18 04:17, Tomasz Figa wrote:
>>> [...]
>>>>>
>>>>> Could you elaborate on what kind of locking you are concerned about?
>>>>> As I explained before, the normally happening fast path would lock
>>>>> dev->power_lock only for the brief moment of incrementing the runtime
>>>>> PM usage counter.
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
>>> We now have no locking at all in the map path, and only a per-domain lock
>>> around TLB sync in unmap which is unfortunately necessary for correctness;
>>> the latter isn't too terrible, since in "serious" hardware it should only be
>>> serialising a few cpus serving the same device against each other (e.g. for
>>> multiple queues on a single NIC).
>>>
>>> Putting in a global lock which serialises *all* concurrent map and unmap
>>> calls for *all* unrelated devices makes things worse. Period. Even if the
>>> lock itself were held for the minimum possible time, i.e. trivially
>>> "spin_lock(&lock); spin_unlock(&lock)", the cost of repeatedly bouncing that
>>> one cache line around between 96 CPUs across two sockets is not negligible.
>>
>> Fair enough. Note that we're in a quite interesting situation now:
>>  a) We need to have runtime PM enabled on Qualcomm SoC to have power
>> properly managed,
>>  b) We need to have lock-free map/unmap on such distributed systems,
>>  c) If runtime PM is enabled, we need to call into runtime PM from any
>> code that does hardware accesses, otherwise the IOMMU API (and so DMA
>> API and then any V4L2 driver) becomes unusable.
>>
>> I can see one more way that could potentially let us have all the
>> three. How about enabling runtime PM only on selected implementations
>> (e.g. qcom,smmu) and then having all the runtime PM calls surrounded
>> with if (pm_runtime_enabled()), which is lockless?
>>
>
> Sorry for pinging, but any opinion on this kind of approach?
>

It is ok by me, for whatever that is worth

BR,
-R
