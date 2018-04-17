Return-Path: <jack@suse.cz>
X-Cyrus-Session-Id: sloti22d1t05-1742877-1523966590-2-7671077651776825191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.135.220.15', Host='mx2.suse.de', Country='DE', FromHeader='cz',
  MailFrom='cz'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jack@suse.cz
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523966589; b=GdT4nCZDviRtRppjF+87WciNapGxeGL8seIe8yjQpy51zFgA4j
    2gg1SwKZGEo+AWGlCqabuMQ6vk0OIK1mirIrm+8Lk1wUrBFU0QLbojdqvoM1c+Gd
    0IFOV+VVKAJsq14FIp62F6w9qJJ8Dt1nJpSoOKc1um8ixB137i7dLMFudJAHoKUg
    lXBGxgQ/Qf46szs1iIiYXtuX9UjPHmtcQzJ9mju6WvpEOgg/+YfWFUmKSgAsrk8J
    TLEi26oi9aYS5OXkwtvJQnS+1So5fYmPUGYwvZlWS9ncWgg+btveOcGRCgjlJckM
    Ktb1iVIR817Wsufhb7dOeuInec3rz6R2lX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1523966589; bh=PU7vJk7wIMHRpD3O7L/mc99H1/9RtjxjMxnWGiP2r5o=; b=l
    JZHktmpmFq6QItwwlrQywNLgDhvvE7wC+G7YLhsuEhXCgk5j/KmW1MavO/IM0eW0
    6IrTA9BM7FXA69kujKfHW8dOIylBRD+HZ7Z6mjrbBiDqRny20TteWu2tIxmob5W6
    nIuKEVJe4KabeCaJNw63YoZK8OhjcLp3cg9+VbrnQ97w4O0G9u5Nn2x1UQBYnYHd
    sdG0yS/uvKE/pEO3W6iQa5+587so+L44KRRL2MlWLsmyKdl5cqegeFW1GMFASMRq
    krnk8GOjfM5HM94S4vvwBI73jTYmT7vn0hJxH1fYONiMeZRUOSo4r8jiv6Vm3wbQ
    diFFEUayBtyESrkfLxLtw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=pass smtp.mailfrom=jack@suse.cz smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=suse.cz smtp.result=pass smtp_is_org_domain=yes header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    spf=pass smtp.mailfrom=jack@suse.cz smtp.helo=mx2.suse.de;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=suse.cz smtp.result=pass smtp_is_org_domain=yes header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOJtK4hW84OTC0O2RzMsoPpVa8oRqXaUvZvwaO1ZY+NyklBXWo1WMeFstTBRoMMlh6Tv5lo6udJ32YYCw1/MGPsex0fIrAmxAeYVx9F9ot54WLNQwi94
    aC8CEa2ugKsOBai83lYD+btD+K6TglA+uH930iEJ7gcTHRLmXXEfAbP8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=uEuDQZVrWKuLCe7byFjfVg==:117
    a=uEuDQZVrWKuLCe7byFjfVg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=2C6YHBdLAAAA:8 a=iox4zFpeAAAA:8 a=Q_ymoEvpKNrtk09bwTUA:9 a=CjuIK1q_8ugA:10
    a=yxGMNg53M24zlVSZdvMH:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Date: Tue, 17 Apr 2018 14:03:06 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Greg KH <greg@kroah.com>, Dexuan Cui <decui@microsoft.com>,
	Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Pavlos Parissis <pavlos.parissis@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"jack@suse.com" <jack@suse.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mszeredi@redhat.com" <mszeredi@redhat.com>
Subject: Re: kernel panics with 4.14.X versions
Message-ID: <20180417120306.536sc3yzsndta5wb@quack2.suse.cz>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <KL1P15301MB0006B378757EC8F6B4D87BBBBFB00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180417103344.GB8445@kroah.com>
 <CAOQ4uxix615i5pVFURtfAH3OmgiYuy37WD7hM8tA=69OCv9B1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxix615i5pVFURtfAH3OmgiYuy37WD7hM8tA=69OCv9B1A@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 14:48:35, Amir Goldstein wrote:
> On Tue, Apr 17, 2018 at 1:33 PM, Greg KH <greg@kroah.com> wrote:
> > On Mon, Apr 16, 2018 at 09:10:35PM +0000, Dexuan Cui wrote:
> >> > From: Jan Kara <jack@suse.cz>
> >> > Sent: Monday, April 16, 2018 07:41
> >> > ...
> >> > How easily can you hit this? Are you able to run debug kernels / inspect
> >> > crash dumps when the issue occurs? Also testing with the latest mainline
> >> > kernel (4.16) would be welcome whether this isn't just an issue with the
> >> > backport of fsnotify fixes from Miklos.
> >>
> >> It's not easy for us to reproduce the fsnotify() lockup issue, and actually
> >> we still don't have an easy & reliable way to reproduce it.
> >>
> >> According to our tests, v4.16 doesn't have the issue.
> >> And v4.15 doesn't have the issue either, if I recall correctly.
> >> I only know the issue happens to v4.14.x and 4.13.x kernels
> >
> > Any chance to run 'git bisect' between 4.14 and 4.15 to find the fix?
> >
> 
> Looking at the changes between 4.14 and 4.15, that are not in 4.14.32,
> the only viable suspects are:
> 9cf90cef362d fsnotify: Protect bail out path of fsnotify_add_mark_locked()
> properly
> 3427ce715541 fsnotify: clean up fsnotify()
> 
> Both don't claim to fix a known issue.

Yeah, and the second one is just a code refactorization and I don't see how
the first fix could lead to anything like what's reported. So I don't think
picking these to 4.14 stable is really the right solution. We first need to
understand what's going wrong.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
