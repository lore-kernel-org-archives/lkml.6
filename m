Return-Path: <outreachy-kernel+bncBCS4V27AVMBBB4OCQHKQKGQEG4SZ7QY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520460146; cv=pass;
        d=google.com; s=arc-20160816;
        b=i5S8HJtcGlJSohWatD90gdK/8zs97mw/aJyc3tP/H6gye5H4XjezsmWn0m9vsmbNrX
         Yei79a/14xIsHQmRdPeHtbYzDevS8dxizAS6WmBZ+KzSfhkwzm7294gQ5vbee51JH3Sb
         5GukpvoKbB/RAZtUCzPEJCaSqZnmmOo8T0z3UJ/xaQwDxS5ByrFfwedltzZA8X7hegwe
         zA5xU1M4nWUgdVMFc+g2JZ7So4oCThdTNJLK45jJmmMPSEZGm2ApNNXEArP//1xMV+/n
         ApD0Y2OKL/fNjDVavLECpohyCUThdLZ+VcALUAA8WHf5TwKyAslCNm09yp0U01d3br3r
         y8lg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=ac6fe5TOXaZET8V5agpTtY/b1NdPxfnFOrKPhIlcYKw=;
        b=wRTfwoJfNo4csc/SsLXhBEONlqrYaWlDAbQEzn0grB66ZnxKIvHh8Vl7s3TU69mEzc
         xofnP3cRHzECHMR9ToKolNWVWlyf6EAkLKVMNXaPBgQw57bpotvgbzKKSwf0LevOFeXq
         CzNRgcfOgTDJ77rhFIR7GD7S5NIJHZz1kYlzlXni4C3srfttP1wnxu8CLjqJBmHK/pVL
         IzWpvZkZQi4bs+hHpOzIrHrJJVXtj7YkgGw5fcFJrgiCmjfBgd2qXqNG2hVoSuvog0qb
         2gRETjp0RpYDp1I5xcoxinC9d2LC2LTZVlcSB4fnO5ap71puQ9+phw1VdC/Nj0dnZhHt
         v7+w==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Op7jYo+k;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcs4v27avmbbb4ocqhkqkgqeg4sz7qy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCS4V27AVMBBB4OCQHKQKGQEG4SZ7QY@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Op7jYo+k;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcs4v27avmbbb4ocqhkqkgqeg4sz7qy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCS4V27AVMBBB4OCQHKQKGQEG4SZ7QY@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520460145; cv=pass;
        d=google.com; s=arc-20160816;
        b=Cr0TvOuNlgfplqwkAeVxh3NiICkCy59sG8GpVnY6TH403i0MeEoI5LvJ6akvpE3XsO
         R120kS/HKPxjNG0j8U0wLo9Lv3FAxHawtulJIEDBbl4xN6dEVapa/GsUoDN1DSa9tHSR
         VmNW44toOPDhpihSBRW2X7IRhW2dicbIbnHi/aoIX7+Y0KYncgAm+wI/v5oBdpJWIcge
         eyIpZW2Qj4RYFU6FoWryrj5bjf5QJ7BFtEDWbsGMlRxCpytV0Jw6KXyXgcWW1NytipCd
         oZn8qjvnblZxxQLdwifQLOlXdB4Cr/k+xzHugQMDyWJTkWVoTQCCpjijXat2h3m5uTtF
         YEtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=ac6fe5TOXaZET8V5agpTtY/b1NdPxfnFOrKPhIlcYKw=;
        b=ey2i3igKgWetbepNhFNw7HEFHuoxA9XGy676J0hPrJ/Q5RcvtaINTRNlhlfzwy0LPx
         A2ps/ekKxeoGB+VZOe1QMA4phBnGk5uGyQhkCqglgE1SOMXe1VREjO6moU74cVeJbLRF
         RbYXC8f+LBFm6zesLoriBs2We5AV/DM8QudqAuDDp4j0Cce0SVX2waNEI9QW48IJDA3j
         /HSz4jozVN5Gf7zwf3MJRQslttahi91esYS/G8qGXhRVLni42n//+/MYnlogEWgzCJ9b
         Hu6V1woZwsdGf5kgvG8dyMIaJB4SIrnBiwwipFsgrq0RFn8iMkTU6uywI0LAcLV+TrTV
         ZHMA==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELsjBek0mU5MAfof1Mg2/VHWQVkxOjOcAAf/DW075TAVhXkNIcLZNKAQgAwWjDLgxyju8WGnsw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520460145; cv=none;
        d=google.com; s=arc-20160816;
        b=YTUWG1evznobbZ32xRipUfm2tgPhqpRr1qr4HCL9Sc6Cjb9nGqnTaFfZ7a+8kiQbI+
         1QIFe1z9BfaUyLSChkrcyBjOqxylucwgehCfxNTcHtRqxJtDaHDi8dZwNnZwpEs2ASz5
         qL3bljBrtDaU8f2fSECWSllykXpDCSmY6Iy1+Dv5Ts+/pzaOdKLazz01nOs8gN4cukYq
         6bJUWGueJgAjtQHsK7eJcoIgK6nLhF/O285A+7eUxpcluPSfNE3KL14nAR56/OOf+3bJ
         iMakq3PUFfLPkKlIK30BrEFbxFhRE/hZlBBCDnBhvO/L1OWvo8DIxKKkURj/YP190omH
         BAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=TG2HoV1POB+2pieziZLl50ON0LCLz+HRq5GP8HNktjk=;
        b=mSFafu0+vYqiY/BAaXcUiC7JrXVhCOZWj6l4HabeRrmRB8OWmveLDwHyrezE8p+Lx5
         hZM5vVCS/WtjM7xz7thEEYDIieQsoZrVIiZRWaO+pp3Fk1Yzo3mDEfIJNKxycjRfIGIK
         JfgCqEm+AThXw19gWQoDOH/K9199sVezFh8+C+KwiPSJ9H4aoP3oM6VRNONIQz2hNAEJ
         2OiQhC3sx+Hp9fEBg5uAKEk1rzDnqSfR+KKQgSr3gb3YSEC0rvjl244Am11RYaG48yzM
         18qDSOgHfZYVAIWrflKJ77ggkSp9+/KdxzUYQbyMe2/jlrLg2EF2ylfXh5YGW6MOORky
         66lQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: boris.brezillon@free-electrons.com, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH] mtd: nand: Added spaces around ('='
 and '<')
