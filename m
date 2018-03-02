Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2195869-1520015964-2-8245713541698376015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  HTML_MESSAGE 0.001, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.216.174', Host='mail-qt0-f174.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8', html='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520015963; b=O7r8z0KdZdF7LrbtzwSlDI5M5rpF/NsPDH8d2EjNCFKD8WD
    3AajuHW88jcrGXzHEBvCUqsYFJelunVfFvrPBB/ZJt21r1UAqvTlu1yYAGjzQHEm
    7eXd330tPOhRYJlmnYI5+IZs+d3WmF1JXewunuOAC/PvwbEp8lXvH9UURFF61fD0
    ots+jIRNY6S1voCHQErL9Kz+FdT1wTRfDqsjvkAHga1wkttLxXlfi+i/8d8+u3AN
    yF7bV82TPNkvYRMq/tVvuZGOwA8iYtWnFuxUX/PLLxaiS3/Rv0W79nZyrsqQFqSu
    iI8t5o4VRThNpRdAInQzqOsY+kOmnzq6BBcHDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1520015963; bh=ATNY0GwUv3pkGBrPij/hUXgzld7eroURvwAjtF6X/Dw=; b=e
    6wcBDoja2I9GNLfR2CFlA3EdOX8GvczacbAyEbSZ4rzG9jJFHj1EGvHhjeodTlsg
    5jvxf9lh9ba//itWvQPIAs7jKthcwR0fevXX3GHTZS0SeOHE4ATHakNDY20Vrvnr
    VQ4hv+/Z5/xOCNTHWeMBsOUH2OYXbZ33hU57yY5Ppe5gbx8HyZnK1LNUHLdO1+7C
    SxjayQoSBJqhUqrnV9pK20lfpm3TIp7351xRog2rI3wtqMZfLMUdbs7H2IC34pwa
    6/y6RDWEjTWxYbCGgpDDfUJKZ35udpcJLFtXtD68zn3dTS+7tqNVJoGmlM8tbbyK
    IVohVDzlxvtonMaLq5+gw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FNOu2hr1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.174 (mail-qt0-f174.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f174.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aD1enpQ5;
    x-ptr=pass x-ptr-helo=mail-qt0-f174.google.com x-ptr-lookup=mail-qt0-f174.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FNOu2hr1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.216.174 (mail-qt0-f174.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qt0-f174.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aD1enpQ5;
    x-ptr=pass x-ptr-helo=mail-qt0-f174.google.com x-ptr-lookup=mail-qt0-f174.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELs6UoLjpHwsxi/XC9BiB8gddcpG+pDU49TGriBk3OdE7UnC3HzcyOEo7SAJ5BrcbTWT0QS39SUIPbgmkxVKiBw=
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3917B92CFDDF46F83A3C4B6B89C50@VI1PR0402MB3917.eurprd04.prod.outlook.com>
References: <1519225343-2929-1-git-send-email-leechu729@gmail.com>
 <VI1PR0402MB39173D6439D8999EDEA080DE89CD0@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <1519789258692.80587@richtek.com> <VI1PR0402MB3917A4BF4E176CD6C767348E89C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <06ae73ba737e4b5197874080384e178d@ex1.rt.l> <VI1PR0402MB3917B33C7716810B12DCE63B89C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <524719c21a4d4c5bb32480ced557d948@ex1.rt.l> <VI1PR0402MB3917B92CFDDF46F83A3C4B6B89C50@VI1PR0402MB3917.eurprd04.prod.outlook.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Sat, 3 Mar 2018 02:39:20 +0800
Message-ID: <CAFaeLdTfmgqCWEo306D+i+eOr80KDucaVjzi2frFxm--qHi1qg@mail.gmail.com>
Subject: Re: [PATCH] staging: typec: handle vendor defined part and modify drp
 toggling flow
To: Jun Li <jun.li@nxp.com>
Cc: =?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	"heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"greg@kroah.com" <greg@kroah.com>, =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Content-Type: multipart/alternative; boundary="001a11425e866b60da0566724bcd"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a11425e866b60da0566724bcd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jun,

  I think this operation should be moved to vendor's operation after
rechecking the specification.

2018-03-02 22:38 GMT+08:00 Jun Li <jun.li@nxp.com>:

> Hi
> > -----Original Message-----
> > From: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86) [mailto:shufan_lee@richte=
k.com]
> > Sent: 2018=E5=B9=B43=E6=9C=881=E6=97=A5 19:54
> > To: Jun Li <jun.li@nxp.com>; ShuFanLee <leechu729@gmail.com>;
> > heikki.krogerus@linux.intel.com; linux@roeck-us.net; greg@kroah.com
> > Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com>;
> > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: RE: [PATCH] staging: typec: handle vendor defined part and
> modify
> > drp toggling flow
> >
> > Hi Jun,
> >
> > > -----Original Message-----
> > > From: Jun Li [mailto:jun.li@nxp.com]
> > > Sent: Thursday, March 01, 2018 6:06 PM
> > > To: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86); ShuFanLee; heikki.kroger=
us@linux.intel.com;
> > > linux@roeck-us.net; greg@kroah.com
> > > Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F); linux-kernel@vger.kernel.o=
rg;
> > > linux-usb@vger.kernel.org; dl-linux-imx
> > > Subject: RE: [PATCH] staging: typec: handle vendor defined part and
> > > modify drp toggling flow
> > >
> > > Hi Shufan
> > >
> > > Please don't top posting
> > >
> > > -----Original Message-----
> > > From: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86) [mailto:shufan_lee@rich=
tek.com]
> > > Sent: 2018=E5=B9=B43=E6=9C=881=E6=97=A5 16:49
> > > To: Jun Li <jun.li@nxp.com>; ShuFanLee <leechu729@gmail.com>;
> > > heikki.krogerus@linux.intel.com; linux@roeck-us.net; greg@kroah.com
> > > Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com>;
> > > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; dl-linux-imx
> > > <linux-imx@nxp.com>
> > > Subject: RE: [PATCH] staging: typec: handle vendor defined part and
> > > modify drp toggling flow
> > >
> > > Hi Jun,
> > >
> > >   The attachment is waveform of the condition we met but I'm not sure
> > > whether you can download the attachment.
> > >   I add log in RT1711H it shows as following:
> > >
> > > You don't need add log by your own.
> > > There is tcpm(./drivers/usb/typec/tcpm.c) log for debug already,
> which can
> > show all the events and state transitions, you can get it by below
> command
> > as I commented:
> > >
> > > cat /sys/kernel/debug/tcpm/xxxxx(your tcpc i2c device)
> > >
> > After applying your patch[2], TCPM log is as following:
>
> I assume you also applied my patch [1].
> [1] https://www.spinics.net/lists/devicetree/msg216851.html
>
> Yes, this patch is also applied.

