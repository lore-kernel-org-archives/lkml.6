Return-Path: <akinobu.mita@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3011481-1520680783-2-11949294501884379682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.54', Host='mail-pl0-f54.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: akinobu.mita@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520680783; b=rD2+DkQqfWdeuX2nKO+iZP9S9AE/VI9gSPbbib1hnUXGYNP
    3jI4sYGacTqyi9K46aU79YlqZbD744afE78/O59G+ji0WR62IwGM/hGtS4ADPkXz
    lw44zzN/2Rq/CoDRsIsna+tyhdNlsiYJsItIyHzLaSjiJ4UV09WdEH/ZUTIJAEBb
    ODdLLPH4v2lPbOVlKtJEjSYqsaUCzahmaHRWiPQDrGSSnG+Kz1gGpsHOn22chObo
    zW0a13ezgHZnCCwKFDXYd81D6BerIZTfVLzUP6w+L+TRCYXJtRLdLAUOGkvd2PY2
    2MlC7MZtm+TMD4Jrhyiuu6l0WiSEH0mPOh25Bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1520680783; bh=5mND+MdnmYwc3h+SRmRwfGm0ntztFvtKj8HM4iRO5FE=; b=e
    aTizdLHTAstDyftkuBCZvGWW52LXLkrn3C/JC0aDFWHvLVd530stIfwzvVY+rxVS
    iUneQOBLWd9fGLf12hblqKThzxXznW3Fl7kGOUHZZn5GrQcBb9zivUtnURQ2ETst
    oZh3LzNRB4Ephva2HWg/b5DcmHpbT1hvtjx9L/Yha4PIDMQh7MjKVapXL1Glz1JO
    4gTmCQdLFNOyluLo2q9sEzosQjzVlLvFIeeV7ns6AfF9JKbsfM9sZGXJTsI36Bom
    OWUNHQ5VcJ3MA+pspwBdOYY3l3KuDJj4jvFqMy2xqCn0UM09X7MBV5iFOyiKxoI6
    nwjAXJo+slXfinejQ/QgQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=p7iIY6To x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.54 (mail-pl0-f54.google.com);
    spf=pass smtp.mailfrom=akinobu.mita@gmail.com smtp.helo=mail-pl0-f54.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Uhio7y2R;
    x-ptr=pass x-ptr-helo=mail-pl0-f54.google.com x-ptr-lookup=mail-pl0-f54.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=p7iIY6To x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.54 (mail-pl0-f54.google.com);
    spf=pass smtp.mailfrom=akinobu.mita@gmail.com smtp.helo=mail-pl0-f54.google.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Uhio7y2R;
    x-ptr=pass x-ptr-helo=mail-pl0-f54.google.com x-ptr-lookup=mail-pl0-f54.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELuJ2+3gdIaMm8iVN4fTwU+Cxg2zYnSJKBBqIGC4TJmuK/5a1VufhpbmH3mC000Yye8AoLlD19qWILAeKTbj0ng=
MIME-Version: 1.0
In-Reply-To: <20180309230124.GA17721@amd>
References: <20180309221220.GA15272@amd> <20180309222821.GA16973@kroah.com> <20180309230124.GA17721@amd>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 10 Mar 2018 20:19:20 +0900
Message-ID: <CAC5umygQvPHPFt7ek_WpTmYHh_=NnDCGBEB+HcgWZgmRG5Rvxw@mail.gmail.com>
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, Jonathan Cameron <jic23@kernel.org>, javier@osg.samsung.com,
	gregor.boirie@parrot.com, pali.rohar@gmail.com, sre@kernel.org,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org,
	tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi,
	ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
	abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	=?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	security@kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-10 8:01 GMT+09:00 Pavel Machek <pavel@ucw.cz>:
