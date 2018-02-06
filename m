Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AH8x2276U2+Iu916qjmrDImshZnd5EUMCvy+1bYAmq7vESpO+hhZX/IOlOtdyhzxBXbRJN39lAnZ
ARC-Seal: i=1; a=rsa-sha256; t=1517954446; cv=none;
        d=google.com; s=arc-20160816;
        b=Oo/pdHcEjFdw92y6sAKKghMsemY5uBgTz6mB2HOrucXEm30kRYITONoTaT2JBLmHF3
         30cW0oh5HRN8Yp3+sgoqsVELv2C3z/xiQzQ5n026Z7B3ZzqYP/YuArPUe8zwyRGl875J
         MbYnIQuOX+js+UTi1wvi1r6fdM8NLDQMqEVmCL/arPSt2jugqbSvUkzcwzHAFxrjwOJq
         c/Fb3kIqovddcvckjjCjjMDRn/Yz1JngDlo7sSmBig95b9hSr1bQwFnuGC2c4Jiqp0DV
         IPzjDJcrrpNWdpuhOMP7KKJpCdqsBQB5Kw2q1i2tRSH3CFJU6gYHgSA9hPo9a0MFFG2I
         MjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=QP+E2ncN2U67KhSW7/qYZrXeK7VmVtCEqFY0njwrD1U=;
        b=iQx5kbfKIRKkR/KOsbUl5PuanPYOWp9h5CXtSvhZBeCxcxBJMxpEKN3c17rx6g9ubz
         RqyNvqdWdmcZ+ODK0vZcpCvzkBUFsFDWSrWElxzzuqAuJ3Jj5DBlwf6/0u4qU1ONsZjP
         /aO4zvKinE1OuNvvJQGp6dJx86KBRSYKp+csNvUOcdhost+D1IvoDlfraOfaSHOJd7RF
         ovYGR27JzQG6vX8iyCt4sSQ+n+eA5ET3L0DYNI2YshkIiIjROqipkZlTBIadbYjoKAag
         ZxRfiUlmx0ycSIFxleg/5dooYyadFK6bwMEh5xmF1AqdDRuJiPZccWcbtMKB180RN415
         etnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Tue, 6 Feb 2018 21:59:59 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: tedheadster <tedheadster@gmail.com>
Cc: whiteheadm@acm.org, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh
 Dickins <hughd@google.com>, dave.hansen@linux.intel.com,
        jikos@kernel.org, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, Jamie
 Iles <jamie@jamieiles.com>,
        eduval@amazon.com, labbott@redhat.com,
        Rik van
 Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Message-ID: <20180206215959.0f640736@alans-desktop>
In-Reply-To: <CAP8WD_Ztwp3dLvv+kbQ9QizWHWCwpZnnXxQ++Z0OVnLnaj01+Q@mail.gmail.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
	<1517643438.31953.108.camel@infradead.org>
	<CAP8WD_Yrp5g6YZwV+XQTx93YpTakWEL8MD+p0bZDaPi3-r88JQ@mail.gmail.com>
	<20180206190233.GA10476@kroah.com>
	<1517944227.3677.15.camel@infradead.org>
	<20180206191355.GA7424@roeck-us.net>
	<1517944648.3677.18.camel@infradead.org>
	<CAP8WD_Znj+zG6hVD3zV+9tTJs0OEZtbQTy=XGOj3hurtRRXhVQ@mail.gmail.com>
	<CAP8WD_Ztwp3dLvv+kbQ9QizWHWCwpZnnXxQ++Z0OVnLnaj01+Q@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591690601973013096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> If that is correct (and I might be wrong), then I am up to date and I
> am still getting the following in /proc/cpuinfo on my Pentium 4M i686:
> 
> bugs  : cpu_meltdown spectre_v1 spectre_v2
> 
> - Matthew

That's an interesting museum piece. It's a Northwood core so I believe
the reporting is correct.

Alan
