Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeBTQHY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:07:24 -0500
Received: from mail1.bemta8.messagelabs.com ([216.82.243.204]:24315 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751895AbeBTQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:07:22 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRWlGSWpSXmKPExsWS8eIhk+4O954
  og86ZuhZXLh5isth/XcJixfdLLBaXd81hs+jc1c9q8XLzGyYHNo8Nn5vYPPa9Xcbm8fjtZnaP
  9/uusnlsPl3t8XmTXABbFGtmXlJ+RQJrxqJD99gKLplWLG9pYmpg/GHSxcjFISTwhFFi/ezJ7
  BDOQkaJCdfnAjmcHGwC2hLbn09gBrFFBBQk3ry6xwhSxCzwgVGi7cAuVpCEsIC9RMveFUwQRQ
  4SRw+fgmpwkjj59BobiM0ioCox7exdFhCbV8BHYvnaRjaIbfcYJS5OXAU0lZ2DE2jbxQKQEkY
  BWYlpj+6DjWQWEJeYO20W2CoJAQGJJXvOM0PYohIvH/8DinMA2fISW2YJgpjMApoS63fpQ3Qq
  SkzpfsgOsVRQ4uTMJywTGEVmIRk6C6FjFpKOWUg6FjCyrGLUKE4tKkst0jU00ksqykzPKMlNz
  MzRNTSw0MtNLS5OTE/NSUwq1kvOz93ECIw4BiDYwThhlvMhRkkOJiVR3hSV7ighvqT8lMqMxO
  KM+KLSnNTiQ4wyHBxKErxT3XqihASLUtNTK9Iyc4CxD5OW4OBREuHdDJLmLS5IzC3OTIdInWK
  05Ljx4nUbM8eWZW+A5K9NezuZhVjy8vNSpcQh5gmANGSU5sGNg6WnS4yyUsK8jEAHCvEUpBbl
  Zpagyr9iFOdgVBLm5QCZwpOZVwK39RXQQUxAB60W6QQ5qCQRISXVwOjJEnRy9e3tIudcPhUdf
  92tc4jzjgXn1lB5kWkzKmOj/56e6nTzjJ32safvL3h1HTtY9uyo8CyRTy+X3HvwuPtLgbfwD2
  2e2DeOadcOuMnz3T1wPaNm1tfeWIaty6I+PP5U2t2c+FGt6jf/0q5FTamO5rfmV+eZ7lqR/KR
  ouUPc96UNrxi+yzErsRRnJBpqMRcVJwIAvUDW/koDAAA=
X-Env-Sender: zhangfp1@lenovo.com
X-Msg-Ref: server-8.tower-128.messagelabs.com!1519142840!70047574!1
X-Originating-IP: [104.232.225.2]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Peter FP1 Zhang <zhangfp1@lenovo.com>
To: Takashi Iwai <tiwai@suse.de>
CC: Benjamin Berg <bberg@redhat.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kailang@realtek.com" <kailang@realtek.com>
Subject: RE: [PATCH] ALSA: hda/realtek: Limit mic boost on T480
Thread-Topic: [PATCH] ALSA: hda/realtek: Limit mic boost on T480
Thread-Index: AQHTpapjmHDLxrKykUSYBZhC+F1z5aOoniMggARU5wCAAIql4A==
Date: Tue, 20 Feb 2018 16:07:16 +0000
Message-ID: <FA1DB435B97D5A4192BAE54A4EA542A99ABF159B@CNMAILEX04.lenovo.com>
References: <20180214122939.10069-1-bberg@redhat.com>
        <s5hr2pn6803.wl-tiwai@suse.de>  <1518622889.23539.65.camel@redhat.com>
        <FA1DB435B97D5A4192BAE54A4EA542A99ABF1473@CNMAILEX04.lenovo.com>
 <s5heflfhdbr.wl-tiwai@suse.de>
In-Reply-To: <s5heflfhdbr.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.19.89]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1KGCZs2019479

Thank you Takashi. 
I will also double confirm it with our Accessory BU guys about Ben's question when I back to my office. And will let you know if there was any different answer from them.


Peter Zhang \ 张福平,  PMP
ThinkPad & ThinkStation Linux Solutions
Tel: (+86) 181-1611-8005 | Lenovo Shanghai

Linux for Those Who Do - http://www.lenovo.com/linux

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Tuesday, February 20, 2018 11:48 PM
To: Peter FP1 Zhang
Cc: Benjamin Berg; alsa-devel@alsa-project.org; Jaroslav Kysela; linux-kernel@vger.kernel.org; kailang@realtek.com
Subject: Re: [PATCH] ALSA: hda/realtek: Limit mic boost on T480

On Sat, 17 Feb 2018 14:54:02 +0100,
Peter FP1 Zhang wrote:
> 
> Hi Ben,
> 
> My understanding is same as yours. Recently Realtek Audio expert Kailang (on copy) submitted a patch for Dock as the attached, are you asking the same thing?
> Looks like the issue is related to Dock model, there are many different Dock models, could you please let us know which specific dock model you mean? Thanks.
> 
> @Kailang, Do you have any suggestions or comments?

