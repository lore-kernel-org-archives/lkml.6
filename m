Return-Path: <john3909@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521933502; cv=none;
        d=google.com; s=arc-20160816;
        b=dqZCapgueKjqpGP1vZEQG/OzfLzrkg69mU6l85R6GMgWhaN89SfluVsQOuMr+2b0ic
         hPNZQW5+YUjWWZAJrKoStph3BAGv7sKwpkKvNjH6jhki7lbs+a16Ok/N+yPv8U3s3WPk
         nBkg2IHK+LhzB/HQMegMAFoqRbouW3JBT7Tzdbb3THh9HNW7miKl1qmf/4b1bsSsLzJd
         c+t+4U5tuTAPA1qe5HTZiWD2uw2MPgDj6lLggTeP3B8ZXUYk+c8RGvFREtNWP+89kgvu
         BiPCqruHx88PKRaIaY7wPBbVecLfO24saSEg44zhJC+V4JvZbEI3iqgz3jBNf2mFj1Gt
         +4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:dkim-signature:arc-authentication-results;
        bh=pDOTnxHinUar1KFgRhcUAjZ58c6fZIEFLnvM4n9KnUQ=;
        b=Nux8noApSa4ptqMDxlzP79gHd9ObfwM5yKVG4PY7KVBOZ85x/dtJWNzNMjF+ISuLrm
         OgDKZDbi16xBFyKZdxTOykCOn9Zpk6lsfblzeUQ5pDEETzyxRLZaXuY32cVJdngtiY5s
         PrUDZTZRzgCyNgqY2ozgrVYGiLwCoot1o2aIpL00+zDqg4T1EawdETzGMX8QdhaY1QfY
         yn6T4KhL8BVaO66oi99OHRstsp9MZ5ZxcR5b73hT9p8epSbZWs0ONT3m9leVR0ajsEgf
         NqCsuzvaWYjOvWLpMgMu/sgUmjPCqAUtlldwiy+4ui5X0G6wbFyWqpVfPy7SSDs4dSoE
         cDyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HHQqidL/;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HHQqidL/;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsT5joVWPlqDw0ryLx6DlPU01wIfwxCs1MK7m61J/oYlFmos5pFoY62x73OYFrH2Ouh74lyGg==
From: John Syne <john3909@gmail.com>
Message-Id: <F9946A8D-5D19-4D2E-8CED-665E645D7B1A@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_A00996E7-8CF4-4A1E-B8C4-BAFECABA1AF0"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Date: Sat, 24 Mar 2018 16:18:15 -0700
In-Reply-To: <20180324151829.7d03ad15@archlinux>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 devel@driverdev.osuosl.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
To: Jonathan Cameron <jic23@kernel.org>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
 <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
 <20180317203037.1093cc11@archlinux>
 <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
 <20180318122312.0d395367@archlinux>
 <F6FE75D3-5289-4675-9345-F46CABEFA99E@gmail.com>
 <20180324151829.7d03ad15@archlinux>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595278152164006674?=
X-GMAIL-MSGID: =?utf-8?q?1595862944735921062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_A00996E7-8CF4-4A1E-B8C4-BAFECABA1AF0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Jonathan,

I have attached a CSV version of this table below. Hopefully that will =
make things easier for you.

