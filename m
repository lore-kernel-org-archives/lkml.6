Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-519562-1526287887-2-14450841064187643750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526287887; b=nYDNL7EEqybrQcxHL7pPmOf1fmZvn0LZGa1ur5/c2cxzGSyaBk
    0JY9xepwvw6k0e9Y2V1Xx+PlytYiwyebYMpsMjYuxHmO+285xpaHWo/WBEdH3XcU
    5aWla0kex5gjCue6BaNO7aJIW4focUUaLLUeO6E1yRTNPfcb3m9XGT7WQJ6aMLTN
    SOy64DiilNvz20wpMmwFsED/TEDbyO+W8SI/WMSjsIPJtFXFJVJpmMglHYLCoRP2
    HycrOhQ51apEbGPY4U6yZwv91OD7lRd/9Irzq45hbwps2IRXcqSSWpDW8L0uTCM6
    bHYQXtiHQxdCdg5pWGF3o3EBf6GA95059R7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526287887; bh=ajVKk
    CjZIaHWd4FzEnlns6sJnt8Y4tUm5+OwBMJi9GA=; b=LxvErSm1RGTIETHFNLtuT
    sIt9HDb0VB52kEs9uqJXXt3mQYnRI4nMr2Y/hrzEIHEPRhJiI5wxF5LEpNlIpUK+
    T1ef7kaJJh/vjWAamVXqRD+ZXkaTH2WEqqgTjeg75OAnT/WApoGVqbmNEg+rTiEL
    /fiY7PsZy/h3wJjaulzDHz8PjsC0jZYeRwsx/+/Zb+Rv24N1YZRc5OZ5T+LBkbW5
    lMhTZGTJ426USN+Gih/BB++yHhw6yDyB+Yvp2htca1Tk54h344B3nXFg43BYuyUR
    wEeJfA5F5SO1nwgFKEwanDM/R7dB5HBzJ84qRceHjYuiGagTI5faRoOveumfDEZH
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=bootlin.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=bootlin.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCDLDsh66VvFk3+eaPGiK8Lwiz7T+o97CQoyATilDayahlT+Prtrwt4oG1B8KF+QWZFG9tTlkBjpnmprG5wJNEK0pHn1cGDxx0V0rvIAdTxPlyoN7QmH
    1j8fcNumVba3Gmcbd7WjXh6h2qyqKDcwd5ChGHEpG0ECKpKPzJIyfKisfoqVe+91DbCuBjG4c5u3fteeujqir4EvZ+8MhQpXpvttdyIuzySfXg84Im4/znFj
    t+9E8gUAqc0/fMFNqGs7jg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=P-IC7800AAAA:8
    a=yMhMjlubAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=ag1SF4gXAAAA:8
    a=eyfXnrM7WqHJlwu2--UA:9 a=CjuIK1q_8ugA:10 a=Oj-tNtZlA1e06AYgeCfH:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE
	autolearn=ham version=3.3.1
Date: Mon, 14 May 2018 10:48:03 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20180514104803.23d2a8a3@bbrezillon>
In-Reply-To: <CAMuHMdVwA6jK1fPu3Dzc4-+_kWv1yTNvOGJP811Fdyrrnbc18w@mail.gmail.com>
References: <20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
	<20180510164722.GH8514@sasha-vm>
	<CAMuHMdWDNjsba29id4Svjy_tauKivWDUixub3qf82Nx_6rYueA@mail.gmail.com>
	<CAMuHMdUHK=kmJB-=G-Y7YEneZityMzi5YZ3nJFD6uCs61bOaiQ@mail.gmail.com>
	<20180514101237.5df1e0d7@bbrezillon>
	<CAMuHMdWQTOioXPmWX+_jetECpp9=SCK_BfWq9kJ7xj3WTnB_ng@mail.gmail.com>
	<20180514103428.55285a70@bbrezillon>
	<CAMuHMdVwA6jK1fPu3Dzc4-+_kWv1yTNvOGJP811Fdyrrnbc18w@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+Fengguang

On Mon, 14 May 2018 10:40:10 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Mon, May 14, 2018 at 10:34 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Mon, 14 May 2018 10:29:04 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> >> On Mon, May 14, 2018 at 10:12 AM, Boris Brezillon
> >> <boris.brezillon@bootlin.com> wrote:  
> >> > On Mon, 14 May 2018 10:00:30 +0200
> >> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> >> >> On Tue, May 1, 2018 at 10:00 PM, Sasha Levin
> >> >> <Alexander.Levin@microsoft.com> wrote:  
> >> >> > On Tue, May 01, 2018 at 03:44:50PM -0400, Theodore Y. Ts'o wrote:  
> >> >> >>On Tue, May 01, 2018 at 04:38:21PM +0000, Sasha Levin wrote:  
> >> >> > What's worse is that that commit is tagged for stable, which means
> >> >> > that (given Greg's schedule) it may find it's way to -stable users
> >> >> > even before some -next users/bots had a chance to test it out.  
> >> >>
> >> >> I just noticed a case where a commit was picked up for stable, while a
> >> >> bot had flagged it as a build regression 18 hours earlier (with a CC to
> >> >> lkml).  
> >> >
> >> > Also, this patch has been on a tree that I know is tested by Fengguang's
> >> > robots for more than a week (and in linux-next for 2 days, which, I
> >> > agree, is probably not enough), and still, I only received the bug
> >> > report when the patch reached mainline. Are there tests that are only
> >> > run on Linus' tree?  
> >>
> >> Have your received a success report from Fengguang's bot, listing all
> >> configs tested (the broken one should be included; it is included in the
> >> configs tested on my branches)?  
> >
> > Yes I did (see below).
> >  
> > -->8--  
> > From: kbuild test robot <lkp@intel.com>
> > To: Boris Brezillon <boris.brezillon@bootlin.com>
> > Subject: [bbrezillon-0day:mtd/fixes] BUILD SUCCESS  fc3a9e15b492eef707afd56b7478001fdecfe53f
> > Date: Mon, 07 May 2018 20:05:52 +0800
> > User-Agent: Heirloom mailx 12.5 6/20/10
> >
> > tree/branch: https://github.com/bbrezillon/linux-0day  mtd/fixes
> > branch HEAD: fc3a9e15b492eef707afd56b7478001fdecfe53f  mtd: rawnand: Make sure we wait tWB before polling the STATUS reg
> >
> > elapsed time: 49m
> >
> > configs tested: 142  
> 
> But the failed config (m68k/allmodconfig) is not listed?

Yes, that's my point. It seems that some configs are only rarely
(never?) tested on my linux-0day tree (probably because they take longer
to build), and I should only take kbuild robot results as an indication
not a guarantee.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
