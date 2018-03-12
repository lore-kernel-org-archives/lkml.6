Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELvi1lzQUKJx0t3vEComggEqAptK0U8nejgRj8DtRVd1+jmtOvoSL3cfu0HgwKPAhXIlTL//
ARC-Seal: i=1; a=rsa-sha256; t=1520843579; cv=none;
        d=google.com; s=arc-20160816;
        b=zCLUa1gd03W1JtXZuO1qWGWvzJU3eFTPedmRwFrGYBMo/zSCO/RpcjxzbF3CMEShp+
         Q9x6oPGp9bI32c8rkO/qJcQPEPBeysidype7+S7b8uDqU4fk1lvo169+ZDcW2E8G6qw0
         Fr0jGRbdvRaVQQIaP3CLG1Oepf7Xhx57FENmmFspFffIU1xlLzNhw4Xykl6fsiIq93KX
         LxFJghRls/IqVR4RSrjJVFDxSgX7siUT0/nxXyb94tFeTwmguge46F+ELM4zhmmv3vg9
         Xi/XLW1cCl56Qg0h7pVhAP63mB+0Bc/s40Xp906tiAlTLuIAzLAjGjZphXC6xe04R2Xn
         OFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=ip/fjGv326P5l0wGAjsqni8tzus/FntO1qW2ibQ6JyE=;
        b=lLJc8rUU1hZdOL7KWKgik/LAurJrdiEm3Wmpj9xQ7hWxETN/eeWPhWCrMLFpANRviL
         bC0Z4OxLhadTPEamG4cm+Ostcpca4BqIrzGNMZ4DMbZXWB5wtJosmtIlUN1GvksyX13k
         lgw8SVner5a0EQ/VwY0rUVqClXY7wJpw9iU9frf4rTtRS8bERaCebmhYhdJ/DGwVqNBs
         +7iIVYz3P8iLmKrKhejcWjh/5vkEKQNnQqEBna399ZCCdj0kXt9vXA11RrOtwFd4Dmwv
         nS9Wzf87r6NK60czOEbncisnxd2uRHf0qiv5yrJ5gEGPYvT4O33bh1ztGDA2ZEzuPfW6
         SBrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.111 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.111 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRWlGSWpSXmKPExsUSt3Opsa6V9bI
  og2V3hS2aF69ns3hzfDqTRdfqnSwWl3fNYbP43HuE0WLRslZmiycLzzBZNC54z2JxeneJxZ/n
  t9gcuDx2zrrL7rFpVSebx7yTgR77565h93i/7yqbx87vDewenzfJBbBHsWbmJeVXJLBm/NqaV
  7Cds+Jz8wH2BsbT7F2MXBxCAksZJdbP7GPrYuTkYBOwkJh84gGQzcEhIpAhsfWQBUgNs8A1Zo
  lNbw+A1QgLuEmsXtwBVeMuMfm0L0hYRMBK4mzLTrASFgFViSWf9rCA2LwCARKfVrczgdhCApk
  SH1ZsBavhFNCT+Ld6BiOIzSggK/GlcTUziM0sIC5x68l8sHoJAQGJJXvOM0PYohIvH/9jhbDl
  JbZ/+80OYdtLvL73jgXkHAkBfYm+xmKIsKHEqmkHWCBsc4nTB86xQozXkViw+xMbhK0tsWzha
  2aIMwUlTs58wjKBUXwWkitmIWmZhaRlFpKWBYwsqxg1ilOLylKLdI0N9ZKKMtMzSnITM3N0DQ
  3M9HJTi4sT01NzEpOK9ZLzczcxAiOdAQh2MDYtCjzEKMnBpCTKm8y9LEqILyk/pTIjsTgjvqg
  0J7X4EKMMB4eSBK+0FVBOsCg1PbUiLTMHmHJg0hIcPEoivD8sgdK8xQWJucWZ6RCpU4y6HDde
  vG5jFmLJy89LlRLnfQlSJABSlFGaBzcClv4uMcpKCfMyAh0lxFOQWpSbWYIq/4pRnINRSZg3A
  OQSnsy8ErhNr4COYAI64sqJJSBHlCQipKQaGE9V7FjzM1Mvpi7P7tedH4vEDjmGZqXsd94htF
  Yuc1qLizNvBu/DhMw+o32ugQuvHu4qXLU/71rlbS2GM24q+w9e51Tvi9lYx7qHOWOFhvoRv+m
  aDzmMmIKVF3g1xO//ZWD1zf7pvefhgb7CjRrpfxoW7s6fPjnWOdc+/l+Rd9DOmz6e69pclFiK
  MxINtZiLihMBAMhtWXoDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-9.tower-194.messagelabs.com!1520843578!107599487!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede
	<hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva
	<rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Support
 Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Thread-Topic: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Thread-Index: AQHTg+F1ZFZ4J0t7y0SWhgHa9CcG+6PIkcKAgAQex9A=
Date: Mon, 12 Mar 2018 08:32:55 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1D92FC@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180309173339.GA9837@kroah.com>
In-Reply-To: <20180309173339.GA9837@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 12/03/2018 06:05:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588496434117149808?=
X-GMAIL-MSGID: =?utf-8?q?1594720077202577563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09 March 2018 17:34, Greg Kroah-Hartman wrote:

> On Tue, Jan 02, 2018 at 03:50:48PM +0000, Adam Thomson wrote:
> > This patch set adds sink side support for the PPS feature introduced in=
 the
> > USB PD 3.0 specification.
> >
> > The source PPS supply is represented using the Power Supply framework t=
o provide
> > access and control APIs for dealing with it's operating voltage and cur=
rent,
> > and switching between a standard PDO and PPS APDO operation. During sta=
ndard
> PDO
> > operation the voltage and current is read-only, but for APDO PPS these =
are
> > writable as well to allow for control.
> >
> > It should be noted that the keepalive for PPS is not handled within TCP=
M. The
> > expectation is that the external user will be required to ensure re-req=
uests
> > occur regularly to ensure PPS remains and the source does not hard rese=
t.
>=20
> I've applied the first 3 patches now.  Can you rebase and resend based
> on the feedback so far?

That's great. Thanks. Need to also rebase based on the patch
'Revert "typec: tcpm: Only request matching pdos"' as this impacts the APDO
selection logic. This is on my TODO list and will try and deal with it ASAP=
,
hopefully this week.
