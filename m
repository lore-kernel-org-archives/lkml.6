Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEBDC282C8
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1FB21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="feGq+qdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfAWEUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 23:20:12 -0500
Received: from ozlabs.org ([203.11.71.1]:52109 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfAWEUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 23:20:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ksWr27t2z9s9G;
        Wed, 23 Jan 2019 15:20:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548217208;
        bh=HPz12GkgmVhD1Ou48wsAB1BI4uft5fyaXKEW+NI+5DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=feGq+qdAsEDlQpbR9xSNh4S02EHyi8IGs0yR4nBiLd8GtU1YhAzUSEs8Cf+OE33Y2
         Ca/DvPiHJ75VKCo56+UqrkTBlQisNQ72j7foyIfKtPdS6rOSLeCWeGWXwDHDADE8WU
         ZBEU9tlPPG0ia7FweQ1TGO/pBEPfn09SmwRtsI4qdHSNVP5Fb6FjsgZyUHl5xYBqDA
         XZgFu1UUre5qarpXifz0S838Yr/DoDJvvTScTgqfMekb7S1e6HiT7DLXwfMGFzyDpt
         qf3AfTb5YiUd1n5Z82xxxScWyGd7TozYkOTqD2ePsyWk8Lgp/fm0YuCaZCGS99NqL9
         gBpDujl3k07CQ==
Date:   Wed, 23 Jan 2019 15:20:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cpufreq-arm tree
Message-ID: <20190123152007.36b29ff7@canb.auug.org.au>
In-Reply-To: <20190118053802.rm7fc5z7wk3agc2f@vireshk-i7>
References: <20190118163307.03bd6710@canb.auug.org.au>
        <20190118053802.rm7fc5z7wk3agc2f@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A05E6ih9uXbbI+n6Fopv24h"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A05E6ih9uXbbI+n6Fopv24h
Content-Type: multipart/mixed; boundary="MP_/XTriIDQf5sZwxq.A1_bu48r"

--MP_/XTriIDQf5sZwxq.A1_bu48r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Viresh,

On Fri, 18 Jan 2019 11:08:02 +0530 Viresh Kumar <viresh.kumar@linaro.org> w=
rote:
>
> I missed looking into that. You must be running some sort of sanity
> checks on the branch itself, can I know what exactly are you doing so
> that I can try the same.

I have attached my current script.  I run this on the range of new
commits for each tree each day.

Suggestions welcome! :-)

--=20
Cheers,
Stephen Rothwell

--MP_/XTriIDQf5sZwxq.A1_bu48r
Content-Type: application/x-shellscript
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=check_fixes

