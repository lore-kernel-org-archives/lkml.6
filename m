Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518907161; cv=none;
        d=google.com; s=arc-20160816;
        b=arzPezZz6AEtevggEtW3ds9kDeKGBVJ6cULTZw4toa2Ww7PuqcHiVVj/UHLXI7NdJ4
         eGPZ5j84/qhjVLUTaWIbyLSVoZ8jOjxrf5Ve5bdMRZCDoJSD7b032kjqHAUs4GQFk4av
         p/BurYnMoPkQX5HDhl8iwk9mNBZ0OOYpKHSJ3njO5a57s++AAtVPns7BMsef2qew0pjp
         E63evivkwY8NaJBK5UQ6n/5ChZAnVDNRYaOJMeWXR1PZc2quZD2aMtMMaZSwr4F2nJtE
         WsWkECRTX/GBJNHQwt72TaceCmD3RccotXrsk3wO71iyHOAeoNSie6+/mAkJK8sxPelB
         dVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=dyHGs6ClkfhhwzXISGifMW1bf6E/U9iXfPdJKMKUsEs=;
        b=BaZRUM34EECTzqznxNCyNAU6ZUQ+PmtYmGCX0oNPqUUjhGImwqyvx0M44+o9a9zohR
         HXVEg84Ij4GzGwO41MznhEJVlrW2REeBsEhmgNhlVRHLY3H+mSMFPBYQORv/QyImnbKU
         CGv9ywc0GIMajP0+0wT1rWtG2o5lKzJcok670318pqT7eztGgo72fSBBb8MEbbsJTLUv
         SOkDlozrLcDgrDz2iCq8cDD9rsEjTui8ev2+LB5pZEjCCRMEfy/cFcUFYgOP0WGeu84v
         IFR1InweI4Scy43QLiRcENNg43ouqTtDkGlnH4v+AWlsJo8iel2h9sgZXjU5IND2I94F
         UrHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YIXrAIaB;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YIXrAIaB;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225McVV9+4jz/dB/FKRLTglVLu/KTDTpChu2lmHSemBMj2wHUSIypVyXFPs8EIkITvDVOFgr4d49d7TYK4pbMe4=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <20180217211623.GA9543@amd>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com> <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
 <201802090941.41782.linux@rainbow-software.org> <20180213210438.GA6569@amd>
 <20180215095320.GA2112@amd> <CAP8WD_ZuYCZW42DXeunS8NvKdSA739Sdrr_oBaxJn7MxfzrNAQ@mail.gmail.com>
 <20180217211623.GA9543@amd>
From: tedheadster <tedheadster@gmail.com>
Date: Sat, 17 Feb 2018 17:39:00 -0500
Message-ID: <CAP8WD_ZCFbCHwf97Zs0ZgkN5iWs2t7=6HuGXfM4g5Ze5VJK_Og@mail.gmail.com>
Subject: Re: What was last kernel that booted on hardware XY? database was Re:
 [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2A
To: Pavel Machek <pavel@ucw.cz>
Cc: Ondrej Zary <linux@rainbow-software.org>, David Laight <David.Laight@aculab.com>,
	Arnd Bergmann <arnd@arndb.de>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hugh Dickins <hughd@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jikos@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	Eduardo Valentin <eduval@amazon.com>, Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592460207317318961?=
X-GMAIL-MSGID: =?utf-8?q?1592689596209618980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 4:16 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > BTW... I'd really like to have a database of machine, kernel version,
>> > cpuinfo, config... So that questions like "what is the latest kernel
>> > that is known to be running on this hardware" and "what config should
>> > I start from".
>> >
>> > For example, I have nokia N810 here. It was supported by Linux at some
>> > point, but then we moved to dts, and stuff changed, and I can no
>> > longer figure how to boot it.
>> >
>> > I guess "what was last kernel that worked on Cyrix MII" is also
>> > relevant question.
>> >
>> > Is there such database? If not, would people be interested in
>> > contributing if I create one?
>> >
>>
>> I am interested and will help. I have i486/i586/Pentium Pro/Pentium
>> II/Pentium II Xeon/Pentium 4 systems to test on. Oddly, I don't yet
>> have Pentium III systems.
>>
>> I think an associated goal would be to fix those broken versions.
>>
>> I think this is a great project for college students to get experience
>> with. Who else is interested?
>
> Ok, I started something:
>
> https://github.com/pavelmachek/missy
>
This is a good start. Could we start to create a hierarchy of major
architectures next? I propose the following:

i486->Intel->i486
i486->Cyrix->Cx486
i486->AMD->Am486
i486->UMC->Green CPU
i586->Intel->Pentium Classic
i586->Intel->Pentium MMX
i586->Intel->Atom
i586->AMD->K5
i586->AMD->K6
i586->AMD->K6 II
i586->AMD->K6 III
i586->Cyrix->5x86
i586->Cyrix->6x86
i586->Cyrix->6x86MX
i586->Cyrix->Cyrix III
i686->Intel->Pentium Pro
i686->Intel->Pentium II
i686->Intel->Pentium III
i686->Intel->Pentium 4
i686->Intel->Pentium M
i686->Intel->Core 2
i686->AMD->K7
i686->AMD->K8

You would put the computer you tested it on inside one of these directories.

This will need to be edited if you choose to use it. I left out items
I know little about, such as Geode GX1, Geode LX, VIA C3-2, VIA C7,
Transmeta Crusoe and Efficeon, Winchip-2, Winchip-C6, and certainly
others.

- Matthew
