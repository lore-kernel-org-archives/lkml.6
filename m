Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518714297; cv=none;
        d=google.com; s=arc-20160816;
        b=juFwfVhEmgqoG7eRHOIY5ZMP4jzWm16F5/az0es3J/15kmd/AHL6qD6w9sXWh0wCrt
         Ci45JDXycynGXf9OzonAVeaYC7wziVL0el7llJPdCPuaZHeit8H+ROOrQCdKUruudLGm
         PcAs1Ebxefz/qV3un9wcTRYqUchxpAmbvH8buM56vIl488vwoh6AsqUgQGr6pSgK99at
         hRUULSBQ0Vw81x9eTi2P1py8C/8tkA/7PZvI8B8T08zfmCo/9QLCCMtLa8qWhUTlf2g6
         I0a8gxh/Z5ZMQOmhRBhd6PxGSt3vXtXEAHmSBbdwNcxHfn5Bbd18B6MRoTYiGj1p7LHZ
         9A5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=obzuUOZTGfXX2OWzKCt18eJ+B3MJwvxEcdsGpfDUPVk=;
        b=rwpl37ONBPOJhT+x1CVlJF5JbsjtNgA3EqguZ8/YZ4kJchLHLxxEBz/kpOPSWRUVAo
         mox5HY0ZOkg6WEqsQHpA73FJWfEiUnQXk0mmvUP8BQ9AjPJEGF4k8HbIeQyv/uF8Fj4R
         ZkwR5mPYQVsrcQTzJkK1Y4xU2YSKFAR3uWoqw/aFV3aIqW88K9B5hqMYHSRDn9h8Zsej
         Uo138ZxueRogc4ZqED4Q8d6sZOxUdaY3+Qh/KTyosIOwiDVdlNFGnHaKqAZu3pmMhlP+
         ZVcLwCxMkesOUvopDnj1b4mQpm6PtSK3BzPPBIYC0xcx0+ISiKZ3sIBaJ0x3T75rI+SC
         WFvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XnJM9ymT;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XnJM9ymT;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225Q0lufh9tPOXRmUv9waoivFPJ9mCiXUGnCKcLAOhjcHLQZ6ABi9EIhEAlj90uH8Wi6dDqj9tVH0+V/FHGYr4Y=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180215054836.GA9861@kroah.com>
References: <20180215003832.pzi7zbze5vlovp6l@gmail.com> <CA+55aFy-TRt++ujpxdq3U5mmXaKLW+jXuB=eD=KWY_Lsz+ox5w@mail.gmail.com>
 <20180215054836.GA9861@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2018 09:04:56 -0800
X-Google-Sender-Auth: wMUHHlpU8Bm_JX1RVvPKMGi7AP4
Message-ID: <CA+55aFzMGDrXPL1zCRCRFM9QG5VoJ3dk-A9k0sVogNAQgqF+Ag@mail.gmail.com>
Subject: Re: [GIT PULL] x86 PTI and Spectre related fixes and updates
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592425307928838978?=
X-GMAIL-MSGID: =?utf-8?q?1592487363069821693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 9:48 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I do use it, I take the commits from there and then queue them up as
> individual patches for the stable releases.
>
> And if it wasn't there, the conflict resolution would have to be on my
> side, making them "not the same commits in the end", so either I have to
> do that, or you do :)

Ok, as long as it helps something, I'm ok with it. I was just
questioning whether it was just extra work.

                   Linus