FYI, because of this unclearness, the patch from Benjamin is still pending.  I'm OK to apply it at first, then adjust later if the docking station quirk is required, too.  Just let me know.


thanks,

Takashi

> 
> Thanks,
> 
> Peter Zhang \ 张福平,  PMP
> ThinkPad & ThinkStation Linux Solutions
> Tel: (+86) 181-1611-8005 | Lenovo Shanghai
> 
> Linux for Those Who Do - http://www.lenovo.com/linux
> 
> 
> -----Original Message-----
> From: Benjamin Berg [mailto:bberg@redhat.com]
> Sent: Wednesday, February 14, 2018 11:41 PM
> To: Takashi Iwai
> Cc: alsa-devel@alsa-project.org; Jaroslav Kysela; 
> linux-kernel@vger.kernel.org; Peter FP1 Zhang
> Subject: Re: [PATCH] ALSA: hda/realtek: Limit mic boost on T480
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> On Wed, 2018-02-14 at 14:00 +0100, Takashi Iwai wrote:
> > On Wed, 14 Feb 2018 13:29:39 +0100,
> > Benjamin Berg wrote:
> > > 
> > > The internal mic boost on the T480 is too high. Fix this by 
> > > applying the ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine 
> > > to limit the gain.
> > > 
> > > Signed-off-by: Benjamin Berg <bberg@redhat.com>
> > > Tested-by: Benjamin Berg <bberg@redhat.com>
> > 
> > Applying this quirk itself is OK, but just wonder whether this model 
> > has a docking station port.  Recently we fixed the dock issue, and 
> > it required to apply ALC298_FIXUP_TPT470_DOCK.
> 
> I assumed that on the T480 and similar models the audio on the dock is connected through USB (the dock is USB-C + further pins), but I cannot confirm this myself right now as I only have a T480 currently.
> 
> I have now contacted Peter Zhang of Lenovo about this and also to check if other 80 series models may need the same fixup.
> 
> Benjamin
> 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > > ---
> > >  sound/pci/hda/patch_realtek.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/sound/pci/hda/patch_realtek.c 
> > > b/sound/pci/hda/patch_realtek.c index ce28f7ce64e6..8467ce3db767
> > > 100644
> > > --- a/sound/pci/hda/patch_realtek.c
> > > +++ b/sound/pci/hda/patch_realtek.c
> > > @@ -6510,6 +6510,7 @@ static const struct snd_pci_quirk 
> > > alc269_fixup_tbl[] = {
> > >  	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", 
> > > ALC298_FIXUP_TPT470_DOCK),
> > >  	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", 
> > > ALC298_FIXUP_TPT470_DOCK),
> > >  	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", 
> > > ALC298_FIXUP_TPT470_DOCK),
> > > +	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480",
> > > ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> > >  	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", 
> > > ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
> > >  	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", 
> > > ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
> > >  	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", 
> > > ALC294_FIXUP_LENOVO_MIC_LOCATION),
> > > --
> > > 2.14.3
> > > 
> > > 
> -----BEGIN PGP SIGNATURE-----
> 
> iQIzBAEBCgAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAlqEWKkACgkQq6ZWhpmF
> Y3AEyQ/7B6l4Na1GLDf11P8OdzzcXOy6grjvrLYwq6WFA3M1DirlQsPwjSbnJ7V8
> znIX30EK6My9Ip6jyvJQIpiBlaX1FKJuJ3So9mjgUeOcCQMFkwnC1fMMyyWEAWLq
> TI1s7F5w4OQwhQpwtlId4AIB7A2ZzQmP/9YqfIPDtIiNJqjd9aRruBJi8A8j3sB5
> slY1CYgCQhBUiAkUPisFrt+b4aFU5FlgINQR+6uOSKO0/IaSKq9rFwX76lOTOsBj
> kHhywIF9Qef6CvUDaAOFWjQcTA/ooDPifUsfNzo6ZHnNZIks0Cov12JeO5UrxjiD
> a3BuG6SZAVm4awfkTj5pIL0DuBAXYhTJd/hU3VMWdV0/kb0OeVONSahMzhSOCM30
> WdFKpWC0+n3TEkTWSG9QGwL6wbXiaLNZ0JRgQkcoJ9JqPVngFf9LIRBzqdMyzyCE
> UzLu/oQ9XlXQrFx1IG5KS/RJJPUwpJKhXOygSpRZx/HhmaWpPVLCu9GNg+ytoVIL
> QEg381jOTTPi+DX0k07WYK+hUEvB83cbtsm+EiEGMa4bxuhYQp2p1moGqOrzv2XK
> iEN8LfF97KJ4GtqVWybnstxMxMdS0CwXBPxUZ3OY6C03S3sdVqk/QrEpE4i0+N8P
> CcX3g+rEJVUkpsdm17Sf5u4DjeGH7HBPsDmHirrwvFdeOkTiO4E=
> =NIZ6
> -----END PGP SIGNATURE-----
> 
> [2 0000-alc298-thinkpad-dock.patch <application/octet-stream 
> (base64)>]
> 