> >
> > [   53.050602] CC1: 0 -> 2, CC2: 0 -> 0 [state DRP_TOGGLING, polarity 0=
,
> > connected]
> > [   53.050613] state change DRP_TOGGLING -> SRC_ATTACH_WAIT
> > [   53.050678] pending state change SRC_ATTACH_WAIT -> SNK_TRY @
> > 200 ms
> > =3D> Rd is plugged out
> > [   53.178804] CC1: 2 -> 0, CC2: 0 -> 0 [state SRC_ATTACH_WAIT, polarit=
y
> 0,
> > disconnected]
> > [   53.178815] state change SRC_ATTACH_WAIT -> SRC_UNATTACHED
> > =3D> Rd is plugged in
> > [   53.178874] Start DRP toggling
> > [   53.188472] CC1: 0 -> 0, CC2: 0 -> 0 [state DRP_TOGGLING, polarity 0=
,
> > disconnected]
>
> 1. The plug out and then plug in happens in 10ms? (53.188472 - 53.178804)
> Was this done manually? Or by some special test method?
>
It's done manually. If you can download the waveform attached in previous
email, you can see Rd is plugged out/in within ms level.
We connect a bridge board with test points of CC1, CC2 and GND to our
platform's Typec receptacle. Then we can simulate a device plugging in/out
by connecting/disconnecting a 5.1k resistor between CC1 and GND.


> 2. This is all tcpm log if you finally keep the Rd-device connected on
> typec
> port? There is no more tcpm log after 53.188472 if you plug in Rd-device

and don't remove it?
>
Yes, RT1711H reports open/open to TCPM in drp_toggling state and stops
toggling. Currently, TCPM does not restart drp_toggling if it receives
open/open in drp_toggling state.
I remember the specification of TypeC does not depict what TCPM should do
if it receives open/open in drp_toggling state.
Maybe restart toggling is an option.

3. If the answer of Q2 is yes, then I must ask why you tcpc chip+internal
> firmware
> can't report further cc change event after your drp toggling starts to
> present Rp(I know
> it firstly present Rd after you write to LOOK4CONNECTION, but then it
> should change
> to present Rp, so it should be able to detect the Rd-device finally)
>
Because RT1711H's internal firmware changes to attached state when Rd is
re-plugged in(cc level is default Rp (around 400mV) now).
Then, LOOK4CONNECTION is set and RT1711H changes CCx to Rd that makes it
reports open/open(because cc level changes from default Rp(around 400mV) to
0mV)

>
> >
> > If TCPM does not enter SRC_ATTACHED state, RC.DRP will not be cleared.
>
> In this case, you don=E2=80=99t need clear RC.DRP, see TCPCI spec:
> "Figure 4-18. Sink Disconnect"
> TCPM sink doesn't clear it in whole sequence, just directly set it:
> Restart DRP Toggling
> PC.AutoDischargeDisconnect=3D0b
> Set RC.DRP=3D1b (DRP)
> Set RC.CC1=3D10b (Rd)
> Set RC.CC2=3D10b (Rd)
> COMMAND.Look4Connection (DRP toggle)


