Return-Path: <b.zolnierkie@samsung.com>
X-Google-Smtp-Source: AH8x22411OaLhQCzKPuZ4vU/GIUOHOH1u3+tTCQrMi+lPTZd0qKYTG8Hchd0wvrcl5rYShSaJQma
ARC-Seal: i=1; a=rsa-sha256; t=1519732742; cv=none;
        d=google.com; s=arc-20160816;
        b=lAbBhFCSl/jCo9njpG24skOsPH3W2e7l0Gr4PBV9WupfS1utusKisuuUoOhmtM6aSU
         isI6RbtoAyNOs6MksB/EKyXdKNPUJY7JHo9BHRfme3egLpi7oP30EbfNo1+ONEyDEV/a
         zHil7ynSDxetazLPX88tAhpDYiwNKtTYhCGjfBMHTq2mQmU0FDYCQxeP50JYmbCi+yIY
         sPliHJL570h4H+k25ruRKf8EB4tKBlDtNZVO8qBlqjLRARm4DT32f4wKnqdUokmUBQVW
         gRXEoRE5BneKU2oTDV0sjpJN2cUhd9DkYW2Ed8hmrX66Wu702ogaIJKLtVQBO6qW1/Ok
         vsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:mime-version
         :in-reply-to:user-agent:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=UBU/hwSEiIH/jLdddKSU34VRyw1PmtLeElDNP2r4rt4=;
        b=AR5TTzLpgFY+kwhmzbIXxQlRot3nQZrCK5rd6WLmhycfyrKpHpd7rhHLQSAWnhq1Rs
         572cKs1U8iah6mjazdAMlMccUltBPiP/UqtzXJwqxY4hmSOzq/ABmx4/l5hwx2h7u1Wu
         ljhondmicIUSIt2+5mmKem8FdcT/2km0AVW0s6+2TT4D6lIKFH54C4l5J1wSYDVd7iJG
         Lvh+mS1V8mueXEOjVRPBLRQNYsCDqe4Tn3yQyak1wYgyFktSNzfbk5/atojmuo0E7EqX
         TDwjqKcvH7IvIB5rEM1H7MoZ2t3qhFUXFYvPW4JgzSQMPm6o4ezUHprHsg1nj71rq6PF
         9UWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=EvyLf8+W;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=EvyLf8+W;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180227115859epoutp04455f01e425da26c0fbee8169142b45dc~XLN-0lIFd2066920669epoutp04o
X-AuditID: b6c32a38-ac3ff70000001054-23-5a954803d5ad
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com,
	cohuck@redhat.com, tomi.valkeinen@ti.com, geert@linux-m68k.org, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/3] Kconfig : Remove HAS_IOMEM dependency for
 Graphics support
Date: Tue, 27 Feb 2018 12:58:57 +0100
Message-id: <5354569.YFYern9snq@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <05a0da63-1d9a-875a-738c-ce453dd59505@de.ibm.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7bCmri6zx9QogxUrpC12N75hs5i+YjuL
	xYQLrxgtnt3ay2TRvHg9m8WJvg+sFpd3zWGzmLCwmdli5TEbi/Xzb7E5cHkcfHSIzePQ4Q5G
	jweHNrN47J+7ht3j/b6rbB7Hb2xn8vi8SS6APYrLJiU1J7MstUjfLoEr4+EBr4LVEhUrv4Q0
	MK4R6mLk5JAQMJHovvqRuYuRi0NIYAejRG/jeWaQhJDAd0aJy/skYYoO3N/CCFG0gVHi8aEr
	bBDOV0aJhwtvsoNUsQlYSUxsXwVUxcEhImAk0fyxFiTMLNDJJHHzjDOILSwQIfH+xi2wBSwC
	qhJHnneygdi8ApoSlzf9YAKxRQW8JLbsawezOQXsJJ5s62SBqBGU+DH5HgvETHmJffunskLY
	OhJnj60DO05C4DmbxPSle9ghrnaRaHjygg3CFpZ4dXwLO8htEgLSEpeO2kLUr2KU+Hn1L1Tz
	ZkaJz9e/skI0WEscPn4RagOfxLuvPawQzbwSHW3QoPOQuPb5JAuE7Six5uEFaAgdZpSYteAo
	8wRG2VlIDp+F5PBZSA5fwMi8ilEstaA4Nz212LDARK84Mbe4NC9dLzk/dxMjOKFoWexg3HPO
	5xCjAAejEg/vDLkpUUKsiWXFlbmHGCU4mJVEeFcunhwlxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nDcgwCVKSCA9sSQ1OzW1ILUIJsvEwSnVwBh+9OzxxtirqTMdyy2m/M2fOsdB7dd2e+NZr5lV
	HtXffR+Y96jllvm6359SZ+4xzeiR9+h6fuL0Uo2F1Xs6VtS5TmCcKsnHKBlg8DDry9QLC3Ia
	Vp+OX/nzlfX39lPrzuU6CsV0O5k2rXb+PO8m//J9CzPcGj91NKTVTtMMKXv2PEZMZZrF0YNK
	LMUZiYZazEXFiQAlOvfrJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t9jQV0mj6lRBtsPGljsbnzDZjF9xXYW
	iwkXXjFaPLu1l8miefF6NosTfR9YLS7vmsNmMWFhM7PFymM2Fuvn32Jz4PI4+OgQm8ehwx2M
	Hg8ObWbx2D93DbvH+31X2TyO39jO5PF5k1wAexSXTUpqTmZZapG+XQJXxsMDXgWrJSpWfglp
	YFwj1MXIySEhYCJx4P4Wxi5GLg4hgXWMElcvHGeDcL4ySmy9towFpIpNwEpiYvsqoCoODhEB
	I4nmj7UgNcwCnUwSl1s/sYLUCAtESMxa+gmsnkVAVeLI8042EJtXQFPi8qYfTCC2qICXxJZ9
	7WA2p4CdxJNtnSwQyw4zSrxb+oIRokFQ4sfke2CDmAXkJfbtn8oKYWtJrN95nGkCI/8sJGWz
	kJTNQlK2gJF5FaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZGYBRsO6zVt4Px/pL4Q4wC
	HIxKPLwz5KZECbEmlhVX5h5ilOBgVhLhXbl4cpQQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5
	xyKFBNITS1KzU1MLUotgskwcnFINjC3trEs+PbN+uM7g5Lq6lyv+SDsHpB9b/6E/8uAcB8Ov
	qcU+PnxLsl5eVDWKvBrK+vdanZ6rQkK+xoaVe890mU1QfOCvY3ko+uuxoxt7JR23Tsx881Uv
	58ibpbs+bipujX9+1ytIPvQcg/RjFy9RTh8NpmDmL6+nJO5MueZuOD3oUPXPI1+S9ymxFGck
	GmoxFxUnAgCDUnTbfgIAAA==
