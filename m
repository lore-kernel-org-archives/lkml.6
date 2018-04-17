Return-Path: <efault@gmx.de>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523982390-2-5361359851052521741
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_LOW -0.7,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='212.227.15.19', Host='mout.gmx.net', Country='DE', FromHeader='de',
  MailFrom='de'
X-Spam-charsets: plain='ISO-8859-15'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: efault@gmx.de
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523982389; b=NzpghiM39v+Eeeb7rfFTIdVkK+gp5rTId3LslCok9tuOdwW6+C
    NqYOx/yCtJR01M01xvpiC3ZmSbZYBkO2LkY8DDdJfUofRX8hyQyHC2i/oGsRkSkZ
    QtNYTOaV/6673NIfvAac/zCGFamOW+/cr6Mq1DS+mTamsPFpv83V5ypLgGvsNeS3
    ix/StuEl9h0vmjMHPMkc2lBbjRynCMLZGaY68weRlcVrdQwxbAeLchRtV0/Otc2d
    UFxX7Mpg1me0XU3+F/f4fxam2TjUjb+8ev5QuZM44NKDzTt8DP3SJHDF6OO/qvfh
    Z5wqgrIp1kb6jxCaylSq03Lr4XvA/KDunWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding; s=fm2; t=1523982389; bh=y1jDN4Y4tHfv
    GOAnqAg9Z4sYk+C2bYRZ9unST+Mcbms=; b=PM3mgMnO0YHYWumTdnEFVTk0asPM
    CmgqDmjJ6mP1YRMTEV33ZEUiA+FIfxCgSkEf8dDsUpdl90ZR1XTYFEiMnwSB0aVO
    nrW+nar3a5JZWMR+EY7E059vHZY7BO6UmGqICo6/pdflFEpIYXw2yDqZTSgPE0eL
    2il1TKmIkaJaPz9l+mfG3az9yRQSQqGVzVWkeA41WVBkhRp6PQzpSb5CkvtCxjpn
    PYih5Vao3NRo0t1PfinA668AvIVDGT1hacrckaKHzar9mefG1xIlAaMD7nIrbrm6
    sb+cJDv/N52F7rEeXTEsAvM6H8+LZrlDBes8w45PDXLcqBsCpHg0WUtWsg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=212.227.15.19 (mout.gmx.net);
    spf=pass smtp.mailfrom=efault@gmx.de smtp.helo=mout.gmx.net;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mout.gmx.net x-ptr-lookup=mout.gmx.net;
    x-return-mx=pass smtp.domain=gmx.de smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=212.227.15.19 (mout.gmx.net);
    spf=pass smtp.mailfrom=efault@gmx.de smtp.helo=mout.gmx.net;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mout.gmx.net x-ptr-lookup=mout.gmx.net;
    x-return-mx=pass smtp.domain=gmx.de smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKSF639YKrMjlEjFRw9cLh3iWnvsTpwzxk9eJLCHJEhk1rdmlVOBC5O6F3njXoP4z3bhVJHM5OBKeSTLNHXmnyFCzr43D5+zibwe65X240c+fvnRaZBn
    5HFG0Gj0xsI7XqsPEAP8wqj4RMyzt/cWa4ajQVNuc3OAjKZGP/4Fx8jy
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=3TOKzCKRji10XXrfGWad6Q==:117
    a=saPhLZ3Eorw/gv/ySYuDbg==:17 a=Q9fys5e9bTEA:10 a=Bblfl5IsfdsA:10
    a=Kd1tUaAdevIA:10 a=pC-FsHXtNivBVjbK49IA:9 a=PUjeQqilurYA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Message-ID: <1523982346.7093.4.camel@gmx.de>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
From: Mike Galbraith <efault@gmx.de>
To: Jiri Kosina <jikos@kernel.org>, Sasha Levin
 <Alexander.Levin@microsoft.com>
Cc: Michal Hocko <mhocko@kernel.org>, Greg KH <greg@kroah.com>, Pavel Machek
 <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Steven
 Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Cong Wang
 <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka
 <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Jan Kara
 <jack@suse.cz>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tetsuo
 Handa <penguin-kernel@i-love.sakura.ne.jp>, Byungchul Park
 <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Date: Tue, 17 Apr 2018 18:25:46 +0200