> > When TCPM writes Rd/Rd or Rp/Rp in the drp_toggling function, it does n=
ot
> > take effect until LOOK4CONNECTION command is set.
> > The above condition causes RT1711H reports open/open at [53.188472]
> >
> > > [ 914.937340] typec_rt1711h 2-004e: __rt1711h_irq_handler [
> > > 914.943838] typec_rt1711h 2-004e: __tcpm_get_cc cc1 =3D Open, cc2 =3D
> > Open
> > > =3D> Device(Rd) is plugged out
> > >
> > > [ 914.958041] typec_rt1711h 2-004e: tcpm_set_pd_rx 0 [ 914.963011]
> > > typec_rt1711h 2-004e: tcpm_set_vbus vbus =3D 0 [ 914.968407]
> > > typec_rt1711h
> > > 2-004e: tcpm_set_vbus chg is already 0 [ 914.974541] typec_rt1711h
> > 2-004e:
> > > tcpm_set_vconn vconn is already 0 [ 914.980921] typec_rt1711h 2-004e:
> > > tcpm_set_current_limit 0 ma, 0 mv (not implemented) [ 914.988894]
> > > typec_rt1711h 2-004e: tcpm_set_polarity Polarity_CC1 [ 915.003201]
> > > typec_rt1711h 2-004e: tcpm_set_roles Source Host [ 915.009264]
> > > typec_rt1711h 2-004e: tcpm_start_drp_toggling =3D> state_machine_work
> > of
> > > TCPM calls start_drp_toggling function but does not set
> > > LOOK4CONNECTION command yet =3D> (Note1) Device(Rd) is plugged in
> > > (RT1711H's internal firmware detects Rd plugged in. cc_change is
> > > triggered and it will be vRd-connected at this moment) =3D> TCPM writ=
es
> > > LOOK4CONNECTION command
> > > - Because RC.DRP is still 1, RT1711H will not pull cc1/cc2 to Rd whil=
e
> > > writing Rd/Rd to RC.CC1/RC.CC2.
> > > - (Note2) Right after LOOK4CONNECTION command is written, RT1711H
> > > pulls CC to Rd's level (because RC.Role is Rd/Rd), stop toggling
> > > (because
> > > device(Rd) is already connected) and CC status will be open/open now
> > > (because RT1711H presents Rd and device is connected(Rd))
> > >
> > > [ 915.037263] typec_rt1711h 2-004e: __tcpm_get_cc cc1 =3D Open, cc2 =
=3D
> > > Open =3D> Enter RT1711H's irq handler and it reports open/open
> > >
> > > I think the point is to write RC.DRP =3D 0 at the beginning of
> > > drp_toggling so that RT1711H will pull cc1/cc2 to Rd while writing
> > > Rd/Rd to RC.CC1/RC.CC2 This operation will make RT1711H's internal
> > > firmware restarts from disconnected state and toggles correctly.
> > >
> > > According to TCPCI spec (4.4.5.2):
> > > It is recommended the TCPM write ROLE_CONTROL.DRP=3D0 before writing
> > to
> > > POWER_CONTROL.AutoDischargeDisconnect and starting the DRP toggling
> > > using COMMAND.Look4Connection Restart DRP Toggling =3D> It is
> > > recommended the TCPM write ROLE_CONTROL.DRP=3D0 here Set
> > >
> > > This statement is_not_ recommend you do this(RC.DRP=3D0) for start dr=
p
> > toggling, Please carefully check the whole sentence:
> > > "... as shown in Figure 4-16, "
> > > If you look at "Figure 4-16. DRP Initialization and Connection
> Detection"
> > > It gives clear drp toggling start operations:
> > >
> > > Set TCPC to DRP
> > > - Read PS.TCPCInitializationStatus
> > > - Write ROLE_CONTROL
> > > - RC.DRP =3D 1b
> > > - RC.CC2=3D01b or 10b
> > > - RC.CC1=3D01b or 10b
> > > - RC.CC1=3DRC.CC2
> > > - Write COMMAND.Look4ConnectionPS.
> > >
> > > Above is all operations required to start drp toggling. You also can
> see
> > RC.CCx =3D 01b or 10b, not fixed to be Rd, right?
> > Yes, this one should be like your patch[07/12]. Write Rd or Rp to RC.CC=
x
> > according to the cc parameter of drp_toggling function.
> > >
> > > Go on to check the Figure 4-16
> > > After debounce, we need do following:
> > >
> > > ConnectionDetermine CC & VCONN
> > > - Write RC.CC1 & RC.CC2 per decision
> > > - Write RC.DRP=3D0
> > > - Write TCPC_CONTROl.PlugOrientation
> > > - Write PC.AutoDischargeDisconnect=3D1
> > >  & PC.EnableVconnConnection
> > >
> > > Current existing tcpm+tcpci will not clear RC.DRP after attach, That
> means
> > RC.DRP clear may be done after attach, not in start_drp_toggling.
> > > I am not sure if this can resolve your problem, but I think it deserv=
e
> a try,
> > you can follow above operation sequence while entering attach state,
> refer
> > to my patch[2]:
> > >
> > > [2]
> > >
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw
> > ww
> > > .spinics.net%2Flists%2Fdevicetree%2Fmsg216852.html&data=3D02%7C01%7
> > Cjun.
> > >
> > li%40nxp.com%7C9117425550d24ddc86d808d57f6b1b4e%7C686ea1d3bc2b
> > 4c6fa92c
> > >
> > d99c5c301635%7C0%7C0%7C636555020366483456&sdata=3D9%2BywYl%2BR
> > PYtk60Wg6p
> > > R63cCW2AnRXs%2BrINvvqUpqL18%3D&reserved=3D0
> > >
> > > diff --git a/drivers/staging/typec/tcpci.c
> > > b/drivers/staging/typec/tcpci.c index 530a5d7..7145771 100644
> > > --- a/drivers/staging/typec/tcpci.c
> > > +++ b/drivers/staging/typec/tcpci.c
> > > @@ -184,6 +184,7 @@ static int tcpci_set_polarity(struct tcpc_dev
> *tcpc,
> > >                               enum typec_cc_polarity polarity)  {
> > >         struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
> > > +       unsigned int reg;
> > >         int ret;
> > >
> > >         ret =3D regmap_write(tcpci->regmap, TCPC_TCPC_CTRL, @@
> > -192,6 +193,20 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > > +       ret =3D regmap_read(tcpci->regmap, TCPC_ROLE_CTRL, &reg);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       if (polarity =3D=3D TYPEC_POLARITY_CC2)
> > > +               ret =3D TCPC_ROLE_CTRL_CC1_SHIFT;
> > > +       else
> > > +               ret =3D TCPC_ROLE_CTRL_CC2_SHIFT;
> > > +       reg |=3D TCPC_ROLE_CTRL_CC_OPEN << ret;
> > > +       reg &=3D ~TCPC_ROLE_CTRL_DRP;
> > > +       ret =3D regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > >         return 0;
> > >  }
> > >
> > > PC.AutoDischargeDisconnect=3D0b Set RC.DRP=3D1b (DRP) Set RC.RpValue=
=3D00b
> > > (smallest Rp to save power) Set RC.CC1=3D01b Set
> > > RC.CC2=3D01bCOMMAND.Look4ConnectionNo
> > >
> > > It seems like it is not a general case here (because it is only
> > > recommended but not necessary), we can move it to vendor_ops in the
> > next patch.
> > >
> > > The TCPM should be able to cover all cases, and we should follow the
> > recommended sequence(if what you are trying to do is really as spec
> says).
> > Agree!
> > My understanding is that we need to set RC.DRP to 0 every time before
> > TCPM restarts toggling but not just for attached.
>
> Actually I have no objection on adding a RC.DRP clear, the question is
> where is the right place to do this, till now I don=E2=80=99t see how thi=
s DRP bit
> keep set
> while start drp toggling is causing problem, You want to start present Rd
> after write
> CC1/CC2 to be Rd/Rd and before write to LOOK4CONNECTION, this is not
> required
> per tcpci spec.
>
According to TCPCI's specification, it is recommended the TCPM write RC.DRP
=3D 0 before changing AutoDischargeDisconnecd.
Maybe, an interface for controlling AutoDischargeDisconnecd can be added.
Then clear RC.DRP in the beginning of that interface.

>
> -Behavior after your patch:
> //begin with Open as RC.DRP =3D 1
> RC.CCx=3DRd & RC.DRP =3D 0; //Start present Rd
> Wait 1ms; // Still Rd
> RC.CCx=3DRd & RC.DRP =3D 1; //Open?
> Look4CONNECTION =3D 1; //DRP toggling continue preset Rd
>
> Is my above CC state description correct? Is this what you want?
>
Correct. But the purpose of setting RC.CCx =3D Rd & RC.DRP =3D 0 is to make
RT1711H's internal firmware leave attached state.
Because RT1711H is still presenting Rp after the device is plugged out,
it's internal firmware enters attached state when the device re-plugged in.
When we write RC.CCx =3D Rd & RC.DRP =3D 0, RT1711H's internal firmware lea=
ves
attached state. So it will keep toggling from Rd to Rp but not report
open/open when LOOK4CONNECTION is set.
After rechecking the specification of TCPCI, I think TCPC's internal
firmware should start toggling from detached state when LOOK4CONNECTION is
set even if RC.DRP is not cleared before
I've discussed with my colleagues, we think this should be in vendor ops.
I'll update it in the patch v6.
Could I also apply your patch [1] in the patch v6?
Thank you for your time to clarify this condition.

>
> -Only apply my patches:
> //begin with Open as RC.DRP =3D 1
> RC.CCx=3DRd & RC.DRP =3D 1; //still Open
> Look4Connection =3D 1; //Start preset Rd
>
> > For RT1711H, it follows above flow. If it is not correct, this operatio=
n
> should
> > be moved to vendor_ops.
> > >
> > > For your question:
> > > Why RT1711H reports open/open after drp_toggling is enabled?
> > > =3D> See Note2 above.
> > > This open/open is for you plug out the device, right?
> > > =3D> No, see Note2 above.
> > > Why RT1711H can't report new cc change events after you plug in the
> > > device?
> > > =3D> RT1711H can generate new cc change events after plugging in the
> > device.
> > > What cc change event tcpc will report on step 4?
> > > =3D> See Note1 above
> > > Did you verify your change can pass the typec compliance test?
> > > =3D> We didn't test it yet but try to make all functions work correct=
ly
> first.
> > >
> > > Best Regards,
> > > *****************************
> > > Shu-Fan Lee
> > > Richtek Technology Corporation
> > > TEL: +886-3-5526789 #2359
> > > FAX: +886-3-5526612
> > > *****************************
> > >
> >
> > ************* Email Confidentiality Notice ********************
> >
> > The information contained in this e-mail message (including any
> attachments)
> > may be confidential, proprietary, privileged, or otherwise exempt from
> > disclosure under applicable laws. It is intended to be conveyed only to
> the
> > designated recipient(s). Any use, dissemination, distribution, printing=
,
> > retaining or copying of this e-mail (including its attachments) by
> unintended
> > recipient(s) is strictly prohibited and may be unlawful. If you are not
> an
> > intended recipient of this e-mail, or believe that you have received th=
is
> > e-mail in error, please notify the sender immediately (by replying to
> this
> > e-mail), delete any and all copies of this e-mail (including any
> attachments)
> > from your system, and do not disclose the content of this e-mail to any
> other
> > person. Thank you!
>



--=20
Best Regards,
=E6=9B=B8=E5=B8=86

--001a11425e866b60da0566724bcd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jun,<div><br></div><div>=C2=A0 I think this operation s=
hould be moved to vendor&#39;s operation after rechecking the specification=
.</div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2018-=
03-02 22:38 GMT+08:00 Jun Li <span dir=3D"ltr">&lt;<a href=3D"mailto:jun.li=
@nxp.com" target=3D"_blank">jun.li@nxp.com</a>&gt;</span>:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi<br>
<span class=3D"gmail-">&gt; -----Original Message-----<br>
&gt; From: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86) [mailto:<a href=3D"mailt=
o:shufan_lee@richtek.com">shufan_lee@richtek.com</a><wbr>]<br>
</span><div><div class=3D"gmail-h5">&gt; Sent: 2018=E5=B9=B43=E6=9C=881=E6=
=97=A5 19:54<br>
&gt; To: Jun Li &lt;<a href=3D"mailto:jun.li@nxp.com">jun.li@nxp.com</a>&gt=
;; ShuFanLee &lt;<a href=3D"mailto:leechu729@gmail.com">leechu729@gmail.com=
</a>&gt;;<br>
&gt; <a href=3D"mailto:heikki.krogerus@linux.intel.com">heikki.krogerus@lin=
ux.intel.<wbr>com</a>; <a href=3D"mailto:linux@roeck-us.net">linux@roeck-us=
.net</a>; <a href=3D"mailto:greg@kroah.com">greg@kroah.com</a><br>
&gt; Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) &lt;<a href=3D"mailto:cy_hua=
ng@richtek.com">cy_huang@richtek.com</a>&gt;;<br>
&gt; <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kern=
el.org</a>; <a href=3D"mailto:linux-usb@vger.kernel.org">linux-usb@vger.ker=
nel.org</a>; dl-linux-imx<br>
&gt; &lt;<a href=3D"mailto:linux-imx@nxp.com">linux-imx@nxp.com</a>&gt;<br>
&gt; Subject: RE: [PATCH] staging: typec: handle vendor defined part and mo=
dify<br>
&gt; drp toggling flow<br>
&gt;<br>
&gt; Hi Jun,<br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Jun Li [mailto:<a href=3D"mailto:jun.li@nxp.com">jun.li@nxp=
.com</a>]<br>
&gt; &gt; Sent: Thursday, March 01, 2018 6:06 PM<br>
&gt; &gt; To: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86); ShuFanLee; <a href=
=3D"mailto:heikki.krogerus@linux.intel.com">heikki.krogerus@linux.intel.<wb=
r>com</a>;<br>
&gt; &gt; <a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>; <a =
href=3D"mailto:greg@kroah.com">greg@kroah.com</a><br>
&gt; &gt; Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F); <a href=3D"mailto:linu=
x-kernel@vger.kernel.org">linux-kernel@vger.kernel.org</a>;<br>
&gt; &gt; <a href=3D"mailto:linux-usb@vger.kernel.org">linux-usb@vger.kerne=
l.org</a>; dl-linux-imx<br>
&gt; &gt; Subject: RE: [PATCH] staging: typec: handle vendor defined part a=
nd<br>
&gt; &gt; modify drp toggling flow<br>
&gt; &gt;<br>
&gt; &gt; Hi Shufan<br>
&gt; &gt;<br>
&gt; &gt; Please don&#39;t top posting<br>
&gt; &gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86) [mailto:<a href=3D"=
mailto:shufan_lee@richtek.com">shufan_lee@richtek.com</a><wbr>]<br>
&gt; &gt; Sent: 2018=E5=B9=B43=E6=9C=881=E6=97=A5 16:49<br>
&gt; &gt; To: Jun Li &lt;<a href=3D"mailto:jun.li@nxp.com">jun.li@nxp.com</=
a>&gt;; ShuFanLee &lt;<a href=3D"mailto:leechu729@gmail.com">leechu729@gmai=
l.com</a>&gt;;<br>
&gt; &gt; <a href=3D"mailto:heikki.krogerus@linux.intel.com">heikki.krogeru=
s@linux.intel.<wbr>com</a>; <a href=3D"mailto:linux@roeck-us.net">linux@roe=
ck-us.net</a>; <a href=3D"mailto:greg@kroah.com">greg@kroah.com</a><br>
&gt; &gt; Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) &lt;<a href=3D"mailto:c=
y_huang@richtek.com">cy_huang@richtek.com</a>&gt;;<br>
&gt; &gt; <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger=
.kernel.org</a>; <a href=3D"mailto:linux-usb@vger.kernel.org">linux-usb@vge=
r.kernel.org</a>; dl-linux-imx<br>
&gt; &gt; &lt;<a href=3D"mailto:linux-imx@nxp.com">linux-imx@nxp.com</a>&gt=
;<br>
&gt; &gt; Subject: RE: [PATCH] staging: typec: handle vendor defined part a=
nd<br>
&gt; &gt; modify drp toggling flow<br>
&gt; &gt;<br>
&gt; &gt; Hi Jun,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0The attachment is waveform of the condition we met bu=
t I&#39;m not sure<br>
&gt; &gt; whether you can download the attachment.<br>
&gt; &gt;=C2=A0 =C2=A0I add log in RT1711H it shows as following:<br>
&gt; &gt;<br>
&gt; &gt; You don&#39;t need add log by your own.<br>
&gt; &gt; There is tcpm(./drivers/usb/typec/tcpm.<wbr>c) log for debug alre=
ady, which can<br>
&gt; show all the events and state transitions, you can get it by below com=
mand<br>
&gt; as I commented:<br>
&gt; &gt;<br>
&gt; &gt; cat /sys/kernel/debug/tcpm/xxxxx(<wbr>your tcpc i2c device)<br>
&gt; &gt;<br>
&gt; After applying your patch[2], TCPM log is as following:<br>
<br>
</div></div>I assume you also applied my patch [1].<br>
[1] <a href=3D"https://www.spinics.net/lists/devicetree/msg216851.html" rel=
=3D"noreferrer" target=3D"_blank">https://www.spinics.net/lists/<wbr>device=
tree/msg216851.html</a><br>
<span class=3D"gmail-"><br></span></blockquote><div>Yes, this patch is also=
 applied. =C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><sp=