> Hi!
>
>> > Hmm. Looks like there's a lot of fun to be had with sysfs.
>> >
>> >
>> > pavel@n900:~$ uname -a
>> > Linux n900 4.16.0-rc4-59690-g7f84626-dirty #543 Thu Mar 8 19:53:30 CET
>> > 2018 armv7l GNU/Linux
>> >
>> > [  306.402496] bq2415x: command Timer reset
>> > [  312.761322] adp1653 2-0030: Read Addr:03 Val:00 ok
>> > [  313.264129] Unable to handle kernel NULL pointer dereference at
>> > virtual address 00000
>> > 000
>> > [  313.272308] pgd = 01336620
>> > [  313.275146] [00000000] *pgd=800af831, *pte=00000000, *ppte=00000000
>> > [  313.281463] Internal error: Oops: 80000007 [#1] ARM
>> > [  313.286376] Modules linked in:
>> > [  313.289459] CPU: 0 PID: 3584 Comm: grep Tainted: G        W
>> > 4.16.0-rc4-59690-g
>> > 7f84626-dirty #543
>> > [  313.298919] Hardware name: Nokia RX-51 board
>> > [  313.303222] PC is at   (null)
>> > [  313.306213] LR is at iio_ev_state_show+0x38/0x54
>> > [  313.310852] pc : [<00000000>]    lr : [<c05d69c0>]    psr: a0000013
>> > [  313.317169] sp : c7b47e70  ip : c087bb24  fp : 00000001
>> > [  313.322418] r10: cb19e000  r9 : c0857220  r8 : 00001000
>> > [  313.327667] r7 : 00000fff  r6 : cb711c80  r5 : cb19e000  r4 :
>> > 00000000
>> > [  313.334228] r3 : 00000001  r2 : 00000000  r1 : c087b4dc  r0 :
>> > ce584800
>> > [  313.340789] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
>> > Segment none
>> > [  313.347991] Control: 10c5387d  Table: 87bec019  DAC: 00000051
>> > [  313.353759] Process grep (pid: 3584, stack limit = 0xc4e45eab)
>> > [  313.359619] Stack: (0xc7b47e70 to 0xc7b48000)
>> > [  313.364013] 7e60:                                     c05d6988
>> > cb711b00 ce585c00 c0450d68
>> > [  313.471038] [<c05d69c0>] (iio_ev_state_show) from [<c0450d68>]
>> > (dev_attr_show+0x1c/0x4c)
>> > [  313.479187] [<c0450d68>] (dev_attr_show) from [<c023f934>]
>> > (sysfs_kf_seq_show+0x90/0x108)
>> > [  313.487426] [<c023f934>] (sysfs_kf_seq_show) from [<c023e2f8>]
>> > (kernfs_seq_show+0x24/0x28)
>> > [  313.495758] [<c023e2f8>] (kernfs_seq_show) from [<c01fc954>]
>> > (seq_read+0x1dc/0x500)
>> > [  313.503479] [<c01fc954>] (seq_read) from [<c01d9f80>]
>> > (__vfs_read+0x2c/0x120)
>> > [  313.510681] [<c01d9f80>] (__vfs_read) from [<c01da0fc>]
>> > (vfs_read+0x88/0x114)
>> > [  313.517852] [<c01da0fc>] (vfs_read) from [<c01da584>]
>> > (SyS_read+0x40/0x8c)
>> > [  313.524780] [<c01da584>] (SyS_read) from [<c0101000>]
>> > (ret_fast_syscall+0x0/0x54)
>> > [  313.532318] Exception stack(0xc7b47fa8 to 0xc7b47ff0)
>> > [  313.537414] 7fa0:                   00035330 00042000 00000003
>> > 00042000 00008000 00008000
>> >
>>
>> What file are you opening to cause this?
>
> Strace says:
>
> openat(7, "in_intensity_both_thresh_rising_en",
>> > O_RDONLY|O_LARGEFILE|O_NOFOLLOW) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
> ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) = -1 ENOTTY
>> > (Inappropriate ioctl for device)
> read(3,
> Message from syslogd@localhost at Mar  9 23:54:39 ...
>  kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM
>
> So that would be:
>
> ./devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/events/in_intensity_both_thresh_rising_en
>
> And indeed, manually cat-ing that file reproduces the problem.

This problem happens when no irq is defined for this device.

In this case, tsl2563_info_no_irq whose read_event_config field is NULL
is selected as iio_info.  On the other hand, iio_chan_spec for this
driver always registers event_spec.

So sysfs files related to the channel events are always created even if
no irq is defined.

I think we can fix this issue by defining another iio_chan_spec with
no event_spec for no irq case.

Jonathan, do you have any other idea how to fix this issue?
