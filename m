Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AB8JxZqs7nGqa4PvlDHkUm11BJrrVn3oGwvl2uZDSny6/898tCNUnuGePoC5SN13zrRDQc4eCo85
ARC-Seal: i=1; a=rsa-sha256; t=1525961275; cv=none;
        d=google.com; s=arc-20160816;
        b=SRX5BuXM+CphWNIWqBGGB5HIE3WH6YkB89BrzBGFy2lNRE5rSDs2rZrhbm+RWHGpYE
         /olajxViBBAMa6SD+bpi+k5FDK3do025gs29yAc8ZOVRCdSfmdD0VQlwhsu5xz/vKoCZ
         UtXMP+QgW8PQzSRLTEvSBx9MZNr5zbJc95w0XBfT9igmr+5yVqnIAlRqCg5fX9HwvATI
         sa2QRgLf2slWzkftYuXJOHUNty38JTqfTo2ytdyhnsLz6Dwdiuz59Hwy9ccOKVQsdP48
         WMIcmcIW724ayy6LbqQqDLAOApQOrO2lPkv974gLEp2w6PEMZFRMuBlXe8P2W6XkDLwb
         HX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=KXTLju5iu3CjXLsjF6aLGaZFCqqxao8I133w2QV6kpM=;
        b=SXKsW2uO4wM03dQhfnze9PPjlsgpXHhctCtVIjBc8b+vlQxBIlAf+alf58jqz+7cpG
         l9UDLVzuYfTpSSZgEkdXbae5GbWOBdkmJNZxo8LlQgjo+1aPlmj66dqbrLW+u0iCvknp
         /Mbg4J17m41Z5pxTqrR1y2fHDASLcoKZwuAE6nWEAWxO9dizaXGvNHN1qtpOItIN4fjM
         wOLA+FiiCaCJUIzS5wL6A/5WF0caEhZg0japzh7L6dbZmZv4BIDXWTMwll3oV3w/hTlp
         3XlLmGA55cvF0anDyb57DFYm+5Imp2LrPPJhR/du+tJkSfIqGH8EtiKqB4FHhNB1SxkZ
         R7CQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ccV5k2Rp;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ccV5k2Rp;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 10 May 2018 16:07:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: Re: [PATCH v1.1 3/3] objtool: Support GCC 8 switch tables
Message-ID: <20180510140723.GF12217@hirez.programming.kicks-ass.net>
References: <cover.1525923412.git.jpoimboe@redhat.com>
 <60ba92277204856ced0723f7d7ca52c691baace3.1525923412.git.jpoimboe@redhat.com>
 <20180510084125.GY12217@hirez.programming.kicks-ass.net>
 <20180510124424.uauk7p4uzsfon4hs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510124424.uauk7p4uzsfon4hs@treble>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046846156782249?=
X-GMAIL-MSGID: =?utf-8?q?1600086370033027444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 07:44:24AM -0500, Josh Poimboeuf wrote:
> On Thu, May 10, 2018 at 10:41:25AM +0200, Peter Zijlstra wrote:

> > Could you maybe detail how the GCC8 switch tables are different? And
> > thus what needed fixing?
> 
> Good point, how about this?

Thanks!

For the series:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
