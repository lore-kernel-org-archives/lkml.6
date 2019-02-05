Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D66C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485542175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l1CJWC46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfBEWnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:43:02 -0500
Received: from ozlabs.org ([203.11.71.1]:37341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbfBEWm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:42:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vKNK0KXTz9sDX;
        Wed,  6 Feb 2019 09:42:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549406577;
        bh=Swvh0Y02F45TzjtTio/yt4f54Y237FLA8Ti5AKjyV/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1CJWC46C5QKxssnK3l7VsBLCu/TXeVxX6Xw54kTajZ+4AzyYkTnvBlpUKsEBubbu
         navn5JzRsJeq82HLOGmwvq5iJB8KHE5wzY7H+deR/yntg78lmpSFLy5QUKJt1OhNV3
         jcNABG+b+4gLEylxXiQFnsNopwSQFUBKPQBcePExh+XwHvaje6e66NU7KyTJ+DdlHA
         CsRTk51caYiV9a8r+zrEXk0XFdTQUanLODKW+koMEwON2T1cr3xhFX9JthtBeL6K50
         uNx296lpTDsRUd6Bbk5h06xCQTh3mQds8b4vi3MX7/sg1g+OgXwEkb4VniRcAtmXEg
         mDPpg3Gg3O2Uw==
Date:   Wed, 6 Feb 2019 09:42:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     schwab@suse.de, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: Fixes tag needs some work in the origin tree
Message-ID: <20190206094255.771d4b21@canb.auug.org.au>
In-Reply-To: <mhng-d27cd6f4-522a-4666-a046-1803f6ee37c9@palmer-si-x1c4>
References: <20190203083310.12b97619@canb.auug.org.au>
        <mhng-d27cd6f4-522a-4666-a046-1803f6ee37c9@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7aQn_VKWOsB7WEHTIZbd=2N"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7aQn_VKWOsB7WEHTIZbd=2N
Content-Type: multipart/mixed; boundary="MP_/hlbs7XfKp0qruSndPV9NbbL"

--MP_/hlbs7XfKp0qruSndPV9NbbL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Palmer,

On Tue, 05 Feb 2019 10:47:43 -0800 (PST) Palmer Dabbelt <palmer@sifive.com>=
 wrote:
>
> Thanks.  Is there a script I should be running to pre-check these?

I run the attached script on each set of new commits that turn up.

--=20
Cheers,
Stephen Rothwell

--MP_/hlbs7XfKp0qruSndPV9NbbL
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

--MP_/hlbs7XfKp0qruSndPV9NbbL--

--Sig_/7aQn_VKWOsB7WEHTIZbd=2N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxaEW8ACgkQAVBC80lX
0GzKvwf+IKJnlIOBY+KAF7firQe1Pp1QaOz3r8NW5Y6ETdVYXzfPC4NEMTt/9UTn
FjgleIkZWnPAEVvORpGDE42VmAcT/X7LeXADHMsPV7zWT/iJI5QFNAmY0WNhaZdg
ICRwVu/dF/+EsBlkvqZy3EpqVnuSGTa8D7jqTMNlU5/Ah8HRYlfY9U2wpMPcVk57
KppxPpY85BcOutNtUhAy0Res7Y71eYI54NGc7wxi7LuqlQk2AAQn9Rc/+qiF9kfh
8Dt999ppFUawhOXX25Ao0rFyng0Wzw3H9Kg+OxGIK7xsXPrz9RWYi/vl5HldQ9Eu
skKXuWJ10li22YOxmJnUeCcW4gH4HQ==
=/1zt
-----END PGP SIGNATURE-----

--Sig_/7aQn_VKWOsB7WEHTIZbd=2N--
