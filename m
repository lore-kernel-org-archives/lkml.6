Return-Path: <leechu729@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2195869-1520016201-2-4554134732476710458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.220.170', Host='mail-qk0-f170.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: leechu729@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520016199; b=wArqFZ14YstMJ3RfVZAknV5FBFN8YH116zzlP53ve8lYYQW
    o9xNXb96nJhia3ZXAyWbUqGq8QooQpqc5ncnAKogo6Gnxr6a9WFT+kSdr97Grcfs
    IbtVcKCZ0CLQRpbIkdx2pO4cI4ta0ydgzpPx18lAoBqg+rw3ciw13KpCXBTgolcS
    rRQtZKd2zoT/QwWCtF0p40DvcSWZJl55gslTLoxDVh3hxW9b4RFwV8I/5hofvCJ+
    ldR3wqxFUO/sFP611giUopgoLnM7ByrvoWSDN2C/F9O+dbV5w+RtOz36isIabBgP
    hPjjL5Cqg49isMuHOtBdLHD3sc+a4iLUL8Kwuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding; s=arctest; t=1520016199; bh=uvo6Jqkj
    ewg4TCILnY+QwHgzuFTwHlzHVGOKPzlrUrA=; b=AJrtrbHj9LQaEe3Mkk7cyet4
    Lit5tzW/uR7OBe6YePz/wu1vUcucIXCwIEQI9932g9POFL4xyMe2/m0z6XjFmi6p
    FiTUX/jjOnFLdraFFsMIJJBrQEMx8wrVdBeXezOAAFQgfsr3XzcJtQJ9M2YB6h/I
    swAOZBo9Mf2HR1vnVfZuIe1wZYp0rs5tI9V+619bf7V40jiPS3eCOe53TH2u2vov
    ZQg7u7z30cYkjpeMabwNEINGCgnFi301hYNIo+sh5DfVQZsT5bLKHBdye4/w4fnt
    QpkD/hhz716xN7hVN5q26oaTHtKjr/4tS/7bqfwd83/Hq55LB14M60O7eDjU+w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=npuSTBPk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.170 (mail-qk0-f170.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f170.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QbHCP46M;
    x-ptr=pass x-ptr-helo=mail-qk0-f170.google.com x-ptr-lookup=mail-qk0-f170.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=npuSTBPk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.220.170 (mail-qk0-f170.google.com);
    spf=pass smtp.mailfrom=leechu729@gmail.com smtp.helo=mail-qk0-f170.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QbHCP46M;
    x-ptr=pass x-ptr-helo=mail-qk0-f170.google.com x-ptr-lookup=mail-qk0-f170.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELvp/Ibvo9vimw4MblFiK6JJcN/UQDTKjvznYBhnS6ilhzftEG1VxnnBk5ieYgKXr07SSkxvO7MmMqeU/OM6djg=
MIME-Version: 1.0
In-Reply-To: <CAFaeLdTfmgqCWEo306D+i+eOr80KDucaVjzi2frFxm--qHi1qg@mail.gmail.com>
References: <1519225343-2929-1-git-send-email-leechu729@gmail.com>
 <VI1PR0402MB39173D6439D8999EDEA080DE89CD0@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <1519789258692.80587@richtek.com> <VI1PR0402MB3917A4BF4E176CD6C767348E89C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <06ae73ba737e4b5197874080384e178d@ex1.rt.l> <VI1PR0402MB3917B33C7716810B12DCE63B89C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <524719c21a4d4c5bb32480ced557d948@ex1.rt.l> <VI1PR0402MB3917B92CFDDF46F83A3C4B6B89C50@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <CAFaeLdTfmgqCWEo306D+i+eOr80KDucaVjzi2frFxm--qHi1qg@mail.gmail.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Sat, 3 Mar 2018 02:43:16 +0800
Message-ID: <CAFaeLdTHY-OPsBecDNOjbn7fpZ8QVGVMJWiWttXoYZCNs6cFaw@mail.gmail.com>
Subject: Re: [PATCH] staging: typec: handle vendor defined part and modify drp
 toggling flow
To: Jun Li <jun.li@nxp.com>
Cc: =?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	"heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"greg@kroah.com" <greg@kroah.com>, =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

  Sorry, I modify it to plain text mode and send again

2018-03-03 2:39 GMT+08:00 =E6=9D=8E=E6=9B=B8=E5=B8=86 <leechu729@gmail.com>=
:
>
> Hi Jun,
>
>   I think this operation should be moved to vendor's operation after rech=
ecking the specification.
>
> 2018-03-02 22:38 GMT+08:00 Jun Li <jun.li@nxp.com>:
>>
>> Hi
>> > -----Original Message-----
>> > From: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86) [mailto:shufan_lee@richt=
ek.com]
>> > Sent: 2018=E5=B9=B43=E6=9C=881=E6=97=A5 19:54
>> > To: Jun Li <jun.li@nxp.com>; ShuFanLee <leechu729@gmail.com>;
>> > heikki.krogerus@linux.intel.com; linux@roeck-us.net; greg@kroah.com
>> > Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com>;
>> > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; dl-linux-imx
>> > <linux-imx@nxp.com>
>> > Subject: RE: [PATCH] staging: typec: handle vendor defined part and mo=
dify
>> > drp toggling flow
>> >
>> > Hi Jun,
>> >
>> > > -----Original Message-----
>> > > From: Jun Li [mailto:jun.li@nxp.com]
>> > > Sent: Thursday, March 01, 2018 6:06 PM
>> > > To: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86); ShuFanLee; heikki.kroge=
rus@linux.intel.com;
>> > > linux@roeck-us.net; greg@kroah.com
>> > > Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F); linux-kernel@vger.kernel.=
org;
>> > > linux-usb@vger.kernel.org; dl-linux-imx
>> > > Subject: RE: [PATCH] staging: typec: handle vendor defined part and
>> > > modify drp toggling flow
>> > >
>> > > Hi Shufan
>> > >
>> > > Please don't top posting
>> > >
>> > > -----Original Message-----
>> > > From: shufan_lee(=E6=9D=8E=E6=9B=B8=E5=B8=86) [mailto:shufan_lee@ric=
htek.com]
>> > > Sent: 2018=E5=B9=B43=E6=9C=881=E6=97=A5 16:49
>> > > To: Jun Li <jun.li@nxp.com>; ShuFanLee <leechu729@gmail.com>;
>> > > heikki.krogerus@linux.intel.com; linux@roeck-us.net; greg@kroah.com
>> > > Cc: cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com>;
>> > > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; dl-linux-im=
x
>> > > <linux-imx@nxp.com>
>> > > Subject: RE: [PATCH] staging: typec: handle vendor defined part and
>> > > modify drp toggling flow
>> > >
>> > > Hi Jun,
>> > >
>> > >   The attachment is waveform of the condition we met but I'm not sur=
e
>> > > whether you can download the attachment.
>> > >   I add log in RT1711H it shows as following:
>> > >
>> > > You don't need add log by your own.
>> > > There is tcpm(./drivers/usb/typec/tcpm.c) log for debug already, whi=
ch can
>> > show all the events and state transitions, you can get it by below com=
mand
>> > as I commented:
>> > >
>> > > cat /sys/kernel/debug/tcpm/xxxxx(your tcpc i2c device)
>> > >
>> > After applying your patch[2], TCPM log is as following:
>>
>> I assume you also applied my patch [1].
>> [1] https://www.spinics.net/lists/devicetree/msg216851.html
>>
> Yes, this patch is also applied.
>>
>> >
>> > [   53.050602] CC1: 0 -> 2, CC2: 0 -> 0 [state DRP_TOGGLING, polarity =
0,
>> > connected]
>> > [   53.050613] state change DRP_TOGGLING -> SRC_ATTACH_WAIT
>> > [   53.050678] pending state change SRC_ATTACH_WAIT -> SNK_TRY @
>> > 200 ms
>> > =3D> Rd is plugged out
>> > [   53.178804] CC1: 2 -> 0, CC2: 0 -> 0 [state SRC_ATTACH_WAIT, polari=
ty 0,
>> > disconnected]
>> > [   53.178815] state change SRC_ATTACH_WAIT -> SRC_UNATTACHED
>> > =3D> Rd is plugged in
>> > [   53.178874] Start DRP toggling
>> > [   53.188472] CC1: 0 -> 0, CC2: 0 -> 0 [state DRP_TOGGLING, polarity =
0,
>> > disconnected]
>>
>> 1. The plug out and then plug in happens in 10ms? (53.188472 - 53.178804=
)
>> Was this done manually? Or by some special test method?
>
> It's done manually. If you can download the waveform attached in previous=
 email, you can see Rd is plugged out/in within ms level.
