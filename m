Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517773532; cv=none;
        d=google.com; s=arc-20160816;
        b=j8qxQoBRUMNOVIi81pbSK6RkiabVp2Icnq6rX1Aj7AWfUBVnAMfVxlWi2EzNioIawn
         GH6bAXvimjdXzN8/wG5DnxYaaNR9bdXZiRo4Pcgd39ai9rqKhkgI/U5/ts6ZF1g/Q7DW
         d/gXgTR7w+q/yhvPVbe5Ug+y/iw/kXLVReNqOuH6L6jyXT8pte40kRgFv71rqk3UCKD6
         38FW+HpW8jsJH7RpE77wz9OAICuf0ECJut4qJdG6l2MEX/+H/mKGAnlsDKlJ92X82VYq
         sWRwHonVA7Q7GUEGST5rwkYiqa5uSOi/7jeeY3DFpIfq6En4C4WGKYGyBcDztI58tjpG
         213g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=bi+lavgtqun6+D6ENIyFWnpqDGKV1gBXMPnITxe9SFc=;
        b=UiHw7Eh+KZ/5sSW0pZdnB0j1owyObn4NrTtDHqlzyjVA9AiYL/wJ0bZ6HP2zsDXpHL
         MWH1G8aujVrGLQRPg6nLPrtjOip350jA2NUSIA9o2fqKZSfupTwwGRIq0ZKEzQKkobTo
         zVudL0nubfRakoJCNV7lNjPidKCaplfvelEb0Wx/EhvRNJSc+VWyrPu2NM7Ca2I9/c0z
         UAzYA1W7o4u1Yt/1IXIu5TjAyUMiKOlHpiOvKRI+mU911vKaJh9DmI3l45vXGda6Ukf8
         RK1LFj8McrV+4xtDCDqIWqfdA6cuzi+0x4v4a9BjdCcntZsPCTK51o0uKl8Xa8l8hsEI
         UMgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KBmG8n4D;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KBmG8n4D;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225+B5sBTv0IT0u2x3tV2Xs49WNKAZUEqkkzQROfOnp1/PJ5zTMABGntL+EUonN3KKcPiCktHnAzu3VOwxjcrVk=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <alpine.DEB.2.21.1802041609440.1035@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1802041609440.1035@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2018 11:45:32 -0800
X-Google-Sender-Auth: BHwOqUEmM6bHuMfzeyacsZgW4gU
Message-ID: <CA+55aFyFe2VhsdN4Y3b+NxQikPeZdg9AeV-ZihhYwZ8ecg0fiQ@mail.gmail.com>
Subject: Re: [GIT pull] More melted spectrum mitigations for 4.16
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591484901255889989?=
X-GMAIL-MSGID: =?utf-8?q?1591500899805747853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 4, 2018 at 7:31 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> That said, I'm taking a belated christmas vacation for a week and hope that
> everything is magically solved when I'm back on Feb. 12th.

Snort. Good luck with that.

               Linus
