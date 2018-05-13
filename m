Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZrjqp2nP+FTG5ZH1Zalh7pteJy81dfs0bZeNnOTVg/4ITEkuxPyMedtgJMIDJMYdgefd7O8
ARC-Seal: i=1; a=rsa-sha256; t=1526178462; cv=none;
        d=google.com; s=arc-20160816;
        b=DtdhAt3Oua1jE8ASfZmaaCwCgX0zLEK4xcahmgRI2XDZ3pq62fjXtVRiRFW/UIW9mQ
         WODHpH7/odcJSyjhd1ZIv0UcYRhWVAWDEegEBG5LatR53DMSbU0yeQqqV3AI1jV5VpSJ
         07TKlLIbOBBYDs28losdr/aQWPgFUM82dYmv+5m1DDNSmoE/BLKq0FT8mWNR/pliutAN
         +nrq/2LoNpRfUI3rKvbHsCRqcGy7dN41yYjSEpoSxFrkIvWpU0ocjgqdyad2ecyqd+zv
         AvrjDqUEVVCP1L0z/4jWzeZXaQX9KcZlEDLhzFS3ZbRnQ5zxtGWzkerI7XuiU/bqPaPl
         pz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vXXBz2gsuT9hWGYv2PO0qD90LgduhLaMv7O5zOToJPA=;
        b=PGoWlQUM8+rM+83ACP8mSqJsWQ5SKPK2fyeqY/zfMV5nQwdcGokfTYuPXnuIL1BM3S
         CXX7ZMJ8TTgHtfMX4kkkwjXGrYIyJXCAruAip5JsphoSgVNu3wiF2tJt1q1nIrhCUjLq
         aSuKwHTwOpuMNWeKznMYbsIG4xgKSUIUBqw4Wcgasxh0Cib7ecL8VGvTi7imjyCTCIRT
         NWds/zTNJ44sengx/OQxp0i/tfiRxuKtOusg1W1aqZVAQk3EGyugO5y0VfvCuH/jzsbs
         8gryKCWWW98SSlhh6Bi3tk+PVtMphTKX9SeQpy786unuEeBtUAMjz1oimZesr3zN3Htl
         ODzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=NFyorH7r;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=NFyorH7r;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Sun, 13 May 2018 11:27:26 +0900
From: Mark Brown <broonie@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/2] regulator: bd9571mwv: Add support for toggle
 power switches
Message-ID: <20180513022726.GI949@sirena.org.uk>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdXyWs1v_D4EUd-H75Q3cpQv6yD2V_MptjJP7FjYhu5c3g@mail.gmail.com>
 <20180418140041.GD10061@sirena.org.uk>
 <20180419201356.GC25034@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
In-Reply-To: <20180419201356.GC25034@amd>
X-Cookie: Falling rock.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912189945282587?=
X-GMAIL-MSGID: =?utf-8?q?1600314108082321094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 10:13:56PM +0200, Pavel Machek wrote:
> On Wed 2018-04-18 15:00:41, Mark Brown wrote:

> > Please don't send content free pings and please allow a reasonable time
> > for review.  People get busy, go on holiday, attend conferences and so=
=20

> If I follow the logs right, there was one month before ping. That
> seems pretty reasonable time.

Right, but the content free bit still applies (as does the bit about
resending which is the main actionable bit for people).  The two go hand
in hand so often that I just wrote the one thing for both.

> > Sending content free pings adds to the mail volume (if they are seen at
> > all) which is often the problem and since they can't be reviewed

> Yep, and sending content free complains about pings also adds to the
> main volume :-(.

They're not content free.  They're telling people that if it looks like
their patch has fallen through the cracks then they need to resend their
patch and why, without that people (especially newer contributors) might
not be clear about what to do.

> Anyway, last time I sent you a patch... you _had_ time to complain
> that I'm pinging too often, but you apparently did not have time to
> look at the patch. That patch would have been in time for v4.16-rc1
> IIRC.

If that's the tlv320dac33 patch you sent a followup in the middle of the
thread with what you said was a current version or something but never
actually sent that version as a regular patch submission.  You'd also
managed to not have the ASoC on the front of the patch which pushes it
to the bottom of the review queue, it won't turn up when I look in in my
inbox for ASoC patches.

Now, I for whatever reason didn't explicitly tell you I was expecting a
resend so you didn't explicitly know that this was what was going on
which is a good example of why letting people know what's going on is a
good idea.

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr3oo0ACgkQJNaLcl1U
h9CS8wf6ApsNWMYuWBEkqkstpUS9gBhwblIChDzGTN9pCR+q3NecEWlBqFCQpk7q
LtjULLle6h9CJAh2+ECSLHkaLAVT5Gh1aTU6YcvGabU37dqUUMdLx7cCFetfSWX9
XmRedqvm6O1KsSrr4zCg9jUNZakjRg1A7mw1+nvsQKHlxuecx5514I8L8n5A2Is9
M8UDI+TtaDJMZzmQWoK8/2Z5lkI1krrDXAH5zLhpEmJaV7vwNI9kCFmP/E9Sxswg
99nh4mdin2w5j0akKNCariNLv3FmaVAVbEMtp+cv8NnyaMvAgkjpfZMtRF1wB6T/
A8DkJ+qqVEebHes1voGfo1JxwePDdg==
=f9+n
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