an class=3D"gmail-">
&gt;<br>
&gt; [=C2=A0 =C2=A053.050602] CC1: 0 -&gt; 2, CC2: 0 -&gt; 0 [state DRP_TOG=
GLING, polarity 0,<br>
&gt; connected]<br>
&gt; [=C2=A0 =C2=A053.050613] state change DRP_TOGGLING -&gt; SRC_ATTACH_WA=
IT<br>
&gt; [=C2=A0 =C2=A053.050678] pending state change SRC_ATTACH_WAIT -&gt; SN=
K_TRY @<br>
&gt; 200 ms<br>
&gt; =3D&gt; Rd is plugged out<br>
&gt; [=C2=A0 =C2=A053.178804] CC1: 2 -&gt; 0, CC2: 0 -&gt; 0 [state SRC_ATT=
ACH_WAIT, polarity 0,<br>
&gt; disconnected]<br>
&gt; [=C2=A0 =C2=A053.178815] state change SRC_ATTACH_WAIT -&gt; SRC_UNATTA=
CHED<br>
&gt; =3D&gt; Rd is plugged in<br>
&gt; [=C2=A0 =C2=A053.178874] Start DRP toggling<br>
&gt; [=C2=A0 =C2=A053.188472] CC1: 0 -&gt; 0, CC2: 0 -&gt; 0 [state DRP_TOG=
GLING, polarity 0,<br>
&gt; disconnected]<br>
<br>
</span>1. The plug out and then plug in happens in 10ms? (53.188472 - 53.17=
8804)<br>
Was this done manually? Or by some special test method?<br></blockquote><di=
v>It&#39;s done manually. If you can download the waveform attached in prev=
ious email, you can see Rd is plugged out/in within ms level.</div><div>We =
connect a bridge board with test points of CC1, CC2 and GND to our platform=
&#39;s Typec receptacle. Then we can simulate a device plugging in/out by c=
onnecting/disconnecting a 5.1k resistor between CC1 and GND.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
2. This is all tcpm log if you finally keep the Rd-device connected on type=
c<br>
port? There is no more tcpm log after 53.188472 if you plug in Rd-device</b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
and don&#39;t remove it?<br></blockquote><div>Yes, RT1711H reports open/ope=
n to TCPM in drp_toggling state and stops toggling. Currently, TCPM does no=
t restart drp_toggling if it receives open/open in drp_toggling state.</div=
><div>I remember the specification of TypeC does not depict what TCPM shoul=
d do if it receives open/open in drp_toggling state.</div><div>Maybe restar=
t toggling is an option.</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
3. If the answer of Q2 is yes, then I must ask why you tcpc chip+internal f=
irmware<br>
can&#39;t report further cc change event after your drp toggling starts to =
present Rp(I know<br>
it firstly present Rd after you write to LOOK4CONNECTION, but then it shoul=
d change<br>
to present Rp, so it should be able to detect the Rd-device finally)<br></b=
lockquote><div>Because RT1711H&#39;s internal firmware changes to attached =
state when Rd is re-plugged in(cc level is default Rp (around 400mV) now).<=
/div><div>Then, LOOK4CONNECTION is set and RT1711H changes CCx to Rd that m=
akes it reports open/open(because cc level changes from default Rp(around 4=
00mV) to 0mV)=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt;<br>
&gt; If TCPM does not enter SRC_ATTACHED state, RC.DRP will not be cleared.=
<br>
<br>
</span>In this case, you don=E2=80=99t need clear RC.DRP, see TCPCI spec:<b=
r>
&quot;Figure 4-18. Sink Disconnect&quot;<br>
TCPM sink doesn&#39;t clear it in whole sequence, just directly set it:<br>
Restart DRP Toggling<br>
PC.AutoDischargeDisconnect=3D0b<br>
Set RC.DRP=3D1b (DRP)<br>
Set RC.CC1=3D10b (Rd)<br>
Set RC.CC2=3D10b (Rd)<br>
COMMAND.Look4Connection (DRP toggle)</blockquote><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<div><div class=3D"gmail-h5"><br>
&gt; When TCPM writes Rd/Rd or Rp/Rp in the drp_toggling function, it does =
not<br>
&gt; take effect until LOOK4CONNECTION command is set.<br>
&gt; The above condition causes RT1711H reports open/open at [53.188472]<br=
>
&gt;<br>
&gt; &gt; [ 914.937340] typec_rt1711h 2-004e: __rt1711h_irq_handler [<br>
&gt; &gt; 914.943838] typec_rt1711h 2-004e: __tcpm_get_cc cc1 =3D Open, cc2=
 =3D<br>
