Return-Path: <vkoul@kernel.org>
X-Google-Smtp-Source: AB8JxZqnipnTHybh7mWT/Rz+3JNTiKgRWNrkyhMIwsOkvGLb5lmvSoXDN+M+1CFRU/dyS6f4ESA+
ARC-Seal: i=1; a=rsa-sha256; t=1526523016; cv=none;
        d=google.com; s=arc-20160816;
        b=yIUwphnbvsIDUcz/RcJa7chrAq6cDA7Zi2FNiaPZDa0X0LTIL1uhudhjDKlCa5rYte
         tvA6peqM9IEJBCmuLO6iiOqnpGXiq3WcEOi30EnnR+o61edODkz9ReyjpLUGWos9u0p3
         oFYor/3JQ37YBLKTCGA9jknIzcy+O3nwjFfriPHl0QqcnD/uj9cjKnvsiCdiLiXBq1gs
         GaMLKTkIUZOxnBU+WaBTcumY4Hq3Y1GRJ7AQfWoYSblC8NPzcQDV0aaSgJlBlZDgGzJW
         FxrcuL6ww3POg0nFEvbpE18TH8dFBjwusUG4aQB8HugJScvcDXG70rUjPQHxtFzwMavA
         9Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+OBMhuu6C1srYK8CW/dv9e0WENXC6wr6v1boEHOYiRY=;
        b=MR/71pTHs/TYsJF3K0vV40PATWjkRoEA8/233ZXxzXz/xN5M1TmRnPK4L8p9wCyuSW
         XCdd2QXEmSP5dLOlMshTLtYZB7+Rzk/zhYvWFGMIwJzXwYAlaZhYIm95ZZR7jQqWVBXq
         ywtzBgAzemC8YwFO95wG03HF6reNRs6dZU+fBvXPwgSizK9J9OYdU1ffH4GyLvG6XzCy
         EHU/WbJ3JSfiYn3eWjyZt0ALTWtiHBUBuLuLWlmqDNvhoIxCtjm04rus9WuF9bxE9Uj2
         LjjZJEAURsC6FjXwlT+Bm3xUS0pW4+gQAe5GKsG2FT1zKyRMu1b011hs0THxZAzHR+s8
         fZ3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rf+hdqUt;
       spf=pass (google.com: domain of vkoul@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=vkoul@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rf+hdqUt;
       spf=pass (google.com: domain of vkoul@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=vkoul@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 17 May 2018 07:40:09 +0530
From: Vinod <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
	liam.r.girdwood@linux.intel.com,
	Keyon Jie <yang.jie@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update sound/soc/intel maintainers
Message-ID: <20180517021009.GP13271@vkoul-mobl>
References: <20180516194901.8128-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20180516194901.8128-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600651492835951658?=
X-GMAIL-MSGID: =?utf-8?q?1600675398989096129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16-05-18, 14:48, Pierre-Louis Bossart wrote:
> The information for Intel SoC drivers was not updated for several
> years. Add myself, Liam and Keyon (Jie) as maintainers to get notified
> of contributions and bug reports. As discussed with Mark and Takashi,
> I'll also monitor alsa-devel and ack Intel patches as necessary.

Yeah somehow never added this, thanks for getting this done. This is the ri=
ght
this going fwd.

Acked-By: Vinod Koul <vkoul@kernel.org>

--=20
~Vinod

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa/OSBAAoJEHwUBw8lI4NHGuMQALOngIKt/vREawbgl5NIu1LI
Kvd7JYiS83Q2PkGaaCZm9npuFh3Pb9WBipXjL0DBF8rbJP8m50PCBbK28ioO/WCV
azB+5caK5mcSx86wJ+wr96p+YCvlQQy0ix/H/mqfN8DjdIG/NyO3mfCFbBm8mUjX
DvxdvORHq0HzRIGKJRFpzU1CuPIVxze6421MaJRjTqy2ufnn3uY4UBUYde36EHTJ
zLOmt+4FiWkbPBfGnNVbx20aC73e3awJLwlEfEOr6yKcMuAkCQN7iCbsKIhK0Gru
SKQMWW5I1iPD/n5x2pOe/6UZLV5Mpo/RRH439c2i/8waTCsigeR9hU+qDJywMmVj
opEwxU79z1vyXCUsvs0yhL9I8+4+jWVaj3euio8J56aFEgKQWsLz6B3oZ6d+gmHy
pg0VDY3iXHqYVaehuw9W2J+/RO866yi0cDBX6XiYmr/12sVvAL73i6nId7IjCter
pskyBtvsqKZks+krxsaw2AfwE5BZ7uRDQhsTEd7a9Oum+n8ocdJT/5ZwuDJb6TM8
E0DsI7dMSQdsq45VVVl0ktA9aX/0Ub9m57UvIKbd+6k0jpmeN56L6dJNpwB+Ec9B
BjsY5GOynTidlYPJs9e+Tf0scjc3wR8wi9Wker8yjOs6/zu7j2iIEh6y+J4qTE2J
OLgxBf7LNnRQ84jsovEx
=Lq7f
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
