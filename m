Return-Path: <kstewart@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524752943; cv=none;
        d=google.com; s=arc-20160816;
        b=A4l0uQcnVUF4fQBH3AM7TdalcyKMvU+FKmN0KSznFojSFS7lTeRx/fAImjKqetlMjG
         8xJRRHqjOsTK3v/YFdSUISV/kWvS2uxxej6cgcdanu61tzo6ulwDp62r8DvY4Ccg45hn
         h9JQX01aHT1T+ZBuTTFQw9a6knYCYJWPHVqLGdwj8v/anynFWqqYFf/uSczCuzxWqPig
         Chh81Un45mHaQFQRCtpCj81ul+PoNhPy0E5y/sIFZUgdwvua378rCRajTTcYmspMF8e4
         fu1H53nV4U56zdiTI5uyFqF73KNy641qP1eWschPp3X0Lg3preK9/TyVH2J0xRPYiCxu
         3TZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LU4oza9vpetb5B1QsAp6qPc44fahPQX+tAO73uffjgk=;
        b=EwnOeRN8KaMj9zf05rf0gWVXzQk2FiZy/vIsZNcL5OX9g5PhbzScNh+awR4ATq7oq6
         sqewbudz2urjSobi2op7iZ3CWFE7e18ZaH543KTQH3VXNElNvfxL2NfSc6PSh04IMxXF
         JnnFyHInX4mflAm044Kd44LsgJamRh9c7Po4i7LXRhP0qfCf31AA0TW15Ia1WP0qlRHh
         Ip9MgYcxloOWuw0Zkv7JC4MvBM6njOYrNwxa9bRmt0NxK/DXgeakcmXflcAFbZWsY2oz
         hIGTtc4s2csJOBkuZrbUv74WeCvjdi++TGxf+vB1R7msJLiXbI4D5NNx1tGjAj82pNIC
         kKFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QMLLON4g;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QMLLON4g;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
X-Google-Smtp-Source: AIpwx4+BbdLIt2A4jxdx8DQQ/bhdCyFpxnFOABn3+NuYolYuY/hRLhsCLa3N1FS2/WOE3gykswJHJ3HFbsVcx/HSxZk=
MIME-Version: 1.0
In-Reply-To: <20180426070118.GI14025@kroah.com>
References: <20180425203020.594959448@linutronix.de> <20180425203703.404420083@linutronix.de>
 <20180426070118.GI14025@kroah.com>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Thu, 26 Apr 2018 09:29:02 -0500
Message-ID: <CAG_66ZQsvkoFyLO0zoyxcF4XS5AtYYmSC4yumd=hfXBziqNMvw@mail.gmail.com>
Subject: Re: [patch V2 4/7] LICENSES: Add CDDL-1.0 license text
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Jonathan Corbet <corbet@lwn.net>,
	Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752950423068745?=
X-GMAIL-MSGID: =?utf-8?q?1598819342474403647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 2:01 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Apr 25, 2018 at 10:30:24PM +0200, Thomas Gleixner wrote:
>> Add the full text of the CDDL-1.0 to the kernel tree.  It was copied directly
>> from:
>>
>>    https://spdx.org/licenses/CDDL-1.0.html#licenseText
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>
