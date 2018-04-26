Return-Path: <kstewart@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524752844; cv=none;
        d=google.com; s=arc-20160816;
        b=E6+bt6KSkYwvACy9+vKETG/PiQZREUnAFRphxsYGpdtUFvC4Ol952YCDFsdy7UEC9z
         +FDT6LCxofzlH/4ZGLSamQLjKPenPKfirNX9ObLxydl/N7eys+JFRbSm2ETIP0I70/y+
         77I81tM8sFOfNzfVe+SnGAwLmI7iXnBjqmFeNGao2tph8QhZCxa6NJrfnXJW4fyHwdQ/
         fUkxScyX03OuXFYrHp/1cY5WfLY6lEDqFIp11AwdIOSNzK4dVAWxpsGvkTehozzL43AH
         jKG7k4521tw6y7ETkH7C2xQ19eJLjR4FwJAECVUGyDvL8y/XBOnYwaMvWyLM9GzQdJFb
         syCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=uoUHsGa2yOd8y4VpWPCknPaxaYUCt2nav2J04HkUSlM=;
        b=xvujgP369g8LqrRq2SkTIWkCeGkb/Iow5Ls2PBlQuE320ZKMNnERf0xatBECAbvgol
         Te+6fCCy0GRNpV7MRByUtr4+f8r5VwLKmD5TatNW5gYhgfHLU2wJSmtAT2CzLJMfp/tF
         kRypIXyAFCajnhK6Q2nGU3vVdjzkESUzCRGI0mDNxU6yd2mmRNd01PYDKIi1JkQ0EmgX
         q4hJVNvPWlZmwmI74ijNu6BoUIZ+rIy65MnxPyM4zMg3aYeu7NhHyvHQ4sWG8yGJQBJ2
         t0DOehYNF8LduE7jrTRUBUnaJD2jmCz6IEZAm9GeXDVvyH5foZ0lpBvC6CudIF3MOQCm
         ZDNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SnSxeg3Q;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SnSxeg3Q;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
X-Google-Smtp-Source: AB8JxZq7avXfTXVcaYcn7XykOAmcetbZZW2LjMm4AYFJot8c5lAt1zaH4i4bcBM6OOAc6YuDEZTEeUE5fVgUh3oqCOI=
MIME-Version: 1.0
In-Reply-To: <20180426070127.GJ14025@kroah.com>
References: <20180425203020.594959448@linutronix.de> <20180425203703.486273125@linutronix.de>
 <20180426070127.GJ14025@kroah.com>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Thu, 26 Apr 2018 09:27:23 -0500
Message-ID: <CAG_66ZQbQOTjrKub-anbz3KL10PmoJvHqdG5RfMkEX03-fKa8A@mail.gmail.com>
Subject: Re: [patch V2 5/7] LICENSES: Add CC-BY-SA-4.0 license text
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Jonathan Corbet <corbet@lwn.net>,
	Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752951135006935?=
X-GMAIL-MSGID: =?utf-8?q?1598819239239708029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 2:01 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Apr 25, 2018 at 10:30:25PM +0200, Thomas Gleixner wrote:
>> Add the full text of the CC-BY-SA-4.0 license to the kernel tree.  It was
>> copied directly from:
>>
>>    https://spdx.org/licenses/CC-BY-SA-4.0.html#licenseText
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>

Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>
