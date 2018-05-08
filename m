Return-Path: <zarniwhoop73@googlemail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525813687; cv=none;
        d=google.com; s=arc-20160816;
        b=Pbq7JOFFcDRhur+NyyU31otjj/DQ97hNd9zv1ph1Wu4DzrtzLnMhWl8k2sBWlgutUi
         b+dWsdzYDU97wpC3R05dFmmKTheqAqKWltYE1oLctTN+QqqwRRlAyMlcz+buNC6U3Izp
         ITsEKZ6q3Bl2gPsZE85RlLViQRO6IwgBc6Sjo9F6d7mdUK8xEYTlkcjMxFjRDy4X5R4g
         qHfPtJzBAL11AOEjktdLlQyQ1caghhdANGTL7ASyQm3knWze43YKy5i1ZsuSVzB/lvCh
         YIEU9v/0uWnJhE6lyKYiDwG26KYnrVAp8kImBlOiJQRpXd+hVYidvkip3rHU0DQ6MzGU
         fBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=r0l2tPwo0X8O9wHZOTdHSipnEaJWMP851vRZYSGwOMA=;
        b=E+nUJcXa1A7jewBzEH2wjYHWzDZlHAzIjXoqzl44pCzI31VeBh9IttNQPpAzIE1/vy
         EiUZ3pePNdbtWvG+d1+iHlMhfBoy6pb8nVyNLOmyncdJqezfRP1pTzaNqBbUJ9TP/8cY
         B5r7txg+hkoLheMnsQhhH0wITkjrfG77xf72SWC6EpXKDHN3ZueWHQW2c6Db5FzqGL8x
         FMHO000o0dB0kGqpRj3u1h0V8SMVTYNp5Sv8dNgJKOTJnWu9Vmf69wLva1BBcBBVFYxV
         dh1q4Ax80nERwc8vhAR2Y3GCzmjayei5ATGIRtgDG6gKynC4uTFOoyKIo+zZ4SmGwIjQ
         paIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@googlemail.com header.s=20161025 header.b=Q14Co3oO;
       spf=pass (google.com: domain of zarniwhoop73@googlemail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=zarniwhoop73@googlemail.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=googlemail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlemail.com header.s=20161025 header.b=Q14Co3oO;
       spf=pass (google.com: domain of zarniwhoop73@googlemail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=zarniwhoop73@googlemail.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=googlemail.com
X-Google-Smtp-Source: AB8JxZpujHl1pH1LBn+qtd1ra6v7ZpaVSK0svB2/myX1CQ7FDdM2u62aSCkKiTcTFhBnvEFsxCnjXX2zsJO37hZnVS4=
MIME-Version: 1.0
In-Reply-To: <20180508202912.GC8514@sasha-vm>
References: <20180501211551.GI2714@sirena.org.uk> <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org> <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org> <20180508202912.GC8514@sasha-vm>
From: Ken Moffat <zarniwhoop73@googlemail.com>
Date: Tue, 8 May 2018 22:00:49 +0100
Message-ID: <CANVEwpawkz0FHii-QOKLj+=WELf06F+mWPqs5L8DA_n4fetLGg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Tony Lindgren <tony@atomide.com>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599931613413216524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 8 May 2018 at 21:29, Sasha Levin <Alexander.Levin@microsoft.com> wrote:

>
> This is interesting. We have a group of power users who are testing out
> -rc releases, who are usually happy to test out a fast moving target and
> provide helpful reports back. We also have a group who run a -stable
> kernel (-stable build/distro/android/etc) who want to avoid having to
> report bugs to us.
>
> What we don't have is a group of people who use Linus's actual releases
> (not the -rc stuff, but the actual point releases). Power users will
> move on to the next kernel, and -stable folks won't touch that release
> until there's a corresponding -stable.

I resent that assumption :)

As a 'prosumer' in this context, I try to test an early -rc (usually
not until -rc2, sometimes not until later, depending on what I see on
this list), and then intermittently I spread the testing to more of my
desktop machines using later -rc versions. Once linus releases .0 I
hope to move my current systems to that in the next few days. But as
always, other things (sometimes real life, sometimes just new changes
in userspace) intervene.

After that, I will pick up Greg's latest if I build a new system
before the next kernel release, or if I become aware of something
critical (for my usage) in it.  And then probably 4 or 5 weeks after
linus's release I will start the next cycle of testing -rc verisons.

So no, I rarely test Greg's current stable version, but there _is_ a
period of some weeks where I run .0 kernels.

=C4=B8en


>
> Even rawhide, like Josh mentioned, will just fill back with the merge
> window commits after the release of an older kernel.
>
> So the problem I'm seeing is that since a merge window is open only once
> every 2-3 months people will sometimes try to push poorly tested code
> just to make that merge window. Additionally, as later -rc releases
> start showing up people will again merge poorly tested fixes just to
> make it in time for that release.
>
> For both cases, people will push poorly tested code in the kernel just
> because they want to make it in time for a kernel release that no one
> will actually use.
>
> What if, instead, Linus doesn't actually ever release a point release?
> We can make the merge window open more often, and since there's no
> actual release, people won't rush to push fixes in later -rc cycles.
>
> We take away the incentive to push poorly tested code. Maintainers still
> free to commit anything they'd like, but there's no reason to commit
> code they're not confident of just to make it to a random release no one
> will use.
>
> Merge window will happen more often, so there's no real reason to rush
> things in a particular window, and since -stable releases every week
> there's no rush to push a fix in since the next release is just a week
> away.