In-Reply-To: <nycvar.YFH.7.76.1804171742450.28129@cbobk.fhfr.pm>
References: <20180416171607.GJ2341@sasha-vm>
	 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
	 <20180416203629.GO2341@sasha-vm>
	 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
	 <20180416211845.GP2341@sasha-vm>
	 <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
	 <20180417103936.GC8445@kroah.com> <20180417110717.GB17484@dhcp22.suse.cz>
	 <20180417140434.GU2341@sasha-vm> <20180417143631.GI17484@dhcp22.suse.cz>
	 <20180417145531.GW2341@sasha-vm>
	 <nycvar.YFH.7.76.1804171742450.28129@cbobk.fhfr.pm>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UFtDtfErrdd0RoP/5ezhLoog67TT8hjB5bZ22NCOLK0WgOC5qEG
 n1qQPq76B8jmnrPNpbP4dLiOv0kxBLZsudUNZzmWNL61K/t8SNZldXcUVsaC0kJvlUbxIG9
 T4c2UdEFJXaPYTtil01yM+fRDw7PZ37jZlbbNfFntYDNlEepIWSNsNF/BIrwK9zoIgdIWF/
 4ycbXfUwZBM1hzFhZYDmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2yHEAHyQZ5E=:9UEvI8V45ANGkfoweYvxA0
 hzIcDzOyFhQRrRFmR6lYsGJDarMu4066XItoWBJEfcciD6zIyn0kq5BK8nkOgezHNP4fVWFrQ
 iCuiJqad7Y4HU8uWaVb2kdQLo7kt60Sv9IGGoOS0VPqjxpiU0Dt+K/PiTS4Fw+awcjCGRzkTF
 /mm4mqGGcPRGZLoZkjHSk+w2WFZBDKJ2CaCinEpnr2r+KvfCHhszmPXuv5e6P0YS1nAgNUjJl
 4cd34m/fwUup84zZI3IM+0XnBaMTmDrMC5Nv5KyCoFcCWUUgcUVbA/DgW8e3lXWLteP7WT3W9
 eMr+lIj/idV7CPpEL3yGK9zNzgKgKoCTVVPNWPx33I7YPfS+JkwsrvzUQgqMVx8h5mcKuoTDO
 lHrvBZR5A2RwQdVRxt0I5o9LqdwhFbqBP/umkIQ8A/XLBV87bnmfC8/BXp5xzYMpximKoiMHb
 BcT04eCv55cu7n2+OxtQ8/l537FZ1lkPEzmwLLsktYxMAcY8skXz5zHSc8cXepEGDLvNHe6ap
 7AelS/aAytskmQOz8ChH724pZJz0pQCwWJ6c2UV6KzqIxVf4vBmstSwANV4mgT4fulWjUIWvD
 7jnKYHpFrfq5kPUIvgrQP47PrYajWLvL7AVeqmm4SXbQ9s84rtwNiG9dM8MuuxE1cC1RW3qgg
 e+nMgQCaRT+fmFe/57o0RlOyhOxcrmh3ANgcaEOBwk0MmElQS1wMY5gk4SO9qsSBAP/wQ6R1p
 cXWB3QB+eUATShTfAWWrope/Hbd1yAVOXaVJyxTCZz5J0wQY/OsAtTnROpHOii+8M3sNLj64G
 SdIPcDsdQz6Y7Ze5ilX7uCA1bQR8rsUGoOQC9APVdM5ZJDs20I=
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-17 at 17:52 +0200, Jiri Kosina wrote:
> On Tue, 17 Apr 2018, Sasha Levin wrote:
> 
> > How do I get the XFS folks to send their stuff to -stable? (we have
> > quite a few customers who use XFS)
> 
> If XFS (or *any* other subsystem) doesn't have enough manpower of upstream 
> maintainers to deal with stable, we just have to accept that and find an 
> answer to that.
> 
> If XFS folks claim that they don't have enough mental capacity to 
> create/verify XFS backports, I totally don't see how any kind of AI would 
> have.
> 
> If your business relies on XFS (and so does ours, BTW) or any other 
> subsystem that doesn't have enough manpower to care for stable, the proper 
> solution (and contribution) would be just bringing more people into the 
> XFS community.
> 
> To put it simply -- I don't think the simple lack of actual human 
> brainpower can be reasonably resolved in other way than bringing more of 
> it in.

Not to worry... soon enough it'll be submitting properly massaged
backports of the stuff it submitted upstream :)

	-Mike
