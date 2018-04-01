Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeDAPBt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 11:01:49 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:37807 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753844AbeDAPBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 11:01:39 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:871:960:965:966:968:973:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1534:1541:1575:1711:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2321:2393:2559:2562:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4362:4385:4390:4395:5007:6261:6506:6747:7281:7909:9036:10004:10848:11026:11232:11658:11914:12048:12740:12895:13095:14096:14180:14181:14721:21060:21080:21433:21627:30054:30070:30091,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: event96_828ad8ffd3e07
X-Filterd-Recvd-Size: 3444
From: Shea Levy <shea@shealevy.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 14/16] powerpc: Use generic free_initrd_mem.
In-Reply-To: <87a7ur10k3.fsf@concordia.ellerman.id.au>
References: <20180328152714.6103-1-shea@shealevy.com> <20180328203659.18692-1-shea@shealevy.com> <20180328203659.18692-15-shea@shealevy.com> <1522269853.12357.135.camel@perches.com> <874lkzudkc.fsf@xps13.shealevy.com> <87a7ur10k3.fsf@concordia.ellerman.id.au>
Date: Sun, 01 Apr 2018 11:01:36 -0400
Message-ID: <87efjzrmwf.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Michael,

Michael Ellerman <mpe@ellerman.id.au> writes:

> Shea Levy <shea@shealevy.com> writes:
>
>> Joe Perches <joe@perches.com> writes:
>>
>>> On Wed, 2018-03-28 at 16:36 -0400, Shea Levy wrote:
>>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>>
>>> Most people seem to want some form of commit message
>>> and not just your sign-off.
>>>
>>
>> Ah, if the subject is insufficient I can add some more detail.
>
> Yeah please do.
>
> Seeing this patch in isolation, with no change log, I might think it's
> safe for me to just apply it.
>
> But that would break the build because I don't have patch 1.
>
> So for starters you need to explain that part, eg something like:
>
>   A previous patch in the series added a weak definition of
>   free_initrd_mem() in init/initramfs.c.
>
>   The powerpc implementation is identical, so it can be removed allowing
>   the generic version to be used.
>
>
> Then you could also tell me if you did/didn't build/boot test it.

Thanks for the feedback, can you let me know if the recently posted v6
fits the bill?

>
> cheers

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlrA9FAACgkQXAvWlX2G
/ieBKBAAk/VCetteefqZltIXAjkY4l/v8JW1hxDADgmU74eMx14ZgZ4ZjJfw1/Gu
gYA0xiz+gZE3+ciDx56n6GlY01Ch3RbZ5CqgFA3v8VORzKJYAzPEET5C+ZKd4sCV
hxkUf8CadMiIcK077p7quHys8HT2hdQc7Jtv+DhkJYhpeUc9QbUmY+Kh9kd3LFTv
pZXdgAfK1bwyVGbhiFwD75k8wK70PtmXN2j5AnpE0JpSCNkuannRakrECCewa7wV
6LZ99wgbokm+/3GrCoPP4zBREkX/rAtXlDYqT0mSYO7c6F8phzA7o+u9HSezJ9Q2
TcOJspb3HC96ZJzpTguDjD48btmMHVwGhxdQwvJdpV1PfTrL1JBTBvfZbvQL3pST
khLtXDUGbqloMV6/904TkeKYuESHOuOZhjXNrhnWQ9GkUyqIjhicbEk8CotTzxN7
6VI6woqE0RLAKMkhcvZQYa8QA8qeSJrfESGtsDmc5HarhxUabRQtH2jlsJO/SJmk
n8rGWBfXUzatv9+Jt6akzPfmOD+fO/3rIQ5BTaJvRXigI6l8wqOLWRSyWst/gIrX
TCjdNw30HcB8vSnNfDNcQRsIERsfg/uN+j0lQFu6keuSqAEMQFr5QLRlyqiD1MsA
2sTKQXkMTRwrbCazgSn4MzLdJ76wDRfTvNnMvR/vKm2Le4NPppU=
=nzH9
-----END PGP SIGNATURE-----
--=-=-=--
