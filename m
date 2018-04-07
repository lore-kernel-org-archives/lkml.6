Return-Path: <johannes@sipsolutions.net>
X-Google-Smtp-Source: AIpwx4//mySbG1DKMDd7ufngoP6m3ONfTMtVnqJO/F0jqXYra4hcDcgsCPC1fuCqaOVyWsr5/wO1
ARC-Seal: i=1; a=rsa-sha256; t=1523128746; cv=none;
        d=google.com; s=arc-20160816;
        b=Jo4m09AKEyanRpX4MVJBSv4xCh7c8/y+iA5/wS9Kr7/b2yFHQg7/O/QZjv62C9H5dC
         xJR7wlN7G4U1IsLMIo767YeQvgO0NM4TlNxMHKK5Qmx4IjjDF4Qeyqu6BLXwaqZB8Dtw
         e8E0hTc+oc6xknqfE8of6EMHxAzATAOs13Wd6LTDHmoHQ3UfvOF3Au+iKndRlB91iB9v
         KVn3toK6wLSwZIsr3bL49Dasw1V207lKv/j6hBRtja0CifwnZsxiHAKFuokxTmNdakLh
         kiJxBrcrfKVqn0SoQRQgUC1t9Uxy72vZVikM1rHmp/OSK+Ng5jdr917dF8bMhQwDK6kb
         t5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=WkV6CzwBODBKw2NLXPKtU3pwPRkvz0FQwJun7H5i0T0=;
        b=XMOSSoyf0Jw5yq2wbkJrGrZ0MGQzlyh+QtnA2LBYg5Ns3Lq725L1TaN+Hv6a8kdQWj
         m9LhTaz084Hf6CDA8QQz1kgT4xa+fuih05pb7BvBI4PGX1Al0HPvm9g+FvfSFGyMVcxc
         NIEr81oEP3K6r6xnqzuep5m7BU5c3nDHkiTD0tA18XVelc7VrkcJtGTpha73qyJljIhJ
         PYQtsMwTTmPnb50Lq76KOtpZUjRTuNryL3TtZc0MmP5WzlNw6OytLHvyRxcQyPQKEC1l
         OLgfozbBvtqtnmiMjF6IYZKyRHPLbxN3WQNKkZrsFZ0WRFss2+LPwyAN2pNDsoaIePkQ
         qA1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of johannes@sipsolutions.net designates 2a01:4f8:191:72ef::2 as permitted sender) smtp.mailfrom=johannes@sipsolutions.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of johannes@sipsolutions.net designates 2a01:4f8:191:72ef::2 as permitted sender) smtp.mailfrom=johannes@sipsolutions.net
Message-ID: <1523128743.6507.5.camel@sipsolutions.net>
Subject: Re: make xmldocs failed with error after 4.17 merge period
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Heiser <markus.heiser@darmarit.de>, Heikki Krogerus
	 <heikki.krogerus@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Masanari Iida
 <standby24x7@gmail.com>,  LKML <linux-kernel@vger.kernel.org>, Linux Doc
 Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>, linux-usb@vger.kernel.org
Date: Sat, 07 Apr 2018 21:19:03 +0200
In-Reply-To: <B8BFEE5C-F2CF-485D-80D6-8EC31EE2429C@darmarit.de>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
	 <20180406075109.GA21589@kuha.fi.intel.com>
	 <20180406075734.GA16728@kroah.com>
	 <20180406081555.GB21589@kuha.fi.intel.com>
	 <20180406083010.GA20174@kroah.com>
	 <20180406091126.GC21589@kuha.fi.intel.com>
	 <2A917B38-AFF6-44DC-A4A9-796B2BE560E2@darmarit.de>
	 <20180406105139.GA28862@kuha.fi.intel.com>
	 <B8BFEE5C-F2CF-485D-80D6-8EC31EE2429C@darmarit.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596966487828993292?=
X-GMAIL-MSGID: =?utf-8?q?1597116248784027630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-04-06 at 13:38 +0200, Markus Heiser wrote:
> 
> Sorry, not yet. Johannes started a discussion about this. Its a long
> time ago and I do not have any new ideas yet :/ see:
> 
>   https://www.mail-archive.com/linux-doc@vger.kernel.org/msg07035.html

I still think the tools themselves don't matter all that much, as long
as there aren't totally onerous requirements. I'd argue pretty much
everything available on a modern distro would be OK provided we have a
reasonable fallback (e.g. to ASCII as I had even written), along with
some sort of documentation of dependencies, or perhaps better, some
command line option to gather the info dynamically.

But then again, I've already said pretty much this a year and a half ago
and most people seemed more interested in some kind of purity argument
than having better documentation :-)

johannes