> We connect a bridge board with test points of CC1, CC2 and GND to our pla=
tform's Typec receptacle. Then we can simulate a device plugging in/out by =
connecting/disconnecting a 5.1k resistor between CC1 and GND.
>
>>
>> 2. This is all tcpm log if you finally keep the Rd-device connected on t=
ypec
>> port? There is no more tcpm log after 53.188472 if you plug in Rd-device
>>
>> and don't remove it?
>
> Yes, RT1711H reports open/open to TCPM in drp_toggling state and stops to=
ggling. Currently, TCPM does not restart drp_toggling if it receives open/o=
pen in drp_toggling state.
> I remember the specification of TypeC does not depict what TCPM should do=
 if it receives open/open in drp_toggling state.
> Maybe restart toggling is an option.
>
>> 3. If the answer of Q2 is yes, then I must ask why you tcpc chip+interna=
l firmware
>> can't report further cc change event after your drp toggling starts to p=
resent Rp(I know
>> it firstly present Rd after you write to LOOK4CONNECTION, but then it sh=
ould change
>> to present Rp, so it should be able to detect the Rd-device finally)
>
> Because RT1711H's internal firmware changes to attached state when Rd is =
re-plugged in(cc level is default Rp (around 400mV) now).
> Then, LOOK4CONNECTION is set and RT1711H changes CCx to Rd that makes it =
reports open/open(because cc level changes from default Rp(around 400mV) to=
 0mV)
