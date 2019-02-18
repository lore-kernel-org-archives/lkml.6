Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0391BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AE320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfBRUkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:40:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfBRUkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:40:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A61F1F569;
        Mon, 18 Feb 2019 20:40:16 +0000 (UTC)
Received: from [10.18.17.32] (dhcp-17-32.bos.redhat.com [10.18.17.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94F7C6012C;
        Mon, 18 Feb 2019 20:40:04 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        David Hildenbrand <david@redhat.com>
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
Organization: Red Hat Inc,
Message-ID: <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
Date:   Mon, 18 Feb 2019 15:40:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218152021-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UMcVK5Z2QsKtm5MVr3h6oIHlz37ZnlBiK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 18 Feb 2019 20:40:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UMcVK5Z2QsKtm5MVr3h6oIHlz37ZnlBiK
Content-Type: multipart/mixed; boundary="28h7ZhV0ptRONXaD1wpW2NJn8mHL0HbkY";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
 yang.zhang.wz@gmail.com, riel@surriel.com, dodgen@google.com,
 konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
 Alexander Duyck <alexander.duyck@gmail.com>,
 David Hildenbrand <david@redhat.com>
Message-ID: <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting

--28h7ZhV0ptRONXaD1wpW2NJn8mHL0HbkY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/18/19 3:31 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 18, 2019 at 09:04:57PM +0100, David Hildenbrand wrote:
>>>>>>> So I'm fine with a simple implementation but the interface needs =
to
>>>>>>> allow the hypervisor to process hints in parallel while guest is
>>>>>>> running.  We can then fix any issues on hypervisor without breaki=
ng
>>>>>>> guests.
>>>>>> Yes, I am fine with defining an interface that theoretically let's=
 us
>>>>>> change the implementation in the guest later.
>>>>>> I consider this even a
>>>>>> prerequisite. IMHO the interface shouldn't be different, it will b=
e
>>>>>> exactly the same.
>>>>>>
>>>>>> It is just "who" calls the batch freeing and waits for it. And as =
I
>>>>>> outlined here, doing it without additional threads at least avoids=
 us
>>>>>> for now having to think about dynamic data structures and that we =
can
>>>>>> sometimes not report "because the thread is still busy reporting o=
r
>>>>>> wasn't scheduled yet".
>>>>> Sorry I wasn't clear. I think we need ability to change the
>>>>> implementation in the *host* later. IOW don't rely on
>>>>> host being synchronous.
>>>>>
>>>>>
>>>> I actually misread it :) . In any way, there has to be a mechanism t=
o
>>>> synchronize.
>>>>
>>>> If we are going via a bare hypercall (like s390x, like what Alexande=
r
>>>> proposes), it is going to be a synchronous interface either way. Jus=
t a
>>>> bare hypercall, there will not really be any blocking on the guest s=
ide.
>>> It bothers me that we are now tied to interface being synchronous. We=

>>> won't be able to fix it if there's an issue as that would break guest=
s.
>> I assume with "fix it" you mean "fix kfree taking longer on every X ca=
ll"?
>>
>> Yes, as I initially wrote, this mimics s390x. That might be good (we
>> know it has been working for years) and bad (we are inheriting the sam=
e
>> problem class, if it exists). And being synchronous is part of the
>> approach for now.
> BTW on s390 are these hypercalls handled by Linux?
>
>> I tend to focus on the first part (we don't know anything besides it i=
s
>> working) while you focus on the second part (there could be a potentia=
l
>> problem). Having a real problem at hand would be great, then we would
>> know what exactly we actually have to fix. But read below.
> If we end up doing a hypercall per THP, maybe we could at least
> not block with interrupts disabled? Poll in guest until
> hypervisor reports its done?  That would already be an
> improvement IMHO. E.g. perf within guest will point you
> in the right direction and towards disabling hinting.
>
>
>>>> Via virtio, I guess it is waiting for a response to a requests, righ=
t?
>>> For the buffer to be used, yes. And it could mean putting some pages
>>> aside until hypervisor is done with them. Then you don't need timers =
or
>>> tricks like this, you can get an interrupt and start using the memory=
=2E
>> I am very open to such an approach as long as we can make it work and =
it
>> is not too complicated. (-> simple)
>>
>> This would mean for example
>>
>> 1. Collect entries to be reported per VCPU in a buffer. Say magic numb=
er
>> 256/512.
>>
>> 2. Once the buffer is full, do crazy "take pages out of the balloon
>> action" and report them to the hypervisor via virtio. Let the VCPU
>> continue. This will require some memory to store the request. Small
>> hickup for the VCPU to kick of the reporting to the hypervisor.
>>
>> 3. On interrupt/response, go over the response and put the pages back =
to
>> the buddy.
>>
>> (assuming that reporting a bulk of frees is better than reporting ever=
y
>> single free obviously)
>>
>> This could allow nice things like "when OOM gets trigger, see if pages=

>> are currently being reported and wait until they have been put back to=

>> the buddy, return "new pages available", so in a real "low on memory"
>> scenario, no OOM killer would get involved. This could address the iss=
ue
>> Wei had with reporting when low on memory.
>>
>> Is that something you have in mind?
> Yes that seems more future proof I think.
>
>> I assume we would have to allocate
>> memory when crafting the new requests. This is the only reason I tend =
to
>> prefer a synchronous interface for now. But if allocation is not a
>> problem, great.
> There are two main ways to avoid allocation:
> 1. do not add extra data on top of each chunk passed
If I am not wrong then this is close to what we have right now.
One issue I see right now is that I am polling while host is freeing the
memory.
In the next version I could tie the logic which returns pages to the
buddy and resets the per cpu array index value to 0 with the callback.
(i.e.., it happens once we receive an response from the host)
Other change which I am testing right now is to only capture 'MAX_ORDER
- 1' pages.
> 2. add extra data but pre-allocate buffers for it
>
>> --=20
>>
>> Thanks,
>>
>> David / dhildenb
--=20
Regards
Nitesh


--28h7ZhV0ptRONXaD1wpW2NJn8mHL0HbkY--

--UMcVK5Z2QsKtm5MVr3h6oIHlz37ZnlBiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxrGCAACgkQo4ZA3AYy
ozlIOg//bNpiejoWwJTH78xiDq+Cd8xOKxKI2UTfLKzeGsbfW7qSZfpQtegbAoOp
GetXyAIdO6770Um9xipYU/BXCzC3YMQ26mGWrpEGBGq9+WXRHAxQveud/vMoAWXv
E2yQWJWaBmIUFsmLHXy9g8O3OYUSQSQUwNvI/EIwDd0rA8iN8Jta5jNTyRs3UBv9
ceti+HmAHKSA7LaEAlc56l3GMSPNtwRr+Ij/wh6LWzZR+PVWQXoJVepGZRm4OrKI
kvopWBdD30cOuPit4RZY8tkKJaHgDvz2oGKbb+xTSQ8wjGb0AGEdhts7Tb/A7hfV
h5GsL7G5IZR+rQWhJpCvNstbF3rvhzgbcbQ/Q5P5j0qK4MB5Vplnr/OrrtmJX/0t
w8pGI8TuQv8LPcnEx3Kzoe/K8tdLERDNYaUxb4yCKq6wws1A5x7vk2HVO+gZzQ7s
9Vj1eOGYYWU9fDaOLMvpM96uS7fWNmiCWZqwOMQkgNziJFvXGsvQ7Ph9dKDEeL4x
ndSqGQFn7yVyqwkkhtukr+2z0k6mfxYMITOptsH3a6ilMqWbUG7UEV12y3eTbzya
TcHOqXZyauDuCqkE3oA9MPnHOjMF0Q+mad+fxR7FUeYUp4MP64T1CscBJDje8wTb
OKV2gfqqxU9+eQBkE184rZ6/GzQymYKtKimlpU/Y8pqn3sb8ij0=
=jGs3
-----END PGP SIGNATURE-----

--UMcVK5Z2QsKtm5MVr3h6oIHlz37ZnlBiK--
