Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqWpSrGD1dw4XyVGGtyv63KoHRspu4OVJT+tRqFdf6siby/5yRgZ2rs7yAvvkcghcN1vkdD
ARC-Seal: i=1; a=rsa-sha256; t=1525895007; cv=none;
        d=google.com; s=arc-20160816;
        b=cD0Xjg3/VA69vQ4Q7rmtcx/v126AKqlhucjTfNchmVzuwlj4Fo7PbjOGVy40PB9lK5
         4ItAZIIIok5nKGTKwzoJ5Oa3oHa1rOsKqSPHXLv5KrHWISJqicvax9FB4lTLn60qQnmY
         lXr5LBLnpHa2Lw/RNFnjnfAtjWVfWBpcG8XyOrGV3P0PLnsY8JlHQQGMvcp1+Fd4JvGR
         Fsnx2U06WMhtUsShKnyvYh7XL/9JH7/aN15HEwnwQr584SZcHMTnI4rkSnpCzmXWDg9B
         vZim4qlM5/QCm7SnxOb9TuRU14nmvJITQkxrCTq0oFaS8Q8kO795KR/f35Y8uT/6wSMN
         HQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=YglPht4l/Q/V0D+q6JxR1UfmbWu7B6ONKq3DQ6erku4=;
        b=ALmld6zCF97sBeVErywpuCWdNdeuRU7BhnygcFkndtjS7Z57NycQzNUTpjr23atDix
         qpKIxloZgZaqrpc7QZ6mlcQ9sHSS/A6XynueLLDxLCMtxGFATDS2Yf9vVW1xqfpd3T3p
         t98Cj2Atnw5f2FVVtj6W7nV4l4OTEohkcU/VXxSPXKENhiHYUeONkD7WhrizYrKFTPSW
         cF98jbeT8i+Xzh8LxcE2a6mkIE7EQPgpoXsNUa9Yv+grIffnyqnAAalQIjadwfxyBSRx
         J51f5A9lI1qGB4LHjen4q3+nOANespXB0X3rnu5RiU5LN9W9lDccQ5oK2zzctkemb1yF
         quiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 19:43:23 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, keescook@chromium.org,
	josh@joshtriplett.org, maco@android.com, andy.gross@linaro.org,
	david.brown@linaro.org, bjorn.andersson@linaro.org, teg@jklm.no,
	wagi@monom.org, hdegoede@redhat.com, andresx7@gmail.com,
	zohar@linux.vnet.ibm.com, kubakici@wp.pl, shuah@kernel.org,
	mfuzzey@parkeon.com, dhowells@redhat.com, pali.rohar@gmail.com,
	tiwai@suse.de, kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
	broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
	torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com, oneukum@suse.com,
	cantabile.desu@gmail.com, ast@fb.com, hare@suse.com,
	jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, khc@pm.waw.pl,
	davem@davemloft.net, arve@android.com, tkjos@android.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 12/13] Documentation: remove stale firmware API
 reference
Message-ID: <20180509194323.GV27853@wotan.suse.de>
References: <20180508181247.19431-1-mcgrof@kernel.org>
 <20180508181247.19431-13-mcgrof@kernel.org>
 <20180509121209.1e332f63@vento.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509121209.1e332f63@vento.lan>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920606656661836?=
X-GMAIL-MSGID: =?utf-8?q?1600016883266553917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 12:12:09PM -0300, Mauro Carvalho Chehab wrote:
> Em Tue,  8 May 2018 11:12:46 -0700
> "Luis R. Rodriguez" <mcgrof@kernel.org> escreveu:
> 
> > It refers to a pending patch, but this was merged eons ago.
> 
> Didn't know that such patch was already merged. Great!
> 
> Regards,
> Mauro
> 
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  Documentation/dell_rbu.txt | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
> > index 0fdb6aa2704c..077fdc29a0d0 100644
> > --- a/Documentation/dell_rbu.txt
> > +++ b/Documentation/dell_rbu.txt
> > @@ -121,9 +121,6 @@ read back the image downloaded.
> >  
> >  .. note::
> >  
> > -   This driver requires a patch for firmware_class.c which has the modified
> > -   request_firmware_nowait function.
> > -
> 
> >     Also after updating the BIOS image a user mode application needs to execute
> >     code which sends the BIOS update request to the BIOS. So on the next reboot
> >     the BIOS knows about the new image downloaded and it updates itself.
> 
> You should likely remove the "Also" here.

Good catch. Will adjust.

> 
> With that,
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Great, thanks.

  Luis