Register	IIO Attribute	Device Tree or Code	Direction	=
type	Index	Modifier	Info Mask
AIGAIN	in_current0_phaseA_scale		in	current	0	=
phaseA	scale
AVGAIN	in_voltage0_phaseA_scale		in	voltage	0	=
phaseA	scale
BIGAIN	in_current0_phaseB_scale		in	current	0	=
phaseB	scale
BVGAIN	in_voltage0_phaseB_scale		in	voltage	0	=
phaseB	scale
CIGAIN	in_current0_phaseC_scale		in	current	0	=
phaseC	scale
CVGAIN	in_voltage0_phaseC_scale		in	voltage	0	=
phaseC	scale
NIGAIN	in_current0_neutral_scale		in	current	0	=
neutral	scale
AIRMSOS	in_current0_phaseA_rms_offset		in	current	0	=
phaseA	offset
AVRMSOS	in_voltage0_phaseA_rms_offset		in	voltage	0	=
phaseA	offset
BIRMSOS	in_current0_phaseB_rms_offset		in	current	0	=
phaseB	offset
BVRMSOS	in_voltage0_phaseB_rms_offset		in	voltage	0	=
phaseB	offset
CIRMSOS	in_current0_phaseC_rms_offset		in	current	0	=
phaseC	offset
CVRMSOS	in_voltage0_phaseC_rms_offset		in	voltage	0	=
phaseC	offset
NIRMSOS	in_current0_neutral_rms_offset		in	current	0	=
neutral	offset
AVAGAIN	in_powerapparent0_phaseA_scale		in	powerapparent	=
0	phaseA	scale
BVAGAIN	in_powerapparent0_phaseB_scale		in	powerapparent	=
0	phaseB	scale
CVAGAIN	in_powerapparent0_phaseC_scale		in	powerapparent	=
0	phaseC	scale
AWGAIN	in_power0_phaseA_scale		in	power	0	phaseA	=
scale
AWATTOS	in_power0_phaseA_offset		in	power	0	phaseA	=
offset
BWGAIN	in_power0_phaseB_scale		in	power	0	phaseB	=
scale
BWATTOS	in_power0_phaseB_offset		in	power	0	phaseB	=
offset
CWGAIN	in_power0_PhaseC_scale		in	power	0	phaseC	=
scale
CWATTOS	in_power0_phaseC_offset		in	power	0	phaseC	=
offset
AVARGAIN	in_powerreactive0_phaseA_scale		in	=
powerreactive	0	phaseA	scale
AVAROS	in_powerreactive0_phaseA_offset		in	powerreactive	=
0	phaseA	offset
BVARGAIN	in_powerreactive0_phaseB_scale		in	=
powerreactive	0	phaseB	scale
BVAROS	in_powerreactive0_phaseB_offset		in	powerreactive	=
0	phaseB	offset
CVARGAIN	in_powerreactive0_phaseC_scale		in	=
powerreactive	0	phaseC	scale
CVAROS	in_powerreactive0_phaseC_offset		in	powerreactive	=
0	phaseC	offset
AFWGAIN	in_power0_phaseA_fundamental_scale		in	power	=
0	phaseA_fundamental	scale
AFWATTOS	in_power0_phaseA_fundamental_offset		in	=
power	0	phaseA_fundamental	offset
BFWGAIN	in_power0_phaseB_fundamental_scale		in	power	=
0	phaseB_fundamental	scale
BFWATTOS	in_power0_phaseB_fundamental_offset		in	=
power	0	phaseB_fundamental	offset
CFWGAIN	in_power0_phaseC_fundamental_scale		in	power	=
0	phaseC_fundamental	scale
CFWATTOS	in_power0_phaseC_fundamental_offset		in	=
power	0	phaseC_fundamental	offset
AFVARGAIN	in_powerreactive0_phaseA_fundamental_scale		=
in	powerreactive	0	phaseA_fundamental	scale
AFVAROS	in_powerreactive0_phaseA_fundamental_offset		in	=
powerreactive	0	phaseA_fundamental	offset
BFVARGAIN	in_powerreactive0_phaseB_fundamental_scale		=
in	powerreactive	0	phaseB_fundamental	scale
BFVAROS	in_powerreactive0_phaseB_fundamental_offset		in	=
powerreactive	0	phaseB_fundamental	offset
CFVARGAIN	in_powerreactive0_phaseC_fundamental_scale		=
in	powerreactive	0	phaseC_fundamental	scale
CFVAROS	in_powerreactive0_phaseC_fundamental_offset		in	=
powerreactive	0	phaseC_fundamental	offset
VATHR1	VATHR1	DT				=09
VATHR0	VATHR0	DT				=09
WTHR1	WTHR1	DT				=09
WTHR0	WTHR0	DT				=09
VARTHR1	VARTHR1	DT				=09
VARTHR0	VARTHR0	DT				=09
Reserved	Reserved					=09
VANOLOAD	VANOLOAD	DT				=09
APNOLOAD	APNOLOAD	DT				=09
VLEVEL	VLEVEL	DT				=09
DICOEFF	DICOEFF	DT				=09
HPFDIS	HPFDIS	DT				=09
ISUMLVL	ISUMLVL	DT	in			=09
ISUM	in_current0_phaseA&phaseB&phaseC_sum		in	current	=
0	phaseA&phaseB&phaseC	sum
AIRMS	in_current0_phaseA_rms_raw		in	current	0	=
phaseA_rms	raw
AVRMS	in_voltage0_phaseA_rms_raw		in	voltage	0	=
phaseA_rms	raw
BIRMS	in_current0_phaseB_rms_raw		in	current	0	=
phaseB_rms	raw
BVRMS	in_voltage0_phaseB_rms_raw		in	voltage	0	=
phaseB_rms	raw
CIRMS	in_current0_phaseC_rms_raw		in	current	0	=
phaseC_rms	raw
CVRMS	in_voltage0_phaseC_rms_raw		in	voltage	0	=
phaseC_rms	raw
NIRMS	in_current0_neutral_rms_raw		in	current	0	=
neutral_rms	raw
Run		Code	in			=09
AWATTHR	in_energy0_phaseA_raw_raw		in	energy	0	=
phaseA	raw
BWATTHR	in_energy0_phaseB_raw_raw		in	energy	0	=
phaseB	raw
CWATTHR	in_energy0_phaseC_raw_raw		in	energy	0	=
phaseC	raw
AFWATTHR	in_energy0_phaseA_fundamental_raw		in	=
energy	0	phaseA_fundamental	raw
BFWATTHR	in_energy0_phaseB_fundamental_raw		in	=
energy	0	phaseB_fundamental	raw
CFWATTHR	in_energy0_phaseC_fundamental_raw		in	=
energy	0	phaseC_fundamental	raw
AVARHR	in_energyreactive0_phaseA_raw		in	energyreactive	=
0	phaseA	raw
BVARHR	in_energyreactive0_phaseB_raw		in	energyreactive	=
0	phaseB	raw
CVARHR	in_energyreactive0_phaseC_raw		in	energyreactive	=
0	phaseC	raw
AFVARHR	in_energyreactive0_phaseA_fundamental_raw		in	=
energyreactive	0	phaseA_fundamental	raw
BFVARHR	in_energyreactive0_phaseB_fundamental_raw		in	=
energyreactive	0	phaseB_fundamental	raw
CFVARHR	in_energyreactive0_phaseC_fundamental_raw		in	=
energyreactive	0	phaseC_fundamental	raw
AVAHR	in_energyapparent0_phaseA_raw		in	energyapparent	=
0	phaseA	raw
BVAHR	in_energyapparent0_phaseB_raw		in	energyapparent	=
0	phaseB	raw
CVAHR	in_energyapparent0_phaseC_raw		in	energyapparent	=
0	phaseC	raw
IPEAK	in_current0_peak		in	current	0		=
peak
VPEAK	in_voltage0_peak		in	voltage	0		=
peak
STATUS0		event				=09
STATUS1		event				=09
AIMAV	in_current0_phaseA_mav_raw		in	current		=
phaseA_mav	raw
BIMAV	in_current0_phaseB_mav_raw		in	current		=
phaseB_mav	raw
CIMAV	in_current0_phaseC_mav_raw		in	current		=
phaseC_mav	raw
OILVL	OILVL	DT				=09
OVLVL	OVLVL	DT				=09
SAGLVL	SAGLVL	DT				=09
MASK0	in_mask0_raw		in	mask	0		raw
MASK1	in_mask1_raw		in	mask	1		raw
IAWV	in_current0_phaseA_instantaneous					=
=09
IBWV	in_current0_phaseB_instantaneous					=
=09
ICWV	in_current0_phaseC_instantaneous					=
=09
INWV	in_current0_phaseN_instantaneous					=
=09
VAWV	in_voltage0_phaseA_instantaneous					=
=09
VBWV	in_voltage0_phaseB_instantaneous					=
=09
VCWV	in_voltage0_phaseC_instantaneous					=
=09
AWATT	in_power0_phaseA_instantaneous					=09=

