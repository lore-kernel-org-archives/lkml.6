Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELusEzxXmA7urSkzJjzcHSJysKq+Wg9eLZKp3bhbrvLN2wLh6tsZ2TgROup8qQ4wcsTVco7I
ARC-Seal: i=1; a=rsa-sha256; t=1521455967; cv=none;
        d=google.com; s=arc-20160816;
        b=l/p73SW9KPbL3x+eAjiOfwtLfFDqzwhNcr2EdxZ8wucBQIrVQLTSPCW0pfXVuxR7V6
         2M+5TGbYT7mNMhqZYvxiZaM9H9t2sy4s+QfwZPF3+DFQnO2cgTqOVbcthQ7ySh/stvgD
         QmNfDQPo9KomvGBSAvzuLdALgypPs+DA8TFGthxfoV9/RCveDRTryHbiu16JZ876FIww
         GI6/oibCB2X2n63rnhpDMMg9BkMS6EY839rhkxPz+XtVqBkaOcnRv/RpXWWWMT2EerFW
         +4xeZ8EmlQYmQ0ncj73LTQwwqb4w/TqOqJgX4chp024j0lJ7fOsKvRQURaA6M3xhOena
         Tkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=T8a9UDWIMtJ8rKAVGpaVMxcMgcFCbHRuZlXrKzzjRuc=;
        b=sgFd8WbLIAOi/POa/CuOn3aRW7f06OWjQcVK9wyAFIoAO26R64px8dYx4ap8A5dit0
         rfnXAJvUi8g5eJGX1OwLdS/moNRVAbxU679Gt0DWMdeO/m5HFKQw8B8tsItJ4kQf4zFu
         uSgQbYPtIgLO/l8RaY0VlfeqKXAGst0gJN04kMf78GXDZ29y+l8y2y8fBcojGLhm77xh
         1cYT+otL/ztZwE0mWKPYq8oPT6iWRigC89dEhvRoB9YqNDktUud/arVveIHmG9SdTOVw
         o/yXaOuJuhXR8gCU6A6gcTT2EzrqH/s/WuXTWm/aE4XMQEXVpfsw5iKb851XBHSm0NuJ
         wECg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.107 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.107 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRWlGSWpSXmKPExsUSt3OpsW7c5PV
  RBh/ecVs0L17PZvHm+HQmi67VO1ksLu+aw2bxufcIo8WiZa3MFk8WnmGyaFzwnsXi9O4Siz/P
  b7E5cHnsnHWX3WPTqk42j3knAz32z13D7vF+31U2j53fG9g9Pm+SC2CPYs3MS8qvSGDNWPH/H
  WtBM2/Ftgs7WRoYt3B1MXJxCAksZZRoO/6asYuRk4NNwEJi8okHbCC2iECGxIr+yawgRcwC15
  glNr09AJYQFnCTWL24A8jmACpyl5h82hei3kli95IuJhCbRUBV4kHfW7CZvAIBEmdazjOD2EI
  C6xklNl6KAbE5BQIlvn67DjaSUUBW4kvjarAaZgFxiVtP5oPNkRAQkFiyB6JXQkBU4uXjf6wQ
  trzE5OZbUDX2Eq/vvWMBOUdCQF+ir7EYImwosWraAaiwucTOpeoQ03UkFuz+xAZha0ssW/iaG
  eJKQYmTM5+wTGAUn4XkiFlIWmYhaZmFpGUBI8sqRo3i1KKy1CJdI2O9pKLM9IyS3MTMHF1DAz
  O93NTi4sT01JzEpGK95PzcTYzAWGcAgh2Mf+YHHmKU5GBSEuXNn7g+SogvKT+lMiOxOCO+qDQ
  ntfgQowwHh5IEb8kkoJxgUWp6akVaZg4w6cCkJTh4lER4V4O08hYXJOYWZ6ZDpE4x6nLcePG6
  jVmIJS8/L1VKnPcJSJEASFFGaR7cCFgCvMQoKyXMywh0lBBPQWpRbmYJqvwrRnEORiVhXheQS
  3gy80rgNr0COoIJ6AifpWtAjihJREhJNTBqf+TTjans+Wp22fdK7NdTwkvmxRxgfvCs+tKMUy
  6X5l4/YK5UfPPBklCu1Tb6TcwxAu15SlO3FP+WOp50RfagXrKSZvzG/ITCg8ZPz/o+K8/2PaE
  3cYaTsdVSszXTRbtUAjo2K098W+hwOrHm/pVfj6KUdZW1dVkML3zn2XDRt+O4sAivxV0lluKM
  REMt5qLiRADMpmOnewMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-12.tower-194.messagelabs.com!1521455965!91171479!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede
	<hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva
	<rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Support
 Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Thread-Topic: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Thread-Index: AQHTg+F1ZFZ4J0t7y0SWhgHa9CcG+6PIkcKAgAQex9CACyIs0A==
Date: Mon, 19 Mar 2018 10:39:24 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E1F2B@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180309173339.GA9837@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1D92FC@SW-EX-MBX01.diasemi.com>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1D92FC@SW-EX-MBX01.diasemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.21.46]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 19/03/2018 07:48:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588496434117149808?=
X-GMAIL-MSGID: =?utf-8?q?1595362212402248754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12 March 2018 08:33, Adam Thomson wrote:

> On 09 March 2018 17:34, Greg Kroah-Hartman wrote:
>=20
> > On Tue, Jan 02, 2018 at 03:50:48PM +0000, Adam Thomson wrote:
> > > This patch set adds sink side support for the PPS feature introduced =
in the
> > > USB PD 3.0 specification.
> > >
> > > The source PPS supply is represented using the Power Supply framework=
 to
> provide
> > > access and control APIs for dealing with it's operating voltage and c=
urrent,
> > > and switching between a standard PDO and PPS APDO operation. During s=
tandard
> > PDO
> > > operation the voltage and current is read-only, but for APDO PPS thes=
e are
> > > writable as well to allow for control.
> > >
> > > It should be noted that the keepalive for PPS is not handled within T=
CPM. The
> > > expectation is that the external user will be required to ensure re-r=
equests
> > > occur regularly to ensure PPS remains and the source does not hard re=
set.
> >
> > I've applied the first 3 patches now.  Can you rebase and resend based
> > on the feedback so far?
>=20
> That's great. Thanks. Need to also rebase based on the patch
> 'Revert "typec: tcpm: Only request matching pdos"' as this impacts the AP=
DO
> selection logic. This is on my TODO list and will try and deal with it AS=
AP,
> hopefully this week.

One quick question. The patch 'Revert "typec: tcpm: Only request matching p=
dos"'
from Hans isn't on your next branch. Is that something that will get pulled=
 in
soon? Need this as well as my updates you already pulled into your next bra=
nch
before I can resubmit. For now I cherry-picked that patch locally for testi=
ng,
but that's no good for submission.
