Return-Path: <mrustad@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518370847; cv=none;
        d=google.com; s=arc-20160816;
        b=jyFrHe0QiGqO4KS+w97q2PCkGaw1h1qwKr29Q06MHXFNOUVSwIq7VpQ96ZwWVPdhZ8
         3KldqRB15ulbdaE++M+FHPwCxfbXKZv/QWoZWme6+r78tvjAL/qff8zIAj0I/GsS/Ehv
         f7L1cU8UNEwbxx//BTEur1lohtfLCS28HNKiSr69Zv5B211VaZnkpkObnBVsASOW5MRT
         edN8WZ60mPjw1bj3NikX2bbbHsNGc9tML89nzpJ+smX5Be4WbrNfHyVBgwf5kKjoNLJj
         ZLkEGFxCV8LCihsCDCBdVdqCaI5uTH5hssAy09dTQs18W5fhphEelCX6G0YhzqweXuKq
         dGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:dkim-signature:arc-authentication-results;
        bh=04OnLRblxY/vaf8XU/knIIFW7JdsQkAmK/bnZu43e74=;
        b=t4P2e4NAvZtnB/LX2HuumGDS60Ua5dzHR/XSebUK8sMnWXYEVn5NhnUa3cInA7NlcN
         Qj+mVJbI5a4ZllJu8Vf8eOhy00K1n7WHiXvMVmyTrIq7BV4pcw6seBmy6Fin9IEidjP6
         H0Dhz66WgtdDTEvGNmwjEEwO3/9ZqgBGQ+XBVygQJ8dgn11AYEQDruMVQEYM4hAlNDpd
         6SHPiT/OXWe5UdV1m+9/DIZ6rmCGds/8G0071TmkRSNNEN2RPjS4VJMkSWVQagl7Oe61
         j2xOONI2+qgYJTNXmF59d33sZVHcqqhKCgbBdhfkChkaJywYkyX63YuGuByFaOGVsgZD
         C7bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KVaHeGCy;
       spf=pass (google.com: domain of mrustad@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mrustad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KVaHeGCy;
       spf=pass (google.com: domain of mrustad@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mrustad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225A2l646kJzYOEXyLK6rPK3aHryryZcOTuocnjw4WYtBgSlcfdm0YOdhK1HWcjMHDoaMENf9w==
From: Mark D Rustad <mrustad@gmail.com>
Message-Id: <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DCD15F6B-F8AE-4A90-959F-96DD4FD7056B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Date: Sun, 11 Feb 2018 09:40:41 -0800
In-Reply-To: <20180211105909.53bv5q363u7jgrsc@angband.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Joerg Roedel <jroedel@suse.de>,
 Andy Lutomirski <luto@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Dave Hansen <dave.hansen@intel.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Juergen Gross <jgross@suse.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>,
 Jiri Kosina <jkosina@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Brian Gerst <brgerst@gmail.com>,
 David Laight <David.Laight@aculab.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Eduardo Valentin <eduval@amazon.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Will Deacon <will.deacon@arm.com>,
 "Liguori, Anthony" <aliguori@amazon.com>,
 Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
 Hugh Dickins <hughd@google.com>,
 Kees Cook <keescook@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Waiman Long <llong@redhat.com>,
 Pavel Machek <pavel@ucw.cz>
To: Adam Borowski <kilobyte@angband.pl>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de>
 <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl>
X-Mailer: Apple Mail (2.3273)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592127230306513677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_DCD15F6B-F8AE-4A90-959F-96DD4FD7056B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On Feb 11, 2018, at 2:59 AM, Adam Borowski <kilobyte@angband.pl> =
wrote:
>=20
>> Does Debian make it easy to upgrade to a 64-bit kernel if you have a
>> 32-bit install?
>=20
> Quite easy, yeah.  Crossgrading userspace is not for the faint of the =
heart,
> but changing just the kernel is fine.

ISTR that iscsi doesn't work when running a 64-bit kernel with a 32-bit =
userspace. I remember someone offered kernel patches to fix it, but I =
think they were rejected. I haven't messed with that stuff in many =
years, so perhaps the userspace side now has accommodation for it. It =
might be something to check on.

--
Mark Rustad, MRustad@gmail.com


--Apple-Mail=_DCD15F6B-F8AE-4A90-959F-96DD4FD7056B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlqAgBkACgkQPA7/547j
7m7WqQ//dL2W2MDxrxtXXgkVjhGojpNcHzpDqPCADZDc7qu0oTnN/po8Cel4KP2n
Wz+nuvnBAWjJdlyo+SAprxBqYRxxTa5u3laswYaouwWptmxvMn7B3KJu4tQWsZpd
bFDxlk8nY2gMnNqMGe4ScVHgXOXLUl2hlSA0OJ1GAp/lHUx/K33B542y4FiXeQ9G
oB5OPSJBGmPb8c+/XrSgDsFVo8bWili4Ubbk0Tdu4JNGaz1BD323u8NSJGh8S0ME
RIYu4hfDZtQJ5slnTU67cxt2R7fvMAzxRpCCeM4QG60aGvkN3CycmfGuxSk6y7K8
g0XsoIOsXwjLoSMtaroMFw7Mo8W+aK0VZ8+ZOC53qTaArVb0jb31SGEtb7C7cI1M
Vjn3ttS8YNDpUDMEBM3+khj6LNH3Ukf6GcoVg/Z+ZUU3IurTHrU93rV2JMplXLua
Qrza/Ei8t0EbgpcXc9qCY3bPOAL+reESKoBfBoxQsBJ2HGvsWVsKIdvZ2BhbnHPe
wiGlw+1s/230B7HRU17eihyftpDi+8CrK30jE6qP3hjpLYJYMJKpT9pxPXMnDujV
8jPmCbhP/DCMRDPKvdpzchAyUN2zIUf9xYsCuzzqXYN9b9dntAJKNrD/ynnbLybr
ntvdu1ByozCeHtyhJaNOSD+tUtF6MDskIy6ySTYJ/xaL88QXi/Q=
=VaGL
-----END PGP SIGNATURE-----

--Apple-Mail=_DCD15F6B-F8AE-4A90-959F-96DD4FD7056B--
