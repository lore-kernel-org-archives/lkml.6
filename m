Return-Path: <lars@metafoo.de>
X-Cyrus-Session-Id: sloti22d1t05-3011481-1520680779-2-12118221811119003377
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='78.46.137.84', Host='www381.your-server.de', Country='DE',
  FromHeader='de', MailFrom='de'
X-Spam-charsets: cc='UTF-8', plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: lars@metafoo.de
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520680778; b=uDPLF6maiWd0BDsTjWrcC/ZLskuHP35EIXMsYd68C726gBT
    Pus7SdU1ZLjwEB0nVIlrUykihn3ereKAUXLCYQzzmFT6D+YXqI+AblLCwbBegWFK
    giQig+0TatskySb58XK+CuAD2KCC0R7X9gMmYGrnHs0uqBcFweauPBuLZgneoD4/
    sOByvLE/ALuVzPevV8negRQMz6oMktJGpFab1VGf3WAkhXe7jLdF+1KVi+7cFpkn
    kbuB7n84cfhDd/M0oZZPnEg585xF5eju4yS/09UBY2t/VJmXB1Y0b8nY+3HMGhQ7
    jG7jZF1o8bYGNwX3N0N0LS1QeaFDg7euY9SCg4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1520680778; bh=tps9ZuG7
    TqwDDoYJ6jFEAZThUirzbJx6eDYU8yFBd4g=; b=bb9xokU8AZenndCroiGvZ1o3
    oK1+fpT5GS/tDDPwS5armgUct7C9t0AtFF+oLbHUere6vwRlTYIfBxU/E6pN0kp2
    s0J/WToG+H1c6ySn62J1/RemJYc9Q2Zb8KbeVaNAd9ONJ22DRP3jmZIrGZXIu1JH
    wN4Hx2zSCHMh7SsY+WgcZy2oUB/OHJhZHtdfWBYVtZsGxOhpgG64wfBRALKlCDca
    S1xHCu45bztq/dSotNOsVmlTxBnOcTtM+nbnr1Iu6uSrkGZcHhzQGyatCWfxUCSN
    9qW9weOlXNP/rXz+vD7qSSMIHhad4wTremA/kD0Of2NL1K+8VRTs2+trQFhK6g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=metafoo.de;
    iprev=pass policy.iprev=78.46.137.84 (www381.your-server.de);
    spf=none smtp.mailfrom=lars@metafoo.de smtp.helo=www381.your-server.de;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=www381.your-server.de x-ptr-lookup=www381.your-server.de;
    x-return-mx=pass smtp.domain=metafoo.de smtp.result=pass smtp_is_org_domain=yes header.domain=metafoo.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=metafoo.de;
    iprev=pass policy.iprev=78.46.137.84 (www381.your-server.de);
    spf=none smtp.mailfrom=lars@metafoo.de smtp.helo=www381.your-server.de;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=www381.your-server.de x-ptr-lookup=www381.your-server.de;
    x-return-mx=pass smtp.domain=metafoo.de smtp.result=pass smtp_is_org_domain=yes header.domain=metafoo.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>, jic23@kernel.org,
 akinobu.mita@gmail.com, javier@osg.samsung.com, gregor.boirie@parrot.com
Cc: pali.rohar@gmail.com, sre@kernel.org,
 kernel list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
 aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com,
 serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net,
 martijn@brixit.nl, sakari.ailus@linux.intel.com,
 =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>,
 security@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org
References: <20180309221220.GA15272@amd> <20180309222821.GA16973@kroah.com>
 <20180309230124.GA17721@amd>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
Date: Sat, 10 Mar 2018 12:19:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309230124.GA17721@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/10/2018 12:01 AM, Pavel Machek wrote:
[...]
>> What file are you opening to cause this?
> 
> Strace says:
> 
> openat(7, "in_intensity_both_thresh_rising_en",
>>> O_RDONLY|O_LARGEFILE|O_NOFOLLOW) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
> ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) = -1 ENOTTY
>>> (Inappropriate ioctl for device)
> read(3,
> Message from syslogd@localhost at Mar  9 23:54:39 ...
>  kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM
> 
> So that would be:
> 
> ./devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/events/in_intensity_both_thresh_rising_en
> 
> And indeed, manually cat-ing that file reproduces the problem.
> 
> pavel@n900:/sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1$
> cat name
> tsl2563
> 
> I can not find tsl2563 in MAINTAINERS, file is
> ./drivers/iio/light/tsl2563.c . I added few people pointed by git log.

The driver registers event attributes, but does not provide a handle to
access those attributes.

Now the question is how to best handle this case.

1) Return an error when the device is registered and abort registration
2) Skip registering the event attributes
3) Skip registering the event attributes, but print a warning
4) Register the attributes, but return an error when they are accessed

I'd prefer 2 since it offers a nice method of disabling all events for a
device (e.g. if not interrupt is provided).

On the other hand it could cause some confusion during development,
potentially causing the developer to wonder why he doesn't get any event
attributes even though he setup his channel description to have event
attributes.

Patch for 2.

--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -477,7 +477,8 @@ int iio_device_register_eventset(struct iio_dev
 	struct attribute **attr;

 	if (!(indio_dev->info->event_attrs ||
-	      iio_check_for_dynamic_events(indio_dev)))
+	      iio_check_for_dynamic_events(indio_dev)) ||
+	    !indio_dev->info->read_event_config)
 		return 0;

 	indio_dev->event_interface =
