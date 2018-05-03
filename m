Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZqkbfDVlWoP25qBmdXljojmezyXL8et39rBhY3pVEamlJc4xDN9J7nNy637wXWGGOYhxFtr
ARC-Seal: i=1; a=rsa-sha256; t=1525353442; cv=none;
        d=google.com; s=arc-20160816;
        b=w7PK8SjRmgjHbqUtRfKiqRHeOePcrkk/i07NhV8iNrftGR3zN6m1Ek+rm6qB4BemwY
         2TbfjUzpIGqmOpwI7yumd8AhywKZoxfvgzLYyQo3qn+F2n0lTJEYEOFwmEz0A/YUyvLc
         9G09xbH8VsFIe0SH6u69/S3R8327vnpjChFzHD/KRSo3ZB/PVMlDf6mI/6e6v2bFUEqZ
         no/qsquw9dihjf3VGdWglgizCUQL5k3hA3kIMwZtzyTvcXBmaypiiz0w8DY1NjDyI3E8
         2ET0Ymhfeezwj05ZH3OiGILrYYyz8uOmsSq9K9ouPX3H7oL37iFfIhmI11y5zjkT/1dk
         QZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=Nx1h4Ok/kg1jJlCoPAzfowX3pB3JV1rSUooRJEgsDzk=;
        b=vIQQbhkppu62LkVGPU92HysjGGLOH3fkeY2/E03Ww5kOVlvYTYhU7C1GJKnVCFDPOB
         IFq8a89xvE9jdt5If06P3LpI7CI2MjStzLJmFoulIP0QsGgwpcPgAyeNXNcbUxmj53Ga
         A0F/f5tWMoNcyJBbpdgDT7f4MRyUy51CYnLmnERqhf+s34cWI56VhWrZUHbhG/UVLT/h
         IqhHMPsdycKT32Qa4Yen2VzzfPw0uVRLVRX6vShMFb8+MaRdSDDtJUl2fTloFqbodOY5
         Ulqnxa2fOi1mhiXclIJMEcccpw2QYHtF4A0Iaud+W7l+YZu7ad9UQ08HxvNJUG8xydA9
         Shtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
MIME-Version: 1.0
In-Reply-To: <CA+55aFyjTZi1S_R4434binJ4f_gkT-CAf8QpPzzVTj+ryi-K7g@mail.gmail.com>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
 <20180502154239.14013-6-christian.brauner@ubuntu.com> <CA+55aFyjTZi1S_R4434binJ4f_gkT-CAf8QpPzzVTj+ryi-K7g@mail.gmail.com>
From: Christian Brauner <christian.brauner@canonical.com>
Date: Thu, 3 May 2018 15:17:13 +0200
Message-ID: <CAPP7u0Whi3dqY_ErQOt7Du2-c7frkM7a=XWPqBKFDK6TRQrDHw@mail.gmail.com>
Subject: Re: [PATCH 5/6 resend] statfs: add ST_SLAVE
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367745879606462?=
X-GMAIL-MSGID: =?utf-8?q?1599449011293091379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:36:09AM +0000, Linus Torvalds wrote:
> No explanation, no nothing?

I tried to explain in more detail why this could be helpful in a
response Al's comments. But I take it you're talking about the
commit messages.

When I'm redoing the series - in case this something that we decide is
worth having - I'm going to make sure that there are more detailed
commit messages. Sorry for the brevity.

Thanks!
Christian

>
> NAK.
>
>               Linus
