Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELuZH7KiShitDK3EnNR8cVo5iSv0Vx9rmhAx5rMkjuui1Csf72Rb4EdVCQqq3B/ao3sEr2VG
ARC-Seal: i=1; a=rsa-sha256; t=1521673685; cv=none;
        d=google.com; s=arc-20160816;
        b=Ehd/CSzYKHc8DDHgGuGj+IbfXw6Q7WMS/it8h7zShFmejz9pYW5Y0NAHJNlb/B2m5t
         JRFTWKgLmH5SHXsT+4ze5Rtxu7vopFwfJX2rktMChQPR3Rs7qUG3Di6Se+/j6m5wxkqi
         FB/eMzPZp9BPnBY942cfT2JxO42BvCW5mGqpHZ50sa3Xf68TPbW3muA3L0oUwc1Kcrb1
         tTrrcGzsVFCbMKwIETRWw/nDUZAFftvkBNISrDSib5NiRWuUQ6c84TPVU7hYDJEBvdfJ
         lRv1ofwW8bI+5igGjJ07v+suBV0bdKpxI87HhgMQ2Ffc0iXHleAZpSgxcnsy/bH4Rmxf
         RPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=mnO4CwzBgR2754II4xifrx4K8yNydBw8aCiAukCtnwc=;
        b=iMSY7PfuWYl5t6oUmJx7pHdcFwMG+w6i6SQyJMUTl0zFaegdkmaUfAaCUDkcWmGeQD
         tS+12RyJf6rsk5cxz14E2REgZUnz9vdL1apdGD2FuYXT5zLB4zWgrz+93wK+MVKtb4GY
         WWOtWhwA28OK5p+IoCm38tFxGX43e/ZcIhJrqQSZFErHMtaaz5tAZolE7CpmnHBzUC+n
         x8rLNYrmAXT8xVgPJt3qYU4yBi3SQkETbeAVZ9Th2ywqX0+xi5PkdU4E63Zib5NlhbqK
         Mb1me8xPxwOSWVl3TmicM3MYG9khJwKLbgqEIiFVR9lsM95o+1KQaNA7cD6EvlF5Arky
         xGpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Thu, 22 Mar 2018 00:08:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Ooi, Joyce" <joyce.ooi@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Ong Hean Loong <hean.loong.ong@intel.com>,
	Yves Vandervennet <yves.vandervennet@intel.com>
Subject: Re: [PATCH] drivers/misc: Add Intel interrupt latency counter driver
Message-ID: <20180321230804.GA6668@amd>
References: <1521026710-24811-1-git-send-email-joyce.ooi@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1521026710-24811-1-git-send-email-joyce.ooi@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912140530622370?=
X-GMAIL-MSGID: =?utf-8?q?1595590506826597262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-03-14 19:25:10, Ooi, Joyce wrote:
> Adding Intel interrupt latency counter driver support. This driver works
> together with the Intel interrupt latency driver soft IP to measure the
> time from the interrupt being asserted to the execution of the interrupt
> service routine. This driver and soft ip supports for both edge and level
> interrupt.


> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
>  .../misc/intel-interrupt-latency-counter.txt       |   49 ++++
>  drivers/misc/intel_ilc.c                           |  299 ++++++++++++++=
++++++

Should this go near "perf" somewhere?

> +++ b/Documentation/devicetree/bindings/misc/intel-interrupt-latency-coun=
ter.txt
> @@ -0,0 +1,49 @@
> +Intel Interrupt Latency Counter soft IP
> +Intel Interrupt Latency Counter IP core driver provides a sysfs interface
> +for user to obtain interrupt latency values from Intel Interrupt Latency
> +Counter soft IP.

Needs to be sent to devicetree people.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqy5dQACgkQMOfwapXb+vJcCQCgofnU8wsKnnDkiDalNoHd2yhm
jFoAnApiq/oJ/m52uMfmet56b/xyCfXd
=xGEY
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
