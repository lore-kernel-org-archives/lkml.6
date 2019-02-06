Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C026C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3322186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfBFOF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:05:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfBFOF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:05:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9277CC05FF87;
        Wed,  6 Feb 2019 14:05:57 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF0D184BC7;
        Wed,  6 Feb 2019 14:05:22 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     Luiz Capitulino <lcapitulino@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com,
        riel@surriel.com, david@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com
Subject: Re: [RFC][Patch v8 5/7] virtio: Enables to add a single descriptor to
 the host
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-6-nitesh@redhat.com>
 <20190205154545-mutt-send-email-mst@kernel.org>
 <26a36489-2289-f970-3362-60547b268a76@redhat.com>
 <20190206081533.336110a0@doriath>
 <1d478678-0a14-a144-2efc-10ff13cf1a5a@redhat.com>
 <20190206082942.29f52fe9@doriath>
Organization: Red Hat Inc,
Message-ID: <05031929-72b2-9080-9ee7-ac930ae3b83c@redhat.com>
Date:   Wed, 6 Feb 2019 09:05:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206082942.29f52fe9@doriath>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ziyT34O3M5k8Sijc1K1Ey2paXRmdFxd2r"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 06 Feb 2019 14:05:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ziyT34O3M5k8Sijc1K1Ey2paXRmdFxd2r
Content-Type: multipart/mixed; boundary="ugpAWSYRAogVFGB4XaOOI3UGm1Dq1ANpE";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, pagupta@redhat.com,
 wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
 david@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
 dhildenb@redhat.com, aarcange@redhat.com
Message-ID: <05031929-72b2-9080-9ee7-ac930ae3b83c@redhat.com>
Subject: Re: [RFC][Patch v8 5/7] virtio: Enables to add a single descriptor to
 the host

--ugpAWSYRAogVFGB4XaOOI3UGm1Dq1ANpE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 8:29 AM, Luiz Capitulino wrote:
> On Wed, 6 Feb 2019 08:24:14 -0500
> Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
>> On 2/6/19 8:15 AM, Luiz Capitulino wrote:
>>> On Wed, 6 Feb 2019 07:56:37 -0500
>>> Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>>> =20
>>>> On 2/5/19 3:49 PM, Michael S. Tsirkin wrote: =20
>>>>> On Mon, Feb 04, 2019 at 03:18:52PM -0500, Nitesh Narayan Lal wrote:=
   =20
>>>>>> This patch enables the caller to expose a single buffers to the
>>>>>> other end using vring descriptor. It also allows the caller to
>>>>>> perform this action in synchornous manner by using virtqueue_kick_=
sync.
>>>>>>
>>>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>   =20
>>>>> I am not sure why do we need this API. Polling in guest
>>>>> until host runs isn't great either since these
>>>>> might be running on the same host CPU.   =20
>>>> True.
>>>>
>>>> However, my understanding is that the existing API such as
>>>> virtqueue_add_outbuf() requires an allocation which will be problema=
tic
>>>> for my implementation.
>>>> Although I am not blocking the allocation path during normal Linux
>>>> kernel usage as even if one of the zone is locked the other zone cou=
ld
>>>> be used to get free pages.
>>>> But during the initial boot time (device initialization), in certain=