BWATT	in_power0_phaseB_instantaneous					=09=

CWATT	in_power0_phaseC_instantaneous					=09=

AVAR	in_powerreactive0_phaseA_instantaneous					=
=09
BVAR	in_powerreactive0_phaseB_instantaneous					=
=09
CVAR	in_powerreactive0_phaseC_instantaneous					=
=09
AVA	in_powerapparent0_phaseA_instantaneous					=
=09
BVA	in_powerapparent0_phaseB_instantaneous					=
=09
CVA	in_powerappatent0_phaseC_instantaneous					=
=09
CHECKSUM	CHECKSUM	Code				=09
VNOM	VNOM	DT				=09
PHSTATUS		event				=09
ANGLE0	ANGLE0	DT				=09
ANGLE1	ANGLE1	DT				=09
ANGLE2	ANGLE2	DT				=09
Reserved						=09
PERIOD	in_period_raw		in	period			raw
PHNOLOAD		event				=09
LINECYC	in_count0_cycle_raw		in	count	0	cycle	=
raw
ZXTOUT	ZXTOUT	DT				=09
COMPMODE	COMPMODE	DT				=09
Gain	Gain	DT				=09
CFMODE	CFMODE	DT				=09
CF1DEN	CF1DEN	DT				=09
CF2DEN	CF2DEN	DT				=09
CF3DEN	CF3DEN	DT				=09
APHCAL	APHCAL	DT				=09
BPHCAL	BPHCAL	DT				=09
CPHCAL	CPHCAL	DT				=09
PHSIGN	PHSIGN	DT				=09
CONFIG	CONFIG	DT				=09
MMODE	MMODE	DT				=09
ACCMODE	ACCMODE	DT				=09
LCYCMODE	LCYCMODE	DT				=09
PEAKCYC	PEAKCYC	DT				=09
SAGCYC	SAGCYC	DT				=09
CFCYC	CFCYC	DT				=09
HSDC_CFG	HSDC_CFG	DT				=09
Version	in_version_raw		in	version			raw
Reserved		DT				=09
LPOILVL	LPOILVL	DT				=09
CONFIG2	CONFIG2	DT				=09



