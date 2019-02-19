Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B90C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348F321773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfBSOR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:17:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfBSOR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:17:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5DF078EA8;
        Tue, 19 Feb 2019 14:17:57 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A5F05D6AA;
        Tue, 19 Feb 2019 14:17:48 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org>
 <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
 <20190218140947-mutt-send-email-mst@kernel.org>
 <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org>
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
 <e2273f4a-dfe9-45fe-d924-598d3e8b38b5@redhat.com>
 <1abac6db-5e1a-2889-9831-707c2b78b0f3@redhat.com>
Organization: Red Hat Inc,
Message-ID: <0d7ff493-71f3-8707-8400-b51f1ce1a2bd@redhat.com>
Date:   Tue, 19 Feb 2019 09:17:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1abac6db-5e1a-2889-9831-707c2b78b0f3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3HZU9lzV4Vonae2VwAXT19pUMy08vmUVV"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 14:17:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3HZU9lzV4Vonae2VwAXT19pUMy08vmUVV
Content-Type: multipart/mixed; boundary="rU3Jwhu7xXVI3qoBGyqtM803SAyIZb4Or";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 yang.zhang.wz@gmail.com, riel@surriel.com, dodgen@google.com,
 konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
 Alexander Duyck <alexander.duyck@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <0d7ff493-71f3-8707-8400-b51f1ce1a2bd@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting

--rU3Jwhu7xXVI3qoBGyqtM803SAyIZb4Or
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/19/19 8:03 AM, David Hildenbrand wrote:
>>>>> There are two main ways to avoid allocation:
>>>>> 1. do not add extra data on top of each chunk passed
>>>> If I am not wrong then this is close to what we have right now.
>>> Yes, minus the kthread(s) and eventually with some sort of memory
>>> allocation for the request. Once you're asynchronous via a notificati=
on
>>> mechanisnm, there is no real need for a thread anymore, hopefully.
>> Whether we should go with kthread or without it, I would like to do so=
me
>> performance comparison before commenting on this.
>>>> One issue I see right now is that I am polling while host is freeing=
 the
>>>> memory.
>>>> In the next version I could tie the logic which returns pages to the=

>>>> buddy and resets the per cpu array index value to 0 with the callbac=
k.
>>>> (i.e.., it happens once we receive an response from the host)
>>> The question is, what happens when freeing pages and the array is not=

>>> ready to be reused yet. In that case, you want to somehow continue
>>> freeing pages without busy waiting or eventually not reporting pages.=

>> This is what happens right now.
>> Having kthread or not should not effect this behavior.
>> When the array is full the current approach simply skips collecting th=
e
>> free pages.
> Well, it somehow does affect your implementation. If you have a kthread=

> you always have to synchronize against the VCPU: "Is the pcpu array
> ready to be used again".
>
> Once you do it asynchronously from your VCPU without another thread
> being involved, such synchronization is not required. Simply prepare a
> request and send it off. Reuse the pcpu array instantly. At least that'=
s
> the theory :)
>
> If you have a guest bulk freeing a lot of memory, I guess temporarily
> dropping free page hints could be counter-productive. It really depends=

> on how fast the thread gets scheduled and how long the hinting process
> takes. Having another thread involved might add a lot to that latency t=
o
> that formula. We'll have to measure, but my gut feeling is that once we=

> do stuff asynchronously, there is no need for a thread anymore.
This is true.
>
>>> The callback should put the pages back to the buddy and free the requ=
est
>>> eventually to have a fully asynchronous mechanism.
>>>
>>>> Other change which I am testing right now is to only capture 'MAX_OR=
DER
>>> I am not sure if this is an arbitrary number we came up with here. We=

>>> should really play with different orders to find a hot spot. I wouldn=
't
>>> consider this high priority, though. Getting the whole concept right =
to
>>> be able to deal with any magic number we come up should be the ultima=
te
>>> goal. (stuff that only works with huge pages I consider not future
>>> proof, especially regarding fragmented guests which can happen easily=
)
>> Its quite possible that when we are only capturing MAX_ORDER - 1 and r=
un
>> a specific workload we don't get any memory back until we re-run the
>> program and buddy finally starts merging of pages of order MAX_ORDER -=
1.
>> This is why I think we may make this configurable from compile time an=
d
>> keep capturing MAX_ORDER - 1 so that we don't end up breaking anything=
=2E
> Eventually pages will never get merged. Assume you have 1 page of a
> MAX_ORDER - 1 chunk still allocated somewhere (e.g. !movable via
> kmalloc). You skip reporting that chunk completely. Roughly 1mb/2mb/4mb=

> wasted (depending on the arch). This stuff can sum up.

After the discussion, here are the changes on which I am planning to
work next:
1. Get rid of the kthread and dynamically allocate a per-cpu array to
hold the
isolated pages. As soon as the initial per-cpu array is completely
scanned, release it
so that we don't end up blocking anything.
2. Continue capturing MAX_ORDER - 1, for now. Reduce the initial per-cpu
array size to 256
for now. As we are doing asynchronous reporting we should be fine with a
lower size array.
3. As soon as the host responds, release the pages back to the buddy
from the callback and free the request.

Benefits wrt current implementation:
1. We will not eat up performance due to kernel thread.
2. We will still be doing reporting asynchronously=3D> no blocking.
3. Hopefully, we will be able to free more memory.
--=20
Regards
Nitesh


--rU3Jwhu7xXVI3qoBGyqtM803SAyIZb4Or--

--3HZU9lzV4Vonae2VwAXT19pUMy08vmUVV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxsEAgACgkQo4ZA3AYy
ozku/w//dsQ6QaQ24f3Mvf0m5XtuD/yqX18BTHCEjxyRfAvVH+OHHayHcOSbUpJq
ml0CguvFGeMkL7eTRON+m7w7RaOC2vpK14XnmCfoRP7lG1zUkUDOJFo9+YZtyB/K
uW6yf7UE4H+yGZRzEHQSXR7bb7S6F289wVHSKJAEHUrrd+5Kiis/HZEQAVF6UF6g
R75N1oSAhNChshzPIEKLcmLLfdb7HYG8J7nlq4TumS33a1jPRlH7tMftrA8wjICk
+xf4WuyOL9m+FarWi8p27gYp1D0lVSiKTIvhMIecOfe2dhaw2BhpD5Hq056L5Cij
V8ooaZPPizdOK/NXrDK18dZ1cjpj3jg4C0Yya20bkcvxPaAcYY3vRIFncWfgwzqD
Jyc05tG4j23L7DSz0VbIbqkshuIHvCepOf345xA+r7iOW8k3lqaKKcpB9ocdSbOh
IaP/teIiRuR6WaH57FeSIttGYM0kAZOZdBWXut10lklBimGIo7yePD5lfQ1TC2bd
yDx23bnV91js7/wtcqphKGzf+aQY/mitHDVUPCi+kVrhwYkzE9wEFpbL9n6HvP4W
nW9tTUdWMYymydeF4rJcdx3avMQoUjTRevCjsxmK8qGa0Fi/eoer0gsTWPIT8B6u
Pd853UpHnBMbBYUzlcTxY/tsLGFIqVbF4xD4kCVacTy/uAUfjvQ=
=CvYu
-----END PGP SIGNATURE-----

--3HZU9lzV4Vonae2VwAXT19pUMy08vmUVV--
