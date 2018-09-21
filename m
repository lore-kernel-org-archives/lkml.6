Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A234C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D972156F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D972156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=petrovitsch.priv.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeIVFx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:53:26 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1989 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeIVFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:53:26 -0400
Received: from thorin.petrovitsch.priv.at (80-110-99-3.cgn.dynamic.surfer.at [80.110.99.3])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id w8M0012l002751
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO);
        Sat, 22 Sep 2018 02:00:19 +0200
Subject: Re: Code of Conduct: Let's revamp it.
To:     "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
        Theodore Tso <tytso@mit.edu>, fche@redhat.com,
        riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com>
 <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org>
 <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
Date:   Sat, 22 Sep 2018 01:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------DC8B0EBFA7A8EDBC394FEA40"
Content-Language: en-US
X-DCC-MGTINTERNET-Metrics: esgaroth.tuxoid.at 1170; Body=8 Fuz1=8 Fuz2=8
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DC8B0EBFA7A8EDBC394FEA40
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/09/2018 01:31, jonsmirl@gmail.com wrote:
[...]
> How does this part apply to email addresses used to commit code?
>=20
> * Publishing others=E2=80=99 private information, such as a physical or=
 electronic
> address, without explicit permission

I need an (explicit) permission to "publish" an already published email
address which is already world-wide known because it can be found by the
simplest and worst search engine as the email address is in public
mailing list archives and git repos?

Sounds pretty absurd as the people themselves already published their
email address.

IMHO you cannot "publish" already published stuff.

MfG,
	Bernd, NAL
--=20
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

--------------DC8B0EBFA7A8EDBC394FEA40
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFr26nABCAC94WhTqVPMksk/AErK3NqDKXE0sqO5umWIF3f4DYRidk8SIuNq
Fk3Sc8hqE2HlbCB9lxV9q+eqDQ8bRjMF6ud7rjXortlwmoclRRMUuSJhluKo0C7o
y2fJIwlQAcAKWNfOKqZBTTz81Mntb4j26MsSL7t7JIibst/G7EfoqyB9CkeoI8R2
20WVKV7Cb70G5cYZkLrSdjhSZ8FJn0QTb+r/TTYHRCFvU2sv+wvG3LAdWfHVnyaC
l9rPkglsYXFCtsdx3jW2zvWf+mGEjpANlVc/9M621C/uS7viLzalmFENpgM1UqFx
TEEt8mwepc7dkiiKlslmDGUWSfc/BAcln8BjABEBAAG0LUJlcm5kIFBldHJvdml0
c2NoIDxiZXJuZEBwZXRyb3ZpdHNjaC5wcml2LmF0PokBVAQTAQgAPhYhBBp+6uAd
nwsL14MwOAUgtH2tYL69BQJa9upyAhsDBQkB4TOABQsJCAcCBhUKCQgLAgQWAgMB
Ah4BAheAAAoJEAUgtH2tYL69e+EH/jL5uerVy/JnSTjM4f6UeWSXCT/RoIACccws
gvr84g5mwYy23c6TxUNNLgeCSGFWCkGxiF07kWazSvMSaQJ7Jb0cIxgqAQfR4xm3
g/O2bu8E0ZvMu1naMVdYrA6iXX40fylrEONF85+/93ccU60sa443ZxjzmQy8Hh4/
Siu0tOPrfvBgdovUcIhJaAAStcPLVocYgQ6zu2A9CCHcBTjaCiRiT4s2IPsooEZU
chKObAormMXJS2mdYHcH/a/6E6+NKnrvZ4yfhAkPF3K1M0Bc1Nvc0ADj62Ffpice
Mnrd/ki31ct5yIUeViJzNNxApXFuThxm1Nmpgmn/eRG2eHnlvu25AQ0EWvbqcQEI
AOnQvBVfytvhpeR96YtYTG2VW85Byv92T/FqG7rPHNm7fVxuJtFXZ8L82LKDTl7r
WtwwbnWFpha3/OAhb4Hn4fWZveDNSPNN8BUMh5BbTV/EW/053F4pBX4uq4/L1t3M
JQZH5QJrDRNAEL56JfK0yOOGJOvXBMSNAe1gXfLWiE6gGwtHxsoDZfPbSNYl703d
f4UaSsG0AleVWw+BGGQuYoeD9/icoy673bca22LdcxcV70SWcNaYcutduwAQYZfe
OTsDO0x/VpapLm7KsyQuNW2EYSPM8RjwuApet1TZxfU4opInQ7HbIusz/kWAWCr3
q47TvuD9c0jG8cKM3UP4UdcAEQEAAYkBPAQYAQgAJhYhBBp+6uAdnwsL14MwOAUg
tH2tYL69BQJa9upxAhsMBQkB4TOAAAoJEAUgtH2tYL69YS0H/21k3QUKHj/m3juD
X3yIbebr+/SR7Db0yrZXLh0RvS9DN2u0E+V26lb9jq+PDHDOJlqgHoiNK5MeWKBA
2yhpFvwx65P6DS3EXUhIT+1NN0CwtXcuSCt7DKHwmuSBZq+2FKr6niNllxKGWUhz
EOYtHE71Xm95LPjVi+ETzONF9Xt1ibjFahioSgx8ld/OrsUKv2nVmWVrHErQ+Ed0
m2fhBB0V9hhv7oCiKv0dfDeoPmeQWmiwMEqBYMgMMaJBUBs4pVwrHYVYYvWGLTfV
uyqqdpcKo99ns7ALSI7PGCwM4J9ra77L8PQenc329eEREzhC0Ok/Qgk+rI832lD7
bxT8MO4=3D
=3DpFcw
-----END PGP PUBLIC KEY BLOCK-----

--------------DC8B0EBFA7A8EDBC394FEA40--
