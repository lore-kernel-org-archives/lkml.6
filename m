Return-Path: <tiwai@suse.de>
X-Google-Smtp-Source: AB8JxZpr+gHIgpjjY68LqJIb92+DGhMlLG/MnK5HmugKUhqwpWinVYTk2Yrgma23+faM1uVlkgXr
ARC-Seal: i=1; a=rsa-sha256; t=1526195617; cv=none;
        d=google.com; s=arc-20160816;
        b=AyvOFCUuVLvElFcPhloIVvVYBTQsQHEiyU8QzODQjwqoSN7ebrtTJto/Ny0b4r82Wc
         MnN3Otofc3ssMfefJtUkhuWa2AJeCm4TXISPZ0O3kwkVooLvZHnk0ir1poJsRehimqGx
         DZ9Jpwc1kn+97cHb8HPTGNDpEJ90behdbzXfttnPlA6fswgONhuHlVEwZO1WcblPykvu
         pNrbvBTexVlkcO2olXDfzZ3quyA7gWRQYDU6WGAwdEASBTmtSTixM5EQNkxLKKWAKEIG
         tfcYcla1l/Cq8e5/ccP8BFuTLIDaoB98SroB2PXLawkwvd/SApXtJaSp3fP9wzmtkfMr
         62hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:arc-authentication-results;
        bh=kteZdiOjWNaBuaIXQVCy/8T5PCsXhAFGan5PQePHKtk=;
        b=sKWZ7bVpe14uBwdITGASpYADU83S+NYCOZai/hlTGAB2Xh+xWOkn2+l12dQuQY8a+3
         HTWnbDja0pi0PCo+oQycU160kZ7OYvCLGvF8rWLpUmBKjBXTtrhC8QgSw2Y144nGtqyy
         XQyQopt0COUMafIyCANhyeDgXTBQgA6ODckOdikVFp4yrf8JYLscoXhZzMYpzdVASNse
         YELRMkCZTn+d3i4uexPrkyvUSJBh3B6K9qMCQddSeGFxTH3OtsnlWc38WHBPBTlqRJGf
         SahFtzmhOj5rYzwhtGQLKVQqYlg8RLZqw8ncoAUmLeuRwQBexF2yjo9XcbbtSOJPLTY/
         jbtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tiwai@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=tiwai@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tiwai@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=tiwai@suse.de
