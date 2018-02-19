Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AH8x225I2+qQuYNrll3hHbThhkSZm1Vo+WpHfHi56JRojnwsm5RTGU3NM6NKrZKleWlG7dWoV9Xd
ARC-Seal: i=1; a=rsa-sha256; t=1519028878; cv=none;
        d=google.com; s=arc-20160816;
        b=iXYvxS9MwqgxJYAE/tmVdKOIWet+862eQYpNm3Ezwzg92FBi+NNO8GOygFmZ/gTCo+
         1MYY/hB8yn2rZ4vx0S/S/Zvo17pXZjzb+fcuZw0KaX+mRLFoSRwBJRzQOmj0li/T4QEk
         MHWU56Y7ZOr4cc3mZc2g4WzHgH0U1gE5QkpsIaE1zwRS4NGMt+faD62VG9qHaXcmv86h
         o2htkLYDkEuYBSqdCsbZvsUDlIRbd4VnqYSUcRwPgkNpOUbiRDiIf0tCNb6zDgTtKTuC
         Yj+4BaREsx7d/sOpyFJVTGDxYCA6RiUdtWA54s4YLb9yj7kGnxKq+GkPnTlEl7svqQka
         /WRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=XQ95ysDOL2Qy42P05pXq6d7iBU2176fticvDlxJOYtc=;
        b=QjT2dnIsiEtt5ZFOQX9Q31xX3I6wtGJxRguvctFgWxhzUbT24qdCVcyhWe8HUdGYrm
         QV7alRYkrZoqzHOQgFKpg46Mmsy5ZtYbaujTr/OiO+IF3q4BoVH0gEebqmgq8H16K5yH
         /kK+2LecJLrr2cVsDtwnnoYjEv9aFtp0dZmZm/8MPAhRxO4qRsPYscFRFjcsFFQEX8kO
         IbFhPDIBMMnENazvRxc3v/poXEgfiSrXZUGSQzSUZy+2UPB4GXJoBciKHzT+1ThnFVI5
         Yyb7wwhJNQzLtvSZKxQBAf0Fd6RgjsXE408Vn++Ta1wXZs808gOthT1ntFqD4zCaCYRT
         +hQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bIhQx7jK;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bIhQx7jK;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bIhQx7jK;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bIhQx7jK;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B23296055B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  David Gnedt <david.gnedt@davizone.at>,  Daniel Wagner <wagi@monom.org>,  Tony Lindgren <tony@atomide.com>,  Sebastian Reichel <sre@kernel.org>,  Pavel Machek <pavel@ucw.cz>,  Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,  Aaro Koskinen <aaro.koskinen@iki.fi>,  Grazvydas Ignotas <notasas@gmail.com>,  linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/6] wl1251: Fix MAC address for Nokia N900
References: <1482598381-16513-1-git-send-email-pali.rohar@gmail.com>
	<1510270708-14377-1-git-send-email-pali.rohar@gmail.com>
	<20180102192345.dnywuv4sapltrfrl@pali>
	<20180105014510.GB22430@wotan.suse.de>
	<20180127141459.lym2mhd5md22co4q@pali>
Date: Mon, 19 Feb 2018 10:27:50 +0200
In-Reply-To: <20180127141459.lym2mhd5md22co4q@pali> ("Pali \=\?utf-8\?Q\?Roh\?\=
 \=\?utf-8\?Q\?\=C3\=A1r\=22's\?\= message of
	"Sat, 27 Jan 2018 15:14:59 +0100")
Message-ID: <87tvud2xkp.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1554617146502445782?=
X-GMAIL-MSGID: =?utf-8?q?1592817224601578108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:

> On Friday 05 January 2018 02:45:10 Luis R. Rodriguez wrote:
>> On Tue, Jan 02, 2018 at 08:23:45PM +0100, Pali Roh=C3=A1r wrote:
>> > On Friday 10 November 2017 00:38:22 Pali Roh=C3=A1r wrote:
>> > > This patch series fix processing MAC address for wl1251 chip found i=
n Nokia N900.
>> > >=20
>> > > Changes since v1:
>> > > * Added Acked-by for Pavel Machek
>> > > * Fixed grammar
>> > > * Magic numbers for NVS offsets are replaced by defines
>> > > * Check for validity of mac address NVS data is moved into function
>> > > * Changed order of patches as Pavel requested
>> > >=20
>> > > Pali Roh=C3=A1r (6):
>> > >   wl1251: Update wl->nvs_len after wl->nvs is valid
>> > >   wl1251: Generate random MAC address only if driver does not have
>> > >     valid
>> > >   wl1251: Parse and use MAC address from supplied NVS data
>> > >   wl1251: Set generated MAC address back to NVS data
>> > >   firmware: Add request_firmware_prefer_user() function
>> > >   wl1251: Use request_firmware_prefer_user() for loading NVS
>> > >     calibration data
>> > >=20
>> > >  drivers/base/firmware_class.c          |   45 +++++++++++++-
>> > >  drivers/net/wireless/ti/wl1251/Kconfig |    1 +
>> > >  drivers/net/wireless/ti/wl1251/main.c  |  104 +++++++++++++++++++++=
+++++------
>> > >  include/linux/firmware.h               |    9 +++
>> > >  4 files changed, 138 insertions(+), 21 deletions(-)
>> >=20
>> > Hi! Are there any comments for first 4 patches? If not, could they be
>> > accepted and merged?
>>=20
>> Since the first 4 patches do not touch the firmware API they seem fine t=
o me so
>> long as the maintainer accepts them. Maybe resend and clarify you have d=
ropped
>> the other ones and amend with the new tags.
>
> According to get_maintainer.pl, Kalle Valo is maintainer.
>
> Kalle Valo, if you do not have any other comments, can you accept first
> 4 patches? Or do you really need to resent first 4 patches again?

The first 4 patches are now in my queue, I should get to them in the
next few days.

--=20
Kalle Valo
