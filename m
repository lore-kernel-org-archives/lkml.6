Return-Path: <mchehab+samsung@kernel.org>
X-Google-Smtp-Source: AB8JxZo1vyhiMowL6HHnAhrf8k2ZoiU8PPZ4ZfX465IyluYnBogWEoHMp+bqryK/K+OuXKg8+ROz
ARC-Seal: i=1; a=rsa-sha256; t=1525868797; cv=none;
        d=google.com; s=arc-20160816;
        b=tBaAub/nS2ksPyjX2zZeBRhApU+cAhvrWi1zjyAglHaazn9qLBi/nypHTEICa5N3en
         YJeXxZOZJLio67/S0m7RUb6H0D5L4IZtm8gmNDwVN/BNV4ljmU2vWMZQxIgPB6Y5nvJM
         Mfex8/aLVu2N/VOwlU9X0D0gEqmu8nWelUqpwrXt76MrI+CkeQPD4y1fF7+vzhj3MF4K
         bcVFr+5rnNFFluNUWsB8g5GLzZ9yFiBCyB6c4WyAY++dOBdAbDJtiuc2HcnU28u5kT2u
         ACtp6m9rcJbqjKPlu5AlyYNb/ztbcIIZXoOmXdMPUFXaO5asXgeCO3hh0dJigS8rS55v
         O0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=rdEPjD5Apeha5PVCjnM7HO8/dZuRiFRhXbUnmmEY2gA=;
        b=fSuQ9zX19Y45tTDeeZfN0Cau+tcqz03OgjdDB/FsvnhOApkEDS7DFiUSAShH79hhZC
         gReNYe8hgwaF9I1Xg8/9B5KptlmnVzKkflLt5WGvcTaV2B7t/NRP6LwwGUwKmUYuHG3p
         hYJ0tjZgo6zyRrH6aQFLGQH+TAPxzwE1PvkY68Gpqsq0v1bYeiAYTS+8pAnE0omdbD3D
         w/B3eCNRcwuOahfHq1YCeBzzsuvaWMhyIFwvlqZWDPr4rPh6x10uxscldz8EIemqMaoR
         y2PjtGMe4GokXUMQgLmYMJGgEvJ0veYjerIkNwG1WTaxbKI4/tZ+Z7pqDWlSAFEAdHeB
         qrCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qGZmxKyL;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qGZmxKyL;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 09:26:18 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho
 Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown
 <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Masanari Iida <standby24x7@gmail.com>,
 linux-pm@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 02/18] docs: fix location of request_firmware & friends
Message-ID: <20180509092618.4a3801ac@vento.lan>
In-Reply-To: <20180508154908.GD27853@wotan.suse.de>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
	<9e40d0b3a085a937b42ec60a3b2409cf820ca713.1525684985.git.mchehab+samsung@kernel.org>
	<20180508154908.GD27853@wotan.suse.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797480965348645?=
X-GMAIL-MSGID: =?utf-8?q?1599989400334962108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Tue, 8 May 2018 15:49:08 +0000
"Luis R. Rodriguez" <mcgrof@kernel.org> escreveu:

> On Mon, May 07, 2018 at 06:35:38AM -0300, Mauro Carvalho Chehab wrote:
> > commit 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> > and other commits renamed the old firmware_class.c file and split it
> > into separate files, but documentation was not changed accordingly,
> > causing Sphinx errors.
> > 
> > Change the location accordingly at the documentation files.
> > 
> > While here, add a missing entry at request_firmware.rst for
> > release_firmware() function.
> > 
> > Fixes: 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/dell_rbu.txt                      |  4 ++--
> >  .../driver-api/firmware/fallback-mechanisms.rst |  2 +-
> >  .../driver-api/firmware/request_firmware.rst    | 17 +++++++++++------
> >  Documentation/driver-api/infrastructure.rst     |  2 +-
> >  Documentation/power/suspend-and-cpuhotplug.txt  |  2 +-
> >  5 files changed, 16 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
> > index 0fdb6aa2704c..befeff80e7ec 100644
> > --- a/Documentation/dell_rbu.txt
> > +++ b/Documentation/dell_rbu.txt
> > @@ -121,8 +121,8 @@ read back the image downloaded.
> >  
> >  .. note::
> >  
> > -   This driver requires a patch for firmware_class.c which has the modified
> > -   request_firmware_nowait function.
> > +   This driver requires a patch for drivers/base/firmware_loader/main.c
> > +   which has the modified request_firmware_nowait() function.
> >  
> >     Also after updating the BIOS image a user mode application needs to execute
> >     code which sends the BIOS update request to the BIOS. So on the next reboot  
> 
> This part looks good and is needed.

Ok. I'll submit this as a separate patch.

> 
> > diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > index f353783ae0be..7aed31b5a439 100644
> > --- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > +++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > @@ -72,7 +72,7 @@ the firmware requested, and establishes it in the device hierarchy by
> >  associating the device used to make the request as the device's parent.
> >  The sysfs directory's file attributes are defined and controlled through
> >  the new device's class (firmware_class) and group (fw_dev_attr_groups).
> > -This is actually where the original firmware_class.c file name comes from,
> > +This is actually where drivers/base/firmware_loader/fallback.c comes from,  
> 
> Not this part.
> 
> What I meant to keep well documented here was not just only the old firmware
> file name for the code, but also the module name firmware_class, and its
> respective sysfs class name which is registered. From what I recall testing, we
> could not rename the module now because of this. I believe it had to do with
> the modular case, given the sysfs class could still be registered.
> 
> The fact that I forget the exact *issue* which prevented the module rename shows
> how important it is to document this.
> 
> Folks 10 years from now may wonder why the hell that name stuck, and the point was
> to document that the *original* loader was the sysfs fallback mechanism.

Yeah, I was in doubt about this one too. Yet, IMHO, mentioning a filename
that got removed will also be problematic 10 years from now. Perhaps you 
could say something similar to:

	Originally, the only firmware loading mechanism available was the
	one that it is now used as fallback. The file containing it used
	to be named after it, as firmware_class.c (nowadays, the fallback
	mechanism is at drivers/base/firmware_loader/fallback.c).

This way, you keep providing the explanations while pointing to the new
location of the code.

Just my 2 cents.

Thanks,
Mauro
