Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AB8JxZpA+oJ8KntNEGLZ4EtGC0vkXH78qPXCmreKGgzHCfAKroDWGsxaLEbejF3/y4hSHJ+01Jeg
ARC-Seal: i=1; a=rsa-sha256; t=1527050774; cv=none;
        d=google.com; s=arc-20160816;
        b=H4QLlht5EnH54oYe/Io/gG0I3fGoOTcsUNoVJU1S5cu875t+dnNV2Gw5JQj+oa3xsy
         L5w8fLLMymAgXpjYi+ioHsjdppa0PVrqj8V64REco0MtnZu7H60DGmOU0Ol97zmS+vOH
         FeDGBxLHFuzV8vtkgCYu0b62Zyab6PUZe0dWVTo7rpPhdOZ5wLxpvrZP96DAkT1ySNND
         6F9aT0sgV78CNu0AMRxcetfsy2KRAMHEBMP6LFWBd3k4569qJZmsJ2wD1lvLRZQbJgdy
         NoobqrsaeB4cK91W8fiAC4NhpeWSA+fOJ4SqcRgUyi3yOAgGotdikikgb/DmeRYNMsYJ
         OlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=rnUtoUWWVtClWZmnWYBR9WYx/BE6wnd1VMCtwvmw3tE=;
        b=zCZt5wmxd35OaZTWgj0gSLB66B69o5Y05V8kiUDtYBeo9bBxXAzXMlmsnJjwxeuzD+
         0COfoBn3iWBb8R6Z15EB1EeIhzdxBDCQ1Nwn5XOUi9nadlpmV0DP2uWgmpL2BVx4T1+x
         T9QESd37qV4bnP7hE9Bvpr61E5aV/zZUqKGlZEALuO36gOqvsM1PGQwWxzZen8JIiQ3E
         YB5RxW/Jr2esLRVzvsf+9dTQb4bGZG5i/OzPivAM/aw8hFDmjmXA7jgS+SZICtccHEVS
         evUPu9yrFBKwBBHjCRSaw4a2CCy1C4YTYSRCwy29MZ9vvYiNwp1FPqfm+FBxwvYyXYJu
         MAKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Wed, 23 May 2018 06:46:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michal Marek <michal.lkml@markovi.net>
Subject: Re: [RFC PATCH 1/1] kconfig: drop localization support
Message-ID: <20180523044609.GA23800@ravnborg.org>
References: <20180522194928.GA29900@ravnborg.org>
 <CAK7LNAQUF6YbHRTJOtQ9F91M-iqF1U+PemDAbsdx3qzcqg4Ufw@mail.gmail.com>
 <CAK7LNAQWHeR71=H5Z94jAMjRjE-kmjFaPrQy6_cd5=G_WHEpUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQWHeR71=H5Z94jAMjRjE-kmjFaPrQy6_cd5=G_WHEpUw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=fhXao1oWnKnNjbk9AckA:9
	a=CjuIK1q_8ugA:10
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601195024335317921?=
X-GMAIL-MSGID: =?utf-8?q?1601228793418697125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masahiro.

> > Ulf Magnusson originally mentioned this removal some time ago.
> >
> > So, here is his tag.
> > Suggested-by: Ulf Magnusson <ulfalizer@gmail.com>
Added.

> PHONY += xconfig gconfig menuconfig config syncconfig update-po-config \
>      localmodconfig localyesconfig
> 
> 
> The 'update-po-config' is left-over in the PHONY assignment.
Good catch.

> This is simple, so I can fix it up locally.
Fine

If there is any other feedback I will respin the patch.

	Sam