&gt; Open<br>
&gt; &gt; =3D&gt; Device(Rd) is plugged out<br>
&gt; &gt;<br>
&gt; &gt; [ 914.958041] typec_rt1711h 2-004e: tcpm_set_pd_rx 0 [ 914.963011=
]<br>
&gt; &gt; typec_rt1711h 2-004e: tcpm_set_vbus vbus =3D 0 [ 914.968407]<br>
&gt; &gt; typec_rt1711h<br>
&gt; &gt; 2-004e: tcpm_set_vbus chg is already 0 [ 914.974541] typec_rt1711=
h<br>
&gt; 2-004e:<br>
&gt; &gt; tcpm_set_vconn vconn is already 0 [ 914.980921] typec_rt1711h 2-0=
04e:<br>
&gt; &gt; tcpm_set_current_limit 0 ma, 0 mv (not implemented) [ 914.988894]=
<br>
&gt; &gt; typec_rt1711h 2-004e: tcpm_set_polarity Polarity_CC1 [ 915.003201=
]<br>
&gt; &gt; typec_rt1711h 2-004e: tcpm_set_roles Source Host [ 915.009264]<br=
>
&gt; &gt; typec_rt1711h 2-004e: tcpm_start_drp_toggling =3D&gt; state_machi=
ne_work<br>
&gt; of<br>
&gt; &gt; TCPM calls start_drp_toggling function but does not set<br>
&gt; &gt; LOOK4CONNECTION command yet =3D&gt; (Note1) Device(Rd) is plugged=
 in<br>
