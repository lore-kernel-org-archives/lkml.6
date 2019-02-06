Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BA7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCD820823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfBFSTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:19:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBFSTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:19:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76E012D4B6E;
        Wed,  6 Feb 2019 18:19:20 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 047A01048117;
        Wed,  6 Feb 2019 18:19:10 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
        dhildenb@redhat.com, aarcange@redhat.com
Subject: Re: [RFC][Patch v8 5/7] virtio: Enables to add a single descriptor to
 the host
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-6-nitesh@redhat.com>
 <20190205154545-mutt-send-email-mst@kernel.org>
 <26a36489-2289-f970-3362-60547b268a76@redhat.com>
 <20190206130201-mutt-send-email-mst@kernel.org>
Organization: Red Hat Inc,
Message-ID: <85a799bf-93f1-3b4b-c4a0-db7af2aef292@redhat.com>
Date:   Wed, 6 Feb 2019 13:19:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206130201-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q6sZGAJ51pl5TzrWDpkYMI19Gl7KcJ3h8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 06 Feb 2019 18:19:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q6sZGAJ51pl5TzrWDpkYMI19Gl7KcJ3h8
Content-Type: multipart/mixed; boundary="O2qf5b9opplM6CBL1D4fEoPN7vjh41AiG";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 yang.zhang.wz@gmail.com, riel@surriel.com, david@redhat.com,
 dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
 aarcange@redhat.com
Message-ID: <85a799bf-93f1-3b4b-c4a0-db7af2aef292@redhat.com>
Subject: Re: [RFC][Patch v8 5/7] virtio: Enables to add a single descriptor to
 the host

--O2qf5b9opplM6CBL1D4fEoPN7vjh41AiG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 1:03 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 06, 2019 at 07:56:37AM -0500, Nitesh Narayan Lal wrote:
>> On 2/5/19 3:49 PM, Michael S. Tsirkin wrote:
>>> On Mon, Feb 04, 2019 at 03:18:52PM -0500, Nitesh Narayan Lal wrote:
>>>> This patch enables the caller to expose a single buffers to the
>>>> other end using vring descriptor. It also allows the caller to
>>>> perform this action in synchornous manner by using virtqueue_kick_sy=
nc.
>>>>
>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>>> I am not sure why do we need this API. Polling in guest
>>> until host runs isn't great either since these
>>> might be running on the same host CPU.
>> True.
>>
>> However, my understanding is that the existing API such as
>> virtqueue_add_outbuf() requires an allocation which will be problemati=
c
>> for my implementation.
> Not with a single s/g entry, no.
Didn't know this. I will re-check.
>
>> Although I am not blocking the allocation path during normal Linux
>> kernel usage as even if one of the zone is locked the other zone could=

>> be used to get free pages.
>
> I am a bit confused about locking,=20
My bad, I think I created the confusion.
> I was under the impression
> that you are not calling virtio under a zone lock.