IyEvYmluL2Jhc2gKCmlmIFsgIiQjIiAtbHQgMSBdOyB0aGVuCiAgICAgICAgcHJpbnRmICdVc2Fn
ZTogJXMgPGNvbW1pdCByYW5nZT5cbicsICIkMCIgMT4mMgogICAgICAgIGV4aXQgMQpmaQoKY29t
bWl0cz0kKGdpdCByZXYtbGlzdCAtLW5vLW1lcmdlcyAtaSAtLWdyZXA9J15bWzpzcGFjZTpdXSpG
aXhlczonICIkQCIpCmlmIFsgLXogIiRjb21taXRzIiBdOyB0aGVuCiAgICAgICAgZXhpdCAwCmZp
CgojIFRoaXMgc2hvdWxkIGJlIGEgZ2l0IHRyZWUgdGhhdCBjb250YWlucyAqb25seSogTGludXMn
IHRyZWUKTGludXNfdHJlZT0iJHtIT01FfS9rZXJuZWxzL2xpbnVzLmdpdCIKc3BsaXRfcmU9J14o
W1s6eGRpZ2l0Ol1dKylbWzpzcGFjZTpdXSsoLiopJCcKbmw9JCdcbicKCiMgU3RyaXAgdGhlIGxl
YWRpbmcgYW5kIHRyYWluaW5nIHNwYWNlcyBmcm9tIGEgc3RyaW5nCnN0cmlwX3NwYWNlcygpCnsK
CVtbICIkMSIgPX4gXltbOnNwYWNlOl1dKiguKlteWzpzcGFjZTpdXSlbWzpzcGFjZTpdXSokIF1d
CgllY2hvICIke0JBU0hfUkVNQVRDSFsxXX0iCn0KCmZvciBjIGluICRjb21taXRzOyBkbwoKCWNv
bW1pdF9sb2c9JChnaXQgbG9nIC0xIC0tZm9ybWF0PSclaCAoIiVzIiknICIkYyIpCgljb21taXRf
bXNnPSJJbiBjb21taXQKCiAgJGNvbW1pdF9sb2cKCiIKCglmaXhlc19saW5lcz0kKGdpdCBsb2cg
LTEgLS1mb3JtYXQ9JyVCJyAiJGMiIHwKCQkJZ3JlcCAtaSAnXltbOnNwYWNlOl1dKkZpeGVzOicp
CgoJd2hpbGUgcmVhZCAtciBmbGluZTsgZG8KCQlmPSQoZWNobyAiJGZsaW5lIiB8IHNlZCAncy9e
W1s6c3BhY2U6XV0qRml4ZXM6W1s6c3BhY2U6XV0qLy9pJykKCQlmaXhlc19tc2c9IkZpeGVzIHRh
ZwoKICAkZmxpbmUKCmhhcyB0aGVzZSBwcm9ibGVtKHMpOgoKIgoJCXNoYT0KCQlzdWJqZWN0PQoJ
CW1zZz0KCQlbWyAiJGYiID1+ICRzcGxpdF9yZSBdXQoJCXNoYT0iJHtCQVNIX1JFTUFUQ0hbMV19
IgoJCXN1YmplY3Q9IiR7QkFTSF9SRU1BVENIWzJdfSIKCgkJaWYgWyAteiAiJHNoYSIgXTsgdGhl
bgoJCQlwcmludGYgJyVzJXMgIC0gJXNcbicgIiRjb21taXRfbXNnIiAiJGZpeGVzX21zZyIgJ05v
IFNIQTEgcmVjb2duaXNlZCcKCQkJY29tbWl0X21zZz0nJwoJCQljb250aW51ZQoJCWZpCgkJaWYg
ISBnaXQgcmV2LXBhcnNlIC1xIC0tdmVyaWZ5ICIkc2hhIiA+L2Rldi9udWxsOyB0aGVuCgkJCXBy
aW50ZiAnJXMlcyAgLSAlc1xuJyAiJGNvbW1pdF9tc2ciICIkZml4ZXNfbXNnIiAnVGFyZ2V0IFNI
QTEgZG9lcyBub3QgZXhpc3QnCgkJCWNvbW1pdF9tc2c9JycKCQkJY29udGludWUKCQlmaQoKCQlp
ZiBbICIkeyNzaGF9IiAtbHQgMTIgXTsgdGhlbgoJCQltc2c9IiR7bXNnOiske21zZ30ke25sfX0g
IC0gU0hBMSBzaG91bGQgYmUgYXQgbGVhc3QgMTIgZGlnaXRzIGxvbmciCgkJZmkKCQkjIHJlZHVj
ZSB0aGUgc3ViamVjdCB0byB0aGUgcGFydCBiZXR3ZWVuICgpIGlmIHRoZXJlCgkJaWYgW1sgIiRz
dWJqZWN0IiA9fiBeXCgoLiopXCkgXV07IHRoZW4KCQkJc3ViamVjdD0iJHtCQVNIX1JFTUFUQ0hb
MV19IgoJCWVsaWYgW1sgIiRzdWJqZWN0IiA9fiBeXCgoLiopIF1dOyB0aGVuCgkJCXN1YmplY3Q9
IiR7QkFTSF9SRU1BVENIWzFdfSIKCQkJbXNnPSIke21zZzorJHttc2d9JHtubH19ICAtIFN1Ympl
Y3QgaGFzIGxlYWRpbmcgYnV0IG5vIHRyYWlsaW5nIHBhcmVudGhlc2VzIgoJCWZpCgoJCSMgc3Ry
aXAgbWF0Y2hpbmcgcXVvdGVzIGF0IHRoZSBzdGFydCBhbmQgZW5kIG9mIHRoZSBzdWJqZWN0CgkJ
IyB0aGUgdW5pY29kZSBjaGFyYWN0ZXJzIGluIHRoZSBjbGFzc2VzIGFyZQoJCSMgVSsyMDFDIExF
RlQgRE9VQkxFIFFVT1RBVElPTiBNQVJLCgkJIyBVKzIwMUQgUklHSFQgRE9VQkxFIFFVT1RBVElP
TiBNQVJLCgkJIyBVKzIwMTggTEVGVCBTSU5HTEUgUVVPVEFUSU9OIE1BUksKCQkjIFUrMjAxOSBS
SUdIVCBTSU5HTEUgUVVPVEFUSU9OIE1BUksKCQlyZTE9JCdeW1wiXHUyMDFDXSguKilbXCJcdTIw
MURdJCcKCQlyZTI9JCdeW1wnXHUyMDE4XSguKilbXCdcdTIwMTldJCcKCQlyZTM9JCdeW1wiXCdc
dTIwMUNcdTIwMThdKC4qKSQnCgkJaWYgW1sgIiRzdWJqZWN0IiA9fiAkcmUxIF1dOyB0aGVuCgkJ
CXN1YmplY3Q9IiR7QkFTSF9SRU1BVENIWzFdfSIKCQllbGlmIFtbICIkc3ViamVjdCIgPX4gJHJl
MiBdXTsgdGhlbgoJCQlzdWJqZWN0PSIke0JBU0hfUkVNQVRDSFsxXX0iCgkJZWxpZiBbWyAiJHN1
YmplY3QiID1+ICRyZTMgXV07IHRoZW4KCQkJc3ViamVjdD0iJHtCQVNIX1JFTUFUQ0hbMV19IgoJ
CQltc2c9IiR7bXNnOiske21zZ30ke25sfX0gIC0gU3ViamVjdCBoYXMgbGVhZGluZyBidXQgbm8g
dHJhaWxpbmcgcXVvdGVzIgoJCWZpCgoJCXN1YmplY3Q9JChzdHJpcF9zcGFjZXMgIiRzdWJqZWN0
IikKCgkJdGFyZ2V0X3N1YmplY3Q9JChnaXQgbG9nIC0xIC0tZm9ybWF0PSclcycgIiRzaGEiKQoJ
CXRhcmdldF9zdWJqZWN0PSQoc3RyaXBfc3BhY2VzICIkdGFyZ2V0X3N1YmplY3QiKQoKCQkjIG1h
dGNoIHdpdGggZWxsaXBzZXMKCQljYXNlICIkc3ViamVjdCIgaW4KCQkqLi4uKQlzdWJqZWN0PSIk
e3N1YmplY3QlLi4ufSIKCQkJdGFyZ2V0X3N1YmplY3Q9IiR7dGFyZ2V0X3N1YmplY3Q6MDokeyNz
dWJqZWN0fX0iCgkJCTs7CgkJLi4uKikJc3ViamVjdD0iJHtzdWJqZWN0Iy4uLn0iCgkJCXRhcmdl
dF9zdWJqZWN0PSIke3RhcmdldF9zdWJqZWN0OiAtJHsjc3ViamVjdH19IgoJCQk7OwoJCSpcIC4u
LlwgKikKCQkJczE9IiR7c3ViamVjdCUgLi4uICp9IgoJCQlzMj0iJHtzdWJqZWN0IyogLi4uIH0i
CgkJCXN1YmplY3Q9IiRzMSAkczIiCgkJCXQxPSIke3RhcmdldF9zdWJqZWN0OjA6JHsjczF9fSIK
CQkJdDI9IiR7dGFyZ2V0X3N1YmplY3Q6IC0keyNzMn19IgoJCQl0YXJnZXRfc3ViamVjdD0iJHQx
ICR0MiIKCQkJOzsKCQllc2FjCgkJc3ViamVjdD0kKHN0cmlwX3NwYWNlcyAiJHN1YmplY3QiKQoJ
CXRhcmdldF9zdWJqZWN0PSQoc3RyaXBfc3BhY2VzICIkdGFyZ2V0X3N1YmplY3QiKQoKCQlpZiBb
ICIkc3ViamVjdCIgIT0gIiR7dGFyZ2V0X3N1YmplY3Q6MDokeyNzdWJqZWN0fX0iIF07IHRoZW4K
CQkJbXNnPSIke21zZzorJHttc2d9JHtubH19ICAtIFN1YmplY3QgZG9lcyBub3QgbWF0Y2ggdGFy
Z2V0IGNvbW1pdCBzdWJqZWN0IgoJCWZpCgkJbHNoYT0kKGNkICIkTGludXNfdHJlZSIgJiYgZ2l0
IHJldi1wYXJzZSAtcSAtLXZlcmlmeSAiJHNoYSIpCgkJaWYgWyAteiAiJGxzaGEiIF07IHRoZW4K
CQkJY291bnQ9JChnaXQgcmV2LWxpc3QgLS1jb3VudCAiJHNoYSIuLiIkYyIpCgkJCWlmIFsgIiRj
b3VudCIgLWVxIDAgXTsgdGhlbgoJCQkJbXNnPSIke21zZzorJHttc2d9JHtubH19ICAtIFRhcmdl
dCBpcyBub3QgYW4gYW5jZXN0b3Igb2YgdGhpcyBjb21taXQiCgkJCWZpCgkJZmkKCQlpZiBbICIk
bXNnIiBdOyB0aGVuCgkJCXByaW50ZiAnJXMlcyVzXG4nICIkY29tbWl0X21zZyIgIiRmaXhlc19t
c2ciICIkbXNnIgoJCQljb21taXRfbXNnPScnCgkJZmkKCWRvbmUgPDw8ICIkZml4ZXNfbGluZXMi
CmRvbmUKCmV4aXQgMAo=

--MP_/XTriIDQf5sZwxq.A1_bu48r--

--Sig_/A05E6ih9uXbbI+n6Fopv24h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxH63cACgkQAVBC80lX
0GxisggAoGnzDpQ1DsjlSZHCZXsyrYDVdLGhCmnQbkhUVJPgePL1RYj7GslWp5sW
L2QzY3t3bzxnilBdrTt1EkUjteMu+G/4PWZZIDd/Iqz/YckRNqYjQgde3FvB5NqF
VBs1omLXVneDwzxh2cUybSWyOUfkKxC7dgHMGPsIFKmeIDsB9Q56yDcMMKN0Yjvt
7eQgTMbMP8Vl0w1L6H0kJAgxE7tPcfU5MBrTsxAnnQRVAqtlrbY5uSVnuu8w6UTu
g2hdhldbyOBKR8aP8qyKf7jGL9bnr0+S011K7IYyXDwcVEQROAISA/K+xgixR//R
oklokK0S2YKVEJh65HrqKernX/VNqQ==
=fLhh
-----END PGP SIGNATURE-----

--Sig_/A05E6ih9uXbbI+n6Fopv24h--