>>
>>
>> >
>> > If TCPM does not enter SRC_ATTACHED state, RC.DRP will not be cleared.
>>
>> In this case, you don=E2=80=99t need clear RC.DRP, see TCPCI spec:
>> "Figure 4-18. Sink Disconnect"
>> TCPM sink doesn't clear it in whole sequence, just directly set it:
>> Restart DRP Toggling
>> PC.AutoDischargeDisconnect=3D0b
>> Set RC.DRP=3D1b (DRP)
>> Set RC.CC1=3D10b (Rd)
>> Set RC.CC2=3D10b (Rd)
>> COMMAND.Look4Connection (DRP toggle)
>>
>>
>> > When TCPM writes Rd/Rd or Rp/Rp in the drp_toggling function, it does =
not
>> > take effect until LOOK4CONNECTION command is set.
>> > The above condition causes RT1711H reports open/open at [53.188472]
>> >
>> > > [ 914.937340] typec_rt1711h 2-004e: __rt1711h_irq_handler [
>> > > 914.943838] typec_rt1711h 2-004e: __tcpm_get_cc cc1 =3D Open, cc2 =
=3D
>> > Open
>> > > =3D> Device(Rd) is plugged out
>> > >
>> > > [ 914.958041] typec_rt1711h 2-004e: tcpm_set_pd_rx 0 [ 914.963011]
>> > > typec_rt1711h 2-004e: tcpm_set_vbus vbus =3D 0 [ 914.968407]
>> > > typec_rt1711h
>> > > 2-004e: tcpm_set_vbus chg is already 0 [ 914.974541] typec_rt1711h
>> > 2-004e:
>> > > tcpm_set_vconn vconn is already 0 [ 914.980921] typec_rt1711h 2-004e=
:
>> > > tcpm_set_current_limit 0 ma, 0 mv (not implemented) [ 914.988894]
>> > > typec_rt1711h 2-004e: tcpm_set_polarity Polarity_CC1 [ 915.003201]
>> > > typec_rt1711h 2-004e: tcpm_set_roles Source Host [ 915.009264]
>> > > typec_rt1711h 2-004e: tcpm_start_drp_toggling =3D> state_machine_wor=
k
>> > of
>> > > TCPM calls start_drp_toggling function but does not set
>> > > LOOK4CONNECTION command yet =3D> (Note1) Device(Rd) is plugged in
>> > > (RT1711H's internal firmware detects Rd plugged in. cc_change is
>> > > triggered and it will be vRd-connected at this moment) =3D> TCPM wri=
tes
>> > > LOOK4CONNECTION command
>> > > - Because RC.DRP is still 1, RT1711H will not pull cc1/cc2 to Rd whi=
le
>> > > writing Rd/Rd to RC.CC1/RC.CC2.
>> > > - (Note2) Right after LOOK4CONNECTION command is written, RT1711H
>> > > pulls CC to Rd's level (because RC.Role is Rd/Rd), stop toggling
>> > > (because
>> > > device(Rd) is already connected) and CC status will be open/open now
>> > > (because RT1711H presents Rd and device is connected(Rd))
>> > >
>> > > [ 915.037263] typec_rt1711h 2-004e: __tcpm_get_cc cc1 =3D Open, cc2 =
=3D
>> > > Open =3D> Enter RT1711H's irq handler and it reports open/open
>> > >
>> > > I think the point is to write RC.DRP =3D 0 at the beginning of
>> > > drp_toggling so that RT1711H will pull cc1/cc2 to Rd while writing
>> > > Rd/Rd to RC.CC1/RC.CC2 This operation will make RT1711H's internal
>> > > firmware restarts from disconnected state and toggles correctly.
>> > >
>> > > According to TCPCI spec (4.4.5.2):
>> > > It is recommended the TCPM write ROLE_CONTROL.DRP=3D0 before writing
>> > to
>> > > POWER_CONTROL.AutoDischargeDisconnect and starting the DRP toggling
>> > > using COMMAND.Look4Connection Restart DRP Toggling =3D> It is
>> > > recommended the TCPM write ROLE_CONTROL.DRP=3D0 here Set
>> > >
>> > > This statement is_not_ recommend you do this(RC.DRP=3D0) for start d=
rp
>> > toggling, Please carefully check the whole sentence:
>> > > "... as shown in Figure 4-16, "
>> > > If you look at "Figure 4-16. DRP Initialization and Connection Detec=
tion"
>> > > It gives clear drp toggling start operations:
>> > >
>> > > Set TCPC to DRP
>> > > - Read PS.TCPCInitializationStatus
>> > > - Write ROLE_CONTROL
>> > > - RC.DRP =3D 1b
>> > > - RC.CC2=3D01b or 10b
>> > > - RC.CC1=3D01b or 10b
>> > > - RC.CC1=3DRC.CC2
>> > > - Write COMMAND.Look4ConnectionPS.
>> > >
>> > > Above is all operations required to start drp toggling. You also can=
 see
