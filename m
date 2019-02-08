Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DFBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8182081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfBHSWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:22:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfBHSWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:22:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C794C05B03C;
        Fri,  8 Feb 2019 18:22:36 +0000 (UTC)
Received: from [10.40.206.40] (unknown [10.40.206.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5DD3383F;
        Fri,  8 Feb 2019 18:22:23 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, david@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 2/7] KVM: Enabling guest free page hinting via
 static key
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-3-nitesh@redhat.com>
 <CAKgT0UfqtRigPwUaN=H_MrLgeXErkeOcpuPy6ys6A3UCLnMBPg@mail.gmail.com>
Organization: Red Hat Inc,
Message-ID: <eac2187a-e6e3-878a-7acc-f9963a61e6dc@redhat.com>
Date:   Fri, 8 Feb 2019 13:22:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfqtRigPwUaN=H_MrLgeXErkeOcpuPy6ys6A3UCLnMBPg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tOyS8UQhUdYqvCCSfi3g2hDllfG3CJmJ8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 08 Feb 2019 18:22:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tOyS8UQhUdYqvCCSfi3g2hDllfG3CJmJ8
Content-Type: multipart/mixed; boundary="2Arqim0FweqXqCGWylmvZOpjMC27hDPHj";
 protected-headers="v1"
From: Nitesh Narayan Lal <nitesh@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 pagupta@redhat.com, wei.w.wang@intel.com,
 Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>,
 david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com,
 Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <eac2187a-e6e3-878a-7acc-f9963a61e6dc@redhat.com>
Subject: Re: [RFC][Patch v8 2/7] KVM: Enabling guest free page hinting via
 static key

--2Arqim0FweqXqCGWylmvZOpjMC27hDPHj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/8/19 1:07 PM, Alexander Duyck wrote:
> On Mon, Feb 4, 2019 at 2:11 PM Nitesh Narayan Lal <nitesh@redhat.com> w=
rote:
>> This patch enables the guest free page hinting support
>> to enable or disable based on the STATIC key which
>> could be set via sysctl.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
>>  include/linux/gfp.h          |  2 ++
>>  include/linux/page_hinting.h |  5 +++++
>>  kernel/sysctl.c              |  9 +++++++++
>>  virt/kvm/page_hinting.c      | 23 +++++++++++++++++++++++
>>  4 files changed, 39 insertions(+)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index e596527284ba..8389219a076a 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -461,6 +461,8 @@ static inline struct zonelist *node_zonelist(int n=
id, gfp_t flags)
>>  #define HAVE_ARCH_FREE_PAGE
>>  static inline void arch_free_page(struct page *page, int order)
>>  {
>> +       if (!static_branch_unlikely(&guest_page_hinting_key))
>> +               return;
>>         guest_free_page(page, order);
>>  }
>>  #endif
>> diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting=
=2Eh
>> index b54f7428f348..9bdcf63e1306 100644
>> --- a/include/linux/page_hinting.h
>> +++ b/include/linux/page_hinting.h
>> @@ -14,4 +14,9 @@ struct hypervisor_pages {
>>         unsigned int order;
>>  };
>>
>> +extern int guest_page_hinting_flag;
>> +extern struct static_key_false guest_page_hinting_key;
>> +
>> +int guest_page_hinting_sysctl(struct ctl_table *table, int write,
>> +                             void __user *buffer, size_t *lenp, loff_=
t *ppos);
>>  void guest_free_page(struct page *page, int order);
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index ba4d9e85feb8..5d53629c9bfb 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -1690,6 +1690,15 @@ static struct ctl_table vm_table[] =3D {
>>                 .extra1         =3D (void *)&mmap_rnd_compat_bits_min,=

>>                 .extra2         =3D (void *)&mmap_rnd_compat_bits_max,=

>>         },
>> +#endif
>> +#ifdef CONFIG_KVM_FREE_PAGE_HINTING
>> +       {
>> +               .procname       =3D "guest-page-hinting",
>> +               .data           =3D &guest_page_hinting_flag,
>> +               .maxlen         =3D sizeof(guest_page_hinting_flag),
>> +               .mode           =3D 0644,
>> +               .proc_handler   =3D guest_page_hinting_sysctl,
>> +       },
>>  #endif
>>         { }
>>  };
> Since you are adding a new sysctl shouldn't you also be updating
> Documentation/sysctl/vm.txt?
Indeed I will be doing that.
However, I would first like to close other major issues with the design.
>
>> diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
>> index 818bd6b84e0c..4a34ea8db0c8 100644
>> --- a/virt/kvm/page_hinting.c
>> +++ b/virt/kvm/page_hinting.c
>> @@ -1,6 +1,7 @@
>>  #include <linux/gfp.h>
>>  #include <linux/mm.h>
>>  #include <linux/kernel.h>
>> +#include <linux/kvm_host.h>
>>
>>  /*
>>   * struct kvm_free_pages - Tracks the pages which are freed by the gu=
est.
>> @@ -31,6 +32,28 @@ struct page_hinting {
>>
>>  DEFINE_PER_CPU(struct page_hinting, hinting_obj);
>>
>> +struct static_key_false guest_page_hinting_key  =3D STATIC_KEY_FALSE_=
INIT;
>> +EXPORT_SYMBOL(guest_page_hinting_key);
>> +static DEFINE_MUTEX(hinting_mutex);
>> +int guest_page_hinting_flag;
>> +EXPORT_SYMBOL(guest_page_hinting_flag);
> I'm not entirely sure this flag makes sense to me. What is to prevent
> someone from turning this on when there is no means of actually using
> the hints. I understand right now that guest_free_page doesn't
> actually do anything, but when it does I would assume it has to
> interact with a device. If that device is not present would it still
> make sense for us to be generating hints?
Fair point, I will address this issue.
>
>> +
>> +int guest_page_hinting_sysctl(struct ctl_table *table, int write,
>> +                             void __user *buffer, size_t *lenp,
>> +                             loff_t *ppos)
>> +{
>> +       int ret;
>> +
>> +       mutex_lock(&hinting_mutex);
>> +       ret =3D proc_dointvec(table, write, buffer, lenp, ppos);
>> +       if (guest_page_hinting_flag)
>> +               static_key_enable(&guest_page_hinting_key.key);
>> +       else
>> +               static_key_disable(&guest_page_hinting_key.key);
>> +       mutex_unlock(&hinting_mutex);
>> +       return ret;
>> +}
>> +
>>  void guest_free_page(struct page *page, int order)
>>  {
>>  }
>> --
>> 2.17.2
>>
--=20
Regards
Nitesh


--2Arqim0FweqXqCGWylmvZOpjMC27hDPHj--

--tOyS8UQhUdYqvCCSfi3g2hDllfG3CJmJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAlxdyNwACgkQo4ZA3AYy
ozlFwQ//cObQErrqLHor8mjiBfRaY95rCaA3wQ0TdKFMk+eXIhHeRuCgNLynVJKY
Pyk/BgCLWNsE7YN6BiTCdWr1151r7vPMeq7jWb3F+Cm9guPE0LTluoQcINrQpHd7
O6PYI1iHa2oliZVu4PmtHKdcNsi+BRkjaEJwI8InEi+8OuVc//RiVfQ9+DtRQK03
oZAaZnLb807GZkcTnPdLCp0kEr9Q/ZqpVUgR+eW3kYaFEk8keWA4cn1VF5ZNlYov
75wIOKRN4LtXWkQLNfrl9xKJd2gH1zSXPqL5a+71imM1pmwgkFo+UVgsD14Y6hL5
yQ37f24wrtpAQeOR1nc+Pr4iJ0jemWOBYcLBJS0T7SngNzR9MGMJlFzN3kxgm/7c
lxfJMob9TFv7jqoJQpODilJbEa1vDKT2Gi7YoQtVFSpNnzwY4WPRZYWMU7EMn3ho
sL3+KagwxEJ1hAxJI5+Wvqn6BSJ779r7eRDbrXmUgqhl4xIwh7kIOHQ9EvK7wTXw
87RFq0vfwYfv/13skHqEcytLzWp145OwqNCU2ndaOV7yUHVnBtrFNw6wG70Af05T
POji67tuo9Nf8qd7lZNm+xrF65SaBowUV97GgkFiYh4kyJTsiF1XyBv5sf6QWKpS
kDUYlVho6d5+3Qwoa3HUfnA/6ejk3GLFKrq9aF0y6D56gRsAg4Y=
=5zZH
-----END PGP SIGNATURE-----

--tOyS8UQhUdYqvCCSfi3g2hDllfG3CJmJ8--
