Return-Path: <kash@tripleback.net>
X-Google-Smtp-Source: AG47ELtS47am+Nu4g31B/oX28FE7m6wiZJuwcPE4kLoqddQkZfg8HRgi538xDWLT1eSRaEuc1ZD2
ARC-Seal: i=1; a=rsa-sha256; t=1521483210; cv=none;
        d=google.com; s=arc-20160816;
        b=imPZwA/perHXJXcKyZyqqkL7zBbiuq5ByOXobfJFCdk10P76JHyKjx90ZqTUy0f844
         xWiOlBF2+UOywvNToNakIo6mi0iQ814KB1yigL3g5wG/uJia5Q/BmV2GHyjMX88CINuj
         BUS3L9iDKpLkCt6fXE9hiAHdtICH9wG9ChS1QdYlbm9Os0n4ZzhAOiU9Flypo7FbTHCb
         33z9Rq4+rDkFe4dQ0ymIx8kkoGCFL2IXdPfGLkmd9Al/kC8mbwkHn3bI6umafZR60VSd
         HplTc5cKBkRt9AMwUgwBiZ/JxuSQ/xR4UUsD9rNRhGcw+LjPQBe+xx6ImjAqi+I/rNbV
         ULyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:arc-authentication-results;
        bh=83UqTXAyNjAj8TrMWKWi0PxEzHi6vgpbKGkvqw0aCAs=;
        b=se/xccTVE/EgyBl8zBNEY6jRV4G8P8R6Fg1v6DRe8w0D5bnJpItaWsXb9yVHMvzd98
         sbyBQcDwX7+7mciW3NkSwAw3Mi7nixWozU4EaBs5rB6fx9xbYco5dSWE6uLtg4nEG+SD
         VVSRza5pbrteTgUSzG0e3B2dJ1m0b5JxGIQfPaXGc902b5l5UfbQI/Q4Q/HvsfQ7+e94
         /e4kt6slxQaGAePuYLUuh2gW081Erj835S5hvaaLAC3ZpbwpFrFCsm3GsF7nI1J5QOc3
         68nOFWBR8LTuxK13XnE1A941z2e7M8Sam+37PyJqV4jwq3ff2ZFP2KgO+029nRkS5+2Q
         00oQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kash@tripleback.net designates 198.50.226.104 as permitted sender) smtp.mailfrom=kash@tripleback.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kash@tripleback.net designates 198.50.226.104 as permitted sender) smtp.mailfrom=kash@tripleback.net
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
 ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
 stable@vger.kernel.org
References: <20180316152329.844663293@linuxfoundation.org>
From: Kash Pande <kash@tripleback.net>
Message-ID: <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
Date: Mon, 19 Mar 2018 14:13:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7SuMsmKMkWyX2CCrbG7buQmMPzgNhSOsS"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109030771020666?=
X-GMAIL-MSGID: =?utf-8?q?1595390779231372401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7SuMsmKMkWyX2CCrbG7buQmMPzgNhSOsS
Content-Type: multipart/mixed; boundary="p0tnFabrNWjOYBkOCnc1wowtgi4UTF8po";
 protected-headers="v1"
From: Kash Pande <kash@tripleback.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
 ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
 stable@vger.kernel.org
Message-ID: <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
References: <20180316152329.844663293@linuxfoundation.org>
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>

--p0tnFabrNWjOYBkOCnc1wowtgi4UTF8po
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 2018-03-16 11:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.28 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please=

> let me know.
>
> Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
> Anything received after that time might be too late.

Any chance to get the k10temp change for Threadripper 1900X offset
reporting included [https://patchwork.kernel.org/patch/10175457/]?


Kash Pande


--p0tnFabrNWjOYBkOCnc1wowtgi4UTF8po--

--7SuMsmKMkWyX2CCrbG7buQmMPzgNhSOsS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlqv/cgUHGthc2hAdHJp
cGxlYmFjay5uZXQACgkQLHWyk7icJXgFLQf/SrVxGMmEZX4gS2gWFueBBZzqPHuS
71qQQYhJDW6cj3oK8q5em5WpJbhL4nn9XcCJooFN/Q9MDsPKzJ94xnZ7gfJzchYY
XY9nSXsk2zy8LtkvDGBp1+x1tIh9WJ2x9+2ffRtlhOWZIC6y9GETzltzPP3gjsqU
fXIpbK2p5egkkZsj0W1IDeVig/NNc9SzT8ITK7c9KKXDBBZ7v2puhFz3rSm6Paiq
pvuqePk5EUTlmea1dSZC1SLA8zPX5iPWoTT/jPwK6WU3vh4WJacrUSdsR5LEVDVA
F4uc/mWHePP0f+PArDV24Idmo0JLsVXnonuEmAgVwu4T7/ogi+hJZbIg8w==
=iDuI
-----END PGP SIGNATURE-----

--7SuMsmKMkWyX2CCrbG7buQmMPzgNhSOsS--