Date: Sun, 13 May 2018 09:13:18 +0200
Message-ID: <s5hr2mg81v5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Cc: "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,	"Jeff Dike"
 <jdike@addtoit.com>,<alsa-devel@alsa-project.org>,	"Catalin Marinas"
 <catalin.marinas@arm.com>,	"Mark Rutland" <mark.rutland@arm.com>,
	"Will Deacon" <will.deacon@arm.com>,	"Russell King"
 <linux@armlinux.org.uk>,	"Arnd Bergmann" <arnd@arndb.de>,
	"Michael Turquette" <mturquette@baylibre.com>,	"Sean Paul"
 <seanpaul@chromium.org>,	"David S. Miller"
 <davem@davemloft.net>,<devel@driverdev.osuosl.org>,	"Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>,	"Akira Yokosawa" <akiyks@gmail.com>,
	"Boqun Feng" <boqun.feng@gmail.com>,	"Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>,	"Harry Wei" <harryxiyou@gmail.com>,
	"Max Filippov" <jcmvbkbc@gmail.com>,	"Lai Jiangshan"
 <jiangshanlai@gmail.com>,	"Kent Overstreet" <kent.overstreet@gmail.com>,
	"Nicholas Piggin" <npiggin@gmail.com>,	=?UTF-8?B?IlBhbGkgUm9ow6FyIg==?=
 <pali.rohar@gmail.com>,	"Andrea Parri" <parri.andrea@gmail.com>,
	"Sudip Mukherjee" <sudipm.mukherjee@gmail.com>,	"Malcolm Priestley"
 <tvboxspy@gmail.com>,	"Herbert Xu" <herbert@gondor.apana.org.au>,
	"Steven Rostedt" <rostedt@goodmis.org>,	"Serge E. Hallyn"
 <serge@hallyn.com>,	"Li Zefan" <lizefan@huawei.com>,	"David Woodhouse"
 <dwmw2@infradead.org>,	"Mauro Carvalho Chehab" <mchehab@infradead.org>,
	"Peter Zijlstra" <peterz@infradead.org>,	"Luc Maranget"
 <luc.maranget@inria.fr>,	"Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>,	"Josh Triplett" <josh@joshtriplett.org>,
	"Jens Axboe" <axboe@kernel.dk>,	"Arnaldo Carvalho de Melo"
 <acme@kernel.org>,	"Masami Hiramatsu" <mhiramat@kernel.org>,	"Namhyung Kim"
 <namhyung@kernel.org>,	"Rob Herring" <robh+dt@kernel.org>,	"Stephen Boyd"
 <sboyd@kernel.org>,<x86@kernel.org>,	"Matias Bjorling" <mb@lightnvm.io>,
	"Linus Walleij" <linus.walleij@linaro.org>,	"Mathieu Poirier"
 <mathieu.poirier@linaro.org>,	"Thomas Gleixner"
 <tglx@linutronix.de>,<linux-xtensa@linux-xtensa.org>,	"David Airlie"
 <airlied@linux.ie>,	"Alexander Shishkin"
 <alexander.shishkin@linux.intel.com>,	"Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>,	"Ananth N Mavinakayanahalli"
 <ananth@linux.vnet.ibm.com>,	"Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>,	"Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,<dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <user-mode-linux-devel@lists.sourceforge.net>,
 <user-mode-linux-user@lists.sourceforge.net>,
 <xen-devel@lists.xenproject.org>,	"Jonathan Corbet" <corbet@lwn.net>,
	"Michael Lyle" <mlyle@lyle.org>,	"Michal Simek" <monstr@monstr.eu>,
	"James Morris" <jmorris@namei.org>,	"Richard Weinberger"
 <richard@nod.at>,<patches@opensource.cirrus.com>,	"Boris Ostrovsky"
 <boris.ostrovsky@oracle.com>,	"Gustavo Padovan" <gustavo@padovan.org>,
	"Eric Paris" <eparis@parisplace.org>,	"Paul Moore" <paul@paul-moore.com>,
	"Jaroslav Kysela" <perex@perex.cz>,	"Guan Xuetao" <gxt@pku.edu.cn>,
	"David Howells" <dhowells@redhat.com>,	"Jiri Olsa" <jolsa@redhat.com>,
	"Ingo Molnar" <mingo@redhat.com>,	"Alan Stern" <stern@rowland.harvard.edu>,
	"Juergen Gross" <jgross@suse.com>,	"Stephen Smalley"
 <sds@tycho.nsa.gov>,<selinux@tycho.nsa.gov>,	"Jade Alglave"
 <j.alglave@ucl.ac.uk>,<cgroups@vger.kernel.org>,
 <devicetree@vger.kernel.org>,<keyrings@vger.kernel.org>,
 <linux-bcache@vger.kernel.org>,<linux-block@vger.kernel.org>,
 <linux-clk@vger.kernel.org>,<linux-crypto@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>,<linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>,<linux-security-module@vger.kernel.org>,
 <linux-usb@vger.kernel.org>,	"Chris Zankel" <chris@zankel.net>,
	"Antoine Jacquet" <royale@zerezo.com>,<linux-kernel@zh-kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 09/11] docs: Fix some broken references
In-Reply-To: <e959f23d6f6905ee606fadfda13e2bb37deed017.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
	<e959f23d6f6905ee606fadfda13e2bb37deed017.1525870886.git.mchehab+samsung@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992730865491295?=
X-GMAIL-MSGID: =?utf-8?q?1600332096010968528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 09 May 2018 15:18:52 +0200,
Mauro Carvalho Chehab wrote:
> 
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
> 	./scripts/documentation-file-ref-check --fix-rst
> 
> Manually checked if the produced result is valid, removing a few
> false-positives.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

For sound stuff, feel free to take my ack (if it's not too late):
  Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