X-CMS-MailID: 20180227115858epcas1p3b3cd6f0d784a12c0ea7464dd2009210b
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180227092348epcas1p4162a6d10e05e3291e989c1e1af4a3272
X-RootMTR: 20180227092348epcas1p4162a6d10e05e3291e989c1e1af4a3272
References: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
	<CGME20180227092348epcas1p4162a6d10e05e3291e989c1e1af4a3272@epcas1p4.samsung.com>
	<05a0da63-1d9a-875a-738c-ce453dd59505@de.ibm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593545512360953090?=
X-GMAIL-MSGID: =?utf-8?q?1593555280114193136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday, February 27, 2018 10:23:37 AM Christian Borntraeger wrote:
> This one has been in linux-next for some days. I can carry this via the kvm/s390
> tree, but I would like to get ack from at least Bartlomiej. Please also look at 
> patch 3 which also touches  drivers/video/console/Kconfig.
> 
> Adding Greg, as I would like an ack from him for patch 3.
> 
> On 02/22/2018 05:22 PM, Farhan Ali wrote:
> > The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> > added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> > "Graphics support" menu for S390. But if we enable VT layer for S390,
> > we would also need to enable the dummy console. So let's remove the
> > HAS_IOMEM dependency.
> > 
> > Move this dependency to sub menu items and console drivers that use
> > io memory.
> > 
> > Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> > ---
> >  drivers/video/Kconfig         | 5 ++++-
> >  drivers/video/console/Kconfig | 6 +++---
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 3c20af9..4f950c6 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -3,7 +3,8 @@
> >  #
> > 
> >  menu "Graphics support"
> > -	depends on HAS_IOMEM
> > +
> > +if HAS_IOMEM
> > 
> >  config HAVE_FB_ATMEL
> >  	bool
> > @@ -36,6 +37,8 @@ config VIDEOMODE_HELPERS
> >  config HDMI
> >  	bool
> > 
> > +endif # HAS_IOMEM
> > +
> >  if VT
> >  	source "drivers/video/console/Kconfig"
> >  endif
> > diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> > index 7f1f1fb..9485857 100644
> > --- a/drivers/video/console/Kconfig
> > +++ b/drivers/video/console/Kconfig
> > @@ -9,7 +9,7 @@ config VGA_CONSOLE
> >  	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
> >  		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
> >  		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> > -		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
> > +		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM
> >  	default y
> >  	help
> >  	  Saying Y here will allow you to use Linux in text mode through a
> > @@ -85,7 +85,7 @@ config MDA_CONSOLE
> > 
> >  config SGI_NEWPORT_CONSOLE
> >          tristate "SGI Newport Console support"
> > -        depends on SGI_IP22 
> > +        depends on SGI_IP22 && HAS_IOMEM
> >          select FONT_SUPPORT
> >          help
> >            Say Y here if you want the console on the Newport aka XL graphics
> > @@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
> > 
> >  config STI_CONSOLE
> >          bool "STI text console"
> > -        depends on PARISC
> > +        depends on PARISC && HAS_IOMEM
> >          select FONT_SUPPORT
> >          default y
> >          help

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