Regards,
John






--Apple-Mail=_A00996E7-8CF4-4A1E-B8C4-BAFECABA1AF0
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_C4D1D58A-44E6-499C-9DB8-004A86417E04"


--Apple-Mail=_C4D1D58A-44E6-499C-9DB8-004A86417E04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D"">Hi Jonathan,</div><div class=3D""><br class=3D""></div><div =
class=3D"">I have attached a CSV version of this table below. Hopefully =
that will make things easier for you.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Register<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>IIO Attribute<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Device =
Tree or Code<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>Direction<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>type<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>Index<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>Modifier<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>Info Mask</div><div class=3D"">AIGAIN<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>in_current0_phaseA_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">AVGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_voltage0_phaseA_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">BIGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_current0_phaseB_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">BVGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_voltage0_phaseB_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">CIGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_current0_phaseC_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">CVGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_voltage0_phaseC_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">NIGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_current0_neutral_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>neutral<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">AIRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_current0_phaseA_rms_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">AVRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_voltage0_phaseA_rms_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">BIRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_current0_phaseB_rms_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">BVRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_voltage0_phaseB_rms_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">CIRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_current0_phaseC_rms_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">CVRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_voltage0_phaseC_rms_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">NIRMSOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_current0_neutral_rms_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>neutral<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">AVAGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerapparent0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerapparent<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseA<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">BVAGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerapparent0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerapparent<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseB<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">CVAGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerapparent0_phaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerapparent<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">AWGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_power0_phaseA_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">AWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_power0_phaseA_offset<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">BWGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_power0_phaseB_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">BWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_power0_phaseB_offset<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">CWGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_power0_PhaseC_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">CWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_power0_phaseC_offset<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">AVARGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseA<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">AVAROS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseA_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseA<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">BVARGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseB<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">BVAROS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseB_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseB<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">CVARGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">CVAROS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseC_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">AFWGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseA_fundamental_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>scale</div><div =
class=3D"">AFWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseA_fundamental_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>offset</div><div =
class=3D"">BFWGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseB_fundamental_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>scale</div><div =
class=3D"">BFWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseB_fundamental_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>offset</div><div =
class=3D"">CFWGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseC_fundamental_scale<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>scale</div><div =
class=3D"">CFWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseC_fundamental_offset<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>offset</div><div =
class=3D"">AFVARGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseA_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseA_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">AFVAROS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseA_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseA_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">BFVARGAIN<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseB_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseB_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">BFVAROS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseB_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseB_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">CFVARGAIN<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseC_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseC_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>scale</div><div class=3D"">CFVAROS<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseC_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>powerreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseC_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>offset</div><div class=3D"">VATHR1<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>VATHR1<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">VATHR0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>VATHR0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">WTHR1<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>WTHR1<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>DT<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">					=
</span></div><div class=3D"">WTHR0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>WTHR0<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>DT<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">					=
</span></div><div class=3D"">VARTHR1<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>VARTHR1<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">VARTHR0<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>VARTHR0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">Reserved<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>Reserved<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
					</span></div><div =
class=3D"">VANOLOAD<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>VANOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">APNOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>APNOLOAD<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">VLEVEL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>VLEVEL<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">DICOEFF<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DICOEFF<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">HPFDIS<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>HPFDIS<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">ISUMLVL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>ISUMLVL<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
		</span></div><div class=3D"">ISUM<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current0_phaseA&amp;phaseB&amp;phaseC_sum<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA&amp;phaseB&amp;phaseC<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>sum</div><div class=3D"">AIRMS<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current0_phaseA_rms_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA_rms<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">AVRMS<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_voltage0_phaseA_rms_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA_rms<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">BIRMS<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current0_phaseB_rms_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB_rms<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">BVRMS<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_voltage0_phaseB_rms_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB_rms<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">CIRMS<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current0_phaseC_rms_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC_rms<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">CVRMS<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_voltage0_phaseC_rms_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC_rms<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">NIRMS<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current0_neutral_rms_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>neutral_rms<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>raw</div><div class=3D"">Run<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>Code<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
		</span></div><div class=3D"">AWATTHR<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_energy0_phaseA_raw_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energy<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">BWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_energy0_phaseB_raw_raw<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energy<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">CWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_energy0_phaseC_raw_raw<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energy<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">AFWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energy0_phaseA_fundamental_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energy<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>raw</div><div =
