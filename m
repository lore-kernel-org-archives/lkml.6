Return-Path: <daniel.diaz@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518023768; cv=none;
        d=google.com; s=arc-20160816;
        b=SODXPoCOIzHiploznH3zpi/9cCOZNsPuyUfp7Muml3gxd4aiesRqyqu5bcH1bq9MpK
         7DaphB8LRObMZw9idjjJa/j3/3BlRRb4foDI1GBCu6fX7RGLHFXdMC/bfAe/8mt3Gt9g
         agV51jBIfaFe4+ebUFjt0WifDtdxaOBDx6PKUmScRNEgBgGnIFITDEiG5jm9kMXvxvok
         pLcrKaq4mvIsZ2nns7HSVSc5I7Zz3ZjDdiFLeQ3WiUj9bCztlDwuaZVv/cXvjMlqfWKR
         3aeKyr679hVd8iwGfGcOy+vA5lFCceYlT1wJh0Dsm4ESobaI95RImQdJUBt17eBF64Mb
         NFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=McsoqMV2uqn0MRoBzhUsGM3oqHP9HUpEyXyT+0tj92A=;
        b=lRMk5XZB/QNRp1MYflyYVDNE2sDWC/Jio+aAb2UeInP5dFzSaxu8rA/gPTAuTdnNaU
         Qt1oAKAoR2xlVFGLgHqiGjukHY/gikT9U9k7f6ftwMZuLeu886Ku3sidcBb4297P2bfr
         jTZapfC47HQi5lJKnychrtvyZzlfWXQdAsQW0O72MgQWomX8B4UvftEVOP1v36BSl86Q
         OMny7x/9/25NoRJZr4Sqxyn3807iSdmfTX/d5Kjn2HWHa6f8+dh0q47zYt9TVTsgZI5A
         SriHFS1SmmjwHN8PNwSjKLOuTJ4OxMK7lNUmZ0rQW/5INWg2Mh+nAsBS1EF3o++N1wfj
         84Wg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GHuTxhqm;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GHuTxhqm;
       spf=pass (google.com: domain of daniel.diaz@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=daniel.diaz@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x225+xpNio3PKinM0LcJE2Q+gtTrN/c5RhWeuqOSxgs/F+8XEg/yVXC+u7HzvJb/RW2p5Yu3S5kw/3vtgnEUDH8M=
MIME-Version: 1.0
In-Reply-To: <CAOuPNLh17DH2nZL86WSWKUKQJr-Z1EY+ZqRFsXRTqK-XMtyx2g@mail.gmail.com>
References: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org> <CAOuPNLh17DH2nZL86WSWKUKQJr-Z1EY+ZqRFsXRTqK-XMtyx2g@mail.gmail.com>
From: =?UTF-8?Q?Daniel_D=C3=ADaz_Rodr=C3=ADguez?= <daniel.diaz@linaro.org>
Date: Wed, 7 Feb 2018 11:16:07 -0600
Message-ID: <CAEUSe79T9Miw==D6u3Wx-EMymzP8aABWf_Lfqb9KP57WZgU0ZQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/android: Fix line continuation in Makefile
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Darren Hart <dvhart@infradead.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591697740031389880?=
X-GMAIL-MSGID: =?utf-8?q?1591763291409185864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!


On 7 February 2018 at 00:01, Pintu Kumar <pintu.ping@gmail.com> wrote:
[...]
> Thanks for your patch.
> However, I have copied this Makefile from
> tools/testing/selftests/futex/Makefile before modifying it.
> If there is a problem with backslash then the same problem must be
> there in futex Makefile as well.

There is. Patch coming.


[...]
> Also is it because of make version ?
> Can you check your make version ?

It's make 3.81.

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