>>>> situations the allocation can only come from a single zone, acquirin=
g a
>>>> lock on it may result in a deadlock situation. =20
>>> I might be wrong, but if I remember correctly, this was true for
>>> your previous implementation where you'd report page hinting down
>>> from arch_free_page() so you couldn't allocate memory. But this
>>> is not the case anymore. =20
>> With the earlier implementation, the allocation was blocked all the ti=
me
>> when freeing was going on.
>> With this implementation, the allocation is not blocked during normal
>> Linux kernel usage (after Linux boots up). For example, on a 64 bit
>> machine, if the Normal zone is locked and there is an allocation reque=
st
>> then it can be served by DMA32 zone as well. (This is not the case
>> during device initialization time)
>> Feel free to correct me if I am wrong.
> That's what I meant :) I have an impression that your virtio API
> was necessary because of your earlier design. I guess it's not needed
> anymore as Michael says.
I will re-visit this change before my next posting.
>>> =20
>>>>>   =20
>>>>>> ---
>>>>>>  drivers/virtio/virtio_ring.c | 72 +++++++++++++++++++++++++++++++=
+++++
>>>>>>  include/linux/virtio.h       |  4 ++
>>>>>>  2 files changed, 76 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_=
ring.c
>>>>>> index cd7e755484e3..93c161ac6a28 100644
>>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>>> @@ -1695,6 +1695,52 @@ static inline int virtqueue_add(struct virt=
queue *_vq,
>>>>>>  					out_sgs, in_sgs, data, ctx, gfp);
>>>>>>  }
>>>>>> =20
>>>>>> +/**
>>>>>> + * virtqueue_add_desc - add a buffer to a chain using a vring des=
c
>>>>>> + * @vq: the struct virtqueue we're talking about.
>>>>>> + * @addr: address of the buffer to add.
>>>>>> + * @len: length of the buffer.
>>>>>> + * @in: set if the buffer is for the device to write.
>>>>>> + *
>>>>>> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
>>>>>> + */
>>>>>> +int virtqueue_add_desc(struct virtqueue *_vq, u64 addr, u32 len, =
int in)
>>>>>> +{
>>>>>> +	struct vring_virtqueue *vq =3D to_vvq(_vq);
>>>>>> +	struct vring_desc *desc =3D vq->split.vring.desc;
>>>>>> +	u16 flags =3D in ? VRING_DESC_F_WRITE : 0;
>>>>>> +	unsigned int i;
>>>>>> +	void *data =3D (void *)addr;
>>>>>> +	int avail_idx;
>>>>>> +
>>>>>> +	/* Sanity check */
>>>>>> +	if (!_vq)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	START_USE(vq);
>>>>>> +	if (unlikely(vq->broken)) {
>>>>>> +		END_USE(vq);
>>>>>> +		return -EIO;
>>>>>> +	}
>>>>>> +
>>>>>> +	i =3D vq->free_head;
>>>>>> +	flags &=3D ~VRING_DESC_F_NEXT;
>>>>>> +	desc[i].flags =3D cpu_to_virtio16(_vq->vdev, flags);
>>>>>> +	desc[i].addr =3D cpu_to_virtio64(_vq->vdev, addr);
>>>>>> +	desc[i].len =3D cpu_to_virtio32(_vq->vdev, len);
>>>>>> +
>>>>>> +	vq->vq.num_free--;
>>>>>> +	vq->free_head =3D virtio16_to_cpu(_vq->vdev, desc[i].next);
>>>>>> +	vq->split.desc_state[i].data =3D data;
>>>>>> +	vq->split.avail_idx_shadow =3D 1;
>>>>>> +	avail_idx =3D vq->split.avail_idx_shadow;
>>>>>> +	vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev, avail_=
idx);
>>>>>> +	vq->num_added =3D 1;
>>>>>> +	END_USE(vq);
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(virtqueue_add_desc);
>>>>>> +
>>>>>>  /**
>>>>>>   * virtqueue_add_sgs - expose buffers to other end
>>>>>>   * @vq: the struct virtqueue we're talking about.
>>>>>> @@ -1842,6 +1888,32 @@ bool virtqueue_notify(struct virtqueue *_vq=
)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_GPL(virtqueue_notify);
>>>>>> =20
>>>>>> +/**
>>>>>> + * virtqueue_kick_sync - update after add_buf and busy wait till =
update is done
>>>>>> + * @vq: the struct virtqueue
>>>>>> + *
>>>>>> + * After one or more virtqueue_add_* calls, invoke this to kick
>>>>>> + * the other side. Busy wait till the other side is done with the=
 update.
>>>>>> + *
>>>>>> + * Caller must ensure we don't call this with other virtqueue
>>>>>> + * operations at the same time (except where noted).
>>>>>> + *
>>>>>> + * Returns false if kick failed, otherwise true.
>>>>>> + */
>>>>>> +bool virtqueue_kick_sync(struct virtqueue *vq)
>>>>>> +{
>>>>>> +	u32 len;
>>>>>> +
>>>>>> +	if (likely(virtqueue_kick(vq))) {
>>>>>> +		while (!virtqueue_get_buf(vq, &len) &&
>>>>>> +		       !virtqueue_is_broken(vq))
>>>>>> +			cpu_relax();
>>>>>> +		return true;
>>>>>> +	}
>>>>>> +	return false;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(virtqueue_kick_sync);
>>>>>> +
>>>>>>  /**
>>>>>>   * virtqueue_kick - update after add_buf
>>>>>>   * @vq: the struct virtqueue
>>>>>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>>>>>> index fa1b5da2804e..58943a3a0e8d 100644
>>>>>> --- a/include/linux/virtio.h
>>>>>> +++ b/include/linux/virtio.h
>>>>>> @@ -57,6 +57,10 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>>>>>>  		      unsigned int in_sgs,
>>>>>>  		      void *data,
>>>>>>  		      gfp_t gfp);
>>>>>> +/* A desc with this init id is treated as an invalid desc */
>>>>>> +int virtqueue_add_desc(struct virtqueue *_vq, u64 addr, u32 len, =
int in);
>>>>>> +
>>>>>> +bool virtqueue_kick_sync(struct virtqueue *vq);
>>>>>> =20
>>>>>>  bool virtqueue_kick(struct virtqueue *vq);
>>>>>> =20
>>>>>> --=20
>>>>>> 2.17.2   =20
--=20
Regards
Nitesh


--ugpAWSYRAogVFGB4XaOOI3UGm1Dq1ANpE--

--ziyT34O3M5k8Sijc1K1Ey2paXRmdFxd2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxa6aEACgkQo4ZA3AYy
ozljDhAAk4NyEX6Ijk3Cvw7ZofeD2dfKM+78fNZ/1znIKVdasYVRDca21SHxsCaQ
95UH6VlSQGqyJdKacF/jp1jMnrqXHztPsR/+60a750tJvoyicuoLuCClTlEetzS9
GfuGKxJKIz0uS3AJihiF5ZaeHTcgMRF7zBg5TPMfHx5iHG7KEapBcIfXMZx2lvP2
yMO1GTyQP2QjUlRkmS/kG4Q9AuE62oDb5aeGfRgTBBHuTadAFxg4Ejq3rIK70vHi
JzNy0ZC+lR3Hx7rqD3zsGo4U5Bbw4w35EVoLPjkxTMmr4ZO7MzdZ6mdyQs1oUigs
ePTcRc3x36KNNCbiX2wuXcEeknyAN9mNNnG8O+4jbHD11K939KGzmKLAE1Grt0rT
pEgep8GQ9YM43+hYqSyh3EvL4vYRsOJxlzYe8jQtFcP7Ei/H8UBSDvCxzwgjleLQ
AjZ3t3EgRj4S4eACJnq/f4FQL3Qtpt/3N+BER55esgdpKGuI1RoMA1M0b4cSq6q6
qOeHOXGBb14KyO0/92P4qKTl1z1AyHGdBJXCa2vfYu17dD3HWCXOQkg9oP/NFhqz
Ud5iwmg36kCD6Wl/0U7ZUxXA1ZpNTupFEpVBSKkA4iLdglkfmFBll7E6IN11jurY
lEFe1JSULT2P3Jyf2Ib4E1jfzFmrpMplziT0RXoyFysJJB4qdK0=
=VsJL
-----END PGP SIGNATURE-----

--ziyT34O3M5k8Sijc1K1Ey2paXRmdFxd2r--
