Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AH8x225gwkt5LAx84lsEgRVWn0GwNPKdpPJGgvmQjqL9sUFyQsHfY84I1lOqYYmn02EuPY1MuD2y
ARC-Seal: i=1; a=rsa-sha256; t=1518175726; cv=none;
        d=google.com; s=arc-20160816;
        b=lmWC1dSezRgwNqAenTP+qMeEAIy6Hjj/Anu4UAccUsey1y09nWSwmkW3r6f+0CkDCv
         wA0P1ZHizg2v40E5c1ioglgTMAS4RlKOpxgQsVxRVgLMiW+tBph1N3ghwjkXGpO3z91P
         +9KvZZJDpPFhsSMtsfP0UN0j5mOvBxrLSgRnEsgg/Z/ePDmfD8y6XZx+yXRevUDepXT7
         BYE0XQIjBmaiCV8+qUYh3gMW85TmFa072rOEnpBkg/OEGSD6YkFw96SdZRB8X2DYkjPn
         FeiOhjXMb6l2G5RVmT7nM0o5F+BfWhjAaFd59Xu4ZCtAZLKT/EGIziQK0GWo8Av0qnAd
         l31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=zj1yTCElJsIn2KuHEwFsnmwI6wHeZgM+Q6wLhH/yaX0=;
        b=J1uTgbBTjbdKfPo06suJIyZDchXZQDnplY2bzqQsYZ3InmDZvNtSeRvZW2XXka+v/X
         1SWT49VbUKrcSG9xEFlVuPCfvRQYvGeT5H/tuOiyeYAqoMan84b2E69o1CKmVWhK65P6
         b/jmEDwB8+BJdEjhXa+N0aOqMOHlMFzN3ThG2ZFml7g72cHVfUWHID878ucTrTx3UxXb
         LqiLhb2HchQt5fZ7IWstBxWp3WYUc5vv6GyNoVCwn8k91PqnlKOYsNvgA6/G1FN+mOUs
         XdwHkEPAPBURsVrd/+R3mSlci8AVw8Cyj5WHOBYmkFuxh6yylvUKqpfkdHHIJJ89SVbo
         5JUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.110 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 193.109.254.110 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHe3fOzo7DI8ep+CaZMoRAmxeiPAW
  WQtS+SAp9Umcd7bQNd+ucGTMcKV6ghSYISVPLe6SJNiO3FhXTUDMoNPESRpFNnTYhtQuFte2g
  2fvpx/P/P8/zh/fBEYlHGIUzJiPD6miNFBOj+Y7OQ7LVKnNO8po9iapo78Oo1ZEGAWXpcaDU5
  OMmjFqvGQZUW1cVQi20vhJQ5S1rKDXuNFK/F+ewdLHcYZ0XyW3d1zD57bFs+bPm+yL52tMpTO
  74XiaSr9v2Z4lyhGpdgd50Xqjq9WyJDNWk6YXbLioDtYQFiHEJ2Qng0sRbkQUE4RhJwfrRD5i
  fw8lcWNc0hPpNCOlG4J/+3oAQRiqgzd4n5E35cMA5i/B8DDq804E6SsbBGmcz8DNBZkHL8g2E
  3zYN4Nrml4AQRKbBzfEpgZ8BGQ03ynsCgxAyEs4t3AnUIUnCjievEZ4j4PKnLSHPMXDw2y8Rz
  yfgynuvLynu4yRYW87x5RTYffM5ynMqnL3rFvLjD8IW51eM5wTY1bqC8DlD4ditBbQORFp3pb
  DuarHuarHuamkBaDc4wDHsZYaVHU4sYNVKlVFLqzWylOQjiVqG42glo6ELuMRCvdYGfP++x/f
  soGHyjAvsxQXSCGKgpjRHElKgv1CiojnVObZYw3AusA/HpZDwVppzJKEso2RMF9Ua3/FsyxAP
  loYTZr9McAZay6mVvPQSyPCZpZVqRILq9DomKpLo95tIv0lVrNsZsX2CEyA6KowAvlCSYAPDa
  tXG/3UPiMSBNIyo9E8JVuuMO5s8vhACX4j59EAII/1PiioDTOzPVJu0feRR6WZ2VfWPwZn4vO
  ONJZP2ppjY8GpyY7HdONqkKJp3tDZcCipBMxXoUtypupbU2sHrCRWlnhmDePCz7STpveIarst
  se3M2d6BeXeY4KrR+TJMZgk7XhrjZRjr4oWIoY1Jf9M6Z0ZHnWLineDAWYc6XWTJchVelKKei
  U+IRlqP/Aujk2099AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-7.tower-194.messagelabs.com!1518175724!107622503!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Sebastian Reichel <sre@kernel.org>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hans
 de Goede" <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, "Rui
 Miguel Silva" <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 5/7] power: supply: Add 'connected_type' property and
 supporting code
Thread-Topic: [PATCH v4 5/7] power: supply: Add 'connected_type' property
 and supporting code
Thread-Index: AQHTg+F4XZuNE7krHk+5wBw2HzfVcKObQG8AgADp4ZA=
Date: Fri, 9 Feb 2018 11:28:42 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C1FDA@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <3af7db87e0e6bdfa46ef3c1c9053297f711aee5a.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180208213054.oqgoktru3lzjiyyn@earth.universe>
In-Reply-To: <20180208213054.oqgoktru3lzjiyyn@earth.universe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 09/02/2018 09:49:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588496437968457675?=
X-GMAIL-MSGID: =?utf-8?q?1591922630381261974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08 February 2018 21:31, Sebastian Reichel wrote:

> Hi,
>
> On Tue, Jan 02, 2018 at 03:50:53PM +0000, Adam Thomson wrote:
> > This commit adds the 'connected_type' property to represent supplies
> > which can report a number of different types of supply based on a
> > connection event.
> >
> > Examples of this already exist in drivers whereby the existing 'type'
> > property is updated, based on an event, to represent what was
> > connected (e.g. USB_DCP, USB_ACA, ...). Current implementations
> > however don't show all supported connectable types, so this knowledge
> > has to be exlicitly known for each driver that supports this.
> >
> > The 'connected_type' property is intended to fill this void and show
> > users all possible types supported by a driver. The property, when
> > read, shows all available types for the driver, and the one currently
> > chosen is highlighted/bracketed. It is expected that the 'type'
> > property would then just show the top-level type, such as 'USB', and
> > this would be static.
> >
> > Currently the 'conn_type' enum contains all of the USB variant types
> > that exist for the 'type' enum at this time, and in addition has
> > the PPS type. In the future this can be extended further for other
> > types which have multiple connected types supported. The mirroring
> > is intentional so as to not impact existing usage of the 'type'
> > property.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>
> Thanks for the patch. I think, that it's a good idea to provide the
> subtype in its own property and just set the type property to "USB".
> I would prefer to name this "usb_type". Otherwise
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>
> -- Sebastian

Thanks for your review. I chose 'connected_type' as I thought this would be=
 more
generic in case other main types would have some dynamic connection element=
 to
them and could also benefit from this. If we don't see that as being someth=
ing
we want though then I can make this just for USB.
