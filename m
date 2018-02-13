Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AH8x226Zs3iMrseTvqEARMlkxFj4yR9NSTlNpe/ifg7rR0ACVilBlF8zHeqgA2r+e84KN5wuoNYe
ARC-Seal: i=1; a=rsa-sha256; t=1518565587; cv=none;
        d=google.com; s=arc-20160816;
        b=UkxkI5DVOzTHMCyR1E+84tV2QQwYY64fDSfrjwgdgw0lU5nGq8R/rdpK6GdaNfIfPN
         m9rOxEqzn0q+Qny+jbRYPLmvH9RunwEpvg0tkAJvqMzkwluj6b5dKWRleBgbYJD24o5s
         srZSMTZ0QFnbUgSMn1CudRnrApFMUwgvNNjE4T4n/STuKKm2yt1LFTB5QYerFNn96U5r
         3HcpF5b2UDO9I7RoM/axttu0/NNZ3kzA9SNjquvFN3KYuvpSqG2hcenPDH9PEgrqe3QM
         qSc71w8gmRyU6dCjf/2WckE7fypt8C2Z9wm8rRPdZlzgnXHSGsrIKj09cLCFx+ahR+w1
         eyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=pMR65YC0uHDarB8D9G7i/vxqX9fHd5EFBD5v84VHsaA=;
        b=Fs0pKdfXwtc+OO4cMFIvnK1eHHrqQjnVe5JpgGQ8NyF3hiVKwWrWPi9AXZ4wyBDLBb
         6Wjmcehhlmzg6O0693exonfvLNT8v9HbhTQb4twR7jiv03qKAJ87KVMkMDTXLXxZxU9o
         dErqgZqQZ8ignXzYXwb8yo76XnC1Kxo82a6b23lXej5CvjyQDifPhUCFZOLpkhWiWv/7
         zmNHBWxD3IVr7Ztkve7LqSjLG4D8ECl7z//f8cAqjHEpvSyTlXiKqkqt1j9NQCspcajM
         nxypTFnBy7nse5tjK9L7pQeR5mBv1JS+Cw1VkW6k9+sOTLUxQxFI8Wu8J1lCkBvSER3O
         EFYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Tue, 13 Feb 2018 23:45:33 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: tedheadster <tedheadster@gmail.com>, whiteheadm@acm.org,
        David Laight
 <David.Laight@aculab.com>, Arnd Bergmann <arnd@arndb.de>,
        Ondrej Zary
 <linux@rainbow-software.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Hugh Dickins <hughd@google.com>,
        Dave Hansen
 <dave.hansen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>, Borislav
 Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, Jamie Iles
 <jamie@jamieiles.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Laura Abbott
 <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Message-ID: <20180213234533.368ce82b@alans-desktop>
In-Reply-To: <20180213210448.GB6569@amd>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
	<1517950494.3677.30.camel@infradead.org>
	<CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
	<201802070918.18978.linux@rainbow-software.org>
	<20180208134908.4b516794@alans-desktop>
	<CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
	<63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
	<CAP8WD_bF4jFQL=hOXRx97cyciq40MTJ9j8QwvJzLsn+LQudkmg@mail.gmail.com>
	<20180208205240.0c53631f@alans-desktop>
	<20180213210448.GB6569@amd>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1592331429807254506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018 22:04:48 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2018-02-08 20:52:40, Alan Cox wrote:
> > > > Also worth nothing that the difference between the cpu and memory
> > > > speeds is much lower - so far fewer instructions could be speculatively
> > > > executed while waiting a cache miss.  
> > 
> > But they also have more instructions that take a lot of clocks and are
> > easier to stall - eg by doing things like opening and mmapping
> > a framebuffer and then doing a floating point double store to it
> > misaligned.
> > 
> > Meltdown we can at least reasonably test but spectre is hard.  
> 
> Do you have pointer for simple meltdown test?

It's CPU dependent but for the older processors you probably want one of
the small ones as you've got much less cache and speculation to play with.

And then you also need the test data to be in L1 D cache

Alan
