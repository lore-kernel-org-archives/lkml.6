Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx48HYUMb1PS6wgsW8xjWrZvu06R191ZZDCE6oJCB2jz/a+SASaR3LgQssgAm24vJTbkk6ah5
ARC-Seal: i=1; a=rsa-sha256; t=1524435133; cv=none;
        d=google.com; s=arc-20160816;
        b=CD4fhcBl9027uJL/+nLj9Nv5zYGEcCz3IPZd/asIvvO3Leu6zUGQecTWU0EwyHqx8T
         dKDu0MRG5RN0f94hcxEBxoVrp48HgTAAcigZ2HBEjX9VusatahHVq8P3W3gPflYcGFiJ
         QmoRzbTmF1ZsANFCkb1U8CtZ+rwz1S6iELP1331Ow4fFwzNuXedoVMtBjH+qwImF7nF6
         M7esZPmO2QWBg04tR1kSYRnwM5vN2r+ky4LUoFcQlE18ZjbFFIsEThi6x4BtUIwZVgpz
         gpqQZuBMCkhaZG/kKzSqRxKzOYBYFchqtpWRgORQ8/REHvAFGzF1ZJU0NifigIxOx1VR
         a5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id
         :arc-authentication-results;
        bh=PKpDSlEPxtqw9xleNi+6xwfKrgT8DLWNOF2tw/ojd3s=;
        b=l7caJfKhTXLgPFAHWdMRddmicmP07kEJhU1cxd8iso6NZ+n/yXTwiISwoshmiF2QTv
         8pRq9M/rX/CHlSHYg3IZtN3PHAOxGOz8lJd8aBT4aphbpGBpUnOabfXuJDMu9UpF5Rjf
         ZIvo7hRng22ebtM9JDryjIO8FefGOwChiiRsIdP1D7j2kuVZu7RuHnk5lcvVqY0C8vmc
         7zpcC6fv/UGskM3BrgGvrnHEcdi4pC3XQBUqt4UoP7EZlR3M8oRnVUVqucNvMnWll+jT
         wdiyZgJ15+F6TvFo8PIKpNlN8MT9xZbd+eZKPtJpB2wVo0Zmbo98UEQhW2DoWkxJyR4h
         ejUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180422220208.772527041@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 00:02:08 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [patch 0/9] LICENSES: Add missing License Text and fixup bogus
 identifiers
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486095151406011?=
X-GMAIL-MSGID: =?utf-8?q?1598486095151406011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are a few bogus SPDX identifiers in various files and SPDX
Identifiers used in tree or about to be used which have no corresponding
License Text file in the LICENSES directory or use the new variant of the
GPL-2.0[+] license identifiers which are not mentioned in the GPL-2.0
Valid-License-Identifiers: tags.

The following series cleans that up:

 - Use the proper identifiers

 - Add GPL-2.0-only and GPL-2.0-or-later identifiers to the GPL2.0 license

 - Add X11, Apache-2.0, CC-BY-SA-4.0, CCDL-1.0, Linux-OpenIB license texts
   to the LICENSES directory along with the required documentation texts

8<-------------
 LICENSES/preferred/GPL-2.0              |    6 
 arch/arm/mach-s3c24xx/h1940-bluetooth.c |    2 
 arch/x86/include/asm/jailhouse_para.h   |    2 
 arch/x86/kernel/jailhouse.c             |    2 
 b/LICENSES/other/Apache-2.0             |  183 ++++++++++++++
 b/LICENSES/other/CC-BY-SA-4.0           |  397 ++++++++++++++++++++++++++++++++
 b/LICENSES/other/CDDL-1.0               |  363 +++++++++++++++++++++++++++++
 b/LICENSES/other/Linux-OpenIB           |   26 ++
 b/LICENSES/other/X11                    |   37 ++
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c   |    2 
 10 files changed, 1016 insertions(+), 4 deletions(-)
