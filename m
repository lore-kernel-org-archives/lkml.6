Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B276C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6DF20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uGVjxObp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfBAKtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:49:17 -0500
Received: from ozlabs.org ([203.11.71.1]:43995 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfBAKtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:49:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rYkZ3Nh7z9s3l;
        Fri,  1 Feb 2019 21:49:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549018153;
        bh=GczyAi0vYYlZhJLkR12s3k9pKqhZOz9EZJi1EEssKfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uGVjxObpfR1Bqw633m2Kv8jidVDJys19gWJIQiiGfcHQwmG8j2yvkiX3nBgyUAAy6
         Vka5fxB68g373Q15sDqd6keVekdWSHYWrgpHVSJJlkr/fT2Myc74T+Yivfhbg+/TxS
         xIGYgzz2WdHPvMcAJ9w75mq+qxFmpQ0pK1GTGq6u0cF79hnNvppi5chxVHi8dOqN6z
         4AHuWYykqitO6+RNVUZGFUJqQOr0uoKRzDiYLg5iM5FTKPscw01UVcq9SPrOkAQHvl
         LujyhxQlPQPVzoU8FfOJe7w0YisXMEspf5KmiJt1bCHxf9+ZSShYCrQigMvH1P7VJN
         fgXxi4VQ/BulA==
Date:   Fri, 1 Feb 2019 21:48:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Kent Russell <kent.russell@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>
Subject: Re: linux-next: Fixes tags need some work in the drm tree
Message-ID: <20190201214835.297d1236@canb.auug.org.au>
In-Reply-To: <CAKMK7uGf7X3m3Hp1r3-RSrKvGqsJK61WAMQ7goFP_28GAieP2w@mail.gmail.com>
References: <20190201105736.1428c9fc@canb.auug.org.au>
        <CAKMK7uGf7X3m3Hp1r3-RSrKvGqsJK61WAMQ7goFP_28GAieP2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Zg1saiTzebk62J_=ALAvqaw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zg1saiTzebk62J_=ALAvqaw
Content-Type: multipart/mixed; boundary="MP_/0nZ9hvX=IJbowboD1dKPi/O"

--MP_/0nZ9hvX=IJbowboD1dKPi/O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Daniel,

On Fri, 1 Feb 2019 11:05:43 +0100 Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Another one: Is the above checker script available somewhere, could be
> useful to put that into our own scripts to make sure this doesn't
> happen again.

I have attached the script.  It accepts a range of commits.
--=20
Cheers,
Stephen Rothwell

--MP_/0nZ9hvX=IJbowboD1dKPi/O
Content-Type: application/x-shellscript
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=check_fixes

IyEvYmluL2Jhc2gKCmlmIFsgIiQjIiAtbHQgMSBdOyB0aGVuCiAgICAgICAgcHJpbnRmICdVc2Fn
ZTogJXMgPGNvbW1pdCByYW5nZT5cbicsICIkMCIgMT4mMgogICAgICAgIGV4aXQgMQpmaQoKY29t
bWl0cz0kKGdpdCByZXYtbGlzdCAtLW5vLW1lcmdlcyAtaSAtLWdyZXA9J15bWzpzcGFjZTpdXSpG
aXhlczonICIkQCIpCmlmIFsgLXogIiRjb21taXRzIiBdOyB0aGVuCiAgICAgICAgZXhpdCAwCmZp
CgojIFRoaXMgc2hvdWxkIGJlIGEgZ2l0IHRyZWUgdGhhdCBjb250YWlucyAqb25seSogTGludXMn
IHRyZWUKTGludXNfdHJlZT0iJHtIT01FfS9rZXJuZWxzL2xpbnVzLmdpdCIKCnNwbGl0X3JlPSde
KFtDY11bT29dW01tXVtNbV1bSWldW1R0XSk/W1s6c3BhY2U6XV0qKFtbOnhkaWdpdDpdXXs1LH0p
KFtbOnNwYWNlOl1dKikoLiopJCcKbmw9JCdcbicKCiMgU3RyaXAgdGhlIGxlYWRpbmcgYW5kIHRy
YWluaW5nIHNwYWNlcyBmcm9tIGEgc3RyaW5nCnN0cmlwX3NwYWNlcygpCnsKCVtbICIkMSIgPX4g
XltbOnNwYWNlOl1dKiguKlteWzpzcGFjZTpdXSlbWzpzcGFjZTpdXSokIF1dCgllY2hvICIke0JB
U0hfUkVNQVRDSFsxXX0iCn0KCmZvciBjIGluICRjb21taXRzOyBkbwoKCWNvbW1pdF9sb2c9JChn
aXQgbG9nIC0xIC0tZm9ybWF0PSclaCAoIiVzIiknICIkYyIpCgljb21taXRfbXNnPSJJbiBjb21t
aXQKCiAgJGNvbW1pdF9sb2cKCiIKCglmaXhlc19saW5lcz0kKGdpdCBsb2cgLTEgLS1mb3JtYXQ9
JyVCJyAiJGMiIHwKCQkJZ3JlcCAtaSAnXltbOnNwYWNlOl1dKkZpeGVzOicpCgoJd2hpbGUgcmVh
ZCAtciBmbGluZTsgZG8KCQlbWyAiJGZsaW5lIiA9fiBeW1s6c3BhY2U6XV0qW0ZmXVtJaV1bWHhd
W0VlXVtTc106W1s6c3BhY2U6XV0qKC4qKSQgXV0KCQlmPSIke0JBU0hfUkVNQVRDSFsxXX0iCgkJ
Zml4ZXNfbXNnPSJGaXhlcyB0YWcKCiAgJGZsaW5lCgpoYXMgdGhlc2UgcHJvYmxlbShzKToKCiIK
CQlzaGE9CgkJc3ViamVjdD0KCQltc2c9CgkJaWYgW1sgIiRmIiA9fiAkc3BsaXRfcmUgXV07IHRo
ZW4KCQkJZmlyc3Q9IiR7QkFTSF9SRU1BVENIWzFdfSIKCQkJc2hhPSIke0JBU0hfUkVNQVRDSFsy
XX0iCgkJCXNwYWNlcz0iJHtCQVNIX1JFTUFUQ0hbM119IgoJCQlzdWJqZWN0PSIke0JBU0hfUkVN
QVRDSFs0XX0iCgkJCWlmIFsgIiRmaXJzdCIgXTsgdGhlbgoJCQkJbXNnPSIke21zZzorJHttc2d9
JHtubH19ICAtIGxlYWRpbmcgd29yZCAnJGZpcnN0JyB1bmV4cGVjdGVkIgoJCQlmaQoJCQlpZiBb
IC16ICIkc3ViamVjdCIgXTsgdGhlbgoJCQkJbXNnPSIke21zZzorJHttc2d9JHtubH19ICAtIG1p
c3Npbmcgc3ViamVjdCIKCQkJZWxpZiBbIC16ICIkc3BhY2VzIiBdOyB0aGVuCgkJCQltc2c9IiR7
bXNnOiske21zZ30ke25sfX0gIC0gbWlzc2luZyBzcGFjZSBiZXR3ZWVuIHRoZSBTSEExIGFuZCB0
aGUgc3ViamVjdCIKCQkJZmkKCQllbHNlCgkJCXByaW50ZiAnJXMlcyAgLSAlc1xuJyAiJGNvbW1p
dF9tc2ciICIkZml4ZXNfbXNnIiAnTm8gU0hBMSByZWNvZ25pc2VkJwoJCQljb21taXRfbXNnPScn
CgkJCWNvbnRpbnVlCgkJZmkKCQlpZiAhIGdpdCByZXYtcGFyc2UgLXEgLS12ZXJpZnkgIiRzaGEi
ID4vZGV2L251bGw7IHRoZW4KCQkJcHJpbnRmICclcyVzICAtICVzXG4nICIkY29tbWl0X21zZyIg
IiRmaXhlc19tc2ciICdUYXJnZXQgU0hBMSBkb2VzIG5vdCBleGlzdCcKCQkJY29tbWl0X21zZz0n
JwoJCQljb250aW51ZQoJCWZpCgoJCWlmIFsgIiR7I3NoYX0iIC1sdCAxMiBdOyB0aGVuCgkJCW1z
Zz0iJHttc2c6KyR7bXNnfSR7bmx9fSAgLSBTSEExIHNob3VsZCBiZSBhdCBsZWFzdCAxMiBkaWdp
dHMgbG9uZyR7bmx9ICAgIENhbiBiZSBmaXhlZCBieSBzZXR0aW5nIGNvcmUuYWJicmV2IHRvIDEy
IChvciBtb3JlKSBvciAoZm9yIGdpdCB2Mi4xMSR7bmx9ICAgIG9yIGxhdGVyKSBqdXN0IG1ha2lu
ZyBzdXJlIGl0IGlzIG5vdCBzZXQgKG9yIHNldCB0byBcImF1dG9cIikuIgoJCWZpCgkJIyByZWR1
Y2UgdGhlIHN1YmplY3QgdG8gdGhlIHBhcnQgYmV0d2VlbiAoKSBpZiB0aGVyZQoJCWlmIFtbICIk
c3ViamVjdCIgPX4gXlwoKC4qKVwpIF1dOyB0aGVuCgkJCXN1YmplY3Q9IiR7QkFTSF9SRU1BVENI
WzFdfSIKCQllbGlmIFtbICIkc3ViamVjdCIgPX4gXlwoKC4qKSBdXTsgdGhlbgoJCQlzdWJqZWN0
PSIke0JBU0hfUkVNQVRDSFsxXX0iCgkJCW1zZz0iJHttc2c6KyR7bXNnfSR7bmx9fSAgLSBTdWJq
ZWN0IGhhcyBsZWFkaW5nIGJ1dCBubyB0cmFpbGluZyBwYXJlbnRoZXNlcyIKCQlmaQoKCQkjIHN0
cmlwIG1hdGNoaW5nIHF1b3RlcyBhdCB0aGUgc3RhcnQgYW5kIGVuZCBvZiB0aGUgc3ViamVjdAoJ
CSMgdGhlIHVuaWNvZGUgY2hhcmFjdGVycyBpbiB0aGUgY2xhc3NlcyBhcmUKCQkjIFUrMjAxQyBM
RUZUIERPVUJMRSBRVU9UQVRJT04gTUFSSwoJCSMgVSsyMDFEIFJJR0hUIERPVUJMRSBRVU9UQVRJ
T04gTUFSSwoJCSMgVSsyMDE4IExFRlQgU0lOR0xFIFFVT1RBVElPTiBNQVJLCgkJIyBVKzIwMTkg
UklHSFQgU0lOR0xFIFFVT1RBVElPTiBNQVJLCgkJcmUxPSQnXltcIlx1MjAxQ10oLiopW1wiXHUy
MDFEXSQnCgkJcmUyPSQnXltcJ1x1MjAxOF0oLiopW1wnXHUyMDE5XSQnCgkJcmUzPSQnXltcIlwn
XHUyMDFDXHUyMDE4XSguKikkJwoJCWlmIFtbICIkc3ViamVjdCIgPX4gJHJlMSBdXTsgdGhlbgoJ
CQlzdWJqZWN0PSIke0JBU0hfUkVNQVRDSFsxXX0iCgkJZWxpZiBbWyAiJHN1YmplY3QiID1+ICRy
ZTIgXV07IHRoZW4KCQkJc3ViamVjdD0iJHtCQVNIX1JFTUFUQ0hbMV19IgoJCWVsaWYgW1sgIiRz
dWJqZWN0IiA9fiAkcmUzIF1dOyB0aGVuCgkJCXN1YmplY3Q9IiR7QkFTSF9SRU1BVENIWzFdfSIK
CQkJbXNnPSIke21zZzorJHttc2d9JHtubH19ICAtIFN1YmplY3QgaGFzIGxlYWRpbmcgYnV0IG5v
IHRyYWlsaW5nIHF1b3RlcyIKCQlmaQoKCQlzdWJqZWN0PSQoc3RyaXBfc3BhY2VzICIkc3ViamVj
dCIpCgoJCXRhcmdldF9zdWJqZWN0PSQoZ2l0IGxvZyAtMSAtLWZvcm1hdD0nJXMnICIkc2hhIikK
CQl0YXJnZXRfc3ViamVjdD0kKHN0cmlwX3NwYWNlcyAiJHRhcmdldF9zdWJqZWN0IikKCgkJIyBt
YXRjaCB3aXRoIGVsbGlwc2VzCgkJY2FzZSAiJHN1YmplY3QiIGluCgkJKi4uLikJc3ViamVjdD0i
JHtzdWJqZWN0JS4uLn0iCgkJCXRhcmdldF9zdWJqZWN0PSIke3RhcmdldF9zdWJqZWN0OjA6JHsj
c3ViamVjdH19IgoJCQk7OwoJCS4uLiopCXN1YmplY3Q9IiR7c3ViamVjdCMuLi59IgoJCQl0YXJn
ZXRfc3ViamVjdD0iJHt0YXJnZXRfc3ViamVjdDogLSR7I3N1YmplY3R9fSIKCQkJOzsKCQkqXCAu
Li5cICopCgkJCXMxPSIke3N1YmplY3QlIC4uLiAqfSIKCQkJczI9IiR7c3ViamVjdCMqIC4uLiB9
IgoJCQlzdWJqZWN0PSIkczEgJHMyIgoJCQl0MT0iJHt0YXJnZXRfc3ViamVjdDowOiR7I3MxfX0i
CgkJCXQyPSIke3RhcmdldF9zdWJqZWN0OiAtJHsjczJ9fSIKCQkJdGFyZ2V0X3N1YmplY3Q9IiR0
MSAkdDIiCgkJCTs7CgkJZXNhYwoJCXN1YmplY3Q9JChzdHJpcF9zcGFjZXMgIiRzdWJqZWN0IikK
CQl0YXJnZXRfc3ViamVjdD0kKHN0cmlwX3NwYWNlcyAiJHRhcmdldF9zdWJqZWN0IikKCgkJaWYg
WyAiJHN1YmplY3QiICE9ICIke3RhcmdldF9zdWJqZWN0OjA6JHsjc3ViamVjdH19IiBdOyB0aGVu
CgkJCW1zZz0iJHttc2c6KyR7bXNnfSR7bmx9fSAgLSBTdWJqZWN0IGRvZXMgbm90IG1hdGNoIHRh
cmdldCBjb21taXQgc3ViamVjdCIKCQlmaQoJCWxzaGE9JChjZCAiJExpbnVzX3RyZWUiICYmIGdp
dCByZXYtcGFyc2UgLXEgLS12ZXJpZnkgIiRzaGEiKQoJCWlmIFsgLXogIiRsc2hhIiBdOyB0aGVu
CgkJCWNvdW50PSQoZ2l0IHJldi1saXN0IC0tY291bnQgIiRzaGEiLi4iJGMiKQoJCQlpZiBbICIk
Y291bnQiIC1lcSAwIF07IHRoZW4KCQkJCW1zZz0iJHttc2c6KyR7bXNnfSR7bmx9fSAgLSBUYXJn
ZXQgaXMgbm90IGFuIGFuY2VzdG9yIG9mIHRoaXMgY29tbWl0IgoJCQlmaQoJCWZpCgkJaWYgWyAi
JG1zZyIgXTsgdGhlbgoJCQlwcmludGYgJyVzJXMlc1xuJyAiJGNvbW1pdF9tc2ciICIkZml4ZXNf
bXNnIiAiJG1zZyIKCQkJY29tbWl0X21zZz0nJwoJCWZpCglkb25lIDw8PCAiJGZpeGVzX2xpbmVz
Igpkb25lCgpleGl0IDAK

--MP_/0nZ9hvX=IJbowboD1dKPi/O--

--Sig_/Zg1saiTzebk62J_=ALAvqaw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxUJAMACgkQAVBC80lX
0GykLggAjJuZvm7XwOe+uk6VrrwVVzfvM+B5zVtJeAr6QCmhQgP2EGA/FxY36Yvd
FlsFE6IwLqSRP25wX4Nh1kLwm8M6vm8MAca52iaTHYsNcOhr3gZQVc0FVUueIS4Y
9A7wDDNrursqql9a34fuljJXiO7HYCGELtlsRJ1JzHkEwEqXjQDySKh45/2C8nC6
wlbvX1V+/tReH6dBQLACPKIxPyDZyWQVt5JefR4gkkk6bVjSC7J3WqTxZRbYRNSw
IJLJMArwtAB/CAbSmTlzExY2I0XULyG9SoSslhbpEM1yNNFzT00fJNeDGbQy1vje
ZZoWaCNoYk4U0KBVTfXc/RIh5mjx0w==
=UA/w
-----END PGP SIGNATURE-----

--Sig_/Zg1saiTzebk62J_=ALAvqaw--
