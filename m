Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeCZAz5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 20:55:57 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:45315 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751010AbeCZAzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 20:55:53 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:871:960:966:973:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1534:1541:1575:1711:1730:1747:1777:1792:2194:2196:2199:2200:2393:2553:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3871:3872:3873:3874:4321:4362:4385:5007:6119:6261:6506:6742:6747:7281:7903:7909:9040:10004:10848:11026:11232:11473:11658:11914:12114:12296:12438:12555:12663:12740:12895:12986:14096:14180:14181:14721:14877:21060:21080:21451:21611:21627:30054:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: part39_6d2e95795a318
X-Filterd-Recvd-Size: 3672
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 02/16] riscv: Use INITRAMFS_GENERIC_UNLOAD.
In-Reply-To: <mhng-5691a509-dedf-4092-bd6d-020a81512c15@palmer-si-x1c4>
References: <mhng-5691a509-dedf-4092-bd6d-020a81512c15@palmer-si-x1c4>
Date: Sun, 25 Mar 2018 20:55:48 -0400
Message-ID: <87o9jbu02z.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Palmer Dabbelt <palmer@sifive.com> writes:

> On Sun, 25 Mar 2018 15:18:39 PDT (-0700), shea@shealevy.com wrote:
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>> ---
>>  arch/riscv/Kconfig   | 1 +
>>  arch/riscv/mm/init.c | 6 ------
>>  2 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index c22ebe08e902..ab1b4cee84fc 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -37,6 +37,7 @@ config RISCV
>>  	select THREAD_INFO_IN_TASK
>>  	select RISCV_TIMER
>>  	select GENERIC_IRQ_MULTI_HANDLER
>> +	select INITRAMFS_GENERIC_UNLOAD
>>
>>  config MMU
>>  	def_bool y
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index c77df8142be2..36f83fe8a726 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -62,9 +62,3 @@ void free_initmem(void)
>>  {
>>  	free_initmem_default(0);
>>  }
>> -
>> -#ifdef CONFIG_BLK_DEV_INITRD
>> -void free_initrd_mem(unsigned long start, unsigned long end)
>> -{
>> -}
>> -#endif /* CONFIG_BLK_DEV_INITRD */
>
> I haven't looked through the rest of the patch set, but this is a pretty=
=20
> trivial change so feel free to add a=20
>
> Reviewed-By: Palmer Dabbelt <palmer@sifive.com>
>
> if you'd like.  If you'd like it merged through my tree then just say=20
> something!

I'm not sure how these cross-cutting changes go, if you can take the
series through your tree that'd be great!

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq4RRQACgkQXAvWlX2G
/idVvw//eVifwGjCVA7W+miXNnrCgZRDqcXBSsy5+RJM0TcRiPp6DHk/yebLED8j
i3/bd9OxMb6FyO2no4XZMZcsCrBPyeXZkwlbU0qhhc4DI/cNicmOUZro8Aj22Zmh
MFmOPbShBJG95BW7OfbCbVwAMxJXzGqzVoIHFE6xN4ZkOYvFytX9R/rruZJORHgO
3+sZBR2g2QG6y7KdXz3yoaRg00neNL8u6kOnDifPDBLBKo/8GI4J1nuycLGt4U3x
/adDOQx6/jTpC22B8AnC1cLS1O9ws/k3aDLgtpaLyPoFvyMp6WbAoSJYZZlVKXE6
/iqreLOaLVy67NPtldqJbcIgOCCZcOKuEhwlMtXNFQXBcC5FOmtI+Ske9MBKJsxJ
dzbS8JTliRn858IJR52cTSo+jaeM7dTqwjYw2lpl8CZsdVOxwyh6ytIAP3h8LYBJ
IyJrSbeDLkfWnQRcyTQBfR2ZHeTb2CDw40+VPMYm8EpRyQoI1oUkwKuPhaiUpcRz
OSJpw7bHo3Nnj+V7PR4+7avRIpZSMoPtPHUcWxKkQURS/3HyMsE49Vzz6Ozz91jK
GVb3D2dM/QDTDA5qY3r9bzJcgbmnKKdaqT9ybKyhjhs3AZJ1HjFhPhBqFgjcOSL/
VXjOvwvokD+HXOJOHW/CAOnF85kFwysKxYUBoj38xxrx4rjT1W8=
=L1b7
-----END PGP SIGNATURE-----
--=-=-=--
