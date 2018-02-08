Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AH8x226ksNcwCS6B6vUJ5pCfOzqCCSyBfgBwrNvd/5W1pH6wx42TbhRNTwBrB+a0Ib3s8/HcHcWZ
ARC-Seal: i=1; a=rsa-sha256; t=1518097720; cv=none;
        d=google.com; s=arc-20160816;
        b=Znpb6wsCnP8Zhip4Hoz32KVfz9mPyQHyXJPcyLH1CDnQebjjv1CAfrft0DMQzQDd8G
         Log6gqk+9AKy5/Pwe4fIfw1RusuzRJV34nmmnfVUSUY9RukK9jt/TxXtyDmIcTjxT9WP
         CdZRochOz+OyI/wk72Z2R08KPqkyn9VEAk0bGJoJECBBhoo1lOaImG1D2WWCI+1xSHsd
         8VPgxJf9S7FdyFANaAfsgl3mBcECSwakCKBnczdLqeUe2I0IP9gizKjrjs99K98bbCL4
         rZJTL93bFRnYjPPfz99yeBg8BYmcFjibkMOGHCx7dMg5dJ75ey/z2FBhCW7BkP8VgrkP
         NfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=81thfF79QQ7ElS52WYx05GIDEc1xLc/oQSud3r8W/P8=;
        b=D/tMC9houS4hSq/zSslWqnzgVySFGtC0oCnR4Ni8OenaD5yIpann1Mz/knPaV+cWQ/
         CQxi5kW0g9PbfPumo7T2/7iBEfUG8KVroHMu0O2ERoi/m4Ohq2iMXF5pvqCku2A7IZO5
         ig/mod8+Qy6fMnRPknbId44RmgKOH1RBDU4rBmIhvT9quM2qE4w1Lh3k+3q37sctYcyx
         10d1OCtASu0RzNDgYz+o6vY0hDJCT6Lpo5x6HoiiikLgAcYjoe3p43LdRIZo0mwE92xa
         CK0Qlu7M4mPwc8/cwL+S1K0wQIPDozPU5nFqyBcskAtGvL8RCa9bT11h276aThklAI63
         nuqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,478,1511856000";
   d="scan'208";a="199666131"
Date: Thu, 8 Feb 2018 15:48:28 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
	platform-driver-x86@vger.kernel.org, x86@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
	Haim Cohen <haim.cohen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
	Jim Mattson <jmattson@google.com>, Kan Liang <Kan.liang@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Len Brown <len.brown@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Piotr Luc <piotr.luc@intel.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sean Christopherson <sean.j.christopherson@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: Re: [PATCH v6 00/11] Intel SGX Driver
Message-ID: <20180208134828.hkrslcoa5xzznkj3@linux.intel.com>
References: <20171125193132.24321-1-jarkko.sakkinen@linux.intel.com>
 <CALXu0Uf6qOg4-4aEfepD9hxXsbUtayndNC-nWc_Ymc5psCdEwQ@mail.gmail.com>
 <20180109142730.ndhxmw6p22kae5fv@linux.intel.com>
 <20180208084653.GA4595@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208084653.GA4595@amd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1585067671616283380?=
X-GMAIL-MSGID: =?utf-8?q?1591840835358741939?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 09:46:53AM +0100, Pavel Machek wrote:
> On Tue 2018-01-09 16:27:30, Jarkko Sakkinen wrote:
> > On Thu, Jan 04, 2018 at 03:17:24PM +0100, Cedric Blancher wrote:
> > > So how does this protect against the MELTDOWN attack (CVE-2017-5754)
> > > and the MELTATOMBOMBA4 worm which uses this exploit?
> > > 
> > > Ced
> > 
> > Everything going out of L1 gets encrypted. This is done to defend
> > against peripheral like adversaries and should work also against
> > meltdown.
> 
> Yeah, but useless against spectre and ability to introduce bit flips
> means this is generally useless...

You are right.

And what I said was simply false. In fact, the encryption is done in
LCC.  I'm sorry that I didn't response to my response and gave incorrect
info. I simply forgot to do this, no other excuses.

/Jarkko