>> > RC.CCx =3D 01b or 10b, not fixed to be Rd, right?
>> > Yes, this one should be like your patch[07/12]. Write Rd or Rp to RC.C=
Cx
>> > according to the cc parameter of drp_toggling function.
>> > >
>> > > Go on to check the Figure 4-16
>> > > After debounce, we need do following:
>> > >
>> > > ConnectionDetermine CC & VCONN
>> > > - Write RC.CC1 & RC.CC2 per decision
>> > > - Write RC.DRP=3D0
>> > > - Write TCPC_CONTROl.PlugOrientation
>> > > - Write PC.AutoDischargeDisconnect=3D1
>> > >  & PC.EnableVconnConnection
>> > >
>> > > Current existing tcpm+tcpci will not clear RC.DRP after attach, That=
 means
>> > RC.DRP clear may be done after attach, not in start_drp_toggling.
>> > > I am not sure if this can resolve your problem, but I think it deser=
ve a try,
>> > you can follow above operation sequence while entering attach state, r=
efer
>> > to my patch[2]:
>> > >
>> > > [2]
>> > >
>> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw
>> > ww
>> > > .spinics.net%2Flists%2Fdevicetree%2Fmsg216852.html&data=3D02%7C01%7
>> > Cjun.
>> > >
>> > li%40nxp.com%7C9117425550d24ddc86d808d57f6b1b4e%7C686ea1d3bc2b
>> > 4c6fa92c
>> > >
>> > d99c5c301635%7C0%7C0%7C636555020366483456&sdata=3D9%2BywYl%2BR
>> > PYtk60Wg6p
>> > > R63cCW2AnRXs%2BrINvvqUpqL18%3D&reserved=3D0
>> > >
>> > > diff --git a/drivers/staging/typec/tcpci.c
>> > > b/drivers/staging/typec/tcpci.c index 530a5d7..7145771 100644
>> > > --- a/drivers/staging/typec/tcpci.c
>> > > +++ b/drivers/staging/typec/tcpci.c
>> > > @@ -184,6 +184,7 @@ static int tcpci_set_polarity(struct tcpc_dev *t=
cpc,
>> > >                               enum typec_cc_polarity polarity)  {
>> > >         struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
>> > > +       unsigned int reg;
>> > >         int ret;
>> > >
>> > >         ret =3D regmap_write(tcpci->regmap, TCPC_TCPC_CTRL, @@
>> > -192,6 +193,20 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
>> > >         if (ret < 0)
>> > >                 return ret;
>> > >
>> > > +       ret =3D regmap_read(tcpci->regmap, TCPC_ROLE_CTRL, &reg);
>> > > +       if (ret < 0)
>> > > +               return ret;
>> > > +
>> > > +       if (polarity =3D=3D TYPEC_POLARITY_CC2)
>> > > +               ret =3D TCPC_ROLE_CTRL_CC1_SHIFT;
>> > > +       else
>> > > +               ret =3D TCPC_ROLE_CTRL_CC2_SHIFT;
>> > > +       reg |=3D TCPC_ROLE_CTRL_CC_OPEN << ret;
>> > > +       reg &=3D ~TCPC_ROLE_CTRL_DRP;
>> > > +       ret =3D regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
>> > > +       if (ret < 0)
>> > > +               return ret;
>> > > +
>> > >         return 0;
>> > >  }
>> > >
>> > > PC.AutoDischargeDisconnect=3D0b Set RC.DRP=3D1b (DRP) Set RC.RpValue=
=3D00b
>> > > (smallest Rp to save power) Set RC.CC1=3D01b Set
>> > > RC.CC2=3D01bCOMMAND.Look4ConnectionNo
>> > >
>> > > It seems like it is not a general case here (because it is only
>> > > recommended but not necessary), we can move it to vendor_ops in the
>> > next patch.
>> > >
>> > > The TCPM should be able to cover all cases, and we should follow the
>> > recommended sequence(if what you are trying to do is really as spec sa=
ys).
>> > Agree!
>> > My understanding is that we need to set RC.DRP to 0 every time before
>> > TCPM restarts toggling but not just for attached.
>>
>> Actually I have no objection on adding a RC.DRP clear, the question is
>> where is the right place to do this, till now I don=E2=80=99t see how th=
is DRP bit keep set
>> while start drp toggling is causing problem, You want to start present R=
d after write
>> CC1/CC2 to be Rd/Rd and before write to LOOK4CONNECTION, this is not req=
uired
>> per tcpci spec.
>
> According to TCPCI's specification, it is recommended the TCPM write RC.D=
RP =3D 0 before changing AutoDischargeDisconnecd.
> Maybe, an interface for controlling AutoDischargeDisconnecd can be added.=
 Then clear RC.DRP in the beginning of that interface.
>>
>>
>> -Behavior after your patch:
>> //begin with Open as RC.DRP =3D 1
>> RC.CCx=3DRd & RC.DRP =3D 0; //Start present Rd
>> Wait 1ms; // Still Rd
>> RC.CCx=3DRd & RC.DRP =3D 1; //Open?
>> Look4CONNECTION =3D 1; //DRP toggling continue preset Rd
>>
>> Is my above CC state description correct? Is this what you want?
>
> Correct. But the purpose of setting RC.CCx =3D Rd & RC.DRP =3D 0 is to ma=
ke RT1711H's internal firmware leave attached state.
> Because RT1711H is still presenting Rp after the device is plugged out, i=
t's internal firmware enters attached state when the device re-plugged in.
> When we write RC.CCx =3D Rd & RC.DRP =3D 0, RT1711H's internal firmware l=
eaves attached state. So it will keep toggling from Rd to Rp but not report=
 open/open when LOOK4CONNECTION is set.
> After rechecking the specification of TCPCI, I think TCPC's internal firm=
ware should start toggling from detached state when LOOK4CONNECTION is set =
even if RC.DRP is not cleared before
> I've discussed with my colleagues, we think this should be in vendor ops.=
 I'll update it in the patch v6.
> Could I also apply your patch [1] in the patch v6?
> Thank you for your time to clarify this condition.
>>
>>
>> -Only apply my patches:
>> //begin with Open as RC.DRP =3D 1
>> RC.CCx=3DRd & RC.DRP =3D 1; //still Open
>> Look4Connection =3D 1; //Start preset Rd
>>
>> > For RT1711H, it follows above flow. If it is not correct, this operati=
on should
>> > be moved to vendor_ops.
>> > >
>> > > For your question:
>> > > Why RT1711H reports open/open after drp_toggling is enabled?
>> > > =3D> See Note2 above.
>> > > This open/open is for you plug out the device, right?
>> > > =3D> No, see Note2 above.
>> > > Why RT1711H can't report new cc change events after you plug in the
>> > > device?
>> > > =3D> RT1711H can generate new cc change events after plugging in the
>> > device.
>> > > What cc change event tcpc will report on step 4?
>> > > =3D> See Note1 above
>> > > Did you verify your change can pass the typec compliance test?
>> > > =3D> We didn't test it yet but try to make all functions work correc=
tly first.
>> > >
>> > > Best Regards,
>> > > *****************************
>> > > Shu-Fan Lee
>> > > Richtek Technology Corporation
>> > > TEL: +886-3-5526789 #2359
>> > > FAX: +886-3-5526612
>> > > *****************************
>> > >
>> >
>> > ************* Email Confidentiality Notice ********************
>> >
>> > The information contained in this e-mail message (including any attach=
ments)
>> > may be confidential, proprietary, privileged, or otherwise exempt from
>> > disclosure under applicable laws. It is intended to be conveyed only t=
o the
>> > designated recipient(s). Any use, dissemination, distribution, printin=
g,
>> > retaining or copying of this e-mail (including its attachments) by uni=
ntended
>> > recipient(s) is strictly prohibited and may be unlawful. If you are no=
t an
>> > intended recipient of this e-mail, or believe that you have received t=
his
>> > e-mail in error, please notify the sender immediately (by replying to =
this
>> > e-mail), delete any and all copies of this e-mail (including any attac=
hments)
>> > from your system, and do not disclose the content of this e-mail to an=
y other
>> > person. Thank you!
>
>
>
>
> --
> Best Regards,
> =E6=9B=B8=E5=B8=86




--=20
Best Regards,
=E6=9B=B8=E5=B8=86
