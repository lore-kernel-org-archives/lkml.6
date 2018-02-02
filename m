Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517595793; cv=none;
        d=google.com; s=arc-20160816;
        b=k2jxxhKhtWn9/JaG7pRSreYCXC7UPTW8q1XOB34iNMSQoVPhU2AePOCkfJPglFoFkw
         s463AfQH/5mFtltNSVaWQc/G3nM/1LH1f82jo2YubMDwIwPXy8aMsZXGIFKWY/Vka8jM
         5Yv5SMcwcv+peE0G0Ge0GgRB88UOXmGhONydmFosQ0QrpMpYRGGcOaXXKHc0d1WQLavn
         phG05gVA8nob5aPY7fJKWIWhzybPLkJp/GR17B4pulww8P+/wldQMLA6Td6oU0m2MTEu
         DOc5wvAds7lUFJ9djtigUSo3GDYTc+wqVLf1xY8qkUjdeESd50/wfvwgzv7tofXZWVuL
         F1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=E2LPyU7pbG0SMTmo86Xm8HDZN8YTRu9My9v1Ie36+gs=;
        b=PtJyZPmTNrK09bItBPSXCQfZQpHlTcabuhWdI2MW1QTLZ7rSBjno+03lttNVpc3BXw
         0ufdDXnMBPfErmqRc4JSE5SRvQcsGxQLQVLgpu3+m1g/2OkEPRcTh/Cp2G1/e3VeWiOS
         1Y3rBGKz6FmUiAayJiiiVQyxtgvIE29KH38RzOlp3y1InZHO+jylCyuKLggqyycM0wKC
         rR+0TRYdUDxIqiMVpqPk8p0yjD4eSB8wCz1+0eIA0cli9iidzkOCxMQ/0/X/PVgfqDPb
         VW/NnoDLshhRpzkIKZA561eIbcihjEc1TMr1EDO7+Bk+sNAWqwe0gtVP3adzcRtMTrHj
         kGDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oPvd0EpK;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oPvd0EpK;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x226wA1TzXGfjjX8jgs3c+ABJ1nHABNjqYQQbUPuCTj7dKz2MdwzCVa7joVt1TO74cEIvVwy/cKs6WMcoTSLxCNw=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <87y3kbpkxy.fsf@concordia.ellerman.id.au>
References: <87y3kbpkxy.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2018 10:23:11 -0800
X-Google-Sender-Auth: Wi7pudgnH7QGMSORh9SHwS12wAc
Message-ID: <CA+55aFypU331cQy-6ZJ6szF=2KVLqcbwCUGd+gTwPViRqRWN+g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-1 tag
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: aik@ozlabs.ru, Alan Modra <amodra@gmail.com>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	"Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, anju@linux.vnet.ibm.com,
	Anton Blanchard <anton@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, bhaktipriya96@gmail.com,
	Bjorn Helgaas <bhelgaas@google.com>, bryantly@linux.vnet.ibm.com,
	Balbir Singh <bsingharora@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>,
	clombard@linux.vnet.ibm.com, Cyril Bur <cyrilbur@gmail.com>,
	Daniel Thompson <daniel.thompson@linaro.org>, david@gibson.dropbear.id.au,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, fbarrat@linux.vnet.ibm.com,
	Geert Uytterhoeven <geert+renesas@glider.be>, geoff@infradead.org, gomonovych@gmail.com,
	gpiccoli@linux.vnet.ibm.com, gromero@linux.vnet.ibm.com,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, ivan@de.ibm.com, Jeremy Kerr <jk@ozlabs.org>,
	joakim.tjernlund@infinera.com, Joe Perches <joe@perches.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, jsperbeck@google.com, julia@ni.com,
	kamalesh@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com, leoyang.li@nxp.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Ram Pai <linuxram@us.ibm.com>, maddy@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
	Mathieu Malaterre <malat@debian.org>, mwb@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
	nfont@linux.vnet.ibm.com, Nick Piggin <npiggin@gmail.com>, oss@buserror.net,
	Paul Mackerras <paulus@ozlabs.org>, Rob Herring <robh@kernel.org>, ruscur@russell.cc,
	santosh@fossix.org, Andreas Schwab <schwab@linux-m68k.org>,
	Stewart Smith <stewart@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
	Tejun Heo <tj@kernel.org>, wei.guo.simon@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591296862282099006?=
X-GMAIL-MSGID: =?utf-8?q?1591314526505011419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hmm. This adds a

   static inline void pci_uevent_ers(struct pci_dev *pdev, ..

to include/linux/pci.h.

Why?

You do realize that that header file is included by almost every
driver out there. Why is that magical function *so* important that it
needs to be an inline function, and those strings etc duplicated in
every user?

Yes, that header file is already full of random inline functions, but
they are generally wrapper functions that don't really do anything,
and in many cases ithey are also basically configurable to really do
nothing at all so that the compiler can remove all trace of something
that isn't enabled.

This function, in contrast, is simply not that at all. I see literally
_zero_ reason why it should be an inline in a really core file.

It's not important.

It's not performance critical.

It's not even used by any core drivers.

I pulled this, but honestly, this part was *GARBAGE*. I'm used to
people always thinking that *their* code is so important that it needs
to be front and center, but this is just ridiculous shit.

Get it fixed.

                 Linus
