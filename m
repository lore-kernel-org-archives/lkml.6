Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeC2LMp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:12:45 -0400
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:48734 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752383AbeC2LMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:12:43 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::,RULES_HIT:41:355:379:599:800:871:960:965:966:973:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1534:1541:1575:1711:1730:1747:1777:1792:1978:2196:2199:2393:2559:2562:2693:3138:3139:3140:3141:3142:3352:3865:3866:3867:3871:4321:4385:4390:4395:5007:6261:6506:6747:7281:7909:10004:10848:11026:11232:11473:11658:11914:12438:12555:12663:12740:12895:12986:13095:14096:14181:14721:21080:21433:21627:30012:30054:30070,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: brick78_8bfa93554ba28
X-Filterd-Recvd-Size: 3010
From: Shea Levy <shea@shealevy.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: Re: [PATCH v4 02/16] riscv: Use generic free_initrd_mem.
In-Reply-To: <7fa4f27c-d421-38cd-aa16-445b364ed9eb@linaro.org>
References: <20180328152714.6103-1-shea@shealevy.com> <20180328203659.18692-1-shea@shealevy.com> <20180328203659.18692-3-shea@shealevy.com> <7fa4f27c-d421-38cd-aa16-445b364ed9eb@linaro.org>
Date: Thu, 29 Mar 2018 07:12:40 -0400
Message-ID: <87y3ibrv87.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Daniel Thompson <daniel.thompson@linaro.org> writes:

> On 28/03/18 21:36, Shea Levy wrote:
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>> ---
>>   arch/riscv/mm/init.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>=20
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index c77df8142be2..36f83fe8a726 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -62,9 +62,3 @@ void free_initmem(void)
>>   {
>>   	free_initmem_default(0);
>>   }
>> -
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -void free_initrd_mem(unsigned long start, unsigned long end)
>> -{
>> -}
>> -#endif /* CONFIG_BLK_DEV_INITRD */
>
> This looks like a change of behavior since the weakly defined code does=20
> not implement a nop.
>
> I'm not saying the change is wrong, but if this is a deliberate bug fix=20
> then we need more than an empty commit message to explain what is=20
> happening here.
>

Right, sorry, will re-send with a proper commit message here.

>
>
> Daniel.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq8yigACgkQXAvWlX2G
/ieUwg//QOJoYqSxnITCFFfNoddzFpiplGiiMWId7+gJ5Fo+cy4ygN4u2Y3JQhg3
fHMeW3xwNepDXhJ9M/pzXU69DhxZEt2+roO9CaGKJYYX8kx9sYPlhMTbjYyg/9ZZ
fgfZaoD05o+Fcq0bJbVhm5yQBIIQWoepbR+vwewa7IjeHyF/enapSuuGycplmn6s
SzKxhbPFguM5kYcHpBcQlRSLREPC1Mqp26/zT8Vt+qZEETnYa2KVHf/aTeKWHNlf
78pwe/JssyXUCE7HVi1lVZRB9EvxUpV40inx5k9gEGrrIsKk2REV1VbfKCRwyjiS
lbZ8KZ9utsh6cHqo6YyVxnNgRI1po4r1pz1BXaMsDOGqgBJY+z6ua0PrcAWctjPG
WZysYd3h5NBxdAQADjwA7hqHD7IsBgUJmiSpmQlZDUJJq4bVnE8EHpkBy6UKiH/L
XDor2xi/maTujsRwC/Pn1S2yRpZQ5XrPPK478xPqOHERlW8rwy9XV14Ye86N26op
sJoKLQYuiSnfaDzsaFrffnXgpfAx+k7DJIq7xpg7IhXe21J9n4nBFv8CZHPJN4rF
nzFCVNZUjwqXWgzmLzdtZxF9y0uV7cOtMIe7SUQ11jkAWkSz8tjv6X5J6F4pEYQK
fFQIkcVvat7Ji8KfNORHAaAbFbWWdVv2Xu+CC4PIL0/O2yJWMPI=
=jCim
-----END PGP SIGNATURE-----
--=-=-=--
