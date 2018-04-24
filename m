Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524590592; cv=none;
        d=google.com; s=arc-20160816;
        b=hWc57haM7X0ed3v1hT+fyS57DtHn7TZRGadBnCP6GwBAqIJ/X3L9DMCQXhqDLHayOO
         lj+hY9UXImBvYFaaltSNGYa7A7jIItlfVUZYv89rTd7Q3Kin4HP7TPgj3WqeR2Lug87S
         5UGgJyWByzaq5hPiql/dDKJ9Y+sB+YtzPU7/pmUMy0KBmS0nBxXPQYKF/WpVEGSKgE9v
         SVRBb9mnlTakTs1vMsjN5IALQhj2J33SH8Xq4OkXoPD0T04W+idC6xg4K7CiuWa/sIwY
         MrJ/c7Io0Et4Ji0jvlxrI5PBYsWdPot7wibechEzihn2H0H0QWLEukSIDThTXg88tqBi
         Gvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=g63CCB9VbMN7an7QsEqJAl3b9ABIN3e6hiKOk4tAsUw=;
        b=Asm7ePuXJ9x2iHKxtpgqHspP5TJyBc5Y3fbTyc7AFj4u4imGPjWUfGXRAmoh8EtM2p
         vgNYJDNGsBeTf1FoEkkDM3Ku57RgrPoZIyrCC8tSw1DEXzFfiA3ztQUUYrpaCgnIchdk
         KMLaImiafSL/ryNQ6qtxPvaL/zuwlGtHAXUGZJW8nMgcvbvz2Fw3gYoGj8Ouzl3ZUZpz
         9kQoXDLDEpKiifvI7VJORdkk59Rx5/bWU9oQHMlIzxV2RBpJQlR7V2Qjy0kwsjyk+cub
         KmKJUQGDcbz+SWb2I208BBJVoCi48aTsX8RyiHsZR5012o/kNxZk6wRC/VyKgUNhaz+Q
         fLXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=aCwmLyK2;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=aCwmLyK2;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpP2ruYkjSHjlRqeHCSmkjOtzk+iLFXbofU+pDY7Cq+UM7DF5CD+FoqcO/UhZSObNtCxpOu5g==
Date: Tue, 24 Apr 2018 12:23:11 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	linux- stable <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
Message-ID: <20180424172311.meeo6wrsp4rtxxiz@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	linux- stable <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu
References: <20180422135210.432103639@linuxfoundation.org>
 <CA+G9fYt_OKQOx7xFPsbgj8+vXDJGR0Oc3XWJ8iQfMM=UkFVAeQ@mail.gmail.com>
 <20180423165750.GA27986@kroah.com>
 <20180423180137.GA26974@kroah.com>
 <20180423222553.lbxx3cwly2fbvabs@xps>
 <20180424072635.GD18419@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424072635.GD18419@kroah.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598455883527705799?=
X-GMAIL-MSGID: =?utf-8?q?1598649105515762403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 09:26:35AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 05:25:53PM -0500, Dan Rue wrote:
> > I made a few comments inline regarding the reported failures. Also, as
> > this report is pushing 200 lines now with all of our tests and
> > environments (about 8*22 test runs), I'm planning on making some changes
> > in the next few weeks to make it more concise and useful. Any
> > suggestions or feature requests are most welcome.
> 
> How about only reporting problems?  Having tests "pass" is the norm and
> should always happen, right?  That would make the reports smaller.

I agree, though I would like to provide a bit of context so that people
new to the process have some idea about testing breadth and depth - but
it should be a few lines, rather than the hundreds that we have now.

Dan
