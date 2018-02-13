Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513243-2-16806668055243770346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.66', Host='mail-pl0-f66.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513242; b=m1ek51NbLEKF3KL4vGSbqhd4MPVmRrtYbVC0ySx8oqcyRQs
    Wgwh/e0X1ANw7AYKvN+WvBOkYmn8mMQCtAGxBUHgMROcUde1AHYpdPyqWHEwGnS6
    3EsPl0T0JIOiN3N96grQkF0xY1djHF9eWivnpJf3iWFyPpY9Qwywb2UTUqfMa9KR
    uZzo8C/GOu0ByNk3bkEJ6TRRnuFNbUOw4dGSqD+MJ5UOuWpzkIKSaCq/7L61KAko
    xiPIZPFifk/FbQhmwK8m95SGSJ010/Qq+kd/EB70DjiiDxnpS7UX5GbflQwcPiwL
    mwtD2KuZO5PCb7ULM0f3P6LIQnsvYVIZTaF4kPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1518513242; bh=oPibUifhk+3mqFA129iZtOfeuI/+kkgohuLOwF
    OjYmE=; b=nO8p3lfM82sqaGGVAYJUcOFh56YX6azfC+Nzda/63VY9IC6/VfMuLW
    nMsA4fF58s2ZErC93clwvSyUZ5dkMnbS9o9cPxtpgqegGl9tj1/Mo+n6wLtn9AsI
    NaTD9nx6uNHnMT/X1bbU/LKY65Fj5cgVD2Aq90nWu8gUEPwIkmqW9pB2kA/uacdd
    YZoUxRcm6AA2qhtllqaQYueKWMtJ4BU/x7NzGCkAkJo0gJg59jf4PB0S5XQMHVWR
    CFtwWBGiQ9GPOtkdn2tVrfil+MgtaL8TN2NIL6tOuxFqwe/7+0UUH2ug1AP10DlU
    x5h7BlpRnCd3tqAcezYpyJclWqh2Pu6w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=f5csiQjP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JrR8BntM;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=f5csiQjP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JrR8BntM;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226Nus8oFDRD1W3q814/5sBbdquiIvkwEgV5RCIK6OBChjC/VWYBFw78x6+n9YpWtz6TIfksbA==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com
Subject: [PATCH v7 0/3] clocksource/drivers/atcpit100: Add andestech atcpit100 timer
Date: Tue, 13 Feb 2018 17:13:16 +0800
Message-Id: <cover.1518505425.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, all:

ATCPIT100 is often used on the Andes architecture,
This timer provide 4 PIT channels. Each PIT channel is a
multi-function timer, can be configured as 32,16,8 bit timers
or PWM as well.

For system timer it will set channel 1 32-bit timer0 as clock
source and count downwards until underflow and restart again.

It also set channel 0 32-bit timer0 as clock event and count
downwards until condition match. It will generate an interrupt
for handling periodically.

Changes in v7:
 - Fix atcpit100_clkevt_next_event(), before set reload register,
   clock source timer shall disable. And re-enable it after the setting.
   Without this modification, the test case 'clock_nanosleep02' of ltp_20170929
   will fail.

Changes in v6:
 - To select TIMER_OF in drivers/clocksource/Kconfig instead of arch/nds32/Kconfig
 - Refine Kconfig
 - Update license format to SPDX-License-Identifier


Rick Chen (3):
  clocksource/drivers/atcpit100: Add andestech atcpit100 timer
  clocksource/drivers/atcpit100: VDSO support
  dt-bindings: timer: Add andestech atcpit100 timer binding doc

 .../bindings/timer/andestech,atcpit100-timer.txt   |  33 +++
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-atcpit100.c              | 266 +++++++++++++++++++++
 4 files changed, 309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
 create mode 100644 drivers/clocksource/timer-atcpit100.c

-- 
2.16.1