class=3D"">BFWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energy0_phaseB_fundamental_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energy<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseB_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>raw</div><div =
class=3D"">CFWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energy0_phaseC_fundamental_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energy<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>phaseC_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>raw</div><div =
class=3D"">AVARHR<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>in_energyreactive0_phaseA_raw<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseA<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">BVARHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energyreactive0_phaseB_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseB<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">CVARHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energyreactive0_phaseC_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">AFVARHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energyreactive0_phaseA_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseA_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">BFVARHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energyreactive0_phaseB_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseB_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">CFVARHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energyreactive0_phaseC_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyreactive<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseC_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">AVAHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energyapparent0_phaseA_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyapparent<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseA<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">BVAHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energyapparent0_phaseB_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyapparent<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseB<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">CVAHR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_energyapparent0_phaseC_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>energyapparent<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>phaseC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">IPEAK<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_current0_peak<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>peak</div><div class=3D"">VPEAK<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_voltage0_peak<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>peak</div><div class=3D"">STATUS0<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>event<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">STATUS1<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">		</span>event<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">AIMAV<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_current0_phaseA_mav_raw<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>phaseA_mav<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">BIMAV<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current0_phaseB_mav_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>phaseB_mav<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">CIMAV<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_current0_phaseC_mav_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>phaseC_mav<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>raw</div><div class=3D"">OILVL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>OILVL<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">OVLVL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>OVLVL<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">SAGLVL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>SAGLVL<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">MASK0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_mask0_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>mask<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>raw</div><div class=3D"">MASK1<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>in_mask1_raw<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>mask<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>1<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>raw</div><div class=3D"">IAWV<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_current0_phaseA_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">IBWV<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_current0_phaseB_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">ICWV<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_current0_phaseC_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">INWV<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_current0_phaseN_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">VAWV<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_voltage0_phaseA_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">VBWV<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_voltage0_phaseB_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">VCWV<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_voltage0_phaseC_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">AWATT<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseA_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">BWATT<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseB_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">CWATT<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_power0_phaseC_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">						=
</span></div><div class=3D"">AVAR<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseA_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
		</span></div><div class=3D"">BVAR<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
		</span></div><div class=3D"">CVAR<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_powerreactive0_phaseC_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
		</span></div><div class=3D"">AVA<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_powerapparent0_phaseA_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
		</span></div><div class=3D"">BVA<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_powerapparent0_phaseB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
		</span></div><div class=3D"">CVA<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_powerappatent0_phaseC_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
		</span></div><div class=3D"">CHECKSUM<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>CHECKSUM<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>Code<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">VNOM<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>VNOM<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">PHSTATUS<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>event<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">ANGLE0<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>ANGLE0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">ANGLE1<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>ANGLE1<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">ANGLE2<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>ANGLE2<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">Reserved<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
			</span></div><div class=3D"">PERIOD<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_period_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>period<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
	</span>raw</div><div class=3D"">PHNOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>event<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">LINECYC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_count0_cycle_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>count<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>cycle<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>raw</div><div class=3D"">ZXTOUT<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>ZXTOUT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">COMPMODE<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>COMPMODE<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">Gain<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Gain<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">CFMODE<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>CFMODE<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">CF1DEN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>CF1DEN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">CF2DEN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>CF2DEN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">CF3DEN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>CF3DEN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">APHCAL<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>APHCAL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">BPHCAL<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>BPHCAL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">CPHCAL<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>CPHCAL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">PHSIGN<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>PHSIGN<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">CONFIG<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>CONFIG<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">MMODE<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>MMODE<span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>DT<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">					=
</span></div><div class=3D"">ACCMODE<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>ACCMODE<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span></div><div class=3D"">LCYCMODE<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>LCYCMODE<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">PEAKCYC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>PEAKCYC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">SAGCYC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>SAGCYC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">CFCYC<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>CFCYC<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">HSDC_CFG<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>HSDC_CFG<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">Version<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>in_version_raw<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>version<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
	</span>raw</div><div class=3D"">Reserved<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">LPOILVL<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>LPOILVL<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D"">CONFIG2<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>CONFIG2<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space:pre">		=
			</span></div><div class=3D""><br =