&gt; &gt; (RT1711H&#39;s internal firmware detects Rd plugged in. cc_change=
 is<br>
&gt; &gt; triggered and it will be vRd-connected at this moment) =3D&gt; TC=
PM writes<br>
&gt; &gt; LOOK4CONNECTION command<br>
&gt; &gt; - Because RC.DRP is still 1, RT1711H will not pull cc1/cc2 to Rd =
while<br>
&gt; &gt; writing Rd/Rd to RC.CC1/RC.CC2.<br>
&gt; &gt; - (Note2) Right after LOOK4CONNECTION command is written, RT1711H=
<br>
&gt; &gt; pulls CC to Rd&#39;s level (because RC.Role is Rd/Rd), stop toggl=
ing<br>
&gt; &gt; (because<br>
&gt; &gt; device(Rd) is already connected) and CC status will be open/open =
now<br>
&gt; &gt; (because RT1711H presents Rd and device is connected(Rd))<br>
&gt; &gt;<br>
&gt; &gt; [ 915.037263] typec_rt1711h 2-004e: __tcpm_get_cc cc1 =3D Open, c=
c2 =3D<br>
&gt; &gt; Open =3D&gt; Enter RT1711H&#39;s irq handler and it reports open/=
open<br>
&gt; &gt;<br>
&gt; &gt; I think the point is to write RC.DRP =3D 0 at the beginning of<br=
>
&gt; &gt; drp_toggling so that RT1711H will pull cc1/cc2 to Rd while writin=
g<br>
&gt; &gt; Rd/Rd to RC.CC1/RC.CC2 This operation will make RT1711H&#39;s int=
ernal<br>
&gt; &gt; firmware restarts from disconnected state and toggles correctly.<=
br>
&gt; &gt;<br>
&gt; &gt; According to TCPCI spec (4.4.5.2):<br>
&gt; &gt; It is recommended the TCPM write ROLE_CONTROL.DRP=3D0 before writ=
ing<br>
&gt; to<br>
&gt; &gt; POWER_CONTROL.<wbr>AutoDischargeDisconnect and starting the DRP t=
oggling<br>
&gt; &gt; using COMMAND.Look4Connection Restart DRP Toggling =3D&gt; It is<=
br>
&gt; &gt; recommended the TCPM write ROLE_CONTROL.DRP=3D0 here Set<br>
&gt; &gt;<br>
&gt; &gt; This statement is_not_ recommend you do this(RC.DRP=3D0) for star=
t drp<br>
&gt; toggling, Please carefully check the whole sentence:<br>
&gt; &gt; &quot;... as shown in Figure 4-16, &quot;<br>
&gt; &gt; If you look at &quot;Figure 4-16. DRP Initialization and Connecti=
on Detection&quot;<br>
&gt; &gt; It gives clear drp toggling start operations:<br>
&gt; &gt;<br>
&gt; &gt; Set TCPC to DRP<br>
&gt; &gt; - Read PS.TCPCInitializationStatus<br>
&gt; &gt; - Write ROLE_CONTROL<br>
&gt; &gt; - RC.DRP =3D 1b<br>
&gt; &gt; - RC.CC2=3D01b or 10b<br>
&gt; &gt; - RC.CC1=3D01b or 10b<br>
&gt; &gt; - RC.CC1=3DRC.CC2<br>
&gt; &gt; - Write COMMAND.Look4ConnectionPS.<br>
&gt; &gt;<br>
&gt; &gt; Above is all operations required to start drp toggling. You also =
can see<br>
&gt; RC.CCx =3D 01b or 10b, not fixed to be Rd, right?<br>
&gt; Yes, this one should be like your patch[07/12]. Write Rd or Rp to RC.C=
Cx<br>
&gt; according to the cc parameter of drp_toggling function.<br>
&gt; &gt;<br>
&gt; &gt; Go on to check the Figure 4-16<br>
&gt; &gt; After debounce, we need do following:<br>
&gt; &gt;<br>
&gt; &gt; ConnectionDetermine CC &amp; VCONN<br>
&gt; &gt; - Write RC.CC1 &amp; RC.CC2 per decision<br>
&gt; &gt; - Write RC.DRP=3D0<br>
&gt; &gt; - Write TCPC_CONTROl.PlugOrientation<br>
&gt; &gt; - Write PC.AutoDischargeDisconnect=3D1<br>
&gt; &gt;=C2=A0 &amp; PC.EnableVconnConnection<br>
&gt; &gt;<br>
&gt; &gt; Current existing tcpm+tcpci will not clear RC.DRP after attach, T=
hat means<br>
&gt; RC.DRP clear may be done after attach, not in start_drp_toggling.<br>
&gt; &gt; I am not sure if this can resolve your problem, but I think it de=
serve a try,<br>
&gt; you can follow above operation sequence while entering attach state, r=
efer<br>
&gt; to my patch[2]:<br>
&gt; &gt;<br>
&gt; &gt; [2]<br>
&gt; &gt;<br>
</div></div>&gt; <a href=3D"https://emea01.safelinks.protection.outlook.com=
/?url=3Dhttps%3A%2F%2Fw" rel=3D"noreferrer" target=3D"_blank">https://emea0=
1.safelinks.<wbr>protection.outlook.com/?url=3D<wbr>https%3A%2F%2Fw</a><br>
&gt; ww<br>
&gt; &gt; .<a href=3D"http://spinics.net" rel=3D"noreferrer" target=3D"_bla=
nk">spinics.net</a>%2Flists%<wbr>2Fdevicetree%2Fmsg216852.html&amp;<wbr>dat=
a=3D02%7C01%7<br>
&gt; Cjun.<br>
&gt; &gt;<br>
&gt; li%<a href=3D"http://40nxp.com" rel=3D"noreferrer" target=3D"_blank">4=
0nxp.com</a>%<wbr>7C9117425550d24ddc86d808d57f6b<wbr>1b4e%7C686ea1d3bc2b<br=
>
&gt; 4c6fa92c<br>
&gt; &gt;<br>
&gt; d99c5c301635%7C0%7C0%<wbr>7C636555020366483456&amp;sdata=3D9%<wbr>2Byw=
Yl%2BR<br>
&gt; PYtk60Wg6p<br>
&gt; &gt; R63cCW2AnRXs%2BrINvvqUpqL18%<wbr>3D&amp;reserved=3D0<br>
<div><div class=3D"gmail-h5">&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/staging/typec/tcpci.<wbr>c<br>
&gt; &gt; b/drivers/staging/typec/tcpci.<wbr>c index 530a5d7..7145771 10064=
4<br>
&gt; &gt; --- a/drivers/staging/typec/tcpci.<wbr>c<br>
&gt; &gt; +++ b/drivers/staging/typec/tcpci.<wbr>c<br>
&gt; &gt; @@ -184,6 +184,7 @@ static int tcpci_set_polarity(struct tcpc_dev=
 *tcpc,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum typec_cc_polarity polarit=
y)=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tcpci *tcpci =3D tcpc_to_=
tcpci(tcpc);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int reg;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;r=
egmap, TCPC_TCPC_CTRL, @@<br>
&gt; -192,6 +193,20 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn ret;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regmap_read(tcpci-&gt;regmap,=
 TCPC_ROLE_CTRL, &amp;reg);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return re=