Yeap. Your understanding is correct.
I will re-visit this and correct it in the next version.
> FYI doing that was nacked by Linus.
>
>
>> But during the initial boot time (device initialization), in certain
>> situations the allocation can only come from a single zone, acquiring =
a
>> lock on it may result in a deadlock situation.
>>
>>>
>>>
>>>> ---
>>>>  drivers/virtio/virtio_ring.c | 72 +++++++++++++++++++++++++++++++++=
+++
>>>>  include/linux/virtio.h       |  4 ++
>>>>  2 files changed, 76 insertions(+)
>>>>
>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ri=
ng.c
>>>> index cd7e755484e3..93c161ac6a28 100644
>>>> --- a/drivers/virtio/virtio_ring.c
>>>> +++ b/drivers/virtio/virtio_ring.c
>>>> @@ -1695,6 +1695,52 @@ static inline int virtqueue_add(struct virtqu=
eue *_vq,
>>>>  					out_sgs, in_sgs, data, ctx, gfp);
>>>>  }
>>>> =20
>>>> +/**
>>>> + * virtqueue_add_desc - add a buffer to a chain using a vring desc
>>>> + * @vq: the struct virtqueue we're talking about.
>>>> + * @addr: address of the buffer to add.
>>>> + * @len: length of the buffer.
>>>> + * @in: set if the buffer is for the device to write.
>>>> + *
>>>> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
>>>> + */
>>>> +int virtqueue_add_desc(struct virtqueue *_vq, u64 addr, u32 len, in=
t in)
>>>> +{
>>>> +	struct vring_virtqueue *vq =3D to_vvq(_vq);
>>>> +	struct vring_desc *desc =3D vq->split.vring.desc;
>>>> +	u16 flags =3D in ? VRING_DESC_F_WRITE : 0;
>>>> +	unsigned int i;
>>>> +	void *data =3D (void *)addr;
>>>> +	int avail_idx;
>>>> +
>>>> +	/* Sanity check */
>>>> +	if (!_vq)
>>>> +		return -EINVAL;
>>>> +
>>>> +	START_USE(vq);
>>>> +	if (unlikely(vq->broken)) {
>>>> +		END_USE(vq);
>>>> +		return -EIO;
>>>> +	}
>>>> +
>>>> +	i =3D vq->free_head;
>>>> +	flags &=3D ~VRING_DESC_F_NEXT;
>>>> +	desc[i].flags =3D cpu_to_virtio16(_vq->vdev, flags);
>>>> +	desc[i].addr =3D cpu_to_virtio64(_vq->vdev, addr);
>>>> +	desc[i].len =3D cpu_to_virtio32(_vq->vdev, len);
>>>> +
>>>> +	vq->vq.num_free--;
>>>> +	vq->free_head =3D virtio16_to_cpu(_vq->vdev, desc[i].next);
>>>> +	vq->split.desc_state[i].data =3D data;
>>>> +	vq->split.avail_idx_shadow =3D 1;
>>>> +	avail_idx =3D vq->split.avail_idx_shadow;
>>>> +	vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev, avail_id=
x);
>>>> +	vq->num_added =3D 1;
>>>> +	END_USE(vq);
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(virtqueue_add_desc);
>>>> +
>>>>  /**
>>>>   * virtqueue_add_sgs - expose buffers to other end
>>>>   * @vq: the struct virtqueue we're talking about.
>>>> @@ -1842,6 +1888,32 @@ bool virtqueue_notify(struct virtqueue *_vq)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(virtqueue_notify);
>>>> =20
>>>> +/**
>>>> + * virtqueue_kick_sync - update after add_buf and busy wait till up=
date is done
>>>> + * @vq: the struct virtqueue
>>>> + *
>>>> + * After one or more virtqueue_add_* calls, invoke this to kick
>>>> + * the other side. Busy wait till the other side is done with the u=
pdate.
>>>> + *
>>>> + * Caller must ensure we don't call this with other virtqueue
>>>> + * operations at the same time (except where noted).
>>>> + *
>>>> + * Returns false if kick failed, otherwise true.
>>>> + */
>>>> +bool virtqueue_kick_sync(struct virtqueue *vq)
>>>> +{
>>>> +	u32 len;
>>>> +
>>>> +	if (likely(virtqueue_kick(vq))) {
>>>> +		while (!virtqueue_get_buf(vq, &len) &&
>>>> +		       !virtqueue_is_broken(vq))
>>>> +			cpu_relax();
>>>> +		return true;
>>>> +	}
>>>> +	return false;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(virtqueue_kick_sync);
>>>> +
>>>>  /**
>>>>   * virtqueue_kick - update after add_buf
>>>>   * @vq: the struct virtqueue
>>>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>>>> index fa1b5da2804e..58943a3a0e8d 100644
>>>> --- a/include/linux/virtio.h
>>>> +++ b/include/linux/virtio.h
>>>> @@ -57,6 +57,10 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>>>>  		      unsigned int in_sgs,
>>>>  		      void *data,
>>>>  		      gfp_t gfp);
>>>> +/* A desc with this init id is treated as an invalid desc */
>>>> +int virtqueue_add_desc(struct virtqueue *_vq, u64 addr, u32 len, in=
t in);
>>>> +
>>>> +bool virtqueue_kick_sync(struct virtqueue *vq);
>>>> =20
>>>>  bool virtqueue_kick(struct virtqueue *vq);
>>>> =20
>>>> --=20
>>>> 2.17.2
>> --=20
>> Regards
>> Nitesh
>>
>
>
--=20
Regards
Nitesh


--O2qf5b9opplM6CBL1D4fEoPN7vjh41AiG--

--Q6sZGAJ51pl5TzrWDpkYMI19Gl7KcJ3h8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxbJR0ACgkQo4ZA3AYy
ozlk/w//QOrzz18+1WBn/AxrF6Zmt/PTMWVeiFVRVs1G9V4n/JTvT4Q/ZoEBtwhs
K196jOD5uUtoidZr1xTFiuG9RDcVbY8IEHo+qC6dLEGl6qvtpyEUpach0lwothsF
/PmuuDhOCMp3b4uzgkub12dY1i75X4rho3cxBW5Btysik28r6o06SsWb+pf0/S3I
GKXGKwlusX5ZGpJAu8992QgnL09DqBfVLWtq2zsOUBd9Ls80+DcpDSQ7ss/G7ZNh
bfM38r1jPdNJrMBxSYo1rr2rceg0L0E8qfCjGvVebuJQeQuj02xjWuWBErfKSGEL
mvfuXuIx3px3UuDY/dkTIcLvy/hjbNhxJdbM8pej1y/N9gbG+MNeBl1HfXIOkn5y
Hv6vpK9Xz1iY9UxXUrc3VN6UdP0q8xM5befm358SRQZbJ4onCTNrfNkWmhECiI0Z
z3yyO5JXXRVqpGdAhjYAQePMf18svrDZuV4y/TW0fGx6bN11rBgvSFJ9L8QcyyGH
SYDyr56obc+jQ8XIhgwcKvbn84nL+k1k3TO9PPQvCOg6kpzfZauCHm6yi5zwlSuP
vMAPboZleCvK0AObrWThvImuUriblesNC1RYSU95DVise0NUy5vlbZOuLOOmOSHP
nepsTB2g94XdlMbK+Y7wKsOaHuMjWJn0FZk+OipCHI8a+FqgLiA=
=wtiu
-----END PGP SIGNATURE-----

--Q6sZGAJ51pl5TzrWDpkYMI19Gl7KcJ3h8--