class=3D"webkit-block-placeholder"></div><div =
class=3D""></div></body></html>=

--Apple-Mail=_C4D1D58A-44E6-499C-9DB8-004A86417E04
Content-Disposition: attachment;
	filename="ADE7878-ABI-Table 1.csv"
Content-Type: text/csv;
	x-unix-mode=0644;
	name="ADE7878-ABI-Table 1.csv"
Content-Transfer-Encoding: quoted-printable

Register,IIO Attribute,Device Tree or =
Code,Direction,type,Index,Modifier,Info Mask=0D
AIGAIN,in_current0_phaseA_scale,,in,current,0,phaseA,scale=0D
AVGAIN,in_voltage0_phaseA_scale,,in,voltage,0,phaseA,scale=0D
BIGAIN,in_current0_phaseB_scale,,in,current,0,phaseB,scale=0D
BVGAIN,in_voltage0_phaseB_scale,,in,voltage,0,phaseB,scale=0D
CIGAIN,in_current0_phaseC_scale,,in,current,0,phaseC,scale=0D
CVGAIN,in_voltage0_phaseC_scale,,in,voltage,0,phaseC,scale=0D
NIGAIN,in_current0_neutral_scale,,in,current,0,neutral,scale=0D
AIRMSOS,in_current0_phaseA_rms_offset,,in,current,0,phaseA,offset=0D
AVRMSOS,in_voltage0_phaseA_rms_offset,,in,voltage,0,phaseA,offset=0D
BIRMSOS,in_current0_phaseB_rms_offset,,in,current,0,phaseB,offset=0D
BVRMSOS,in_voltage0_phaseB_rms_offset,,in,voltage,0,phaseB,offset=0D
CIRMSOS,in_current0_phaseC_rms_offset,,in,current,0,phaseC,offset=0D
CVRMSOS,in_voltage0_phaseC_rms_offset,,in,voltage,0,phaseC,offset=0D
NIRMSOS,in_current0_neutral_rms_offset,,in,current,0,neutral,offset=0D
AVAGAIN,in_powerapparent0_phaseA_scale,,in,powerapparent,0,phaseA,scale=0D=

BVAGAIN,in_powerapparent0_phaseB_scale,,in,powerapparent,0,phaseB,scale=0D=

CVAGAIN,in_powerapparent0_phaseC_scale,,in,powerapparent,0,phaseC,scale=0D=

AWGAIN,in_power0_phaseA_scale,,in,power,0,phaseA,scale=0D
AWATTOS,in_power0_phaseA_offset,,in,power,0,phaseA,offset=0D
BWGAIN,in_power0_phaseB_scale,,in,power,0,phaseB,scale=0D
BWATTOS,in_power0_phaseB_offset,,in,power,0,phaseB,offset=0D
CWGAIN,in_power0_PhaseC_scale,,in,power,0,phaseC,scale=0D
CWATTOS,in_power0_phaseC_offset,,in,power,0,phaseC,offset=0D
AVARGAIN,in_powerreactive0_phaseA_scale,,in,powerreactive,0,phaseA,scale=0D=

AVAROS,in_powerreactive0_phaseA_offset,,in,powerreactive,0,phaseA,offset=0D=

BVARGAIN,in_powerreactive0_phaseB_scale,,in,powerreactive,0,phaseB,scale=0D=

BVAROS,in_powerreactive0_phaseB_offset,,in,powerreactive,0,phaseB,offset=0D=

CVARGAIN,in_powerreactive0_phaseC_scale,,in,powerreactive,0,phaseC,scale=0D=

CVAROS,in_powerreactive0_phaseC_offset,,in,powerreactive,0,phaseC,offset=0D=