t;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (polarity =3D=3D TYPEC_POLARITY_CC=
2)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D T=
CPC_ROLE_CTRL_CC1_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D T=
CPC_ROLE_CTRL_CC2_SHIFT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg |=3D TCPC_ROLE_CTRL_CC_OPEN &lt;&=
lt; ret;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg &amp;=3D ~TCPC_ROLE_CTRL_DRP;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D regmap_write(tcpci-&gt;regmap=
, TCPC_ROLE_CTRL, reg);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return re=
t;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; PC.AutoDischargeDisconnect=3D0b Set RC.DRP=3D1b (DRP) Set RC.RpVa=
lue=3D00b<br>
&gt; &gt; (smallest Rp to save power) Set RC.CC1=3D01b Set<br>
&gt; &gt; RC.CC2=3D01bCOMMAND.<wbr>Look4ConnectionNo<br>
&gt; &gt;<br>
&gt; &gt; It seems like it is not a general case here (because it is only<b=
r>
&gt; &gt; recommended but not necessary), we can move it to vendor_ops in t=
he<br>
&gt; next patch.<br>
&gt; &gt;<br>
&gt; &gt; The TCPM should be able to cover all cases, and we should follow =
the<br>
&gt; recommended sequence(if what you are trying to do is really as spec sa=
ys).<br>
&gt; Agree!<br>
&gt; My understanding is that we need to set RC.DRP to 0 every time before<=
br>
&gt; TCPM restarts toggling but not just for attached.<br>
<br>
</div></div>Actually I have no objection on adding a RC.DRP clear, the ques=
tion is<br>
where is the right place to do this, till now I don=E2=80=99t see how this =
DRP bit keep set<br>
while start drp toggling is causing problem, You want to start present Rd a=
fter write<br>
CC1/CC2 to be Rd/Rd and before write to LOOK4CONNECTION, this is not requir=
ed<br>
per tcpci spec.<br></blockquote><div>According to TCPCI&#39;s specification=
, it is recommended the TCPM write RC.DRP =3D 0 before changing AutoDischar=
geDisconnecd.</div><div>Maybe, an interface for controlling AutoDischargeDi=
sconnecd can be added. Then clear RC.DRP in the beginning of that interface=
.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-Behavior after your patch:<br>
//begin with Open as RC.DRP =3D 1<br>
RC.CCx=3DRd &amp; RC.DRP =3D 0; //Start present Rd<br>
Wait 1ms; // Still Rd<br>
RC.CCx=3DRd &amp; RC.DRP =3D 1; //Open?<br>
Look4CONNECTION =3D 1; //DRP toggling continue preset Rd<br>
<br>
Is my above CC state description correct? Is this what you want?<br></block=
quote><div>Correct. But the purpose of setting RC.CCx =3D Rd &amp; RC.DRP =
=3D 0 is to make RT1711H&#39;s internal firmware leave attached state.</div=
><div>Because RT1711H is still presenting Rp after the device is plugged ou=
t, it&#39;s internal firmware enters attached state when the device re-plug=
ged in.</div><div>When we write RC.CCx =3D Rd &amp; RC.DRP =3D 0, RT1711H&#=
39;s internal firmware leaves attached state. So it will keep toggling from=
 Rd to Rp but not report open/open when LOOK4CONNECTION is set.</div><div>A=