Date: Wed, 07 Mar 2018 23:03:53 +0100
Message-ID: <4005910.RbgyVDuFdx@blindfold>
In-Reply-To: <CA+XqjF-2K48uEPHhgoH4K+4X0Gnr=S3VaG4-VeZ9urfsNEf3QQ@mail.gmail.com>
References: <20180303140233.GA9634@seema-Inspiron-15-3567> <2872216.aoWXzO2rYL@blindfold> <CA+XqjF-2K48uEPHhgoH4K+4X0Gnr=S3VaG4-VeZ9urfsNEf3QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: richard@nod.at
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning richard@nod.at does not designate
 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593925468888777014?=
X-GMAIL-MSGID: =?utf-8?q?1594318017846418754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arushi,

Am Mittwoch, 7. M=C3=A4rz 2018, 16:38:50 CET schrieb Arushi Singhal:
> On Mon, Mar 5, 2018 at 9:12 PM, Richard Weinberger <richard@nod.at> wrote=
:
> > Arushi Singhal,
> >=20
> > Am Samstag, 3. M=C3=A4rz 2018, 15:02:33 CET schrieb Arushi Singhal:
> > > Add spaces around ('=3D' and '<'),  to conform to the Linux
> > > kernel coding style. Issue found using checkpatch.
> >=20
> > please fix real issues. Coding style fixes to existing code just add to=
o
> > much
> > churn. Except for drivers/staging/.
>=20
> Hello Richard
> Thanks for explaining,
>=20
> > If you're looking for a small MTD related project, I can offer the
> > following.
> > Cleanup all ubi_assert()s in drivers/mtd/ubi/.
> > Some of them need to be transformed into a meaningful warning/error
> > message,
> > others into a hard error, such as WARN_ON().
> > Review/understand every ubi_assert() and convert it.
>=20
> Before doing this task, I read about this discussion (
> http://lists.infradead.org/pipermail/linux-mtd/2014-November/056352.html =
).
> In this discussion it is decided to split ubi_assert() into two different
> functions, BUG_ON() and WARN_ON(). Even some of the asserts can be remove=
d
> too.

Very good! You managed to exhume my forgotten TODOs. ;-)

One comment on BUG_ON(), we have to make very sure that it is not user=20
trigger-able.

Thanks,
//richard =20

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/4005910.RbgyVDuFdx%40blindfold.
For more options, visit https://groups.google.com/d/optout.
