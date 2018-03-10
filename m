Return-Path: <kernel-hardening-return-12373-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvqwunHIJWhWs1U1sB1fZIp2fSaF90QQWqpkkFniw8ZLnIK7nhta+GAXtIlxGQav4Jxz4pz
ARC-Seal: i=1; a=rsa-sha256; t=1520687702; cv=none;
        d=google.com; s=arc-20160816;
        b=RHbu0+pZwT/Uir4dc7fJRqurAofzkSJwsyQGkycMIqiV4jeITzha76N9RiGe1FwsT4
         QLUYfTKJU8oebJHMhzaTnASyMbvicNgwBnlvPn1y5Jy1+Ey3/4cxnxUyxPFufj52VqXD
         pUSSMo6mrHyZYwncgMsXJFCCxjXQ1anqdF0MIwSOfLPXgkHqghT4A3n1sTSN0Hm5I7po
         TzAte6AcLU4uvi+VeqCVKjnRuqLHLTJ0J0C/9riECwJ1o4XacHGq8esk3m6VJcp0Ajpx
         yEnXsTJ8F85JYE9PaTs1MaUuZsjVuhcIcP4JaUFg2AU35rRaCcbjieA6MgolNIclZl8E
         szFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=GfmYGZZ35Pd9DDQAFo/im8+/VNsXm92ArZs4/xtCVRQ=;
        b=S5DGW3/gVD9QCRQx8BxgmnifZxSgBkYPaqW/mo9JQy2XY6zUNznufeZ3bqKF8fbTOv
         QgTW6Mhr0k6ehXnZL0KJbOD0VOo8KAtB4ukhQOr44V+MuhgTpXLQdAm54xryj5u5vQOG
         OXx4EybEizwblsA0rWhifpL9TISAa7my5YoFLiqkiIvOFy84tGe3vq/kILdhtrdPkud3
         PDSCGhR2xtLs7qtK5sUgAm9IyUZK5Vng0Y3XU/SzbN5V7pD68SC2vihp58XT0BdTOjCr
         YTn406mcVIcy8REYmwySj6MsL9YucjIxnf2dhI8bQ3J052tpJLF9EqNtSOwwKEUYj5Aj
         6pzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12373-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12373-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12373-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12373-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 10 Mar 2018 14:14:22 +0100
From: Stephen Kitt <steve@sk2.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>, "hare@suse.com"
 <hare@suse.com>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] device_handler: remove VLAs
Message-ID: <20180310141422.3a8c451f@heffalump.sk2.org>
In-Reply-To: <1520635688.2907.17.camel@wdc.com>
References: <20180309232933.14e39858@heffalump.sk2.org>
	<20180309223211.20473-1-steve@sk2.org>
	<1520635688.2907.17.camel@wdc.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/RLkA53ioUhv_A3ygWmrpsFY"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 15726851378016767454
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrkeelgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501121445271854?=
X-GMAIL-MSGID: =?utf-8?q?1594556628719398308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/RLkA53ioUhv_A3ygWmrpsFY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bart,

On Fri, 9 Mar 2018 22:48:10 +0000, Bart Van Assche <Bart.VanAssche@wdc.com>
wrote:
> On Fri, 2018-03-09 at 23:32 +0100, Stephen Kitt wrote:
> > In preparation to enabling -Wvla, remove VLAs and replace them with
> > fixed-length arrays instead.
> >=20
> > scsi_dh_{alua,emc,rdac} use variable-length array declarations to
> > store command blocks, with the appropriate size as determined by
> > COMMAND_SIZE. This patch replaces these with fixed-sized arrays using
> > MAX_COMMAND_SIZE, so that the array size can be determined at compile
> > time. =20
>=20
> If COMMAND_SIZE() is evaluated at compile time, do we still need this pat=
ch?

The two patches I sent were supposed to be alternative solutions; see
https://marc.info/?l=3Dlinux-scsi&m=3D152063671005295&w=3D2 for the introdu=
ction (I
seem to have messed up the headers, so the mails didn=E2=80=99t end up thre=
aded
properly).

The MAX_COMMAND_SIZE approach is nice and simple, but I thought it worth
eliminating scsi_command_size_tbl while I was at it...

Regards,

Stephen

--Sig_/RLkA53ioUhv_A3ygWmrpsFY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAlqj2i8ACgkQgNMC9Yht
g5zViA/+MF5I+78bIeowASW4WOSYxUhajnvUxXnTaR9TT5cs2jZDKQjie0lVu8wm
L2H5dLE+4UWqIEKzSQRyRVhj6Bt3sWYye2hm6/kiDheIq+FXR9pfOOyOgzsvfmt/
bHXiFYKb7TQ6BcapWLNKpCJewaMyAPWhghTdJL3UycPwZIWAo21AhNwWsQ5HWKW0
UV/XOV0Mqvv9LlcWrdFiXPvee9NB4ZT3KVhNlyHpx9M2jO3hEMi2HqXQvhHl8H3L
UI6jWKFLzmWGQzXkJ+2GRq/bdvWyqzyKX89mq3Xb+zRcyjd1J/AjUtcUqwkSrBt1
r7RQIQ8XE8zD5TK39BC0OX7hWZd+oBvc+RlLl++hvYSBLJv87Eo9Mu+Fciys7PBJ
p7YOldKbIA53DO18gsKVgruhvYNnR1VvbS5DI1rXFFDhM+21tpVXlKwBZEBAo3Kz
4LeOKxTjuzy4OsNkSgjArWX3kBkWurNP7ueKVx6Aw1o6uOkVqqgAbXRuL67yGEL8
CRpiF4ceZ54ZVHzz0oKXBLbZ1qpKgo4RhZ8NQFbqhI473gDbN5EJ7hugFbDde8A4
lLGVoSqzEO/zPe88RUZD2AYsrY7X/yToXF5HTOeIHAebQwvMMh1uKcrEUVhzEfuS
RCfd2DupwXnUUACQ4/bhJYtYizlXFeBp6iyMv4xUbmmRu0K4hwg=
=TYGA
-----END PGP SIGNATURE-----

--Sig_/RLkA53ioUhv_A3ygWmrpsFY--