fter rechecking the specification of TCPCI, I think TCPC&#39;s internal fir=
mware should start toggling from detached state when LOOK4CONNECTION is set=
 even if RC.DRP is not cleared before</div><div>I&#39;ve discussed with my =
colleagues, we think this should be in vendor ops. I&#39;ll update it in th=
e patch v6.</div><div>Could I also apply your patch [1] in the patch v6?</d=
iv><div>Thank you for your time to clarify this condition.</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
-Only apply my patches:<br>
//begin with Open as RC.DRP =3D 1<br>
RC.CCx=3DRd &amp; RC.DRP =3D 1; //still Open<br>
Look4Connection =3D 1; //Start preset Rd<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
&gt; For RT1711H, it follows above flow. If it is not correct, this operati=
on should<br>
&gt; be moved to vendor_ops.<br>
&gt; &gt;<br>
&gt; &gt; For your question:<br>
&gt; &gt; Why RT1711H reports open/open after drp_toggling is enabled?<br>
&gt; &gt; =3D&gt; See Note2 above.<br>
&gt; &gt; This open/open is for you plug out the device, right?<br>
&gt; &gt; =3D&gt; No, see Note2 above.<br>
&gt; &gt; Why RT1711H can&#39;t report new cc change events after you plug =
in the<br>
&gt; &gt; device?<br>
&gt; &gt; =3D&gt; RT1711H can generate new cc change events after plugging =
in the<br>
&gt; device.<br>
&gt; &gt; What cc change event tcpc will report on step 4?<br>
&gt; &gt; =3D&gt; See Note1 above<br>
&gt; &gt; Did you verify your change can pass the typec compliance test?<br=
>
&gt; &gt; =3D&gt; We didn&#39;t test it yet but try to make all functions w=
ork correctly first.<br>
&gt; &gt;<br>
&gt; &gt; Best Regards,<br>
&gt; &gt; *****************************<br>
&gt; &gt; Shu-Fan Lee<br>
&gt; &gt; Richtek Technology Corporation<br>
&gt; &gt; TEL: <a href=3D"tel:%2B886-3-5526789%20%232359" value=3D"+8863552=
6789">+886-3-5526789 #2359</a><br>
&gt; &gt; FAX: <a href=3D"tel:%2B886-3-5526612" value=3D"+88635526612">+886=
-3-5526612</a><br>
&gt; &gt; *****************************<br>
&gt; &gt;<br>
&gt;<br>
&gt; ************* Email Confidentiality Notice ********************<br>
&gt;<br>
&gt; The information contained in this e-mail message (including any attach=
ments)<br>
&gt; may be confidential, proprietary, privileged, or otherwise exempt from=
<br>
&gt; disclosure under applicable laws. It is intended to be conveyed only t=
o the<br>
&gt; designated recipient(s). Any use, dissemination, distribution, printin=
g,<br>
&gt; retaining or copying of this e-mail (including its attachments) by uni=
ntended<br>
&gt; recipient(s) is strictly prohibited and may be unlawful. If you are no=
t an<br>
&gt; intended recipient of this e-mail, or believe that you have received t=
his<br>
&gt; e-mail in error, please notify the sender immediately (by replying to =
this<br>
&gt; e-mail), delete any and all copies of this e-mail (including any attac=
hments)<br>
&gt; from your system, and do not disclose the content of this e-mail to an=
y other<br>
&gt; person. Thank you!<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr">Best Regards,<div>=E6=9B=B8=
=E5=B8=86</div></div></div>
</div></div></div>

--001a11425e866b60da0566724bcd--
