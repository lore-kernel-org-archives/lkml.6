Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B749DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F496208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F496208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=petrovitsch.priv.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeIYBvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:51:12 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:3046 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeIYBvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:51:12 -0400
Received: from thorin.petrovitsch.priv.at (80-110-99-3.cgn.dynamic.surfer.at [80.110.99.3])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id w8OJjdrb027134
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO);
        Mon, 24 Sep 2018 21:45:41 +0200
Subject: Re: Code of Conduct: Let's revamp it.
To:     xDynamite <dreamingforward@gmail.com>
Cc:     "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
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
 <d364f33b-fbb4-57e0-78f5-302cd5c9050f@petrovitsch.priv.at>
 <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <8c18dcc5-9028-672f-1449-359ac3d73592@petrovitsch.priv.at>
Date:   Mon, 24 Sep 2018 21:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAMjeLr-a4cCrs0cF0aBRoeeXXLwiM835BXqhP9ZoeLB8=w=YKw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------CE87B260FDF929D4E4BE134B"
Content-Language: en-US
X-DCC--Metrics: esgaroth.tuxoid.at 1480; Body=9 Fuz1=9 Fuz2=9
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CE87B260FDF929D4E4BE134B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/09/2018 20:59, \0xDynamite wrote:
>>> * Publishing others=E2=80=99 private information, such as a physical =
or
>>> electronic
>>> address, without explicit permission
>>
>> I need an (explicit) permission to "publish" an already published emai=
l
>> address which is already world-wide known because it can be found by t=
he
>> simplest and worst search engine as the email address is in public
>> mailing list archives and git repos?
>>
>> Sounds pretty absurd as the people themselves already published their
>> email address.
>>
>> IMHO you cannot "publish" already published stuff.
>=20
> The notion of being "published" means at least these two things:  1)

Where exactly - URL? - is that notion defined?
Especially the intention is IMHO not necessary - just the fact if it
happened (and I don't think we want to discuss legal stuff about "X
broke into my home, stole and published my work" - the patent world has
the same problem).

> you INTEND it to be PUBLIC, 2) you made it available to the PUBLIC
> A semi-private email list is a boundary area of being public.  Just

Define "semi-private" - URL?:

Any company/club/family/...-internal ML is - should be;-) - obviously
private as the subscription policy is usually pretty selective (read:
not public, not debatable, ...) and the archives - if any - are not
public by design. So everyone there should know that.

Of course, anyone getting all mails can put an $SEARCH_MACHINE indexed
archive publicly online but that's another (law) question.

On the otherhand, if the mailinglist is public, the (future) subscribers
should know the beforehand.

> like a memo distributed within a university department.  Participants
> in the latter have some reasonable expectation that the material is
> not being published in the larger public sphere beyond actions of the
> trusted participants involved (which might share it in a limited
> fashion as a personal note).

ACK but what has that to do with LKML etc?
You try to change - manipulate - the issues of the discussion. Are you
only a troll?

> So, is code a *published* item?  Most of the public can't read it.

I cannot read (or understand) neither Russian nor Chinese nor almost any
natural (let alone dead) languages of the world. I'm pretty sure that
I'm not the only one;-)
Does that make Russian literature non-public? I don't think so ...
You really don't want to go down that road - neither with law people and
even less with techies.

So how can be (source) code (at least in any publicly known/defined
language) posted on a "everyone can subscribe" mailinglist, archived in
several $SEARCH_ENGINE indexed mailinglist archives and replicated in a
myriad of public accessible git-repos with the only intention of
inclusion in the Kernel not be *obviously* and *clearly* public?

> It is often not intended for the public, per se, only a specialized

Maybe but doesn't change any fact of publication - you may also want to
check with patent folks and "unintended or unwanted publication" (yes,
some talk in a "maybe publicly accessible space" might count there as
"publication") - they have more or less the same situation.

> COMMUNITY.  Because once published, it belongs to copyright and fair> u=
se (THAT sticky little wicket).

In the law area, the Copyright (TTBOMK) and the much more advanced
Central European Authors rights start to exist with existence of the
"work" (and not a =C2=B5s later) independent of any status or situation o=
f
publication.

Where does the "fair use" come from?
Reads: where is that defined?

If you want me to define "fair use of source code publicized in the LKML
and similar under the GPLv2": You also cease the right to efeectively
revoke it (though that is in some jurisdictions not possible but that
"revoke-right" was made for completely different situations - long
before GPL or CC was even thinkable).

"effectively revoke it" is meant that you cannot say "I wrote parts of
it/I'm the initial contributor/I have a significant patch accepted and
I'm fed up with the kernel so remove all my contributions".
BTW you cannot do that at your workplace either because in all sane
software development companies you cease all (transferable) rights of
your written to the company paying you (and the rest is usually not
enough to get anything revoked).

I don't see why that should be any different with GPLv2 patches for the
Kernel sent to public mailinglists with the intent of inclusion.

Please get back to the issue and circumstances at hand and do not try to
divert people with "not intended for the public" or "semi-public" or any
other off-topic stuff which is clearly not the case here.
Or - even better - shut up, unsubscribe and go away, thank you.

MfG,
	Bernd, NAL but I talked to a lot of them;-)

PS: Sorry for troll feeding:-(
--=20
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

--------------CE87B260FDF929D4E4BE134B
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

--------------CE87B260FDF929D4E4BE134B--
