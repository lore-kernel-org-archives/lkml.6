Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AH8x226fa9e9EDJXS0xyogFH5qmzA/oZmPJw4fOHl625JLt8WGIERtSwjlE5Gl9Nz6zYZAuSJ7W5
ARC-Seal: i=1; a=rsa-sha256; t=1518123202; cv=none;
        d=google.com; s=arc-20160816;
        b=IgxIuZ5Y346HbC0tNt6X93NceDroaDp8rW4vbQUPnni6h6wFjHwyD4jiB7SWT6W8yD
         Lk+uRwCP09pj2vElYTMLTh73QGwc6WqsayFJ3/GEAfr9Qbg2qd4hrSLFC3N98tpOvJ8A
         +7CoTS+M/dXQM27Urvyy+cbnRF6+/mgXIT8qufzzOYQPs1ipo/4Qai2TO+ELDxwcllz/
         grNdrDmkSCFCcbSYVjy96nHIaZY5kZITrcQRfgDapgWA8+kPF5iBiBE2M/9s50thg1+J
         iyhjSGJ4p+bsjNbGVthMx7jUpD9I2/uGVM0tCbMdPzeXs+FzWyV3HTQirlcGC3P4nRbF
         M4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=vFU+wvqnoq98KmSCqxioK2/dMnnU2UYGs+YuRs7jEeI=;
        b=A8lbF14sVB7Z4+G6Na5/m+fnXjX78jLafVLrTUJn5iIK/Ah6tI39DA8h7l4Nh/m9J5
         jM3lnTwF9fPG5/1IfQZ4AqF2H/5n1l+gyA2UV0bz36DNz/DPTnCr70LUaxSeaqnz7HyH
         Mxv+V63gypUo3WmeUb+dDelNFX/fyslD1OAtm4exNr/7yHnxsk2TRp0J1bBh3TtRSIqj
         DspT1I026UELRL7oHbAkGsWfa0IRedOHN+upgjVrb5EnvoPFTgZGp1YZueH27d2alnvm
         AqAXddnz0GIjqBP3nltKbvRFczDSQmWjn6kjY+LI/da9MCIwbVTNe0JVEg6f3i1xwYvR
         bz+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Thu, 8 Feb 2018 20:52:40 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: tedheadster <tedheadster@gmail.com>
Cc: whiteheadm@acm.org, David Laight <David.Laight@aculab.com>,
        Arnd
 Bergmann <arnd@arndb.de>,
        Ondrej Zary <linux@rainbow-software.org>,
        David
 Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh Dickins
 <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina
 <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Kees Cook
 <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
        Eduardo Valentin
 <eduval@amazon.com>,
        Laura Abbott <labbott@redhat.com>, Rik van Riel
 <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Message-ID: <20180208205240.0c53631f@alans-desktop>
In-Reply-To: <CAP8WD_bF4jFQL=hOXRx97cyciq40MTJ9j8QwvJzLsn+LQudkmg@mail.gmail.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
	<1517950494.3677.30.camel@infradead.org>
	<CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
	<201802070918.18978.linux@rainbow-software.org>
	<20180208134908.4b516794@alans-desktop>
	<CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
	<63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
	<CAP8WD_bF4jFQL=hOXRx97cyciq40MTJ9j8QwvJzLsn+LQudkmg@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591867555006731843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > Also worth nothing that the difference between the cpu and memory
> > speeds is much lower - so far fewer instructions could be speculatively
> > executed while waiting a cache miss.

But they also have more instructions that take a lot of clocks and are
easier to stall - eg by doing things like opening and mmapping
a framebuffer and then doing a floating point double store to it
misaligned.

Meltdown we can at least reasonably test but spectre is hard.

Alan
