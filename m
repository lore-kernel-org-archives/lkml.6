Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZpya4jfdIrYRbrdgyRFc+Z65KGEjpFpw30f9n+Ve3+ryiCVLOpTHqZkk8uog83alBljB5KA
ARC-Seal: i=1; a=rsa-sha256; t=1525967879; cv=none;
        d=google.com; s=arc-20160816;
        b=jjsG7t5tn8vNespk2/6kA3/3hLSObhCsupkVRWGTpS6BpAaCdhziMNsXFi4hL/FQyY
         EPgbVP8o7bv4cqYYYkKJL9Cx9iIzFFxnocAuZ0Pf2GCoRR0nkEZXpV5TGMnQzUDmKDax
         o0Hf+tkF4ZBuDly2NTn3wNfWnLIhcEHpQeR4G7/IRD1OKN+vA3XaB9l3I8Sk/gTWPXSV
         BbUW846fFTp2dUHQS4vbIjpJAjAjdEh8a6VmfqZevrP+5kUu/BJdDFWIazDu5r6XUaU2
         DFMVyJHh+S8gKNeridD4SOpZXUnLWzQ5KlH3tDz4YmxObRg2AglyEzgby/z43VKPT0Ye
         p9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2VROEj1/qE89nk+KUk/m2tBPaYh+MCNQBj2NgX3ljxk=;
        b=xcMhr7wk/ARJC2uB+P8jlJK3hCsZ2nQXs4lv5hWq/ArKZLgCl9gg+pbYKS81nhr8Hz
         Wsh2EcODmTBRUPNA5N8fY1qDPuYc3CNMOPR2aB94qeQc7vJ+XOa34RNoih7268Tde32B
         5fYHeYz1uwe43nQGRDn01P3YexVEjvny2yjgVF11+0gY9r7gTUfZnNsbiE/Ao9oedKVW
         Mg4VsebyQ9RRpdqHC59BufN/MzQyydaSeuzSfXERfjpY9NgFFXrL62hg/Q3liB86HLLf
         u3R6A1aEwwQJvlzJhj/arMkeF67p1ZulTdfr+cDzrc+Wwc5gcJ/8STYwitNfTvXhFMKI
         MfBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Thu, 10 May 2018 08:57:55 -0700
From: Tony Lindgren <tony@atomide.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180510155755.GF98604@atomide.com>
References: <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk>
 <20180509204727.7ff38021@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600093295070636802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Stephen Rothwell <sfr@canb.auug.org.au> [180509 10:49]:
> I currently have 44 such fixes branches.  More welcome!

Can you please also add mine:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git fixes

Thanks,

Tony



--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkgNvrZJU/QSQYIcQG9Q+yVyrpXMFAlr0bAAACgkQG9Q+yVyr
pXPEpw//Xf2XUKq9mvoygg2qozGp0qMdr4i/+4t9hP8gwYl2ZXlmzeaVoJvJb1jb
xE/bKEMazXZ0xs3k9kDIqeZAG/f9TRT/BLJudkjGm4iJz49FA35rp1caY2OEjL3z
R3AmDsaREWSQ+rEuWU0M8wtroxbsEmNEtYF1EpAL7St0eQvfHIvQhoN17Gnf81tS
/OoBpNyupNaooZY17xtf7/OSGJgdkfvoh3Mpntvkv5k48tLGo7BHhjxgwYLf2xo+
VSlcaB+To+Hvf+1qpuqEhsgY8kODL/f7oBB/bGsXfQ4SnAwnBUErYGudS/c9D8bz
von8xjXAPCIvtJ3g7TKTfaQemffGnQ0gpUPcOcu8RS4aew3dGyssOd/oC8C3pGLy
E9LrdBfHaB2/mQPyuK5zBozFgrjbC5/TKIFGpt0NxG4GC6jQFN0HR87MXIdDTjaF
g3drs+aqR7GB1hgmb1KyCNP+fryRGO4Z5xZ6nMzfiP/nsROkDTd5qF//K4tho0bT
rAuhpUXw67iF7tBBBDQ3zUEgdzlWx9MTlVnt8YYcLPF4YQd5ATOqXNroi382YwES
tzkdNTfY6pvDWffNSYCSCaeMWM9YS7d5owjMwP6LX4itEq+I1kpOz/hvfWQzkkNV
GBYLHZGIpX9eHNzPKob5yWoLy6qJIOoLH9+d1ruTdFJ24gg6HvU=
=GSF7
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