=
AFWGAIN,in_power0_phaseA_fundamental_scale,,in,power,0,phaseA_fundamental,=
scale=0D
=
AFWATTOS,in_power0_phaseA_fundamental_offset,,in,power,0,phaseA_fundamenta=
l,offset=0D
=
BFWGAIN,in_power0_phaseB_fundamental_scale,,in,power,0,phaseB_fundamental,=
scale=0D
=
BFWATTOS,in_power0_phaseB_fundamental_offset,,in,power,0,phaseB_fundamenta=
l,offset=0D
=
CFWGAIN,in_power0_phaseC_fundamental_scale,,in,power,0,phaseC_fundamental,=
scale=0D
=
CFWATTOS,in_power0_phaseC_fundamental_offset,,in,power,0,phaseC_fundamenta=
l,offset=0D
=
AFVARGAIN,in_powerreactive0_phaseA_fundamental_scale,,in,powerreactive,0,p=
haseA_fundamental,scale=0D
=
AFVAROS,in_powerreactive0_phaseA_fundamental_offset,,in,powerreactive,0,ph=
aseA_fundamental,offset=0D
=
BFVARGAIN,in_powerreactive0_phaseB_fundamental_scale,,in,powerreactive,0,p=
haseB_fundamental,scale=0D
=
BFVAROS,in_powerreactive0_phaseB_fundamental_offset,,in,powerreactive,0,ph=
aseB_fundamental,offset=0D
=
CFVARGAIN,in_powerreactive0_phaseC_fundamental_scale,,in,powerreactive,0,p=
haseC_fundamental,scale=0D
=
CFVAROS,in_powerreactive0_phaseC_fundamental_offset,,in,powerreactive,0,ph=
aseC_fundamental,offset=0D
VATHR1,VATHR1,DT,,,,,=0D
VATHR0,VATHR0,DT,,,,,=0D
WTHR1,WTHR1,DT,,,,,=0D
WTHR0,WTHR0,DT,,,,,=0D
VARTHR1,VARTHR1,DT,,,,,=0D
VARTHR0,VARTHR0,DT,,,,,=0D
Reserved,Reserved,,,,,,=0D
VANOLOAD,VANOLOAD,DT,,,,,=0D
APNOLOAD,APNOLOAD,DT,,,,,=0D
VLEVEL,VLEVEL,DT,,,,,=0D
DICOEFF,DICOEFF,DT,,,,,=0D
HPFDIS,HPFDIS,DT,,,,,=0D
ISUMLVL,ISUMLVL,DT,in,,,,=0D
=
ISUM,in_current0_phaseA&phaseB&phaseC_sum,,in,current,0,phaseA&phaseB&phas=
eC,sum=0D
AIRMS,in_current0_phaseA_rms_raw,,in,current,0,phaseA_rms,raw=0D
AVRMS,in_voltage0_phaseA_rms_raw,,in,voltage,0,phaseA_rms,raw=0D
BIRMS,in_current0_phaseB_rms_raw,,in,current,0,phaseB_rms,raw=0D
BVRMS,in_voltage0_phaseB_rms_raw,,in,voltage,0,phaseB_rms,raw=0D
CIRMS,in_current0_phaseC_rms_raw,,in,current,0,phaseC_rms,raw=0D
CVRMS,in_voltage0_phaseC_rms_raw,,in,voltage,0,phaseC_rms,raw=0D
NIRMS,in_current0_neutral_rms_raw,,in,current,0,neutral_rms,raw=0D
Run,,Code,in,,,,=0D
AWATTHR,in_energy0_phaseA_raw_raw,,in,energy,0,phaseA,raw=0D
BWATTHR,in_energy0_phaseB_raw_raw,,in,energy,0,phaseB,raw=0D
CWATTHR,in_energy0_phaseC_raw_raw,,in,energy,0,phaseC,raw=0D
=
AFWATTHR,in_energy0_phaseA_fundamental_raw,,in,energy,0,phaseA_fundamental=
,raw=0D
=
BFWATTHR,in_energy0_phaseB_fundamental_raw,,in,energy,0,phaseB_fundamental=
,raw=0D
=
CFWATTHR,in_energy0_phaseC_fundamental_raw,,in,energy,0,phaseC_fundamental=
,raw=0D
AVARHR,in_energyreactive0_phaseA_raw,,in,energyreactive,0,phaseA,raw=0D
BVARHR,in_energyreactive0_phaseB_raw,,in,energyreactive,0,phaseB,raw=0D
CVARHR,in_energyreactive0_phaseC_raw,,in,energyreactive,0,phaseC,raw=0D
=
AFVARHR,in_energyreactive0_phaseA_fundamental_raw,,in,energyreactive,0,pha=
seA_fundamental,raw=0D
=
BFVARHR,in_energyreactive0_phaseB_fundamental_raw,,in,energyreactive,0,pha=
seB_fundamental,raw=0D
=
CFVARHR,in_energyreactive0_phaseC_fundamental_raw,,in,energyreactive,0,pha=
seC_fundamental,raw=0D
AVAHR,in_energyapparent0_phaseA_raw,,in,energyapparent,0,phaseA,raw=0D
BVAHR,in_energyapparent0_phaseB_raw,,in,energyapparent,0,phaseB,raw=0D
CVAHR,in_energyapparent0_phaseC_raw,,in,energyapparent,0,phaseC,raw=0D
IPEAK,in_current0_peak,,in,current,0,,peak=0D
VPEAK,in_voltage0_peak,,in,voltage,0,,peak=0D
STATUS0,,event,,,,,=0D
STATUS1,,event,,,,,=0D
AIMAV,in_current0_phaseA_mav_raw,,in,current,,phaseA_mav,raw=0D
BIMAV,in_current0_phaseB_mav_raw,,in,current,,phaseB_mav,raw=0D
CIMAV,in_current0_phaseC_mav_raw,,in,current,,phaseC_mav,raw=0D
OILVL,OILVL,DT,,,,,=0D
OVLVL,OVLVL,DT,,,,,=0D
SAGLVL,SAGLVL,DT,,,,,=0D
MASK0,in_mask0_raw,,in,mask,0,,raw=0D
MASK1,in_mask1_raw,,in,mask,1,,raw=0D
IAWV,in_current0_phaseA_instantaneous,,,,,,=0D
IBWV,in_current0_phaseB_instantaneous,,,,,,=0D
ICWV,in_current0_phaseC_instantaneous,,,,,,=0D
INWV,in_current0_phaseN_instantaneous,,,,,,=0D
VAWV,in_voltage0_phaseA_instantaneous,,,,,,=0D
VBWV,in_voltage0_phaseB_instantaneous,,,,,,=0D
VCWV,in_voltage0_phaseC_instantaneous,,,,,,=0D
AWATT,in_power0_phaseA_instantaneous,,,,,,=0D
BWATT,in_power0_phaseB_instantaneous,,,,,,=0D
CWATT,in_power0_phaseC_instantaneous,,,,,,=0D
AVAR,in_powerreactive0_phaseA_instantaneous,,,,,,=0D
BVAR,in_powerreactive0_phaseB_instantaneous,,,,,,=0D
CVAR,in_powerreactive0_phaseC_instantaneous,,,,,,=0D
AVA,in_powerapparent0_phaseA_instantaneous,,,,,,=0D
BVA,in_powerapparent0_phaseB_instantaneous,,,,,,=0D
CVA,in_powerappatent0_phaseC_instantaneous,,,,,,=0D
CHECKSUM,CHECKSUM,Code,,,,,=0D
VNOM,VNOM,DT,,,,,=0D
PHSTATUS,,event,,,,,=0D
ANGLE0,ANGLE0,DT,,,,,=0D
ANGLE1,ANGLE1,DT,,,,,=0D
ANGLE2,ANGLE2,DT,,,,,=0D
Reserved,,,,,,,=0D
PERIOD,in_period_raw,,in,period,,,raw=0D
PHNOLOAD,,event,,,,,=0D
LINECYC,in_count0_cycle_raw,,in,count,0,cycle,raw=0D
ZXTOUT,ZXTOUT,DT,,,,,=0D
COMPMODE,COMPMODE,DT,,,,,=0D
Gain,Gain,DT,,,,,=0D
CFMODE,CFMODE,DT,,,,,=0D
CF1DEN,CF1DEN,DT,,,,,=0D
CF2DEN,CF2DEN,DT,,,,,=0D
CF3DEN,CF3DEN,DT,,,,,=0D
APHCAL,APHCAL,DT,,,,,=0D
BPHCAL,BPHCAL,DT,,,,,=0D
CPHCAL,CPHCAL,DT,,,,,=0D
PHSIGN,PHSIGN,DT,,,,,=0D
CONFIG,CONFIG,DT,,,,,=0D
MMODE,MMODE,DT,,,,,=0D
ACCMODE,ACCMODE,DT,,,,,=0D
LCYCMODE,LCYCMODE,DT,,,,,=0D
PEAKCYC,PEAKCYC,DT,,,,,=0D
SAGCYC,SAGCYC,DT,,,,,=0D
CFCYC,CFCYC,DT,,,,,=0D
HSDC_CFG,HSDC_CFG,DT,,,,,=0D
Version,in_version_raw,,in,version,,,raw=0D
Reserved,,DT,,,,,=0D
LPOILVL,LPOILVL,DT,,,,,=0D
CONFIG2,CONFIG2,DT,,,,,=

--Apple-Mail=_C4D1D58A-44E6-499C-9DB8-004A86417E04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""></div><div class=3D"">
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><br class=3D"Apple-interchange-newline">Regards,</div><div =
class=3D"">John</div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div></div><br =
class=3D"Apple-interchange-newline" style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;"><br =
class=3D"Apple-interchange-newline">

</div>
<div><br class=3D""></div></body></html>=

--Apple-Mail=_C4D1D58A-44E6-499C-9DB8-004A86417E04--

--Apple-Mail=_A00996E7-8CF4-4A1E-B8C4-BAFECABA1AF0--
