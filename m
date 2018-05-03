Return-Path: <pavel@ucw.cz>
X-Cyrus-Session-Id: sloti22d1t05-2309188-1525341885-2-8999801874044799245
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, WPBL_RBL 2,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.113.26.193', Host='atrey.karlin.mff.cuni.cz', Country='CZ',
  FromHeader='cz', MailFrom='cz'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: pavel@ucw.cz
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525341884; b=YDlJE2bdzb9IKSnWo1Vhiyv6cHROfUXHjVablQDhPBrn9AUzm0
    1jDWXsD76zic3VwvWfKUmpqxeBGHd2tmsRE+ClR9uX9AxBuOmhuieUWB7bk4GKUq
    gMhrA9I7bSxd2wX2G1hphTPIFgq7+UhX0Q1kIlMGpQAn8tDgg39oSAE0WywwzjX9
    WqDGHQI1oCR5rD5n6TQJwf7mvXUzs73UEONAkaE5mj7uXJwQlfOKrS/F9JA6EfXG
    hRbvqPOeU55zPRvjsuW+9mjskOMlgmkdnp/kU2qEqvbq2lJbSM1YtRrAx0r00TfY
    Dq9jrERKyr5sN0QunWfWi2b5r4QDb8CmRRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1525341884; bh=AeYv/tAcGAN4aMymh65Ro4Vtjq0H0qJUZcVgPeTWB7E=; b=W
    NPoZIjzrPibpmdkFkV6054ap1kKmavq7NGsprJDsDoOp2hkKCGmPMKKZjWytC1+o
    6g61CWpUdAnMEJZx4Jsid2ICTJ5unLX5E+BQ9uV4UGeEfkoVwNnBFr/dk2gzB0+i
    kRo77FxIJdsOZt8Mvr1JBCa2hdN2mVeeTEUnfnlV5jL+ZjE+vDrjgpM3p0T95TIa
    3PUOrC2BUMz1HSic8v5s+plY+BXb/wrwPqXneszfERdmryrPBuxNm6dwf3/0tOBD
    KcITtCNu2JlF8l6DZOnsl3dVuz067kccjO0L8zrfhKVHFgvruY+fri38ZsRloWXr
    jeEMwY1FbhjIPGlgu8oCw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=195.113.26.193 (atrey.karlin.mff.cuni.cz);
    spf=none smtp.mailfrom=pavel@ucw.cz smtp.helo=atrey.karlin.mff.cuni.cz;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=atrey.karlin.mff.cuni.cz
    x-ptr-lookup=atrey.karlin.mff.cuni.cz;
    x-return-mx=pass smtp.domain=ucw.cz smtp.result=pass
    smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-51 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=195.113.26.193 (atrey.karlin.mff.cuni.cz);
    spf=none smtp.mailfrom=pavel@ucw.cz smtp.helo=atrey.karlin.mff.cuni.cz;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=atrey.karlin.mff.cuni.cz
      x-ptr-lookup=atrey.karlin.mff.cuni.cz;
    x-return-mx=pass smtp.domain=ucw.cz smtp.result=pass
      smtp_is_org_domain=yes header.domain=ucw.cz header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF2fz5sK9DIc9dbT5XKlMnk/RSA1KO9NNDIArYFE9P8JgJ3in6CYyPAAAjfQxgNS9l9K72KalBbsfwEKBiBLjCSsk2IipjXcbxsbwUxnJWq1yiQQ5GKX
    FMu0l5LsjwN8Y22A2Ws4b494hySMsQD6tqwPDK7O6RVNU+TodMqIAx/XIWUTsMVQzAfCPt4kv3Y3mQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=E+/PIkTXOk9Cia4AHJaiXw==:117
    a=E+/PIkTXOk9Cia4AHJaiXw==:17 a=VUJBJC2UJ8kA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=w8aTxdAGIl5jrrBm8_gA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=BAz6B0Azokup4dhzIHcA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Date: Thu, 3 May 2018 12:04:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Jiri Kosina <jikos@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180503100441.GE32180@amd>
References: <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
 <20180416211845.GP2341@sasha-vm>
 <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
 <20180417103936.GC8445@kroah.com>
 <20180417110717.GB17484@dhcp22.suse.cz>
 <20180417140434.GU2341@sasha-vm>
 <20180417143631.GI17484@dhcp22.suse.cz>
 <20180417145531.GW2341@sasha-vm>
 <nycvar.YFH.7.76.1804171742450.28129@cbobk.fhfr.pm>
 <20180417160627.GX2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <20180417160627.GX2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-04-17 16:06:29, Sasha Levin wrote:
> On Tue, Apr 17, 2018 at 05:52:30PM +0200, Jiri Kosina wrote:
> >On Tue, 17 Apr 2018, Sasha Levin wrote:
> >
> >> How do I get the XFS folks to send their stuff to -stable? (we have
> >> quite a few customers who use XFS)
> >
> >If XFS (or *any* other subsystem) doesn't have enough manpower of upstre=
am
> >maintainers to deal with stable, we just have to accept that and find an
> >answer to that.
>=20
> This is exactly what I'm doing. Many subsystems don't have enough
> manpower to deal with -stable, so I'm trying to help.

=2E..and the torrent of spams from the AUTOSEL subsystem actually makes
that worse.

And when you are told particular fix to LEDs is not that important
after all, you start arguing about nuclear power plants (without
really knowing how critical subsystems work).

If you want cooperation with maintainers to work, the rules need to be
clear, first. They are documented, so follow them. If you think rules
are wrong, lets talk about changing the rules; but arguing "every bug
is important because someone may be hitting it" is not ok.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrq3rkACgkQMOfwapXb+vL3WgCePfWMg7iZHBhdexYMSWCmEBeL
m0QAoJ423IJ5qO/X0Qh+fM867kCxABvz
=7e2E
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
