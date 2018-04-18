Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524039119; cv=none;
        d=google.com; s=arc-20160816;
        b=VH9KOOS4IJxRsbtx8hjem35idVpAaU1ukzbEWwb/ZU8yAcfU4+D2FclqulO9x0y3lv
         rj+17WqBOyJEL/2q2hkEOFpH9J3geMf2jsyc8cAuCUH63OUeL5aTEyWNM3pgzi9WyVoA
         hlHpgOK3ZCb6t83vnB7ZV3bSY/tL04b1nT2NTqxWzgiPP5jpQDM6EwVfmncnwhVWqNbM
         //03sA3a7tRN6MU5ev1pHH8S7+CThRWVdvw/NPjqi5T6hQZZervTXdZ9Y+M6yivFaj/N
         KVDVHWm2PW+ubS+9gtYMsWWNRRXlYBfsv4nf1140e3klxMw7GmXDNpNjgaYR4qDFlzi7
         7kAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=h9lA8qSNFDViJRvZLXLeJ1VbcNDStVlgRowcbpT8EsE=;
        b=GeX1tHWMaa+6UCpa/0e11qhSOkXfYtDXgeiXMTicq/tZakFzTn0uuEkzgw5ieOPeCl
         DgoA3Ov2fNsm99UHmFbzVwmSbUkow8yyNKbLfryMm4oH3IjMpryyVccK8g383ASpH5DK
         jDFP8bLU4M+5a17k+RPygFoXLIcXuhgFRonC1m0RIrTzLghTFTHhoGuh85Djv/AmRhJT
         Dh4u9VIU7L/2GPefAT3rT2UmLcj3NlgGiE4Yn1ByOYx5Z39nZ277vanUE3HVBfMMSxRP
         ysaL3kDDZbP+pZIw4jWRBs4AEzE82aTaXWyWcs4K7xVozsgHRJ0Gz0SFrT3clkUAR2GE
         6m0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=alXYdvHM;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=alXYdvHM;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoeYNu9XS7cQtnbAA9dsdNFN1Tl9fGJeVjeIP/8+qmsIHBqPzKFkrTZ7Ae57yk4nZ2exJXd5t7jQqw2oMTPX74=
MIME-Version: 1.0
In-Reply-To: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Apr 2018 10:11:58 +0200
Message-ID: <CACRpkdZNm54ukoggpta4o5XfALryHSO4Ptx0EhzNDG5HLLSSRw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To: Maran Wilson <maran.wilson@oracle.com>
Cc: x86@kernel.org, xen-devel@lists.xenproject.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, pbonzini@redhat.com,
	jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, bp@suse.de,
	dave.hansen@linux.intel.com, "David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, kirill.shutemov@linux.intel.com, luto@kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
	Christoph Hellwig <hch@infradead.org>, roger.pau@citrix.com, rkrcmar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597946171029255726?=
X-GMAIL-MSGID: =?utf-8?q?1598070844389445764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I wonder why I am starting to get CCed on Xen patches all of a sudden.

I happened to run into J=C3=BCrgen at a conference only last weekend, but
I still don't know anything whatsoever about Xen or how it works.

If get_maintainer.pl has started to return my name on this stuff I
really want to know why :/

Yours,
Linus Walleij
