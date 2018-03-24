Return-Path: <john3909@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521932785; cv=none;
        d=google.com; s=arc-20160816;
        b=DHUlruXFDREnwKV4iIylRlAqB3Y2OeN7huSDhP43lDAj8tbRvkc8W1VSrdQyX4zuqK
         oM7QJcSPLrj7Cy0Funbp+KbkTNwOebFCYEOhpMsSA7vcGym1DoIhgo/9ZQ7EuGIwEEhP
         tGfLlQhhz1g7vsljqMtzDVTSdQxdI9stq/NJhUEnGn9I4ue+m8CPn5T0VZZ6htDqy68x
         bry398LpBhzxxJR6T9uQPsdx4zQi84N97IAW7S/LDDBp685cAMDxQqTcBuMNjenfQX8S
         YKHio6FJ+1zxv2zmQTqwF45PIUGDAkhbREVYuDrJTVOU5pVeI7XlmrblMHB7A/eccnXj
         PhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:dkim-signature:arc-authentication-results;
        bh=eoOIDsrPFhj98pZ6Z6zBP2gCtTs0kwva6s7KhaUI4Qg=;
        b=mmy0J2ucTwKBLcK2gduvZzjkGyz+hYBQFzSUfjMLcfKo2WXI92I0o7XtFS0zw7g1EW
         X5RDifiTo0lCHq+DQktSBbPA1hwWHhnU5PnjFLaj9jgbPhjLWPZpqcXRXxvTNsqOKTxl
         Zm2WEZQs/ZeES0sJy0BVlyWjHlhyJQYJfEg+bShVYP10I7WWBUNX8fgd1TsV2956lJAG
         DLZLySNrx4adGTi1a3ZuWaP1mx8Tn5TqSF8M92vaAO6GaqFrXdmAvcjkOLHwZLNEv3ny
         6oZ+KDzCxqUgYh0QQBMmFGa2s6jdcXUOhE2Et6u2Z71RFcTdoyvADcgpqwCJdHTjNVlh
         jeRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Leuv3XxN;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Leuv3XxN;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu6wJdXH14tkmfR+BvYBECkNwFpFZy3vUbUdhfw5oTLtNTuTz1UGie+Gl5Edf1MJ+zmVz1XBw==
From: John Syne <john3909@gmail.com>
Message-Id: <21395383-9236-4312-AA1A-3378F4E5B0BC@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_26FE8CBF-2E74-449F-9637-902B29F073EA"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Date: Sat, 24 Mar 2018 16:06:17 -0700
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
X-GMAIL-MSGID: =?utf-8?q?1595862193131168411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_26FE8CBF-2E74-449F-9637-902B29F073EA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Mar 24, 2018, at 8:18 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>=20
> On Mon, 19 Mar 2018 23:28:45 -0700
> John Syne <john3909@gmail.com <mailto:john3909@gmail.com>> wrote:
>=20
>> Hi Jonathan,
>>=20
>> I broke out the {Direction}_{Type}_{Index}_{Modifier}_{Info_Mask} =
into separate columns to make sure I understand your instructions. Good =
way to check the results.=20
>>=20
>> Probably easier to copy and paste this table into a spreadsheet. Let =
me know if there is anything I got wrong. Thank you again for all your =
help.
> Yeah, we need to shrink this if we do it again.
I=E2=80=99ll send an updated copy after this e-mail. Can you accept a =
spreadsheet=20
attachment or a CSV file?
>=20
> Can drop anything not related to ABI (so RW mask address etc and just =
have the
> register name and the bits around ABI.
Done
>=20
> Note I mentioned the altvoltage stuff in the previous email, so we =
need
> to think about whether that is useful to distinguish the instantaneous
> measurements from the multi cycle AC ones.
> Actually I think we are fine here as we explicitly describe all=20
> alt measurements as mav or rms which going to be handled in our
> new computedvalue description.
Yeah, I don=E2=80=99t see how anyone would use these registers, so I =
propose
we just drop them.
>=20
>=20
>>=20
>> Address	Register	IIO Attribute	Device Tree or Code	=
Direction	Type	Index	Modifier	Info Mask	R/W	=
Bit Length	Bit Length During Communications	Type	Default =
Value	Description
>> 0x4380	AIGAIN	in_current0_phaseA_scale		in	=
current	0	phaseA	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase A current gain adjust.
>> 0x4381	AVGAIN	in_voltage0_phaseA_scale		in	=
voltage	0	phaseA	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase A voltage gain adjust.
>> 0x4382	BIGAIN	in_current0_phaseB_scale		in	=
current	0	phaseB	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase B current gain adjust.
>> 0x4383	BVGAIN	in_voltage0_phaseB_scale		in	=
voltage	0	phaseB	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase B voltage gain adjust.
>> 0x4384	CIGAIN	in_current0_phaseC_scale		in	=
current	0	phaseC	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase C current gain adjust.
>> 0x4385	CVGAIN	in_voltage0_phaseC_scale		in	=
voltage	0	phaseC	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase C voltage gain adjust.
>> 0x4386	NIGAIN	in_current0_neutral_scale		in	=
current	0	neutral	scale	R/W	24	32 ZPSE	S	0x000000	=
Neutral current gain adjust (ADE7868 and ADE7878 only).
>> 0x4387	AIRMSOS	in_current0_phaseA_rms_offset		in	=
current	0	phaseA	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase A current rms offset.
>> 0x4388	AVRMSOS	in_voltage0_phaseA_rms_offset		in	=
voltage	0	phaseA	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase A voltage rms offset.
>> 0x4389	BIRMSOS	in_current0_phaseB_rms_offset		in	=
current	0	phaseB	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase B current rms offset.
>> 0x438A	BVRMSOS	in_voltage0_phaseB_rms_offset		in	=
voltage	0	phaseB	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase B voltage rms offset.
>> 0x438B	CIRMSOS	in_current0_phaseC_rms_offset		in	=
current	0	phaseC	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase C current rms offset.
>> 0x438C	CVRMSOS	in_voltage0_phaseC_rms_offset		in	=
voltage	0	phaseC	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase C voltage rms offset.
>> 0x438D	NIRMSOS	in_current0_neutral_rms_offset		in	=
current	0	neutral	offset	R/W	24	32 ZPSE	S	0x000000	=
Neutral current rms offset (ADE7868 and ADE7878 only).
>> 0x438E	AVAGAIN	in_powerapparent0_phaseA_scale		in	=
powerapparent	0	phaseA	scale	R/W	24	32 ZPSE	S	=
0x000000	Phase A apparent power gain adjust.
>> 0x438F	BVAGAIN	in_powerapparent0_phaseB_scale		in	=
powerapparent	0	phaseB	scale	R/W	24	32 ZPSE	S	=
0x000000	Phase B apparent power gain adjust.
>> 0x4390	CVAGAIN	in_powerapparent0_phaseC_scale		in	=
powerapparent	0	phaseC	scale	R/W	24	32 ZPSE	S	=
0x000000	Phase C apparent power gain adjust.
>> 0x4391	AWGAIN	in_power0_phaseA_scale		in	power	=
0	phaseA	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase A total active power gain adjust.
>> 0x4392	AWATTOS	in_power0_phaseA_offset		in	power	=
0	phaseA	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase A total active power offset adjust.
>> 0x4393	BWGAIN	in_power0_phaseB_scale		in	power	=
0	phaseB	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase B total active power gain adjust.
>> 0x4394	BWATTOS	in_power0_phaseB_offset		in	power	=
0	phaseB	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase B total active power offset adjust.
>> 0x4395	CWGAIN	in_power0_PhaseC_scale		in	power	=
0	phaseC	scale	R/W	24	32 ZPSE	S	0x000000	=
Phase C total active power gain adjust.
>> 0x4396	CWATTOS	in_power0_phaseC_offset		in	power	=
0	phaseC	offset	R/W	24	32 ZPSE	S	0x000000	=
Phase C total active power offset adjust.
>> 0x4397	AVARGAIN	in_powerreactive0_phaseA_scale		=
in	powerreactive	0	phaseA	scale	R/W	24	32 ZPSE	=
S	0x000000	Phase A total reactive power gain adjust =
(ADE7858, ADE7868, and ADE7878).
>> 0x4398	AVAROS	in_powerreactive0_phaseA_offset		in	=
powerreactive	0	phaseA	offset	R/W	24	32 ZPSE	S	=
0x000000	Phase A total reactive power offset adjust (ADE7858, =
ADE7868, and ADE7878).
>> 0x4399	BVARGAIN	in_powerreactive0_phaseB_scale		=
in	powerreactive	0	phaseB	scale	R/W	24	32 ZPSE	=
S	0x000000	Phase B total reactive power gain adjust =
(ADE7858, ADE7868, and ADE7878).
>> 0x439A	BVAROS	in_powerreactive0_phaseB_offset		in	=
powerreactive	0	phaseB	offset	R/W	24	32 ZPSE	S	=
0x000000	Phase B total reactive power offset adjust (ADE7858, =
ADE7868, and ADE7878).
>> 0x439B	CVARGAIN	in_powerreactive0_phaseC_scale		=
in	powerreactive	0	phaseC	scale	R/W	24	32 ZPSE	=
S	0x000000	Phase C total reactive power gain adjust =
(ADE7858, ADE7868, and ADE7878).
>> 0x439C	CVAROS	in_powerreactive0_phaseC_offset		in	=
powerreactive	0	phaseC	offset	R/W	24	32 ZPSE	S	=
0x000000	Phase C total reactive power offset adjust (ADE7858, =
ADE7868, and ADE7878).
>> 0x439D	AFWGAIN	in_power0_phaseA_fundamental_scale		=
in	power	0	phaseA_fundamental	scale	R/W	24	=
32 ZPSE	S	0x000000	Phase A fundamental active power gain =
adjust. Location reserved for ADE7854, ADE7858, and ADE7868.
> Hmm. Fundamental needs to be represented using a separate channel =
index
> and description of the frequency filters applied.  That should map it
> a generic way.
How do I do this?
> I assume we will at some point have fundamental RMS?
>=20
>> 0x439E	AFWATTOS	in_power0_phaseA_fundamental_offset		=
in	power	0	phaseA_fundamental	offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A fundamental active power offset =
adjust. Location reserved for ADE7854, ADE7858, and ADE7868.
>> 0x439F	BFWGAIN	in_power0_phaseB_fundamental_scale		=
in	power	0	phaseB_fundamental	scale	R/W	24	=
32 ZPSE	S	0x000000	Phase B fundamental active power gain =
adjust (ADE7878 only).
>> 0x43A0	BFWATTOS	in_power0_phaseB_fundamental_offset		=
in	power	0	phaseB_fundamental	offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B fundamental active power offset =
adjust (ADE7878 only).
>> 0x43A1	CFWGAIN	in_power0_phaseC_fundamental_scale		=
in	power	0	phaseC_fundamental	scale	R/W	24	=
32 ZPSE	S	0x000000	Phase C fundamental active power gain =
adjust.
>> 0x43A2	CFWATTOS	in_power0_phaseC_fundamental_offset		=
in	power	0	phaseC_fundamental	offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C fundamental active power offset =
adjust (ADE7878 only).
>> 0x43A3	AFVARGAIN	=
in_powerreactive0_phaseA_fundamental_scale		in	=
powerreactive	0	phaseA_fundamental	scale	R/W	24	=
32 ZPSE	S	0x000000	Phase A fundamental reactive power gain =
adjust (ADE7878 only).
>> 0x43A4	AFVAROS	in_powerreactive0_phaseA_fundamental_offset		=
in	powerreactive	0	phaseA_fundamental	offset	R/W	=
24	32 ZPSE	S	0x000000	Phase A fundamental reactive =
power offset adjust (ADE7878 only).
>> 0x43A5	BFVARGAIN	=
in_powerreactive0_phaseB_fundamental_scale		in	=
powerreactive	0	phaseB_fundamental	scale	R/W	24	=
32 ZPSE	S	0x000000	Phase B fundamental reactive power gain =
adjust (ADE7878 only).
>> 0x43A6	BFVAROS	in_powerreactive0_phaseB_fundamental_offset		=
in	powerreactive	0	phaseB_fundamental	offset	R/W	=
24	32 ZPSE	S	0x000000	Phase B fundamental reactive =
power offset adjust (ADE7878 only).
>> 0x43A7	CFVARGAIN	=
in_powerreactive0_phaseC_fundamental_scale		in	=
powerreactive	0	phaseC_fundamental	scale	R/W	24	=
32 ZPSE	S	0x000000	Phase C fundamental reactive power gain =
adjust (ADE7878 only).
>> 0x43A8	CFVAROS	in_powerreactive0_phaseC_fundamental_offset		=
in	powerreactive	0	phaseC_fundamental	offset	R/W	=
24	32 ZPSE	S	0x000000	Phase C fundamental reactive =
power offset adjust (ADE7878 only).
>=20
> =46rom further versions drop anything we aren't exposing to userspace. =
Makes this easier to read.
Done
>=20
>> 0x43A9	VATHR1	VATHR1	DT	in					=
R/W	24	32 ZP	U	0x000000	Most significant 24 bits =
of VATHR[47:0] threshold used in phase apparent power datapath.
>> 0x43AA	VATHR0	VATHR0	DT	in					=
R/W	24	32 ZP	U	0x000000	Less significant 24 bits =
of VATHR[47:0] threshold used in phase apparent power datapath.
>> 0x43AB	WTHR1	WTHR1	DT	in					=
R/W	24	32 ZP	U	0x000000	Most significant 24 bits =
of WTHR[47:0] threshold used in phase total/fundamental active power =
datapath.
>> 0x43AC	WTHR0	WTHR0	DT	in					=
R/W	24	32 ZP	U	0x000000	Less significant 24 bits =
of WTHR[47:0] threshold used in phase total/fundamental active power =
datapath.
>> 0x43AD	VARTHR1	VARTHR1	DT	in					=
R/W	24	32 ZP	U	0x000000	Most significant 24 bits =
of VARTHR[47:0] threshold used in phase total/fundamental reactive power =
datapath (ADE7858, ADE7868, and ADE7878).
>> 0x43AE	VARTHR0	VARTHR0	DT	in					=
R/W	24	32 ZP	U	0x000000	Less significant 24 bits =
of VARTHR[47:0] threshold used in phase total/fundamental reactive power =
datapath (ADE7858, ADE7868, and ADE7878).
>> 0x43AF	Reserved	Reserved					=
		N/A4	N/A4	N/A4	N/A4	0x000000	This =
memory location should be kept at 0x000000 for proper operation.
>> 0x43B0	VANOLOAD	VANOLOAD	DT	in			=
		R/W	24	32 ZPSE	S	0x0000000	No load =
threshold in the apparent power datapath.
>> 0x43B1	APNOLOAD	APNOLOAD	DT	in			=
		R/W	24	32 ZPSE	S	0x0000000	No load =
threshold in the total/fundamental active power datapath.
>> 0x43B3	VLEVEL	VLEVEL	DT	in					=
R/W	24	32 ZPSE	S	0x000000	Register used in the =
algorithm that computes the fundamental active and reactive powers =
(ADE7878 only).
>> 0x43B5	DICOEFF	DICOEFF	DT	in					=
R/W	24	32 ZPSE	S	0x0000000	Register used in the =
digital integrator algorithm. If the integrator is turned on, it must be =
set at 0xFF8000. In practice, it is transmitted as 0xFFF8000.
>> 0x43B6	HPFDIS	HPFDIS	DT	in					=
R/W	24	32 ZP	U	0x000000	Disables/enables the HPF =
in the current datapath (see Table 34).
>> 0x43B8	ISUMLVL	ISUMLVL		in					=
R/W	24	32 ZPSE	S	0x000000	Threshold used in =
comparison between the sum of phase currents and the neutral current =
(ADE7868 and ADE7878 only).
>> 0x43BF	ISUM	in_current0_phaseA&phaseB&phaseC_sum		=
in	current	0	phaseA&phaseB&phaseC	sum	R	28	=
32 ZP	S	N/A4	Sum of IAWV, IBWV, and ICWV registers (ADE7868 =
and ADE7878 only).
> Hehe, I'll get compaints about defining very long ABI again.  Pah, it =
says what
> it does on the tin.
>=20
>> 0x43C0	AIRMS	in_current0_phaseA_rms		in	current	=
0	phaseA_rms		R	24	32 ZP	S	N/A4	=
Phase A current rms value.
> in_current0_phaseA_rms_raw as otherwise we don't know we need to apply
> in_current0_phaseA_rms_scale to it (or the shared value that maps to =
that).
Yeah, this is still confusion to me. This should read =
in_current0_phaseA_rms_gain=20
as it directly affects the value in_current0_phaseA_rms_raw. We still =
have to apply
a scale value to turn this cryptic number into something meaningful.=20
>=20
>=20
>> 0x43C1	AVRMS	in_voltage0_phaseA_rms		in	voltage	=
0	phaseA_rms		R	24	32 ZP	S	N/A4	=
Phase A voltage rms value.
>> 0x43C2	BIRMS	in_current0_phaseB_rms		in	current	=
0	phaseB_rms		R	24	32 ZP	S	N/A4	=
Phase B current rms value.
>> 0x43C3	BVRMS	in_voltage0_phaseB_rms		in	voltage	=
0	phaseB_rms		R	24	32 ZP	S	N/A4	=
Phase B voltage rms value.
>> 0x43C4	CIRMS	in_current0_phaseC_rms		in	current	=
0	phaseC_rms		R	24	32 ZP	S	N/A4	=
Phase C current rms value.
>> 0x43C5	CVRMS	in_voltage0_phaseC_rms		in	voltage	=
0	phaseC_rms		R	24	32 ZP	S	N/A4	=
Phase C voltage rms value.
>> 0x43C6	NIRMS	in_current0_neutral_rms		in	current	=
0	neutral_rms		R	24	32 ZP	S	N/A4	=
Neutral current rms value (ADE7868 and ADE7878 only).
>> 0xE228	Run		Code	in					=
R/W	16	16	U	0x0000	Run register starts and stops =
the DSP. See the Digital Signal Processor section for more details.
>> 0xE400	AWATTHR	in_energy0_phaseA_raw		in	energy	=
0	phaseA	raw	R	32	32	S	0x00000000	=
Phase A total active energy accumulation.
>> 0xE401	BWATTHR	in_energy0_phaseB_raw		in	energy	=
0	phaseB	raw	R	32	32	S	0x00000000	=
Phase B total active energy accumulation.
>> 0xE402	CWATTHR	in_energy0_phaseC_raw		in	energy	=
0	phaseC	raw	R	32	32	S	0x00000000	=
Phase C total active energy accumulation.
>> 0xE403	AFWATTHR	in_energy0_phaseA_fundamental_raw		=
in	energy	0	phaseA_fundamental	raw	R	32	=
32	S	0x00000000	Phase A fundamental active energy =
accumulation (ADE7878 only).
>> 0xE404	BFWATTHR	in_energy0_phaseB_fundamental_raw		=
in	energy	0	phaseB_fundamental	raw	R	32	=
32	S	0x00000000	Phase B fundamental active energy =
accumulation (ADE7878 only).
>> 0xE405	CFWATTHR	in_energy0_phaseC_fundamental_raw		=
in	energy	0	phaseC_fundamental	raw	R	32	=
32	S	0x00000000	Phase C fundamental active energy =
accumulation (ADE7878 only).
>> 0xE406	AVARHR	in_energyreactive0_phaseA_raw		in	=
energyreactive	0	phaseA	raw	R	32	32	S	=
0x00000000	Phase A total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).
>> 0xE407	BVARHR	in_energyreactive0_phaseB_raw		in	=
energyreactive	0	phaseB	raw	R	32	32	S	=
0x00000000	Phase B total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).
>> 0xE408	CVARHR	in_energyreactive0_phaseC_raw		in	=
energyreactive	0	phaseC	raw	R	32	32	S	=
0x00000000	Phase C total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).
>> 0xE409	AFVARHR	in_energyreactive0_phaseA_fundamental_raw		=
in	energyreactive	0	phaseA_fundamental	raw	R	=
32	32	S	0x00000000	Phase A fundamental reactive =
energy accumulation (ADE7878 only).
>> 0xE40A	BFVARHR	in_energyreactive0_phaseB_fundamental_raw		=
in	energyreactive	0	phaseB_fundamental	raw	R	=
32	32	S	0x00000000	Phase B fundamental reactive =
energy accumulation (ADE7878 only).
>> 0xE40B	CFVARHR	in_energyreactive0_phaseC_fundamental_raw		=
in	energyreactive	0	phaseC_fundamental	raw	R	=
32	32	S	0x00000000	Phase C fundamental reactive =
energy accumulation (ADE7878 only).
>> 0xE40C	AVAHR	in_energyapparent0_phaseA_raw		in	=
energyapparent	0	phaseA	raw	R	32	32	S	=
0x00000000	Phase A apparent energy accumulation.
>> 0xE40D	BVAHR	in_energyapparent0_phaseB_raw		in	=
energyapparent	0	phaseB	raw	R	32	32	S	=
0x00000000	Phase B apparent energy accumulation.
>> 0xE40E	CVAHR	in_energyapparent0_phaseC_raw		in	=
energyapparent	0	phaseC	raw	R	32	32	S	=
0x00000000	Phase C apparent energy accumulation.
>> 0xE500	IPEAK	in_current0_peak		in	current	=
0		peak	R	32	32	U	N/A	Current =
peak register. See Figure 50 and Table 35 for details about its =
composition.
>> 0xE501	VPEAK	in_voltage0_peak		in	voltage	=
0		peak	R	32	32	U	N/A	Voltage =
peak register. See Figure 50 and Table 36 for details about its =
composition.
>=20
>> 0xE502	STATUS0	mapped to events	event	in	status	=
0		raw	R/W	32	32	U	N/A	=
Interrupt Status Register 0. See Table 37.
>> 0xE503	STATUS1	mapped to events	event	in	status	=
1		raw	R/W	32	32	U	N/A	=
Interrupt Status Register 1. See Table 38.
>> 0xE504	AIMAV	in_current0_phaseA_mav		in	current		=
phaseA_mav		R	20	32 ZP	U	N/A	Phase A =
current mean absolute value computed during PSM0 and PSM1 modes (ADE7868 =
and ADE7878 only).
> in_current0_phaseA_mav_raw
>=20
>> 0xE505	BIMAV	in_current0_phaseB_mav		in	current		=
phaseB_mav		R	20	32 ZP	U	N/A	Phase B =
current mean absolute value computed during PSM0 and PSM1 modes (ADE7868 =
and ADE7878 only).
>> 0xE506	CIMAV	in_current0_phaseC_mav		in	current		=
phaseC_mav		R	20	32 ZP	U	N/A	Phase C =
current mean absolute value computed during PSM0 and PSM1 modes (ADE7868 =
and ADE7878 only).
>> 0xE507	OILVL	OILVL	DT	in					=
R/W	24	32 ZP	U	0xFFFFFF	Overcurrent threshold.
>> 0xE508	OVLVL	OVLVL	DT	in					=
R/W	24	32 ZP	U	0xFFFFFF	Overvoltage threshold.
>> 0xE509	SAGLVL	SAGLVL	DT	in					=
R/W	24	32 ZP	U	0x000000	Voltage SAG level =
threshold.
>> 0xE50A	MASK0	in_mask0_raw		in	mask	0		=
raw	R/W	32	32	U	0x00000000	Interrupt Enable =
Register 0. See Table 39.
>> 0xE50B	MASK1	in_mask1_raw		in	mask	1		=
raw	R/W	32	32	U	0x00000000	Interrupt Enable =
Register 1. See Table 40.
>> 0xE50C	IAWV	in_current0_phaseA_instantaneous		=
in	current		phaseA	instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase A current.
> As mentioned before. This is the 'expectation' for in_currentX
> So it is the other case we need to represent by describing filtering
> or using the altvoltage equivalent.
>=20
>> 0xE50D	IBWV	in_current0_phaseB_instantaneous		=
in	current		phaseB	instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase B current.
>> 0xE50E	ICWV	in_current0_phaseC_instantaneous		=
in	current		phaseC	instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase C current.
>> 0xE50F	INWV	in_current0_phaseN_instantaneous		=
in	current		neutral	instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of neutral current (ADE7868 and =
ADE7878 only).
>> 0xE510	VAWV	in_voltage0_phaseA_instantaneous		=
in	voltage		phaseA	instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase A voltage.
>> 0xE511	VBWV	in_voltage0_phaseB_instantaneous		=
in	voltage		phaseB	instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase B voltage.
>> 0xE512	VCWV	in_voltage0_phaseC_instantaneous		=
in	voltage		phaseC	instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase C voltage.
>> 0xE513	AWATT	in_power0_phaseA_instantaneous		in	=
power		phaseA	instantaneous	R	24	32 SE	S	=
N/A	Instantaneous value of Phase A total active power.
>> 0xE514	BWATT	in_power0_phaseB_instantaneous		in	=
power		phaseB	instantaneous	R	24	32 SE	S	=
N/A	Instantaneous value of Phase B total active power.
>> 0xE515	CWATT	in_power0_phaseC_instantaneous		in	=
power		phaseC	instantaneous	R	24	32 SE	S	=
N/A	Instantaneous value of Phase C total active power.
>> 0xE516	AVAR	in_powerreactive0_phaseA_instantaneous		=
in	powerreactive		phaseA	instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>> 0xE517	BVAR	in_powerreactive0_phaseB_instantaneous		=
in	powerreactive		phaseB	instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>> 0xE518	CVAR	in_powerreactive0_phaseC_instantaneous		=
in	powerreactive		phaseC	instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>> 0xE519	AVA	in_powerapparent0_phaseA_instantaneous		=
in	powerapparent		phaseA	instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A apparent power.
>> 0xE51A	BVA	in_powerapparent0_phaseB_instantaneous		=
in	powerapparent		phaseB	instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B apparent power.
>> 0xE51B	CVA	in_powerappatent0_phaseC_instantaneous		=
in	powerapparent		phaseC	instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C apparent power.
>> 0xE51F	CHECKSUM	register_CHECKSUM	Code	in		=
			R	32	32	U	0x33666787	=
Checksum verification. See the Checksum Register section for details.
>> 0xE520	VNOM	in_voltage0_phase_rms_nominal		in	=
voltage		phase_rms	nominal	R/W	24	32 ZP	S	=
0x000000	Nominal phase voltage rms used in the alternative =
computation of the apparent power. When the VNOMxEN bit is set, the =
applied voltage input in the corresponding phase is ignored and all =
corresponding rms voltage instances are replaced by the value in the =
VNOM register.
> This one is an oddity.  I'm not sure we want to expose it to userspace =
at all.
We could just move this to DT. Not sure if a user would need to set this =
from a=20
user space app.
>=20
>> 0xE600	PHSTATUS	mapped to events	event	in		=
			R	16	16	U	N/A	Phase =
peak register. See Table 41.
>> 0xE601	ANGLE0	ANGLE0	DT	in					=
R	16	16	U	N/A	Time Delay 0. See the Time =
Interval Between Phases section for details.
>> 0xE602	ANGLE1	ANGLE1	DT	in					=
R	16	16	U	N/A	Time Delay 1. See the Time =
Interval Between Phases section for details.
>> 0xE603	ANGLE2	ANGLE2	DT	in					=
R	16	16	U	N/A	Time Delay 2. See the Time =
Interval Between Phases section for details.
>> 0xE604 to 0xE606	Reserved						=
							These addresses =
should not be written for proper operation.
>> 0xE607	PERIOD	in_period_raw		in	period			=
raw	R	16	16	U	N/A	Network line period.
>> 0xE608	PHNOLOAD	mapped to events	event	in		=
			R	16	16	U	N/A	Phase no =
load register. See Table 42.
>> 0xE60C	LINECYC	in_count0_cycle		in	count	0	=
cycle	raw	R/W	16	16	U	0xFFFF	Line cycle =
accumulation mode count.
>> 0xE60D	ZXTOUT	ZXTOUT	DT	in					=
R/W	16	16	U	0xFFFF	Zero-crossing timeout count.
>> 0xE60E	COMPMODE	COMPMODE	DT	in			=
		R/W	16	16	U	0x01FF	Computation-mode =
register. See Table 43.
>> 0xE60F	Gain	Gain	DT	in					=
R/W	16	16	U	0x0000	PGA gains at ADC inputs. See =
Table 44.
>> 0xE610	CFMODE	CFMODE	DT	in					=
R/W	16	16	U	0x0E88	CFx configuration register. See =
Table 45.
>> 0xE611	CF1DEN	CF1DEN	DT	in					=
R/W	16	16	U	0x0000	CF1 denominator.
>> 0xE612	CF2DEN	CF2DEN	DT	in					=
R/W	16	16	U	0x0000	CF2 denominator.
>> 0xE613	CF3DEN	CF3DEN	DT	in					=
R/W	16	16	U	0x0000	CF3 denominator.
>> 0xE614	APHCAL	APHCAL	DT	in					=
R/W	10	16 ZP	S	0x0000	Phase calibration of Phase A. =
See Table 46.
>> 0xE615	BPHCAL	BPHCAL	DT	in					=
R/W	10	16 ZP	S	0x0000	Phase calibration of Phase B. =
See Table 46.
>> 0xE616	CPHCAL	CPHCAL	DT	in					=
R/W	10	16 ZP	S	0x0000	Phase calibration of Phase C. =
See Table 46.
>> 0xE617	PHSIGN	PHSIGN	DT	in					=
R	16	16	U	N/A	Power sign register. See Table =
47.
>> 0xE618	CONFIG	CONFIG	DT	in					=
R/W	16	16	U	0x0000	ADE7878 configuration register. =
See Table 48.
>> 0xE700	MMODE	MMODE	DT	in					=
R/W	8	8	U	0x1C	Measurement mode register. See =
Table 49.
>> 0xE701	ACCMODE	ACCMODE	DT	in					=
R/W	8	8	U	0x00	Accumulation mode register. See =
Table 50.
>> 0xE702	LCYCMODE	LCYCMODE	DT	in			=
		R/W	8	8	U	0x78	Line =
accumulation mode behavior. See Table 52.
>> 0xE703	PEAKCYC	PEAKCYC	DT	in					=
R/W	8	8	U	0x00	Peak detection half line cycles.
>> 0xE704	SAGCYC	SAGCYC	DT	in					=
R/W	8	8	U	0x00	SAG detection half line cycles.
>> 0xE705	CFCYC	CFCYC	DT	in					=
R/W	8	8	U	0x01	Number of CF pulses between two =
consecutive energy latches. See the Synchronizing Energy Registers with =
CFx Outputs section.
>> 0xE706	HSDC_CFG	HSDC_CFG	DT	in			=
		R/W	8	8	U	0x00	HSDC =
configuration register. See Table 53.
>> 0xE707	Version	in_version_raw		in	version			=
raw	R	8	8	U		Version of die.
>> 0xEBFF	Reserved		DT	in				=
		8	8			This address can be used =
in manipulating the SS/HSA pin when SPI is chosen as the active port. =
See the Serial Interfaces section for details.
>> 0xEC00	LPOILVL	LPOILVL	DT	in					=
R/W	8	8	U	0x07	"Overcurrent threshold used =
during PSM2 mode (ADE7868 and ADE7878 only). See Table 54 in which the =
register is detailed.=E2=80=9D
>> 0xEC01	CONFIG2	CONFIG2	DT	in					=
R/W	8	8	U	0x00	Configuration register used =
during PSM1 mode. See Table 55.
>=20
> So other than fundamental, instantaneous and the distinction between
> what would be considered DC measurements and AC ones (over several =
cycles)
> that all looks good to me ;)
>=20
> So in brief, I don't think we need instantaneous at all.
Agreed
>=20
> Fundamental should be done as a parallel channel (different index)
> with the filters described to make it fundamental only.
How do I do this. Is there a good implementation of this anywhere?
>=20
> So next step may be proposing the core changes to add the
> handling for computed values and change the events description
> to allow for events based on them.  We do that with some
> examples added to the dummy driver (so anyone can play with it
> without hardware).  After that we can start moving the
> driver over by adding the basic channels and then building
> up to support all the oddities (dropping the custom
> attributes as we go).
>=20
> It's a big job so fingers crossed.
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
>>=20
>> Regards,
>> John
>>=20
>>=20
>>=20
>>=20
>>=20
>>> On Mar 18, 2018, at 5:23 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>>>=20
>>> On Sat, 17 Mar 2018 23:11:45 -0700
>>> John Syne <john3909@gmail.com> wrote:
>>>=20
>>>> Hi Jonathan, =20
>>> Hi John and All,
>>>=20
>>> I'd love to get some additional input on this from anyone =
interested.
>>> There are a lot of weird and wonderful derived quantities in an =
energy
>>> meter and it seems we need to make some fundamental changes to =
support
>>> them - including potentially a userspace breaking change to the =
event
>>> code description.
>>>=20
>>>>=20
>>>> Here is the complete list of registers for the ADE7878 which I =
copied from the data sheet. I added a column =E2=80=9CIIO Attribute=E2=80=9D=
 which I hope follows your IIO ABI. Please make any changes you feel are =
incorrect. BTW, there are several registers that cannot be generalized =
and are used purely for chip configuration. I think we should add a new =
naming convention, namely {register}_{<chip-register-name>}. Also, I see =
in the sys_bus_iio doc
>>>> in_accel_x_peak_raw
>>>>=20
>>>> so shouldn=E2=80=99t the phase be represented as follows:
>>>>=20
>>>> in_current_A_scale =20
>>> I'm still confused.  What does A represent here?  I assumed that was =
a wild
>>> card for the channel number before but clearly not.
>>>=20
>>> Ah, you are labelling the 3 separate phases as A, B and C. Hmm.
>>> I guess they sort of look like axis, and sort of like independent =
channels.
>>> So could be indexed or done via modifiers depending on how you look =
at it.
>>>=20
>>> Hmm. With neutral in there as well I guess we need to make them
>>> modifiers (but might change my mind later ;)
>>>=20
>>> Particularly as we are using the the modifier for RMS under the =
previous
>>> plan... It appears we should treat that instead like we did for peak
>>> and do it as an additional info mask element.  The problem with =
doing that
>>> on a continuous measurement is that we can't treat it as a channel =
to
>>> be output through the buffered interface.
>>>=20
>>> So again we have run out of space. It's increasingly looking like we =
need
>>> room for another field in the events - to cleanly represent computed =
values.
>>>=20
>>> Hmm. What is the current usage? - it's been a while so I had to go
>>> look in the header.
>>>=20
>>> 0-15 Channel (lots of channels)
>>> 31-16 Channel 2  (36 modifiers - lots of channels)
>>> 47-32 Channel Type (31 used so far - this looks most likely to run =
out of
>>> space in the long run so leave this one alone).
>>> 54-48 Event Direction (4 used)
>>> 55 Differential  (1: channel 2 as differential pair 0: as a =
modifier)
>>> 63-56 Event Type (6 used)
>>>=20
>>> So I think we can pinch bit 53 as another flag to indicate we have
>>> a computed value or possibly bit 63 as event types are few and
>>> far between as well.
>>>=20
>>> Probably reasonable to assume we never have 16 bits worth
>>> of channels and computed channels at the same time?
>>> Hence I think we can steal bits off the top of Channel.
>>> How many do we need?  Not sure unfortunately but feels like
>>> 8 should be plenty.
>>>=20
>>> The other element of this is we add a new field to iio_chan_spec
>>> to contain 'derived_type' or something like that which has
>>> rms and sum squared etc. Over time we can move some of those
>>> from the modifiers and free up a few entires there.
>>> So modifier might be "X and Y and Z" with a derived_type of=20
>>> sum_squared to give existing sum_squared_x_y_z but no
>>> rush on that.
>>>=20
>>> Anyhow so now we have an extra element to play that will result
>>> in a different channel.
>>>=20
>>> Whilst here we should think about any other mods needed to
>>> that event structure.  It is a little unfortunate that this
>>> will be a breaking change for any old userspace code playing
>>> with new drivers but it can't be helped as we didn't have
>>> reserved values in the original definition (oops).
>>>=20
>>> At somepoint we may need to add the 'shared by derived_value'
>>> info mask but I think we can ignore that for now (seems
>>> moderately unlikely to have anything in it!) =20
>>>>=20
>>>> But for now, I followed your instructions from your reply.
>>>>=20
>>>> After finalizing this one, I will work on the ADE9000, which as way =
more registers ;-)
>>>>=20
>>>> Once we can agree on the register naming, I will update the ADE7854 =
driver for Rodrigo, which will go a long way to getting it out of =
staging. =20
>>> I'll edit to fit with new scheme and insert indexes which I think =
would be
>>> preferred though optional under the ABI as we only have one of each =
type/ =20
>>>>=20
>>>> Address	Register	IIO Attribute	R/W	Bit Length	=
Bit Length During Communications	Type	Default Value	=
Description
>>>> 0x4380	AIGAIN	in_current0_phaseA_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase A current gain adjust. =20
>>> A, B, C, N aren't obvious to the lay reader so I suggest we burn a =
few characters and stick phase in for ABC and just have neutral for
>>> the neutral one. Not sure about capitalization or not though.
>>>=20
>>>> 0x4381	AVGAIN	in_voltage0_phaseA_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase A voltage gain adjust.
>>>> 0x4382	BIGAIN	in_current0_phaseB_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase B current gain adjust.
>>>> 0x4383	BVGAIN	in_voltage0_phaseB_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase B voltage gain adjust.
>>>> 0x4384	CIGAIN	in_current0_phaseC_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase C current gain adjust.
>>>> 0x4385	CVGAIN	in_voltage0_phaseC_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase C voltage gain adjust.
>>>> 0x4386	NIGAIN	in_current0_neutral_scale	R/W	24	=
32 ZPSE	S	0x000000	Neutral current gain adjust (ADE7868 and =
ADE7878 only).
>>>> 0x4387	AIRMSOS	in_current0_phaseA_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A current rms offset.
>>>> 0x4388	AVRMSOS	in_voltage0_phaseA_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A voltage rms offset.
>>>> 0x4389	BIRMSOS	in_current0_phaseB_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B current rms offset.
>>>> 0x438A	BVRMSOS	in_voltage0_phaseB_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B voltage rms offset.
>>>> 0x438B	CIRMSOS	in_current0_phaseC_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C current rms offset.
>>>> 0x438C	CVRMSOS	in_voltage0_phaseC_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C voltage rms offset.
>>>> 0x438D	NIRMSOS	in_current0_neutral_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Neutral current rms offset (ADE7868 and =
ADE7878 only).
>>>> 0x438E	AVAGAIN	in_powerapparent0_phaseA_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase A apparent power gain adjust.
>>>> 0x438F	BVAGAIN	in_powerapparent0_phaseB_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase B apparent power gain adjust.
>>>> 0x4390	CVAGAIN	in_powerapparent0_phaseC_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase C apparent power gain adjust.
>>>> 0x4391	AWGAIN	in_power0_phaseA_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase A total active power gain adjust.
>>>> 0x4392	AWATTOS	in_power0_phaseA_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase A total active power offset adjust.
>>>> 0x4393	BWGAIN	in_power0_phaseB_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase B total active power gain adjust.
>>>> 0x4394	BWATTOS	in_power0_phaseB_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase B total active power offset adjust.
>>>> 0x4395	CWGAIN	in_power0_PhaseC_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase C total active power gain adjust.
>>>> 0x4396	CWATTOS	in_power0_phaseC_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase C total active power offset adjust.
>>>> 0x4397	AVARGAIN	in_powerreactive0_phaseA_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase A total reactive power =
gain adjust (ADE7858, ADE7868, and ADE7878).
>>>> 0x4398	AVAROS	in_powerreactive0_phaseA_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A total reactive power offset =
adjust (ADE7858, ADE7868, and ADE7878).
>>>> 0x4399	BVARGAIN	in_powerreactive0_phaseB_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase B total reactive power =
gain adjust (ADE7858, ADE7868, and ADE7878).
>>>> 0x439A	BVAROS	in_powerreactive0_phaseB_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B total reactive power offset =
adjust (ADE7858, ADE7868, and ADE7878).
>>>> 0x439B	CVARGAIN	in_powerreactive0_phaseC_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase C total reactive power =
gain adjust (ADE7858, ADE7868, and ADE7878).
>>>> 0x439C	CVAROS	in_powerreactive0_phaseC_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C total reactive power offset =
adjust (ADE7858, ADE7868, and ADE7878).
>>>> 0x439D	AFWGAIN	in_power0_phaseA_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase A fundamental active power =
gain adjust. Location reserved for ADE7854, ADE7858, and ADE7868. =20
>>> Hmm. fundamental is the oddity here.  I here because  it is sort of =
a derived value
>>> and sort of a filter applied.  Can it be sensible combined with RMS? =
probably not but
>>> it can be combined with peak for example (which I'd also ideally =
move into
>>> the derived representation.).
>>>=20
>>>> 0x439E	AFWATTOS	in_power0_phaseA_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase A fundamental =
active power offset adjust. Location reserved for ADE7854, ADE7858, and =
ADE7868.
>>>> 0x439F	BFWGAIN	in_power0_phaseB_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase B fundamental active power =
gain adjust (ADE7878 only).
>>>> 0x43A0	BFWATTOS	in_power0_phaseB_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase B fundamental =
active power offset adjust (ADE7878 only).
>>>> 0x43A1	CFWGAIN	in_power0_phaseC_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase C fundamental active power =
gain adjust.
>>>> 0x43A2	CFWATTOS	in_power0_phaseC_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase C fundamental =
active power offset adjust (ADE7878 only).
>>>> 0x43A3	AFVARGAIN	=
in_powerreactive0_phaseA_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase A fundamental reactive power gain adjust =
(ADE7878 only).
>>>> 0x43A4	AFVAROS	in_powerreactive0_phaseA_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase A fundamental =
reactive power offset adjust (ADE7878 only).
>>>> 0x43A5	BFVARGAIN	=
in_powerreactive0_phaseB_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase B fundamental reactive power gain adjust =
(ADE7878 only).
>>>> 0x43A6	BFVAROS	in_powerreactive0_phaseB_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase B fundamental =
reactive power offset adjust (ADE7878 only).
>>>> 0x43A7	CFVARGAIN	=
in_powerreactive0_phaseC_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase C fundamental reactive power gain adjust =
(ADE7878 only).
>>>> 0x43A8	CFVAROS	in_powerreactive0_phaseC_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase C fundamental =
reactive power offset adjust (ADE7878 only).
>>>> 0x43A9	VATHR1	regiister_VATHR1	R/W	24	32 ZP	=
U	0x000000	Most significant 24 bits of VATHR[47:0] =
threshold used in phase apparent power datapath. =20
>>> Do not expose these to userspace. Why would it care?
>>>=20
>>>> 0x43AA	VATHR0	register_VATHR0	R/W	24	32 ZP	U	=
0x000000	Less significant 24 bits of VATHR[47:0] threshold used =
in phase apparent power datapath.
>>>> 0x43AB	WTHR1	register_WTHR1	R/W	24	32 ZP	U	=
0x000000	Most significant 24 bits of WTHR[47:0] threshold used in =
phase total/fundamental active power datapath.
>>>> 0x43AC	WTHR0	register_WTHR0	R/W	24	32 ZP	U	=
0x000000	Less significant 24 bits of WTHR[47:0] threshold used in =
phase total/fundamental active power datapath.
>>>> 0x43AD	VARTHR1	register_VARTHR1	R/W	24	32 ZP	=
U	0x000000	Most significant 24 bits of VARTHR[47:0] =
threshold used in phase total/fundamental reactive power datapath =
(ADE7858, ADE7868, and ADE7878).
>>>> 0x43AE	VARTHR0	register_VARTHR0	R/W	24	32 ZP	=
U	0x000000	Less significant 24 bits of VARTHR[47:0] =
threshold used in phase total/fundamental reactive power datapath =
(ADE7858, ADE7868, and ADE7878).
>>>> 0x43AF	Reserved		N/A4	N/A4	N/A4	N/A4	=
0x000000	This memory location should be kept at 0x000000 for =
proper operation.
>>>> 0x43B0	VANOLOAD	register_VANOLOAD	R/W	24	=
32 ZPSE	S	0x0000000	No load threshold in the apparent power =
datapath. =20
>>> This one is kind of an event parameter, but one that controls =
internal creep prevention.
>>> This will be a driver specific attr I think for now. We may add it =
to info_mask
>>> later if we get lots of meter drivers.=20
>>> Something like
>>> in_power0_no_load_thresh though I haven't really thought about it or =
looked
>>> for similar precedence.
>>>=20
>>>=20
>>>> 0x43B1	APNOLOAD	register_APNOLOAD	R/W	24	=
32 ZPSE	S	0x0000000	No load threshold in the =
total/fundamental active power datapath. =20
>>> in_activepower0_no_load_thresh =20
>>>> 0x43B2	VARNOLOAD	register_VARNOLOAD	R/W	24	=
32 ZPSE	S	0x0000000	No load threshold in the =
total/fundamental reactive power datapath. Location reserved for =
ADE7854. =20
>>> in_reactivpower0_no_load_thresh
>>>=20
>>>> 0x43B3	VLEVEL	register_VLEVEL	R/W	24	32 ZPSE	S	=
0x000000	Register used in the algorithm that computes the =
fundamental active and reactive powers (ADE7878 only). =20
>>> This one looks like a characteristic of the circuit attached.  So =
should be devicetree
>>> or similar and not exposed to userspace.
>>>=20
>>>> 0x43B5	DICOEFF	register_DICOEFF	R/W	24	32 ZPSE	=
S	0x0000000	Register used in the digital integrator =
algorithm. If the integrator is turned on, it must be set at 0xFF8000. =
In practice, it is transmitted as 0xFFF8000. =20
>>> no userspace interface.
>>>=20
>>>> 0x43B6	HPFDIS	register_HPFDIS	R/W	24	32 ZP	U	=
0x000000	Disables/enables the HPF in the current datapath (see =
Table 34). =20
>>> We have controls for high pass filters, you'll need to map on to =
them.
>>> Disable is usually setting 3DB point to 0 IIRC.
>>>=20
>>>> 0x43B8	ISUMLVL	register_ISUMLVL	R/W	24	32 ZPSE	=
S	0x000000	Threshold used in comparison between the sum of =
phase currents and the neutral current (ADE7868 and ADE7878 only). =20
>>> This is an event threshold so needs to map to the events =
infrastructure
>>> as best we can.  It's actually a pain to describe so may be device =
specific ABI.
>>>=20
>>>> 0x43BF	ISUM	register_ISUM	R	28	32 ZP	S	=
N/A4	Sum of IAWV, IBWV, and ICWV registers (ADE7868 and ADE7878 =
only). =20
>>> So this would be using a modifier for AandBandC phases (similar to =
the XandYanZ ones for mems devices and
>>> a derived value of sum I think So would look something like.
>>> in_current0_phaseA&phaseB&phaseC_sum and yet another channel
>>>=20
>>>> 0x43C0	AIRMS	in_current0_phaseA_rms	R	24	32 ZP	=
S	N/A4	Phase A current rms value.
>>>> 0x43C1	AVRMS	in_voltage0_phaseA_rms	R	24	32 ZP	=
S	N/A4	Phase A voltage rms value.
>>>> 0x43C2	BIRMS	in_current0_phaseB_rms	R	24	32 ZP	=
S	N/A4	Phase B current rms value.
>>>> 0x43C3	BVRMS	in_voltage0_phaseB_rms	R	24	32 ZP	=
S	N/A4	Phase B voltage rms value.
>>>> 0x43C4	CIRMS	in_current0_phaseC_rms	R	24	32 ZP	=
S	N/A4	Phase C current rms value.
>>>> 0x43C5	CVRMS	in_voltage0_phaseC_rms	R	24	32 ZP	=
S	N/A4	Phase C voltage rms value.
>>>> 0x43C6	NIRMS	in_current0_neutral_rms	R	24	32 ZP	=
S	N/A4	Neutral current rms value (ADE7868 and ADE7878 only).
>>>> 0xE228	Run	register_Run	R/W	16	16	U	=
0x0000	Run register starts and stops the DSP. See the Digital Signal =
Processor section for more details. =20
>>> Not exposed to userspace.
>>>=20
>>>> 0xE400	AWATTHR	in_energy0_phaseA_raw	R	32	32	=
S	0x00000000	Phase A total active energy accumulation.
>>>> 0xE401	BWATTHR	in_energy0_phaseB_raw	R	32	32	=
S	0x00000000	Phase B total active energy accumulation.
>>>> 0xE402	CWATTHR	in_energy0_phaseC_raw	R	32	32	=
S	0x00000000	Phase C total active energy accumulation.
>>>> 0xE403	AFWATTHR	in_energy0_phaseA_fundamental_raw	=
R	32	32	S	0x00000000	Phase A fundamental =
active energy accumulation (ADE7878 only).
>>>> 0xE404	BFWATTHR	in_energy0_phaseB_fundamental_raw	=
R	32	32	S	0x00000000	Phase B fundamental =
active energy accumulation (ADE7878 only).
>>>> 0xE405	CFWATTHR	in_energy0_phaseC_fundamental_raw	=
R	32	32	S	0x00000000	Phase C fundamental =
active energy accumulation (ADE7878 only).
>>>> 0xE406	AVARHR	in_energyreactive0_phaseA_raw	R	32	=
32	S	0x00000000	Phase A total reactive energy =
accumulation (ADE7858, ADE7868, and ADE7878 only).
>>>> 0xE407	BVARHR	in_energyreactive0_phaseB_raw	R	32	=
32	S	0x00000000	Phase B total reactive energy =
accumulation (ADE7858, ADE7868, and ADE7878 only).
>>>> 0xE408	CVARHR	in_energyreactive0_phaseC_raw	R	32	=
32	S	0x00000000	Phase C total reactive energy =
accumulation (ADE7858, ADE7868, and ADE7878 only).
>>>> 0xE409	AFVARHR	in_energyreactive0_phaseA_fundamental_raw	=
R	32	32	S	0x00000000	Phase A fundamental =
reactive energy accumulation (ADE7878 only).
>>>> 0xE40A	BFVARHR	in_energyreactive0_phaseB_fundamental_raw	=
R	32	32	S	0x00000000	Phase B fundamental =
reactive energy accumulation (ADE7878 only).
>>>> 0xE40B	CFVARHR	in_energyreactive0_phaseC_fundamental_raw	=
R	32	32	S	0x00000000	Phase C fundamental =
reactive energy accumulation (ADE7878 only).
>>>> 0xE40C	AVAHR	in_energyapparent0_phaseA_raw	R	32	=
32	S	0x00000000	Phase A apparent energy accumulation.
>>>> 0xE40D	BVAHR	in_energyapparent0_phaseB_raw	R	32	=
32	S	0x00000000	Phase B apparent energy accumulation.
>>>> 0xE40E	CVAHR	in_energyapparent0_phaseC_raw	R	32	=
32	S	0x00000000	Phase C apparent energy accumulation.
>>>> 0xE500	IPEAK	in_current0_peak	R	32	32	=
U	N/A	Current peak register. See Figure 50 and Table 35 for =
details about its composition. =20
>>> Oh goody. I have no idea how we expose the which phase element of =
this
>>> cleanly.  One option I suppose is to have in_current0_phaseA_peak =
etc
>>> and have all but the current peak return an error when read? It is a =
bit
>>> nasty but only so much we can do and keep with a consistent =
interface.
>>>=20
>>>> 0xE501	VPEAK	in_voltage_peak	R	32	32	U	=
N/A	Voltage peak register. See Figure 50 and Table 36 for details =
about its composition. =20
>>> Same as peak.
>>>=20
>>>> 0xE502	STATUS0	register_STATUS0	R/W	32	32	=
U	N/A	Interrupt Status Register 0. See Table 37.
>>>> 0xE503	STATUS1	register_STATUS1	R/W	32	32	=
U	N/A	Interrupt Status Register 1. See Table 38. =20
>>> No userspace interface except via events interface or error reports.
>>>=20
>>>> 0xE504	AIMAV	in_currentA_mav	R	20	32 ZP	U	=
N/A	Phase A current mean absolute value computed during PSM0 and =
PSM1 modes (ADE7868 and ADE7878 only). =20
>>> Probably a longer name as mav is cryptic.
>>> in_current0_phaseA_meanabs_raw - it could have a scale and all sorts =
of fun.
>>> So I think this needs to be using the new derived infrastructure =
proposed here
>>> rather than being an info_mask element.
>>>=20
>>>> 0xE505	BIMAV	in_currentB_mav	R	20	32 ZP	U	=
N/A	Phase B current mean absolute value computed during PSM0 and =
PSM1 modes (ADE7868 and ADE7878 only).
>>>> 0xE506	CIMAV	in_currentC_mav	R	20	32 ZP	U	=
N/A	Phase C current mean absolute value computed during PSM0 and =
PSM1 modes (ADE7868 and ADE7878 only).
>>>> 0xE507	OILVL	register_OILVL	R/W	24	32 ZP	U	=
0xFFFFFF	Overcurrent threshold.
>>>> 0xE508	OVLVL	register_OVLVL	R/W	24	32 ZP	U	=
0xFFFFFF	Overvoltage threshold. =20
>>> These presumably result in interrupts? (I'm running out of time so =
not checking)
>>> In which case standard event interface should work.
>>>=20
>>>> 0xE509	SAGLVL	register_SAGLVL	R/W	24	32 ZP	U	=
0x000000	Voltage SAG level threshold. =20
>>> That's another event I think...=20
>>>=20
>>>> 0xE50A	MASK0	register_MASK0	R/W	32	32	U	=
0x00000000	Interrupt Enable Register 0. See Table 39.
>>>> 0xE50B	MASK1	register_MASK1	R/W	32	32	U	=
0x00000000	Interrupt Enable Register 1. See Table 40. =20
>>>=20
>>>> 0xE50C	IAWV	in_currentA_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A current.
>>>> 0xE50D	IBWV	in_currentB_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B current.
>>>> 0xE50E	ICWV	in_currentC_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C current.
>>>> 0xE50F	INWV	in_currentN_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of neutral current (ADE7868 =
and ADE7878 only).
>>>> 0xE510	VAWV	in_voltageA_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A voltage.
>>>> 0xE511	VBWV	in_voltageB_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B voltage.
>>>> 0xE512	VCWV	in_voltageC_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C voltage. =20
>>> OK, this is getting silly.  I presume this means the values above =
are filtered and these
>>> aren't?  If so you need to have channels for both and different =
filter values.
>>>=20
>>>> 0xE513	AWATT	in_powerA_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase A total active power.
>>>> 0xE514	BWATT	in_powerB_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase B total active power.
>>>> 0xE515	CWATT	in_powerC_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase C total active power.
>>>> 0xE516	AVAR	in_powerreactiveA_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>>>> 0xE517	BVAR	in_powerreactiveB_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>>>> 0xE518	CVAR	in_powerreactiveC_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>>>> 0xE519	AVA	in_powerapparentA_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A apparent power.
>>>> 0xE51A	BVA	in_powerapparentB_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B apparent power.
>>>> 0xE51B	CVA	in_powerappatentC_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C apparent power. =20=

>>> Same for all of these.
>>>=20
>>>> 0xE51F	CHECKSUM	register_CHECKSUM	R	32	=
32	U	0x33666787	Checksum verification. See the Checksum =
Register section for details. =20
>>> Not exposed to userspace.
>>>=20
>>>> 0xE520	VNOM	in_voltage_rms_nominal	R/W	24	32 ZP	=
S	0x000000	Nominal phase voltage rms used in the =
alternative computation of the apparent power. When the VNOMxEN bit is =
set, the applied voltage input in the corresponding phase is ignored and =
all corresponding rms voltage instances are replaced by the value in the =
VNOM register. =20
>>> Why would this be done?  Sounds like something that is a circuit =
design time
>>> decision so a job for DT to me.
>>>=20
>>>> 0xE600	PHSTATUS	in_current_phase_peak	R	16	=
16	U	N/A	Phase peak register. See Table 41.
>>>> 0xE601	ANGLE0	register_ANGLE0	R	16	16	U	=
N/A	Time Delay 0. See the Time Interval Between Phases section for =
details.
>>>> 0xE602	ANGLE1	register_ANGLE1	R	16	16	U	=
N/A	Time Delay 1. See the Time Interval Between Phases section for =
details.
>>>> 0xE603	ANGLE2	register_ANGLE2	R	16	16	U	=
N/A	Time Delay 2. See the Time Interval Between Phases section for =
details. =20
>>> Hmm. More fun.  These are derived values between to phase =
measurements.=20
>>> The phase as a modifier falls down a bit here - if we had just =
treated
>>> them as channels we could have done this a differential angle =
channel.
>>> Right now I'm not sure how we do this, could do it as a derived =
values so something like
>>> in_angle0_phaseA&phaseB_diff_raw etc but that feels odd.
>>> This one needs more thought.
>>>=20
>>>> 0xE604 to 0xE606	Reserved						=
	These addresses should not be written for proper operation.
>>>> 0xE607	PERIOD	register_PERIOD	R	16	16	U	=
N/A	Network line period. =20
>>> Superficially this sounds like a channel free element so =
shared_by_all.
>>>=20
>>>> 0xE608	PHNOLOAD	register_PHNOLOAD	R	16	=
16	U	N/A	Phase no load register. See Table 42. =20
>>> Hmm. So this is kind of a set of events with but without I think an =
interrupt.
>>> Odd.
>>>=20
>>>> 0xE60C	LINECYC	register_LINECYC	R/W	16	16	=
U	0xFFFF	Line cycle accumulation mode count. =20
>>> in_count0_raw probably though it's a bit of a stretch.
>>>=20
>>>> 0xE60D	ZXTOUT	register_ZXTOUT	R/W	16	16	U	=
0xFFFF	Zero-crossing timeout count. =20
>>> This is going to be another top level one I think and device =
specific for now.
>>>=20
>>>> 0xE60E	COMPMODE	register_COMPMODE	R/W	16	=
16	U	0x01FF	Computation-mode register. See Table 43. =20
>>> If there is stuff to control in here it need breaking out.
>>>=20
>>>> 0xE60F	Gain	register_Gain	R/W	16	16	U	=
0x0000	PGA gains at ADC inputs. See Table 44. =20
>>> Oh goody another scale value. Needs breaking up into separate =
controls.
>>> Do these directly effect the measured output voltage etc? If they do =
then
>>> I'm not sure how to separate the two gains, there ought to be a =
'right'
>>> answer.  If this is about matching to the circuit present then they
>>> should probably be coming from DT or simillar.
>>>=20
>>>=20
>>>> 0xE610	CFMODE	register_CFMODE	R/W	16	16	U	=
0x0E88	CFx configuration register. See Table 45.
>>>> 0xE611	CF1DEN	register_CF1DEN	R/W	16	16	U	=
0x0000	CF1 denominator.
>>>> 0xE612	CF2DEN	register_CF2DEN	R/W	16	16	U	=
0x0000	CF2 denominator.
>>>> 0xE613	CF3DEN	register_CF3DEN	R/W	16	16	U	=
0x0000	CF3 denominator. =20
>>> Are these things that should be in DT?  Look very quickly like they =
are todo with other circuits nearby.
>>>=20
>>>> 0xE614	APHCAL	register_APHCAL	R/W	10	16 ZP	S	=
0x0000	Phase calibration of Phase A. See Table 46.
>>>> 0xE615	BPHCAL	register_BPHCAL	R/W	10	16 ZP	S	=
0x0000	Phase calibration of Phase B. See Table 46.
>>>> 0xE616	CPHCAL	register__CPHCAL	R/W	10	16 ZP	=
S	0x0000	Phase calibration of Phase C. See Table 46. =20
>>> I'm not actually sure how you would set these.  Per circuit design?
>>>=20
>>>> 0xE617	PHSIGN	register_PHSIGN	R	16	16	U	=
N/A	Power sign register. See Table 47.
>>>> 0xE618	CONFIG	register_CONFIG	R/W	16	16	U	=
0x0000	ADE7878 configuration register. See Table 48.
>>>> 0xE700	MMODE	register__MMODE	R/W	8	8	U	=
0x1C	Measurement mode register. See Table 49.
>>>> 0xE701	ACCMODE	register__ACCMODE	R/W	8	8	=
U	0x00	Accumulation mode register. See Table 50.
>>>> 0xE702	LCYCMODE	register_LCYCMODE	R/W	8	=
8	U	0x78	Line accumulation mode behavior. See Table 52.
>>>> 0xE703	PEAKCYC	register_PEAKCYC	R/W	8	8	=
U	0x00	Peak detection half line cycles.
>>>> 0xE704	SAGCYC	register_SAGCYC	R/W	8	8	U	=
0x00	SAG detection half line cycles. =20
>>> Some of these are event controls. Map them as such.
>>>=20
>>>> 0xE705	CFCYC	register_CFCYC	R/W	8	8	U	=
0x01	Number of CF pulses between two consecutive energy latches. See =
the Synchronizing Energy Registers with CFx Outputs section.
>>>> 0xE706	HSDC_CFG	register_HSDC_CFG	R/W	8	=
8	U	0x00	HSDC configuration register. See Table 53.
>>>> 0xE707	Version	register_Version	R	8	8	=
U		Version of die.
>>>> 0xEBFF	Reserved			8	8			=
This address can be used in manipulating the SS/HSA pin when SPI is =
chosen as the active port. See the Serial Interfaces section for =
details.
>>>> 0xEC00	LPOILVL	register_LPOILVL	R/W	8	8	=
U	0x07	"Overcurrent threshold used during PSM2 mode (ADE7868 =
and ADE7878
>>>> only). See Table 54 in which the register is detailed."
>>>> 0xEC01	CONFIG2	register_CONFIG2	R/W	8	8	=
U	0x00	Configuration register used during PSM1 mode. See Table =
55. =20
>>>=20
>>> As you can guess I was running out of stamina towards the end of =
that.
>>>=20
>>> I'm not totally sure of the answer I provided. It may take some more =
thought.
>>> Ideally some others will give input on this question.
>>>=20
>>> Jonathan =20
>>>>=20
>>>> Regards,
>>>> John
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>> On Mar 17, 2018, at 1:30 PM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>>>>>=20
>>>>> On Wed, 14 Mar 2018 23:12:02 -0700
>>>>> John Syne <john3909@gmail.com> wrote:
>>>>>=20
>>>>>> Hi Jonathan,
>>>>>>=20
>>>>>> I have been looking at the IIO ABI docs and if I understand
>>>>>> correctly, the idea is to use consistent naming conventions? So =
for
>>>>>> example, looking at the ADE7854 datasheet, the naming matching =
the
>>>>>> ADE7854 registers would be as follows:   =20
>>>>>=20
>>>>> Welcome to one of the big reasons no one tidied these drivers
>>>>> up originally.  Still we have moved on somewhat since then
>>>>> so similar circumstances have come up in other types of sensor.
>>>>>=20
>>>>>>=20
>>>>>> {direction}_{type}_{index}_{modifier}_{info_mask}
>>>>>>=20
>>>>>> AIGAIN	-	In_current_a_gain   =20
>>>>> Other than the fact that gain isn't an ABI element and that index
>>>>> doesn't have
>>>>> _ before it that is right.
>>>>> in_voltageA_scale
>>>>>=20
>>>>> That was a weird quirk a long time back which we should probably
>>>>> not have done (copied it from hwmon)
>>>>>=20
>>>>>> AVGAIN	-	in_voltage_a_gain
>>>>>> BIGAIN	-	in_current_b_gain
>>>>>> BVGAIN	-	in_voltage_b_gain
>>>>>> =E2=80=94
>>>>>> How do we represent the rms and offset
>>>>>> AIRMSOS	-	in_current_a_rmsoffset
>>>>>> AVRMSOS	-	in_voltage_a_rmsoffset   =20
>>>>>=20
>>>>> Right now we can't unfortunately though this one is easier to fix.
>>>>> We already have modifiers for multi axis devices doing sum_squared
>>>>> so add one of those for root_mean_square - this one is well known
>>>>> enough that rms is fine in the string.
>>>>>=20
>>>>> It's a effectively a different channel be it one derived from a =
simple
>>>>> one.  This is going to get tricky however as we would normally use
>>>>> modifier to specialise a channel type - thoughts on this below.
>>>>>=20
>>>>>> =E2=80=94
>>>>>> Here I don=E2=80=99t understand how to represent both the phase =
and the active/reactive/apparent power components. Do we combine the =
phase and quadrature part like this
>>>>>> AVAGAIN		-	in_power_a_gain				=
/* apparent power */
>>>>>> =E2=80=94
>>>>>> AWGAIN		-	in_power_ai_gain				=
/* active power */   =20
>>>>> And that is the problem.  How do we represent the various power =
types.
>>>>> Hmm. We could do it with modifiers but above we show that we have =
already used them.
>>>>>=20
>>>>> It would be easy enough to add yet another field to the channel =
spec to specify
>>>>> this but there is a problem - Events.  The event format is already =
pretty full
>>>>> so where do we put this extra element if we need to define a =
channel separated
>>>>> only by it.
>>>>>=20
>>>>> One thought is we could instead define these as different top =
level
>>>>> IIO_CHAN_TYPES in a similar fashion to we do for relative humidity =
vs
>>>>> the proposed absolute humidity.
>>>>>=20
>>>>> in_powerreactiveA_scale
>>>>> in_poweractivceA_scale
>>>>> (or in_powerrealA_scale to match with what I got taught years =
ago?)
>>>>>=20
>>>>> I presume we keep in_powerA_scale etc for the apparent power and
>>>>> modify any docs to make that clear.
>>>>>=20
>>>>>> =E2=80=94
>>>>>> AVARGAIN	-	in_power_aq_gain				=
/* reactive power */
>>>>>> =E2=80=94
>>>>>> Now here it becomes more complicated. Not sure how this gets =
handled.=20
>>>>>> AFWATTOS	-	in_power_a_active/fundamental/offset   =20
>>>>> Yeah, some of these are getting odd.
>>>>> If I read this correctly this is the active power estimate based =
on only
>>>>> the fundamental frequency - so no harmonics?
>>>>>=20
>>>>> Hmm.  This then becomes a separate channel with additional =
properties
>>>>> specifying it is only the fundamental.  This feels a bit like a =
filter
>>>>> be it an unusual one?  Might just be necessary to add a =
_fundamental_only
>>>>> element on the end (would be info_mask if this is common enough to
>>>>> justify that rather than using the extended methods to define =
it.).
>>>>>=20
>>>>>=20
>>>>>> =E2=80=94
>>>>>> AWATTHR	-	in_energy_ai_accumulation   =20
>>>>> Great, just when I thought we had gone far enough they define =
reactive
>>>>> energy which is presumably roughly the same as reactivepower * =
time?
>>>>> In that case we need types for that as well.
>>>>> in_energyreactiveA_*
>>>>> in_energyactiveA_*
>>>>>=20
>>>>>> =E2=80=94
>>>>>> AVARHR		-	in_energy_aq_accumulation
>>>>>> =E2=80=94
>>>>>> IPEAK		-	in_current_peak   =20
>>>>> That one is easy as we have an info_mask element for peak and one
>>>>> for peak_scale that has always been a bit odd but was needed =
somewhere.
>>>>>=20
>>>>>> =E2=80=94
>>>>>>=20
>>>>>> I=E2=80=99ll leave it there, because there are some even more =
complicated register naming issues.   =20
>>>>> Something to look forward to.  Gah, I always hated power =
engineering
>>>>> though I taught it very briefly (I really pity those students :(
>>>>>=20
>>>>> Jonathan
>>>>>=20
>>>>>>=20
>>>>>> Regards,
>>>>>> John
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On Mar 10, 2018, at 7:10 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>>>>>>>=20
>>>>>>> On Thu, 8 Mar 2018 21:37:33 -0300
>>>>>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>>>>>>>=20
>>>>>>>> On 03/07, Jonathan Cameron wrote:     =20
>>>>>>>>> On Tue, 6 Mar 2018 21:43:47 -0300
>>>>>>>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>>>>>>>>>=20
>>>>>>>>>> The macro IIO_DEV_ATTR_CH_OFF is a wrapper for =
IIO_DEVICE_ATTR, with a
>>>>>>>>>> tiny change in the name definition. This extra macro does not =
improve
>>>>>>>>>> the readability and also creates some checkpatch errors.
>>>>>>>>>>=20
>>>>>>>>>> This patch fixes the checkpatch.pl errors:
>>>>>>>>>>=20
>>>>>>>>>> staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal =
(0777) not
>>>>>>>>>> decimal permissions
>>>>>>>>>> staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal =
(0777) not
>>>>>>>>>> decimal permissions
>>>>>>>>>> staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal =
(0777) not
>>>>>>>>>> decimal permissions
>>>>>>>>>> staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal =
(0777) not
>>>>>>>>>> decimal permissions
>>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Rodrigo Siqueira =
<rodrigosiqueiramelo@gmail.com>       =20
>>>>>>>>>=20
>>>>>>>>> Hmm. I wondered a bit about this one. It's a correct patch in =
of
>>>>>>>>> itself but the interface in question doesn't even vaguely =
conform
>>>>>>>>> to any of defined IIO ABI.  Anyhow, it's still and improvement =
so
>>>>>>>>> I'll take it.       =20
>>>>>>>>=20
>>>>>>>> I am not sure if I understood the comment about the ABI. The =
meter
>>>>>>>> interface is wrong because it uses things like IIO_DEVICE_ATTR? =
It
>>>>>>>> should use iio_info together with *write_raw and *read_raw. =
Right? Is it
>>>>>>>> the ABI problem that you refer?     =20
>>>>>>> The ABI is about the userspace interface of IIO.  It is defined
>>>>>>> in Documentation/ABI/testing/sysfs-bus-iio*
>>>>>>> So this documents the naming of sysfs attributes and (more or =
less)
>>>>>>> describes a consistent interface to userspace across lots of =
different
>>>>>>> types of devices.
>>>>>>>=20
>>>>>>> A lot of these older drivers in staging involve a good deal of =
ABI that
>>>>>>> was not reviewed or discussed.  That is one of the biggest =
reasons we
>>>>>>> didn't take them out of staging in the first place.
>>>>>>>=20
>>>>>>> In order for generic userspace programs to have any idea what to =
do
>>>>>>> with these devices this all needs to be fixed.
>>>>>>>=20
>>>>>>> There may well be cases where we need to expand the existing ABI =
to
>>>>>>> cover new things.   That's fine, but it has to be done with full
>>>>>>> review of the relevant documentation patches.
>>>>>>>=20
>>>>>>> Incidentally if you want an easy driver to work on moving out of =
staging
>>>>>>> then first thing to do is to compare what it shows to userspace =
with these
>>>>>>> docs.  If it's totally different then you have a big job on your =
hands
>>>>>>> as often ABI can take a lot of discussion and a long time to =
establish
>>>>>>> a consensus.
>>>>>>>=20
>>>>>>> Jonathan
>>>>>>>=20
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Thanks :)
>>>>>>>>=20
>>>>>>>>> Applied to the togreg branch of iio.git and pushed out as =
testing
>>>>>>>>> for the autobuilders to play with it.
>>>>>>>>>=20
>>>>>>>>> I also added the removal of the header define which is no
>>>>>>>>> longer used.
>>>>>>>>>=20
>>>>>>>>> Please note, following discussions with Michael, I am going to =
send
>>>>>>>>> an email announcing an intent to drop these meter drivers next
>>>>>>>>> cycle unless someone can provide testing for any attempt to
>>>>>>>>> move them out of staging.  I'm still taking patches on the =
basis
>>>>>>>>> that 'might' happen - but I wouldn't focus on these until we
>>>>>>>>> have some certainty on whether they will be around long term!
>>>>>>>>>=20
>>>>>>>>> Jonathan
>>>>>>>>>=20
>>>>>>>>>> ---
>>>>>>>>>> drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
>>>>>>>>>> drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
>>>>>>>>>> 2 files changed, 20 insertions(+), 16 deletions(-)
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/drivers/staging/iio/meter/ade7753.c =
b/drivers/staging/iio/meter/ade7753.c
>>>>>>>>>> index c44eb577dc35..275e8dfff836 100644
>>>>>>>>>> --- a/drivers/staging/iio/meter/ade7753.c
>>>>>>>>>> +++ b/drivers/staging/iio/meter/ade7753.c
>>>>>>>>>> @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
>>>>>>>>>> 		ade7753_read_16bit,
>>>>>>>>>> 		NULL,
>>>>>>>>>> 		ADE7753_PERIOD);
>>>>>>>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>>>>>>>> -		ade7753_read_8bit,
>>>>>>>>>> -		ade7753_write_8bit,
>>>>>>>>>> -		ADE7753_CH1OS);
>>>>>>>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>>>>>>>> -		ade7753_read_8bit,
>>>>>>>>>> -		ade7753_write_8bit,
>>>>>>>>>> -		ADE7753_CH2OS);
>>>>>>>>>> +
>>>>>>>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>>>>>>>> +			ade7753_read_8bit,
>>>>>>>>>> +			ade7753_write_8bit,
>>>>>>>>>> +			ADE7753_CH1OS);
>>>>>>>>>> +
>>>>>>>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>>>>>>>> +			ade7753_read_8bit,
>>>>>>>>>> +			ade7753_write_8bit,
>>>>>>>>>> +			ADE7753_CH2OS);
>>>>>>>>>>=20
>>>>>>>>>> static int ade7753_set_irq(struct device *dev, bool enable)
>>>>>>>>>> {
>>>>>>>>>> diff --git a/drivers/staging/iio/meter/ade7759.c =
b/drivers/staging/iio/meter/ade7759.c
>>>>>>>>>> index 1decb2b8afab..c078b770fa53 100644
>>>>>>>>>> --- a/drivers/staging/iio/meter/ade7759.c
>>>>>>>>>> +++ b/drivers/staging/iio/meter/ade7759.c
>>>>>>>>>> @@ -328,14 +328,16 @@ static =
IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>>>>>>>>>> 		ade7759_read_16bit,
>>>>>>>>>> 		ade7759_write_16bit,
>>>>>>>>>> 		ADE7759_APGAIN);
>>>>>>>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>>>>>>>> -		ade7759_read_8bit,
>>>>>>>>>> -		ade7759_write_8bit,
>>>>>>>>>> -		ADE7759_CH1OS);
>>>>>>>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>>>>>>>> -		ade7759_read_8bit,
>>>>>>>>>> -		ade7759_write_8bit,
>>>>>>>>>> -		ADE7759_CH2OS);
>>>>>>>>>> +
>>>>>>>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>>>>>>>> +			ade7759_read_8bit,
>>>>>>>>>> +			ade7759_write_8bit,
>>>>>>>>>> +			ADE7759_CH1OS);
>>>>>>>>>> +
>>>>>>>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>>>>>>>> +			ade7759_read_8bit,
>>>>>>>>>> +			ade7759_write_8bit,
>>>>>>>>>> +			ADE7759_CH2OS);
>>>>>>>>>>=20
>>>>>>>>>> static int ade7759_set_irq(struct device *dev, bool enable)
>>>>>>>>>> {       =20
>>>>>>>>>=20
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe =
linux-iio" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  =
http://vger.kernel.org/majordomo-info.html     =20
>>>>>>>=20
>>>>>>> _______________________________________________
>>>>>>> devel mailing list
>>>>>>> devel@linuxdriverproject.org
>>>>>>> =
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel =
    =20


--Apple-Mail=_26FE8CBF-2E74-449F-9637-902B29F073EA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><blockquote type=3D"cite" class=3D""><div class=3D"">On =
Mar 24, 2018, at 8:18 AM, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org" class=3D"">jic23@kernel.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Mon, 19 Mar 2018 23:28:45 =
-0700</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">John Syne &lt;</span><a =
href=3D"mailto:john3909@gmail.com" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">john3909@gmail.com</a><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">&gt; wrote:</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">Hi Jonathan,<br class=3D""><br=
 class=3D"">I broke out the =
{Direction}_{Type}_{Index}_{Modifier}_{Info_Mask} into separate columns =
to make sure I understand your instructions. Good way to check the =
results.<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""><br class=3D"">Probably easier to copy and paste this table =
into a spreadsheet. Let me know if there is anything I got wrong. Thank =
you again for all your help.<br class=3D""></blockquote><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">Yeah, we need to shrink this if =
we do it again.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""></div></blockquote>I=E2=80=99l=
l send an updated copy after this e-mail. Can you accept a =
spreadsheet&nbsp;</div><div>attachment or a CSV file?<br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Can drop anything not related to ABI (so RW mask =
address etc and just have the</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">register name and the bits =
around ABI.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""></div></blockquote>Done<br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Note I mentioned the altvoltage stuff in the =
previous email, so we need</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">to think about whether that is =
useful to distinguish the instantaneous</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">measurements from the multi =
cycle AC ones.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Actually I think we are fine here as we =
explicitly describe all<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">alt measurements as mav or rms which going to be =
handled in our</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">new computedvalue description.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote>Yeah, I don=E2=80=99t see how anyone would =
use these registers, so I propose</div><div>we just drop them.<br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">Address<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Register<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>IIO Attribute<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Device Tree or Code<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Direction<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Type<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Index<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Modifier<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Info Mask<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Bit =
Length<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Bit Length During Communications<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Type<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Default Value<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Description<br class=3D"">0x4380<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AIGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A current gain adjust.<br =
class=3D"">0x4381<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A voltage gain adjust.<br =
class=3D"">0x4382<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BIGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B current gain adjust.<br =
class=3D"">0x4383<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BVGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B voltage gain adjust.<br =
class=3D"">0x4384<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CIGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C current gain adjust.<br =
class=3D"">0x4385<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CVGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C voltage gain adjust.<br =
class=3D"">0x4386<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>NIGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_neutral_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>neutral<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Neutral current gain adjust =
(ADE7868 and ADE7878 only).<br class=3D"">0x4387<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AIRMSOS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseA_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A current rms offset.<br =
class=3D"">0x4388<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVRMSOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_voltage0_phaseA_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A voltage rms offset.<br =
class=3D"">0x4389<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BIRMSOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_current0_phaseB_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B current rms offset.<br =
class=3D"">0x438A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BVRMSOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_voltage0_phaseB_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B voltage rms offset.<br =
class=3D"">0x438B<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CIRMSOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_current0_phaseC_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C current rms offset.<br =
class=3D"">0x438C<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CVRMSOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_voltage0_phaseC_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C voltage rms offset.<br =
class=3D"">0x438D<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>NIRMSOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_current0_neutral_rms_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>neutral<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Neutral current rms offset =
(ADE7868 and ADE7878 only).<br class=3D"">0x438E<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AVAGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerapparent0_phaseA_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerapparent<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A apparent power gain =
adjust.<br class=3D"">0x438F<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BVAGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerapparent0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>powerapparent<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B apparent power gain =
adjust.<br class=3D"">0x4390<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CVAGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerapparent0_phaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>powerapparent<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C apparent power gain =
adjust.<br class=3D"">0x4391<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AWGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>power<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>phaseA<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A total active power gain =
adjust.<br class=3D"">0x4392<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AWATTOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseA_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>power<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>phaseA<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A total active power offset =
adjust.<br class=3D"">0x4393<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BWGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>power<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>phaseB<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B total active power gain =
adjust.<br class=3D"">0x4394<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BWATTOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseB_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>power<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>phaseB<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B total active power offset =
adjust.<br class=3D"">0x4395<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CWGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_PhaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>power<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>phaseC<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C total active power gain =
adjust.<br class=3D"">0x4396<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CWATTOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseC_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>power<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>phaseC<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C total active power offset =
adjust.<br class=3D"">0x4397<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AVARGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>powerreactive<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A total reactive power gain =
adjust (ADE7858, ADE7868, and ADE7878).<br class=3D"">0x4398<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AVAROS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseA_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>powerreactive<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A total reactive power =
offset adjust (ADE7858, ADE7868, and ADE7878).<br class=3D"">0x4399<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BVARGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerreactive0_phaseB_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B total reactive power gain =
adjust (ADE7858, ADE7868, and ADE7878).<br class=3D"">0x439A<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BVAROS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseB_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>powerreactive<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B total reactive power =
offset adjust (ADE7858, ADE7868, and ADE7878).<br class=3D"">0x439B<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CVARGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerreactive0_phaseC_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>scale<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C total reactive power gain =
adjust (ADE7858, ADE7868, and ADE7878).<br class=3D"">0x439C<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CVAROS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseC_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>powerreactive<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C total reactive power =
offset adjust (ADE7858, ADE7868, and ADE7878).<br class=3D"">0x439D<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AFWGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseA_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>scale<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental active power gain adjust. Location =
reserved for ADE7854, ADE7858, and ADE7868.<br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Hmm. Fundamental needs to be represented =
using a separate channel index</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">and description of the frequency =
filters applied. &nbsp;That should map it</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">a generic way.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote>How do I do this?<br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">I assume we will at some point have =
fundamental RMS?</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">0x439E<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AFWATTOS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseA_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental active power offset adjust. Location =
reserved for ADE7854, ADE7858, and ADE7868.<br class=3D"">0x439F<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BFWGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseB_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>scale<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B fundamental active power gain adjust (ADE7878 =
only).<br class=3D"">0x43A0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BFWATTOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseB_fundamental_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>power<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>phaseB_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B fundamental active power =
offset adjust (ADE7878 only).<br class=3D"">0x43A1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CFWGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseC_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>scale<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C fundamental active power gain adjust.<br =
class=3D"">0x43A2<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CFWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_power0_phaseC_fundamental_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>power<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>phaseC_fundamental<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>offset<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C fundamental active power =
offset adjust (ADE7878 only).<br class=3D"">0x43A3<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AFVARGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerreactive0_phaseA_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>scale<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental reactive power gain adjust (ADE7878 =
only).<br class=3D"">0x43A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AFVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseA_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental reactive power offset adjust (ADE7878 =
only).<br class=3D"">0x43A5<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BFVARGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseB_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseB_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>scale<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B fundamental reactive power gain adjust (ADE7878 =
only).<br class=3D"">0x43A6<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BFVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseB_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseB_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B fundamental reactive power offset adjust (ADE7878 =
only).<br class=3D"">0x43A7<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CFVARGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseC_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseC_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>scale<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C fundamental reactive power gain adjust (ADE7878 =
only).<br class=3D"">0x43A8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CFVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseC_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseC_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C fundamental reactive power offset adjust (ADE7878 =
only).<br class=3D""></blockquote><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">=46rom further versions drop =
anything we aren't exposing to userspace. Makes this easier to =
read.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""></div></blockquote>Done<br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">0x43A9<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VATHR1<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VATHR1<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Most significant 24 bits of VATHR[47:0] threshold used in =
phase apparent power datapath.<br class=3D"">0x43AA<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VATHR0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VATHR0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Less significant 24 bits of VATHR[47:0] threshold used in =
phase apparent power datapath.<br class=3D"">0x43AB<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>WTHR1<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>WTHR1<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Most significant 24 bits of WTHR[47:0] threshold used in =
phase total/fundamental active power datapath.<br class=3D"">0x43AC<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>WTHR0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>WTHR0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Less significant 24 bits of WTHR[47:0] threshold used in =
phase total/fundamental active power datapath.<br class=3D"">0x43AD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VARTHR1<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>VARTHR1<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Most significant 24 bits of =
VARTHR[47:0] threshold used in phase total/fundamental reactive power =
datapath (ADE7858, ADE7868, and ADE7878).<br class=3D"">0x43AE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VARTHR0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>VARTHR0<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Less significant 24 bits of =
VARTHR[47:0] threshold used in phase total/fundamental reactive power =
datapath (ADE7858, ADE7868, and ADE7878).<br class=3D"">0x43AF<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Reserved<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Reserved<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>This =
memory location should be kept at 0x000000 for proper operation.<br =
class=3D"">0x43B0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>VANOLOAD<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VANOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>No load threshold in the apparent power datapath.<br =
class=3D"">0x43B1<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>APNOLOAD<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>APNOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>No load threshold in the total/fundamental active power =
datapath.<br class=3D"">0x43B3<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VLEVEL<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VLEVEL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Register used in the algorithm =
that computes the fundamental active and reactive powers (ADE7878 =
only).<br class=3D"">0x43B5<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>DICOEFF<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DICOEFF<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Register used in the digital =
integrator algorithm. If the integrator is turned on, it must be set at =
0xFF8000. In practice, it is transmitted as 0xFFF8000.<br =
class=3D"">0x43B6<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>HPFDIS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>HPFDIS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Disables/enables the HPF in the =
current datapath (see Table 34).<br class=3D"">0x43B8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ISUMLVL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ISUMLVL<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Threshold used in comparison =
between the sum of phase currents and the neutral current (ADE7868 and =
ADE7878 only).<br class=3D"">0x43BF<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ISUM<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_current0_phaseA&amp;phaseB&amp;phaseC_sum<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseA&amp;phaseB&amp;phaseC<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>sum<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>28<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Sum of IAWV, IBWV, and ICWV =
registers (ADE7868 and ADE7878 only).<br class=3D""></blockquote><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">Hehe, I'll get compaints about =
defining very long ABI again. &nbsp;Pah, it says what</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">it does on the tin.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">0x43C0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AIRMS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseA_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA_rms<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A current rms value.<br class=3D""></blockquote><span=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">in_current0_phaseA_rms_raw as =
otherwise we don't know we need to apply</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">in_current0_phaseA_rms_scale to =
it (or the shared value that maps to that).</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote>Yeah, this is still confusion to me. This =
should read in_current0_phaseA_rms_gain&nbsp;</div><div>as it directly =
affects the value in_current0_phaseA_rms_raw. We still have to =
apply</div><div>a scale value to turn this cryptic number into something =
meaningful.&nbsp;<br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">0x43C1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AVRMS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage0_phaseA_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA_rms<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A voltage rms value.<br class=3D"">0x43C2<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BIRMS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseB_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB_rms<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B current rms value.<br class=3D"">0x43C3<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BVRMS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage0_phaseB_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB_rms<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B voltage rms value.<br class=3D"">0x43C4<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CIRMS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseC_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC_rms<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C current rms value.<br class=3D"">0x43C5<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CVRMS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage0_phaseC_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC_rms<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C voltage rms value.<br class=3D"">0x43C6<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>NIRMS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_neutral_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>neutral_rms<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Neutral current rms value (ADE7868 and ADE7878 only).<br =
class=3D"">0xE228<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Run<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Code<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Run register starts and stops the DSP. See the Digital =
Signal Processor section for more details.<br class=3D"">0xE400<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AWATTHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energy0_phaseA_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energy<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A total active energy accumulation.<br =
class=3D"">0xE401<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BWATTHR<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_energy0_phaseB_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energy<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B total active energy accumulation.<br =
class=3D"">0xE402<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CWATTHR<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_energy0_phaseC_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energy<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C total active energy accumulation.<br =
class=3D"">0xE403<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AFWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_energy0_phaseA_fundamental_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energy<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase A =
fundamental active energy accumulation (ADE7878 only).<br =
class=3D"">0xE404<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BFWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_energy0_phaseB_fundamental_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energy<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase B =
fundamental active energy accumulation (ADE7878 only).<br =
class=3D"">0xE405<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CFWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_energy0_phaseC_fundamental_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energy<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase C =
fundamental active energy accumulation (ADE7878 only).<br =
class=3D"">0xE406<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVARHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energyreactive0_phaseA_raw<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energyreactive<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).<br class=3D"">0xE407<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BVARHR<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyreactive0_phaseB_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energyreactive<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).<br class=3D"">0xE408<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CVARHR<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyreactive0_phaseC_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energyreactive<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C total reactive energy accumulation (ADE7858, =
ADE7868, and ADE7878 only).<br class=3D"">0xE409<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AFVARHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energyreactive0_phaseA_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>energyreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseA_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase A =
fundamental reactive energy accumulation (ADE7878 only).<br =
class=3D"">0xE40A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BFVARHR<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_energyreactive0_phaseB_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>energyreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseB_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase B =
fundamental reactive energy accumulation (ADE7878 only).<br =
class=3D"">0xE40B<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CFVARHR<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_energyreactive0_phaseC_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>energyreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseC_fundamental<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase C =
fundamental reactive energy accumulation (ADE7878 only).<br =
class=3D"">0xE40C<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVAHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energyapparent0_phaseA_raw<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energyapparent<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A apparent energy accumulation.<br =
class=3D"">0xE40D<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BVAHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energyapparent0_phaseB_raw<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energyapparent<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B apparent energy accumulation.<br =
class=3D"">0xE40E<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CVAHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energyapparent0_phaseC_raw<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>energyapparent<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C apparent energy accumulation.<br =
class=3D"">0xE500<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>IPEAK<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_peak<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>peak<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Current =
peak register. See Figure 50 and Table 35 for details about its =
composition.<br class=3D"">0xE501<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VPEAK<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>in_voltage0_peak<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>peak<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Voltage peak register. See Figure 50 and Table 36 for =
details about its composition.<br class=3D""></blockquote><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">0xE502<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>STATUS0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mapped to events<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>event<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>status<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Interrupt =
Status Register 0. See Table 37.<br class=3D"">0xE503<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>STATUS1<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mapped to events<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>event<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>status<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Interrupt =
Status Register 1. See Table 38.<br class=3D"">0xE504<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AIMAV<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseA_mav<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA_mav<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>20<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A current mean absolute value computed during PSM0 =
and PSM1 modes (ADE7868 and ADE7878 only).<br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">in_current0_phaseA_mav_raw</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">0xE505<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BIMAV<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseB_mav<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB_mav<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>20<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B current mean absolute value computed during PSM0 =
and PSM1 modes (ADE7868 and ADE7878 only).<br class=3D"">0xE506<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CIMAV<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseC_mav<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC_mav<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>20<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C current mean absolute value computed during PSM0 =
and PSM1 modes (ADE7868 and ADE7878 only).<br class=3D"">0xE507<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>OILVL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>OILVL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xFFFFFF<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Overcurrent threshold.<br class=3D"">0xE508<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>OVLVL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>OVLVL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xFFFFFF<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Overvoltage threshold.<br class=3D"">0xE509<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>SAGLVL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>SAGLVL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>24<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Voltage SAG level threshold.<br class=3D"">0xE50A<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MASK0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_mask0_raw<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mask<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>raw<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x00000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Interrupt Enable Register 0. See =
Table 39.<br class=3D"">0xE50B<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>MASK1<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>in_mask1_raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>mask<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Interrupt Enable Register 1. See Table 40.<br =
class=3D"">0xE50C<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>IAWV<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseA_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase A =
current.<br class=3D""></blockquote><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">As mentioned before. This is the =
'expectation' for in_currentX</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">So it is the other case we need =
to represent by describing filtering</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">or using the altvoltage =
equivalent.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">0xE50D<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>IBWV<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseB_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>instantaneous<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 SE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Instantaneous value of Phase B current.<br =
class=3D"">0xE50E<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ICWV<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseC_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>current<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase C =
current.<br class=3D"">0xE50F<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>INWV<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_current0_phaseN_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>current<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>neutral<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of neutral =
current (ADE7868 and ADE7878 only).<br class=3D"">0xE510<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>VAWV<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage0_phaseA_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>instantaneous<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 SE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Instantaneous value of Phase A voltage.<br =
class=3D"">0xE511<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>VBWV<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>voltage<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase B =
voltage.<br class=3D"">0xE512<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VCWV<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_voltage0_phaseC_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>instantaneous<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 SE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Instantaneous value of Phase C voltage.<br =
class=3D"">0xE513<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AWATT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseA_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>instantaneous<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 SE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Instantaneous value of Phase A total active power.<br =
class=3D"">0xE514<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BWATT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>instantaneous<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 SE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Instantaneous value of Phase B total active power.<br =
class=3D"">0xE515<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CWATT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseC_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>power<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>instantaneous<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 SE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Instantaneous value of Phase C total active power.<br =
class=3D"">0xE516<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVAR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerreactive0_phaseA_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase A =
total reactive power (ADE7858, ADE7868, and ADE7878 only).<br =
class=3D"">0xE517<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BVAR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerreactive0_phaseB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase B =
total reactive power (ADE7858, ADE7868, and ADE7878 only).<br =
class=3D"">0xE518<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CVAR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerreactive0_phaseC_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerreactive<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase C =
total reactive power (ADE7858, ADE7868, and ADE7878 only).<br =
class=3D"">0xE519<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVA<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerapparent0_phaseA_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerapparent<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseA<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase A =
apparent power.<br class=3D"">0xE51A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BVA<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_powerapparent0_phaseB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerapparent<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseB<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase B =
apparent power.<br class=3D"">0xE51B<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CVA<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_powerappatent0_phaseC_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>powerapparent<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>phaseC<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase C =
apparent power.<br class=3D"">0xE51F<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CHECKSUM<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_CHECKSUM<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Code<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x33666787<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Checksum =
verification. See the Checksum Register section for details.<br =
class=3D"">0xE520<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>VNOM<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phase_rms_nominal<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>voltage<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>phase_rms<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>nominal<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Nominal phase voltage rms used in =
the alternative computation of the apparent power. When the VNOMxEN bit =
is set, the applied voltage input in the corresponding phase is ignored =
and all corresponding rms voltage instances are replaced by the value in =
the VNOM register.<br class=3D""></blockquote><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">This one is an oddity. &nbsp;I'm not sure =
we want to expose it to userspace at all.</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote>We could just move this to DT. Not sure if =
a user would need to set this from a&nbsp;</div><div>user space app.<br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">0xE600<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>PHSTATUS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>mapped to events<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>event<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase peak register. See Table =
41.<br class=3D"">0xE601<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ANGLE0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ANGLE0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Time Delay 0. See the Time Interval Between Phases section for =
details.<br class=3D"">0xE602<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ANGLE1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ANGLE1<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Time Delay 1. See the Time Interval Between Phases section for =
details.<br class=3D"">0xE603<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ANGLE2<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ANGLE2<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Time Delay 2. See the Time Interval Between Phases section for =
details.<br class=3D"">0xE604 to 0xE606<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Reserved<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>These =
addresses should not be written for proper operation.<br =
class=3D"">0xE607<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PERIOD<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_period_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>period<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Network =
line period.<br class=3D"">0xE608<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>PHNOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>mapped to =
events<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>event<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Phase no load register. See Table 42.<br class=3D"">0xE60C<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>LINECYC<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_count0_cycle<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>count<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>cycle<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0xFFFF<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Line =
cycle accumulation mode count.<br class=3D"">0xE60D<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ZXTOUT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ZXTOUT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0xFFFF<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Zero-crossing timeout count.<br class=3D"">0xE60E<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>COMPMODE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>COMPMODE<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>DT<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x01FF<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Computation-mode register. See Table 43.<br class=3D"">0xE60F<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Gain<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Gain<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>PGA gains at ADC inputs. See Table 44.<br class=3D"">0xE610<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CFMODE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CFMODE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0E88<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CFx configuration register. See Table 45.<br class=3D"">0xE611<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CF1DEN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CF1DEN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CF1 denominator.<br class=3D"">0xE612<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>CF2DEN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CF2DEN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CF2 denominator.<br class=3D"">0xE613<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>CF3DEN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CF3DEN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CF3 denominator.<br class=3D"">0xE614<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>APHCAL<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>APHCAL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>10<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>16 ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Phase calibration of Phase A. See Table 46.<br =
class=3D"">0xE615<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BPHCAL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BPHCAL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>10<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase calibration of Phase B. See Table 46.<br =
class=3D"">0xE616<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CPHCAL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CPHCAL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>10<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase calibration of Phase C. See Table 46.<br =
class=3D"">0xE617<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PHSIGN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PHSIGN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Power sign register. See Table 47.<br =
class=3D"">0xE618<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CONFIG<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CONFIG<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ADE7878 configuration register. See Table 48.<br =
class=3D"">0xE700<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>MMODE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>MMODE<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x1C<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Measurement mode register. See Table 49.<br =
class=3D"">0xE701<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ACCMODE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>ACCMODE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x00<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Accumulation mode register. See Table 50.<br =
class=3D"">0xE702<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>LCYCMODE<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>LCYCMODE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0x78<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Line =
accumulation mode behavior. See Table 52.<br class=3D"">0xE703<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>PEAKCYC<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PEAKCYC<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x00<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Peak detection half line cycles.<br class=3D"">0xE704<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>SAGCYC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>SAGCYC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>8<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>8<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>SAG detection half line cycles.<br class=3D"">0xE705<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CFCYC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CFCYC<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>8<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>8<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x01<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Number of CF pulses between two consecutive energy latches. See =
the Synchronizing Energy Registers with CFx Outputs section.<br =
class=3D"">0xE706<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>HSDC_CFG<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>HSDC_CFG<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>0x00<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>HSDC =
configuration register. See Table 53.<br class=3D"">0xE707<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Version<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_version_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>version<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Version =
of die.<br class=3D"">0xEBFF<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Reserved<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>DT<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>in<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>8<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>This =
address can be used in manipulating the SS/HSA pin when SPI is chosen as =
the active port. See the Serial Interfaces section for details.<br =
class=3D"">0xEC00<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>LPOILVL<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>LPOILVL<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x07<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>"Overcurrent threshold used during PSM2 mode (ADE7868 and =
ADE7878 only). See Table 54 in which the register is detailed.=E2=80=9D<br=
 class=3D"">0xEC01<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CONFIG2<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>CONFIG2<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>DT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x00<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Configuration register used during PSM1 mode. See Table =
55.<br class=3D""></blockquote><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">So other than fundamental, =
instantaneous and the distinction between</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">what would be considered DC =
measurements and AC ones (over several cycles)</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">that all looks good to me ;)</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">So in brief, I don't think we need instantaneous =
at all.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""></div></blockquote>Agreed<br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Fundamental should be done as a parallel channel =
(different index)</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">with the filters described to make it =
fundamental only.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""></div></blockquote>How do I =
do this. Is there a good implementation of this anywhere?<br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">So next step may be proposing the core changes =
to add the</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">handling for computed values and change =
the events description</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">to allow for events based on =
them. &nbsp;We do that with some</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">examples added to the dummy =
driver (so anyone can play with it</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">without hardware). &nbsp;After =
that we can start moving the</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">driver over by adding the basic =
channels and then building</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">up to support all the oddities =
(dropping the custom</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">attributes as we go).</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">It's a big job so fingers crossed.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Thanks,</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Jonathan</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">Regards,<br =
class=3D"">John<br class=3D""><br class=3D""><br class=3D""><br =
class=3D""><br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">On Mar 18, 2018, at 5:23 AM, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org" class=3D"">jic23@kernel.org</a>&gt; =
wrote:<br class=3D""><br class=3D"">On Sat, 17 Mar 2018 23:11:45 =
-0700<br class=3D"">John Syne &lt;<a href=3D"mailto:john3909@gmail.com" =
class=3D"">john3909@gmail.com</a>&gt; wrote:<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">Hi Jonathan, &nbsp;<br =
class=3D""></blockquote>Hi John and All,<br class=3D""><br class=3D"">I'd =
love to get some additional input on this from anyone interested.<br =
class=3D"">There are a lot of weird and wonderful derived quantities in =
an energy<br class=3D"">meter and it seems we need to make some =
fundamental changes to support<br class=3D"">them - including =
potentially a userspace breaking change to the event<br class=3D"">code =
description.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">Here is the complete list of registers for the =
ADE7878 which I copied from the data sheet. I added a column =E2=80=9CIIO =
Attribute=E2=80=9D which I hope follows your IIO ABI. Please make any =
changes you feel are incorrect. BTW, there are several registers that =
cannot be generalized and are used purely for chip configuration. I =
think we should add a new naming convention, namely =
{register}_{&lt;chip-register-name&gt;}. Also, I see in the sys_bus_iio =
doc<br class=3D"">in_accel_x_peak_raw<br class=3D""><br class=3D"">so =
shouldn=E2=80=99t the phase be represented as follows:<br class=3D""><br =
class=3D"">in_current_A_scale &nbsp;<br class=3D""></blockquote>I'm =
still confused. &nbsp;What does A represent here? &nbsp;I assumed that =
was a wild<br class=3D"">card for the channel number before but clearly =
not.<br class=3D""><br class=3D"">Ah, you are labelling the 3 separate =
phases as A, B and C. Hmm.<br class=3D"">I guess they sort of look like =
axis, and sort of like independent channels.<br class=3D"">So could be =
indexed or done via modifiers depending on how you look at it.<br =
class=3D""><br class=3D"">Hmm. With neutral in there as well I guess we =
need to make them<br class=3D"">modifiers (but might change my mind =
later ;)<br class=3D""><br class=3D"">Particularly as we are using the =
the modifier for RMS under the previous<br class=3D"">plan... It appears =
we should treat that instead like we did for peak<br class=3D"">and do =
it as an additional info mask element. &nbsp;The problem with doing =
that<br class=3D"">on a continuous measurement is that we can't treat it =
as a channel to<br class=3D"">be output through the buffered =
interface.<br class=3D""><br class=3D"">So again we have run out of =
space. It's increasingly looking like we need<br class=3D"">room for =
another field in the events - to cleanly represent computed values.<br =
class=3D""><br class=3D"">Hmm. What is the current usage? - it's been a =
while so I had to go<br class=3D"">look in the header.<br class=3D""><br =
class=3D"">0-15 Channel (lots of channels)<br class=3D"">31-16 Channel 2 =
&nbsp;(36 modifiers - lots of channels)<br class=3D"">47-32 Channel Type =
(31 used so far - this looks most likely to run out of<br class=3D"">space=
 in the long run so leave this one alone).<br class=3D"">54-48 Event =
Direction (4 used)<br class=3D"">55 Differential &nbsp;(1: channel 2 as =
differential pair 0: as a modifier)<br class=3D"">63-56 Event Type (6 =
used)<br class=3D""><br class=3D"">So I think we can pinch bit 53 as =
another flag to indicate we have<br class=3D"">a computed value or =
possibly bit 63 as event types are few and<br class=3D"">far between as =
well.<br class=3D""><br class=3D"">Probably reasonable to assume we =
never have 16 bits worth<br class=3D"">of channels and computed channels =
at the same time?<br class=3D"">Hence I think we can steal bits off the =
top of Channel.<br class=3D"">How many do we need? &nbsp;Not sure =
unfortunately but feels like<br class=3D"">8 should be plenty.<br =
class=3D""><br class=3D"">The other element of this is we add a new =
field to iio_chan_spec<br class=3D"">to contain 'derived_type' or =
something like that which has<br class=3D"">rms and sum squared etc. =
Over time we can move some of those<br class=3D"">from the modifiers and =
free up a few entires there.<br class=3D"">So modifier might be "X and Y =
and Z" with a derived_type of<span =
class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">sum_squared =
to give existing sum_squared_x_y_z but no<br class=3D"">rush on that.<br =
class=3D""><br class=3D"">Anyhow so now we have an extra element to play =
that will result<br class=3D"">in a different channel.<br class=3D""><br =
class=3D"">Whilst here we should think about any other mods needed to<br =
class=3D"">that event structure. &nbsp;It is a little unfortunate that =
this<br class=3D"">will be a breaking change for any old userspace code =
playing<br class=3D"">with new drivers but it can't be helped as we =
didn't have<br class=3D"">reserved values in the original definition =
(oops).<br class=3D""><br class=3D"">At somepoint we may need to add the =
'shared by derived_value'<br class=3D"">info mask but I think we can =
ignore that for now (seems<br class=3D"">moderately unlikely to have =
anything in it!) &nbsp;<br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">But for now, I followed your instructions from =
your reply.<br class=3D""><br class=3D"">After finalizing this one, I =
will work on the ADE9000, which as way more registers ;-)<br =
class=3D""><br class=3D"">Once we can agree on the register naming, I =
will update the ADE7854 driver for Rodrigo, which will go a long way to =
getting it out of staging. &nbsp;<br class=3D""></blockquote>I'll edit =
to fit with new scheme and insert indexes which I think would be<br =
class=3D"">preferred though optional under the ABI as we only have one =
of each type/ &nbsp;<br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">Address<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Register<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>IIO =
Attribute<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Bit Length<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Bit Length During Communications<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Type<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Default =
Value<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Description<br class=3D"">0x4380<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AIGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A current gain adjust. &nbsp;<br =
class=3D""></blockquote>A, B, C, N aren't obvious to the lay reader so I =
suggest we burn a few characters and stick phase in for ABC and just =
have neutral for<br class=3D"">the neutral one. Not sure about =
capitalization or not though.<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0x4381<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AVGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A voltage gain adjust.<br class=3D"">0x4382<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BIGAIN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B current gain adjust.<br class=3D"">0x4383<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BVGAIN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B voltage gain adjust.<br class=3D"">0x4384<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CIGAIN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C current gain adjust.<br class=3D"">0x4385<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CVGAIN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage0_phaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C voltage gain adjust.<br class=3D"">0x4386<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>NIGAIN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_neutral_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Neutral current gain adjust (ADE7868 and ADE7878 =
only).<br class=3D"">0x4387<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AIRMSOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_phaseA_rms_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A current rms offset.<br class=3D"">0x4388<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AVRMSOS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseA_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A voltage rms offset.<br class=3D"">0x4389<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BIRMSOS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseB_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B current rms offset.<br class=3D"">0x438A<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BVRMSOS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseB_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B voltage rms offset.<br class=3D"">0x438B<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CIRMSOS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseC_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C current rms offset.<br class=3D"">0x438C<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CVRMSOS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseC_rms_offset<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C voltage rms offset.<br class=3D"">0x438D<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>NIRMSOS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_neutral_rms_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Neutral current rms offset (ADE7868 and ADE7878 only).<br =
class=3D"">0x438E<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVAGAIN<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_powerapparent0_phaseA_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A apparent power gain adjust.<br =
class=3D"">0x438F<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BVAGAIN<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_powerapparent0_phaseB_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B apparent power gain adjust.<br =
class=3D"">0x4390<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CVAGAIN<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_powerapparent0_phaseC_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C apparent power gain adjust.<br =
class=3D"">0x4391<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AWGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A total active power gain adjust.<br =
class=3D"">0x4392<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AWATTOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_power0_phaseA_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A total active power offset adjust.<br =
class=3D"">0x4393<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BWGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B total active power gain adjust.<br =
class=3D"">0x4394<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BWATTOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_power0_phaseB_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B total active power offset adjust.<br =
class=3D"">0x4395<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CWGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_PhaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C total active power gain adjust.<br =
class=3D"">0x4396<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CWATTOS<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>in_power0_phaseC_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C total active power offset adjust.<br =
class=3D"">0x4397<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVARGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseA_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A total reactive power gain adjust (ADE7858, =
ADE7868, and ADE7878).<br class=3D"">0x4398<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseA_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A total reactive power offset adjust (ADE7858, =
ADE7868, and ADE7878).<br class=3D"">0x4399<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BVARGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseB_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B total reactive power gain adjust (ADE7858, =
ADE7868, and ADE7878).<br class=3D"">0x439A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseB_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B total reactive power offset adjust (ADE7858, =
ADE7868, and ADE7878).<br class=3D"">0x439B<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CVARGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseC_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C total reactive power gain adjust (ADE7858, =
ADE7868, and ADE7878).<br class=3D"">0x439C<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseC_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C total reactive power offset adjust (ADE7858, =
ADE7868, and ADE7878).<br class=3D"">0x439D<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AFWGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseA_fundamental_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental active power gain adjust. Location =
reserved for ADE7854, ADE7858, and ADE7868. &nbsp;<br =
class=3D""></blockquote>Hmm. fundamental is the oddity here. &nbsp;I =
here because &nbsp;it is sort of a derived value<br class=3D"">and sort =
of a filter applied. &nbsp;Can it be sensible combined with RMS? =
probably not but<br class=3D"">it can be combined with peak for example =
(which I'd also ideally move into<br class=3D"">the derived =
representation.).<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0x439E<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AFWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_power0_phaseA_fundamental_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental active power offset adjust. Location =
reserved for ADE7854, ADE7858, and ADE7868.<br class=3D"">0x439F<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BFWGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power0_phaseB_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B fundamental active power gain adjust (ADE7878 =
only).<br class=3D"">0x43A0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BFWATTOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseB_fundamental_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B fundamental active power offset adjust (ADE7878 =
only).<br class=3D"">0x43A1<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CFWGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power0_phaseC_fundamental_scale<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C fundamental active power gain adjust.<br =
class=3D"">0x43A2<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CFWATTOS<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_power0_phaseC_fundamental_offset<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C fundamental active power offset adjust (ADE7878 =
only).<br class=3D"">0x43A3<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AFVARGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseA_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental reactive power gain adjust (ADE7878 =
only).<br class=3D"">0x43A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AFVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseA_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental reactive power offset adjust (ADE7878 =
only).<br class=3D"">0x43A5<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BFVARGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseB_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B fundamental reactive power gain adjust (ADE7878 =
only).<br class=3D"">0x43A6<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BFVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseB_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B fundamental reactive power offset adjust (ADE7878 =
only).<br class=3D"">0x43A7<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CFVARGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseC_fundamental_scale<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C fundamental reactive power gain adjust (ADE7878 =
only).<br class=3D"">0x43A8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CFVAROS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactive0_phaseC_fundamental_offset<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZPSE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C fundamental reactive power offset adjust (ADE7878 =
only).<br class=3D"">0x43A9<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VATHR1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>regiister_VATHR1<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Most =
significant 24 bits of VATHR[47:0] threshold used in phase apparent =
power datapath. &nbsp;<br class=3D""></blockquote>Do not expose these to =
userspace. Why would it care?<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0x43AA<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VATHR0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_VATHR0<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Less significant 24 bits of =
VATHR[47:0] threshold used in phase apparent power datapath.<br =
class=3D"">0x43AB<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>WTHR1<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_WTHR1<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Most =
significant 24 bits of WTHR[47:0] threshold used in phase =
total/fundamental active power datapath.<br class=3D"">0x43AC<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>WTHR0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_WTHR0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Less significant 24 bits of =
WTHR[47:0] threshold used in phase total/fundamental active power =
datapath.<br class=3D"">0x43AD<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VARTHR1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_VARTHR1<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Most =
significant 24 bits of VARTHR[47:0] threshold used in phase =
total/fundamental reactive power datapath (ADE7858, ADE7868, and =
ADE7878).<br class=3D"">0x43AE<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VARTHR0<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_VARTHR0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Less =
significant 24 bits of VARTHR[47:0] threshold used in phase =
total/fundamental reactive power datapath (ADE7858, ADE7868, and =
ADE7878).<br class=3D"">0x43AF<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Reserved<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A4<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A4<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A4<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A4<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>This memory location should be kept at 0x000000 for =
proper operation.<br class=3D"">0x43B0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VANOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_VANOLOAD<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>No load threshold in the apparent power datapath. =
&nbsp;<br class=3D""></blockquote>This one is kind of an event =
parameter, but one that controls internal creep prevention.<br =
class=3D"">This will be a driver specific attr I think for now. We may =
add it to info_mask<br class=3D"">later if we get lots of meter =
drivers.<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D"">Something like<br class=3D"">in_power0_no_load_thresh though =
I haven't really thought about it or looked<br class=3D"">for similar =
precedence.<br class=3D""><br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0x43B1<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>APNOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_APNOLOAD<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>No load threshold in the total/fundamental active power =
datapath. &nbsp;<br class=3D""></blockquote>in_activepower0_no_load_thresh=
 &nbsp;<br class=3D""><blockquote type=3D"cite" class=3D"">0x43B2<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VARNOLOAD<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_VARNOLOAD<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>No load threshold in the total/fundamental reactive power =
datapath. Location reserved for ADE7854. &nbsp;<br =
class=3D""></blockquote>in_reactivpower0_no_load_thresh<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0x43B3<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>VLEVEL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_VLEVEL<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZPSE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Register used in the algorithm =
that computes the fundamental active and reactive powers (ADE7878 only). =
&nbsp;<br class=3D""></blockquote>This one looks like a characteristic =
of the circuit attached. &nbsp;So should be devicetree<br class=3D"">or =
similar and not exposed to userspace.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0x43B5<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>DICOEFF<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_DICOEFF<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x0000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Register used in the digital integrator algorithm. If the =
integrator is turned on, it must be set at 0xFF8000. In practice, it is =
transmitted as 0xFFF8000. &nbsp;<br class=3D""></blockquote>no userspace =
interface.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0x43B6<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>HPFDIS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_HPFDIS<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Disables/enables the HPF in the current datapath (see Table 34). =
&nbsp;<br class=3D""></blockquote>We have controls for high pass =
filters, you'll need to map on to them.<br class=3D"">Disable is usually =
setting 3DB point to 0 IIRC.<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0x43B8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ISUMLVL<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_ISUMLVL<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZPSE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Threshold used in comparison between the sum of phase =
currents and the neutral current (ADE7868 and ADE7878 only). &nbsp;<br =
class=3D""></blockquote>This is an event threshold so needs to map to =
the events infrastructure<br class=3D"">as best we can. &nbsp;It's =
actually a pain to describe so may be device specific ABI.<br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">0x43BF<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ISUM<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_ISUM<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>28<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Sum of IAWV, IBWV, and ICWV registers (ADE7868 and =
ADE7878 only). &nbsp;<br class=3D""></blockquote>So this would be using =
a modifier for AandBandC phases (similar to the XandYanZ ones for mems =
devices and<br class=3D"">a derived value of sum I think So would look =
something like.<br class=3D"">in_current0_phaseA&amp;phaseB&amp;phaseC_sum=
 and yet another channel<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0x43C0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AIRMS<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>in_current0_phaseA_rms<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A4<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Phase A current rms value.<br class=3D"">0x43C1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AVRMS<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage0_phaseA_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase A voltage rms value.<br =
class=3D"">0x43C2<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BIRMS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseB_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B current rms value.<br =
class=3D"">0x43C3<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BVRMS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseB_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase B voltage rms value.<br =
class=3D"">0x43C4<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CIRMS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_phaseC_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C current rms value.<br =
class=3D"">0x43C5<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CVRMS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage0_phaseC_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase C voltage rms value.<br =
class=3D"">0x43C6<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>NIRMS<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current0_neutral_rms<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A4<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Neutral current rms value =
(ADE7868 and ADE7878 only).<br class=3D"">0xE228<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Run<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_Run<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Run register starts and stops the DSP. See the Digital =
Signal Processor section for more details. &nbsp;<br =
class=3D""></blockquote>Not exposed to userspace.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0xE400<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AWATTHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energy0_phaseA_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase A =
total active energy accumulation.<br class=3D"">0xE401<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BWATTHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energy0_phaseB_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase B =
total active energy accumulation.<br class=3D"">0xE402<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CWATTHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energy0_phaseC_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase C =
total active energy accumulation.<br class=3D"">0xE403<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AFWATTHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energy0_phaseA_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental active energy accumulation (ADE7878 =
only).<br class=3D"">0xE404<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BFWATTHR<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energy0_phaseB_fundamental_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase B =
fundamental active energy accumulation (ADE7878 only).<br =
class=3D"">0xE405<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CFWATTHR<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_energy0_phaseC_fundamental_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase C =
fundamental active energy accumulation (ADE7878 only).<br =
class=3D"">0xE406<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVARHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energyreactive0_phaseA_raw<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase A =
total reactive energy accumulation (ADE7858, ADE7868, and ADE7878 =
only).<br class=3D"">0xE407<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BVARHR<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyreactive0_phaseB_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase B =
total reactive energy accumulation (ADE7858, ADE7868, and ADE7878 =
only).<br class=3D"">0xE408<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CVARHR<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyreactive0_phaseC_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase C =
total reactive energy accumulation (ADE7858, ADE7868, and ADE7878 =
only).<br class=3D"">0xE409<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AFVARHR<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyreactive0_phaseA_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A fundamental reactive energy accumulation (ADE7878 =
only).<br class=3D"">0xE40A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BFVARHR<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyreactive0_phaseB_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase B fundamental reactive energy accumulation (ADE7878 =
only).<br class=3D"">0xE40B<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CFVARHR<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyreactive0_phaseC_fundamental_raw<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>S<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C fundamental reactive energy accumulation (ADE7878 =
only).<br class=3D"">0xE40C<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AVAHR<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	=
</span>in_energyapparent0_phaseA_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase A =
apparent energy accumulation.<br class=3D"">0xE40D<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>BVAHR<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyapparent0_phaseB_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase B =
apparent energy accumulation.<br class=3D"">0xE40E<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CVAHR<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energyapparent0_phaseC_raw<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase C =
apparent energy accumulation.<br class=3D"">0xE500<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>IPEAK<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current0_peak<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Current peak register. See Figure =
50 and Table 35 for details about its composition. &nbsp;<br =
class=3D""></blockquote>Oh goody. I have no idea how we expose the which =
phase element of this<br class=3D"">cleanly. &nbsp;One option I suppose =
is to have in_current0_phaseA_peak etc<br class=3D"">and have all but =
the current peak return an error when read? It is a bit<br =
class=3D"">nasty but only so much we can do and keep with a consistent =
interface.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE501<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>VPEAK<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_voltage_peak<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Voltage peak register. See Figure =
50 and Table 36 for details about its composition. &nbsp;<br =
class=3D""></blockquote>Same as peak.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0xE502<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>STATUS0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_STATUS0<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Interrupt Status Register 0. See =
Table 37.<br class=3D"">0xE503<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>STATUS1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_STATUS1<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Interrupt Status Register 1. See =
Table 38. &nbsp;<br class=3D""></blockquote>No userspace interface =
except via events interface or error reports.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0xE504<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AIMAV<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_currentA_mav<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>20<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase A current mean absolute value computed during PSM0 =
and PSM1 modes (ADE7868 and ADE7878 only). &nbsp;<br =
class=3D""></blockquote>Probably a longer name as mav is cryptic.<br =
class=3D"">in_current0_phaseA_meanabs_raw - it could have a scale and =
all sorts of fun.<br class=3D"">So I think this needs to be using the =
new derived infrastructure proposed here<br class=3D"">rather than being =
an info_mask element.<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0xE505<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BIMAV<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>in_currentB_mav<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>20<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
ZP<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>U<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Phase B current mean absolute value computed during PSM0 and PSM1 =
modes (ADE7868 and ADE7878 only).<br class=3D"">0xE506<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CIMAV<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_currentC_mav<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>20<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase C current mean absolute value computed during PSM0 =
and PSM1 modes (ADE7868 and ADE7878 only).<br class=3D"">0xE507<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>OILVL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_OILVL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>24<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0xFFFFFF<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Overcurrent threshold.<br =
class=3D"">0xE508<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>OVLVL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_OVLVL<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0xFFFFFF<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Overvoltage threshold. &nbsp;<br class=3D""></blockquote>These =
presumably result in interrupts? (I'm running out of time so not =
checking)<br class=3D"">In which case standard event interface should =
work.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE509<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>SAGLVL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_SAGLVL<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Voltage =
SAG level threshold. &nbsp;<br class=3D""></blockquote>That's another =
event I think...<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">0xE50A<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MASK0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_MASK0<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>32<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x00000000<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Interrupt Enable Register 0. See =
Table 39.<br class=3D"">0xE50B<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>MASK1<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>register_MASK1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x00000000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Interrupt Enable Register 1. See Table 40. &nbsp;<br =
class=3D""></blockquote><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE50C<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>IAWV<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_currentA_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase A =
current.<br class=3D"">0xE50D<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>IBWV<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in_currentB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of Phase B current.<br class=3D"">0xE50E<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ICWV<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_currentC_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase C =
current.<br class=3D"">0xE50F<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>INWV<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in_currentN_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of neutral current (ADE7868 and ADE7878 =
only).<br class=3D"">0xE510<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VAWV<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in_voltageA_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of Phase A voltage.<br class=3D"">0xE511<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>VBWV<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltageB_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase B =
voltage.<br class=3D"">0xE512<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>VCWV<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in_voltageC_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of Phase C voltage. &nbsp;<br =
class=3D""></blockquote>OK, this is getting silly. &nbsp;I presume this =
means the values above are filtered and these<br class=3D"">aren't? =
&nbsp;If so you need to have channels for both and different filter =
values.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE513<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AWATT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerA_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase A =
total active power.<br class=3D"">0xE514<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>BWATT<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>in_powerB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of Phase B total active power.<br =
class=3D"">0xE515<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CWATT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerC_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase C =
total active power.<br class=3D"">0xE516<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AVAR<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>in_powerreactiveA_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase A =
total reactive power (ADE7858, ADE7868, and ADE7878 only).<br =
class=3D"">0xE517<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BVAR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerreactiveB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of Phase B total reactive power (ADE7858, =
ADE7868, and ADE7878 only).<br class=3D"">0xE518<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>CVAR<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_powerreactiveC_instantaneous<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 SE<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Instantaneous value of Phase C =
total reactive power (ADE7858, ADE7868, and ADE7878 only).<br =
class=3D"">0xE519<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AVA<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerapparentA_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of Phase A apparent power.<br =
class=3D"">0xE51A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BVA<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerapparentB_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of Phase B apparent power.<br =
class=3D"">0xE51B<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CVA<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_powerappatentC_instantaneous<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>24<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>32 =
SE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>S<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Instantaneous value of Phase C apparent power. &nbsp;<br =
class=3D""></blockquote>Same for all of these.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0xE51F<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CHECKSUM<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_CHECKSUM<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x33666787<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Checksum =
verification. See the Checksum Register section for details. &nbsp;<br =
class=3D""></blockquote>Not exposed to userspace.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0xE520<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>VNOM<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage_rms_nominal<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>24<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>32 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x000000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Nominal =
phase voltage rms used in the alternative computation of the apparent =
power. When the VNOMxEN bit is set, the applied voltage input in the =
corresponding phase is ignored and all corresponding rms voltage =
instances are replaced by the value in the VNOM register. &nbsp;<br =
class=3D""></blockquote>Why would this be done? &nbsp;Sounds like =
something that is a circuit design time<br class=3D"">decision so a job =
for DT to me.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE600<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>PHSTATUS<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>in_current_phase_peak<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>N/A<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase =
peak register. See Table 41.<br class=3D"">0xE601<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ANGLE0<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_ANGLE0<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Time Delay 0. See the Time Interval Between Phases =
section for details.<br class=3D"">0xE602<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ANGLE1<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_ANGLE1<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Time Delay 1. See the Time Interval Between Phases =
section for details.<br class=3D"">0xE603<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ANGLE2<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_ANGLE2<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Time Delay 2. See the Time Interval Between Phases =
section for details. &nbsp;<br class=3D""></blockquote>Hmm. More fun. =
&nbsp;These are derived values between to phase measurements.<span =
class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">The phase as =
a modifier falls down a bit here - if we had just treated<br =
class=3D"">them as channels we could have done this a differential angle =
channel.<br class=3D"">Right now I'm not sure how we do this, could do =
it as a derived values so something like<br =
class=3D"">in_angle0_phaseA&amp;phaseB_diff_raw etc but that feels =
odd.<br class=3D"">This one needs more thought.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0xE604 to 0xE606<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Reserved<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>These addresses should not be written for proper =
operation.<br class=3D"">0xE607<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>PERIOD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_PERIOD<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Network line period. &nbsp;<br =
class=3D""></blockquote>Superficially this sounds like a channel free =
element so shared_by_all.<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0xE608<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>PHNOLOAD<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_PHNOLOAD<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>N/A<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Phase no load register. See Table =
42. &nbsp;<br class=3D""></blockquote>Hmm. So this is kind of a set of =
events with but without I think an interrupt.<br class=3D"">Odd.<br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">0xE60C<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>LINECYC<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_LINECYC<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0xFFFF<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Line =
cycle accumulation mode count. &nbsp;<br =
class=3D""></blockquote>in_count0_raw probably though it's a bit of a =
stretch.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE60D<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ZXTOUT<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_ZXTOUT<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0xFFFF<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Zero-crossing timeout count. &nbsp;<br class=3D""></blockquote>This=
 is going to be another top level one I think and device specific for =
now.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE60E<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>COMPMODE<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>register_COMPMODE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>R/W<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>16<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>U<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>0x01FF<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>Computation-mode register. See Table 43. &nbsp;<br =
class=3D""></blockquote>If there is stuff to control in here it need =
breaking out.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE60F<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Gain<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_Gain<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x0000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>PGA gains =
at ADC inputs. See Table 44. &nbsp;<br class=3D""></blockquote>Oh goody =
another scale value. Needs breaking up into separate controls.<br =
class=3D"">Do these directly effect the measured output voltage etc? If =
they do then<br class=3D"">I'm not sure how to separate the two gains, =
there ought to be a 'right'<br class=3D"">answer. &nbsp;If this is about =
matching to the circuit present then they<br class=3D"">should probably =
be coming from DT or simillar.<br class=3D""><br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">0xE610<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CFMODE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_CFMODE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0E88<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CFx configuration register. See Table 45.<br =
class=3D"">0xE611<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CF1DEN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_CF1DEN<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x0000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>CF1 =
denominator.<br class=3D"">0xE612<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>CF2DEN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_CF2DEN<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CF2 denominator.<br class=3D"">0xE613<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CF3DEN<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_CF3DEN<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CF3 denominator. &nbsp;<br class=3D""></blockquote>Are =
these things that should be in DT? &nbsp;Look very quickly like they are =
todo with other circuits nearby.<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0xE614<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>APHCAL<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_APHCAL<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>10<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16 ZP<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>S<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x0000<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Phase calibration of Phase A. See Table 46.<br =
class=3D"">0xE615<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>BPHCAL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_BPHCAL<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>10<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x0000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase =
calibration of Phase B. See Table 46.<br class=3D"">0xE616<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CPHCAL<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register__CPHCAL<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>10<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16 ZP<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>S<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x0000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>Phase =
calibration of Phase C. See Table 46. &nbsp;<br =
class=3D""></blockquote>I'm not actually sure how you would set these. =
&nbsp;Per circuit design?<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">0xE617<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>PHSIGN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_PHSIGN<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>16<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>N/A<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Power sign register. See Table 47.<br =
class=3D"">0xE618<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CONFIG<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_CONFIG<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>16<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x0000<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ADE7878 =
configuration register. See Table 48.<br class=3D"">0xE700<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>MMODE<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register__MMODE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x1C<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Measurement mode register. See Table 49.<br =
class=3D"">0xE701<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ACCMODE<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>register__ACCMODE<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Accumulation mode register. See =
Table 50.<br class=3D"">0xE702<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>LCYCMODE<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_LCYCMODE<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x78<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Line accumulation mode behavior. =
See Table 52.<br class=3D"">0xE703<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>PEAKCYC<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_PEAKCYC<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Peak detection half line =
cycles.<br class=3D"">0xE704<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>SAGCYC<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_SAGCYC<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>R/W<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>8<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>U<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>0x00<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>SAG detection half line cycles. &nbsp;<br =
class=3D""></blockquote>Some of these are event controls. Map them as =
such.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">0xE705<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>CFCYC<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_CFCYC<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x01<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Number of CF pulses between two =
consecutive energy latches. See the Synchronizing Energy Registers with =
CFx Outputs section.<br class=3D"">0xE706<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>HSDC_CFG<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_HSDC_CFG<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>HSDC configuration register. See =
Table 53.<br class=3D"">0xE707<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Version<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>register_Version<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Version of die.<br =
class=3D"">0xEBFF<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>Reserved<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>This address can be used in =
manipulating the SS/HSA pin when SPI is chosen as the active port. See =
the Serial Interfaces section for details.<br class=3D"">0xEC00<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>LPOILVL<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_LPOILVL<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x07<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>"Overcurrent threshold used =
during PSM2 mode (ADE7868 and ADE7878<br class=3D"">only). See Table 54 =
in which the register is detailed."<br class=3D"">0xEC01<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>CONFIG2<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>register_CONFIG2<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>R/W<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>8<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>U<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>0x00<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>Configuration register used =
during PSM1 mode. See Table 55. &nbsp;<br class=3D""></blockquote><br =
class=3D"">As you can guess I was running out of stamina towards the end =
of that.<br class=3D""><br class=3D"">I'm not totally sure of the answer =
I provided. It may take some more thought.<br class=3D"">Ideally some =
others will give input on this question.<br class=3D""><br =
class=3D"">Jonathan &nbsp;<br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">Regards,<br class=3D"">John<br class=3D""><br =
class=3D""><br class=3D""><br class=3D""><br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">On Mar 17, 2018, at 1:30 =
PM, Jonathan Cameron &lt;<a href=3D"mailto:jic23@kernel.org" =
class=3D"">jic23@kernel.org</a>&gt; wrote:<br class=3D""><br class=3D"">On=
 Wed, 14 Mar 2018 23:12:02 -0700<br class=3D"">John Syne &lt;<a =
href=3D"mailto:john3909@gmail.com" class=3D"">john3909@gmail.com</a>&gt; =
wrote:<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">Hi Jonathan,<br class=3D""><br class=3D"">I have been looking =
at the IIO ABI docs and if I understand<br class=3D"">correctly, the =
idea is to use consistent naming conventions? So for<br =
class=3D"">example, looking at the ADE7854 datasheet, the naming =
matching the<br class=3D"">ADE7854 registers would be as follows: =
&nbsp;&nbsp;&nbsp;<br class=3D""></blockquote><br class=3D"">Welcome to =
one of the big reasons no one tidied these drivers<br class=3D"">up =
originally. &nbsp;Still we have moved on somewhat since then<br =
class=3D"">so similar circumstances have come up in other types of =
sensor.<br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><br =
class=3D"">{direction}_{type}_{index}_{modifier}_{info_mask}<br =
class=3D""><br class=3D"">AIGAIN<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>In_current_a_gain =
&nbsp;&nbsp;&nbsp;<br class=3D""></blockquote>Other than the fact that =
gain isn't an ABI element and that index<br class=3D"">doesn't have<br =
class=3D"">_ before it that is right.<br class=3D"">in_voltageA_scale<br =
class=3D""><br class=3D"">That was a weird quirk a long time back which =
we should probably<br class=3D"">not have done (copied it from hwmon)<br =
class=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">AVGAIN<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage_a_gain<br class=3D"">BIGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current_b_gain<br class=3D"">BVGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage_b_gain<br class=3D"">=E2=80=94<br class=3D"">How do we =
represent the rms and offset<br class=3D"">AIRMSOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_current_a_rmsoffset<br class=3D"">AVRMSOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_voltage_a_rmsoffset &nbsp;&nbsp;&nbsp;<br =
class=3D""></blockquote><br class=3D"">Right now we can't unfortunately =
though this one is easier to fix.<br class=3D"">We already have =
modifiers for multi axis devices doing sum_squared<br class=3D"">so add =
one of those for root_mean_square - this one is well known<br =
class=3D"">enough that rms is fine in the string.<br class=3D""><br =
class=3D"">It's a effectively a different channel be it one derived from =
a simple<br class=3D"">one. &nbsp;This is going to get tricky however as =
we would normally use<br class=3D"">modifier to specialise a channel =
type - thoughts on this below.<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">=E2=80=94<br class=3D"">Here I don=E2=80=99t =
understand how to represent both the phase and the =
active/reactive/apparent power components. Do we combine the phase and =
quadrature part like this<br class=3D"">AVAGAIN<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power_a_gain<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>/* apparent power */<br class=3D"">=E2=80=94<br =
class=3D"">AWGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power_ai_gain<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>/* active power */ =
&nbsp;&nbsp;&nbsp;<br class=3D""></blockquote>And that is the problem. =
&nbsp;How do we represent the various power types.<br class=3D"">Hmm. We =
could do it with modifiers but above we show that we have already used =
them.<br class=3D""><br class=3D"">It would be easy enough to add yet =
another field to the channel spec to specify<br class=3D"">this but =
there is a problem - Events. &nbsp;The event format is already pretty =
full<br class=3D"">so where do we put this extra element if we need to =
define a channel separated<br class=3D"">only by it.<br class=3D""><br =
class=3D"">One thought is we could instead define these as different top =
level<br class=3D"">IIO_CHAN_TYPES in a similar fashion to we do for =
relative humidity vs<br class=3D"">the proposed absolute humidity.<br =
class=3D""><br class=3D"">in_powerreactiveA_scale<br =
class=3D"">in_poweractivceA_scale<br class=3D"">(or in_powerrealA_scale =
to match with what I got taught years ago?)<br class=3D""><br class=3D"">I=
 presume we keep in_powerA_scale etc for the apparent power and<br =
class=3D"">modify any docs to make that clear.<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">=E2=80=94<br =
class=3D"">AVARGAIN<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_power_aq_gain<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>/* reactive power */<br =
class=3D"">=E2=80=94<br class=3D"">Now here it becomes more complicated. =
Not sure how this gets handled.<span =
class=3D"Apple-converted-space">&nbsp;</span><br class=3D"">AFWATTOS<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_power_a_active/fundamental/offset &nbsp;&nbsp;&nbsp;<br =
class=3D""></blockquote>Yeah, some of these are getting odd.<br =
class=3D"">If I read this correctly this is the active power estimate =
based on only<br class=3D"">the fundamental frequency - so no =
harmonics?<br class=3D""><br class=3D"">Hmm. &nbsp;This then becomes a =
separate channel with additional properties<br class=3D"">specifying it =
is only the fundamental. &nbsp;This feels a bit like a filter<br =
class=3D"">be it an unusual one? &nbsp;Might just be necessary to add a =
_fundamental_only<br class=3D"">element on the end (would be info_mask =
if this is common enough to<br class=3D"">justify that rather than using =
the extended methods to define it.).<br class=3D""><br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">=E2=80=94<br =
class=3D"">AWATTHR<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_energy_ai_accumulation &nbsp;&nbsp;&nbsp;<br =
class=3D""></blockquote>Great, just when I thought we had gone far =
enough they define reactive<br class=3D"">energy which is presumably =
roughly the same as reactivepower * time?<br class=3D"">In that case we =
need types for that as well.<br class=3D"">in_energyreactiveA_*<br =
class=3D"">in_energyactiveA_*<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">=E2=80=94<br class=3D"">AVARHR<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>in_energy_aq_accumulation<br class=3D"">=E2=80=94<br =
class=3D"">IPEAK<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>in_current_peak &nbsp;&nbsp;&nbsp;<br =
class=3D""></blockquote>That one is easy as we have an info_mask element =
for peak and one<br class=3D"">for peak_scale that has always been a bit =
odd but was needed somewhere.<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">=E2=80=94<br class=3D""><br class=3D"">I=E2=80=99=
ll leave it there, because there are some even more complicated register =
naming issues. &nbsp;&nbsp;&nbsp;<br class=3D""></blockquote>Something =
to look forward to. &nbsp;Gah, I always hated power engineering<br =
class=3D"">though I taught it very briefly (I really pity those students =
:(<br class=3D""><br class=3D"">Jonathan<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D""><br class=3D"">Regards,<br=
 class=3D"">John<br class=3D""><br class=3D""><br class=3D""><br =
class=3D""><br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">On Mar 10, 2018, at 7:10 AM, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org" class=3D"">jic23@kernel.org</a>&gt; =
wrote:<br class=3D""><br class=3D"">On Thu, 8 Mar 2018 21:37:33 -0300<br =
class=3D"">Rodrigo Siqueira &lt;<a =
href=3D"mailto:rodrigosiqueiramelo@gmail.com" =
class=3D"">rodrigosiqueiramelo@gmail.com</a>&gt; wrote:<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">On 03/07, Jonathan =
Cameron wrote: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br class=3D""><blockquote =
type=3D"cite" class=3D"">On Tue, 6 Mar 2018 21:43:47 -0300<br =
class=3D"">Rodrigo Siqueira &lt;<a =
href=3D"mailto:rodrigosiqueiramelo@gmail.com" =
class=3D"">rodrigosiqueiramelo@gmail.com</a>&gt; wrote:<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">The macro =
IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, with a<br =
class=3D"">tiny change in the name definition. This extra macro does not =
improve<br class=3D"">the readability and also creates some checkpatch =
errors.<br class=3D""><br class=3D"">This patch fixes the checkpatch.pl =
errors:<br class=3D""><br class=3D"">staging/iio/meter/ade7753.c:391: =
ERROR: Use 4 digit octal (0777) not<br class=3D"">decimal permissions<br =
class=3D"">staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal =
(0777) not<br class=3D"">decimal permissions<br =
class=3D"">staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal =
(0777) not<br class=3D"">decimal permissions<br =
class=3D"">staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal =
(0777) not<br class=3D"">decimal permissions<br class=3D""><br =
class=3D"">Signed-off-by: Rodrigo Siqueira &lt;<a =
href=3D"mailto:rodrigosiqueiramelo@gmail.com" =
class=3D"">rodrigosiqueiramelo@gmail.com</a>&gt; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br class=3D""></blockquote><br =
class=3D"">Hmm. I wondered a bit about this one. It's a correct patch in =
of<br class=3D"">itself but the interface in question doesn't even =
vaguely conform<br class=3D"">to any of defined IIO ABI. &nbsp;Anyhow, =
it's still and improvement so<br class=3D"">I'll take it. =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br class=3D""></blockquote><br =
class=3D"">I am not sure if I understood the comment about the ABI. The =
meter<br class=3D"">interface is wrong because it uses things like =
IIO_DEVICE_ATTR? It<br class=3D"">should use iio_info together with =
*write_raw and *read_raw. Right? Is it<br class=3D"">the ABI problem =
that you refer? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br =
class=3D""></blockquote>The ABI is about the userspace interface of IIO. =
&nbsp;It is defined<br class=3D"">in =
Documentation/ABI/testing/sysfs-bus-iio*<br class=3D"">So this documents =
the naming of sysfs attributes and (more or less)<br class=3D"">describes =
a consistent interface to userspace across lots of different<br =
class=3D"">types of devices.<br class=3D""><br class=3D"">A lot of these =
older drivers in staging involve a good deal of ABI that<br class=3D"">was=
 not reviewed or discussed. &nbsp;That is one of the biggest reasons =
we<br class=3D"">didn't take them out of staging in the first place.<br =
class=3D""><br class=3D"">In order for generic userspace programs to =
have any idea what to do<br class=3D"">with these devices this all needs =
to be fixed.<br class=3D""><br class=3D"">There may well be cases where =
we need to expand the existing ABI to<br class=3D"">cover new things. =
&nbsp;&nbsp;That's fine, but it has to be done with full<br =
class=3D"">review of the relevant documentation patches.<br class=3D""><br=
 class=3D"">Incidentally if you want an easy driver to work on moving =
out of staging<br class=3D"">then first thing to do is to compare what =
it shows to userspace with these<br class=3D"">docs. &nbsp;If it's =
totally different then you have a big job on your hands<br class=3D"">as =
often ABI can take a lot of discussion and a long time to establish<br =
class=3D"">a consensus.<br class=3D""><br class=3D"">Jonathan<br =
class=3D""><br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">Thanks :)<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">Applied to the togreg =
branch of iio.git and pushed out as testing<br class=3D"">for the =
autobuilders to play with it.<br class=3D""><br class=3D"">I also added =
the removal of the header define which is no<br class=3D"">longer =
used.<br class=3D""><br class=3D"">Please note, following discussions =
with Michael, I am going to send<br class=3D"">an email announcing an =
intent to drop these meter drivers next<br class=3D"">cycle unless =
someone can provide testing for any attempt to<br class=3D"">move them =
out of staging. &nbsp;I'm still taking patches on the basis<br =
class=3D"">that 'might' happen - but I wouldn't focus on these until =
we<br class=3D"">have some certainty on whether they will be around long =
term!<br class=3D""><br class=3D"">Jonathan<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">---<br =
class=3D"">drivers/staging/iio/meter/ade7753.c | 18 =
++++++++++--------<br class=3D"">drivers/staging/iio/meter/ade7759.c | =
18 ++++++++++--------<br class=3D"">2 files changed, 20 insertions(+), =
16 deletions(-)<br class=3D""><br class=3D"">diff --git =
a/drivers/staging/iio/meter/ade7753.c =
b/drivers/staging/iio/meter/ade7753.c<br class=3D"">index =
c44eb577dc35..275e8dfff836 100644<br class=3D"">--- =
a/drivers/staging/iio/meter/ade7753.c<br class=3D"">+++ =
b/drivers/staging/iio/meter/ade7753.c<br class=3D"">@@ -388,14 +388,16 =
@@ static IIO_DEV_ATTR_VPERIOD(0444,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_read_16bit,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>NULL,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7753_PERIOD);<br class=3D"">-static IIO_DEV_ATTR_CH_OFF(1, =
0644,<br class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ade7753_read_8bit,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_write_8bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7753_CH1OS);<br =
class=3D"">-static IIO_DEV_ATTR_CH_OFF(2, 0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_read_8bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7753_write_8bit,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7753_CH2OS);<br class=3D"">+<br class=3D"">+static =
IIO_DEVICE_ATTR(choff_1, 0644,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_read_8bit,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7753_write_8bit,<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7753_CH1OS);<br class=3D"">+<br class=3D"">+static =
IIO_DEVICE_ATTR(choff_2, 0644,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7753_read_8bit,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7753_write_8bit,<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7753_CH2OS);<br class=3D""><br class=3D"">static int =
ade7753_set_irq(struct device *dev, bool enable)<br class=3D"">{<br =
class=3D"">diff --git a/drivers/staging/iio/meter/ade7759.c =
b/drivers/staging/iio/meter/ade7759.c<br class=3D"">index =
1decb2b8afab..c078b770fa53 100644<br class=3D"">--- =
a/drivers/staging/iio/meter/ade7759.c<br class=3D"">+++ =
b/drivers/staging/iio/meter/ade7759.c<br class=3D"">@@ -328,14 +328,16 =
@@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_read_16bit,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7759_write_16bit,<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7759_APGAIN);<br class=3D"">-static IIO_DEV_ATTR_CH_OFF(1, =
0644,<br class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ade7759_read_8bit,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_write_8bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ADE7759_CH1OS);<br =
class=3D"">-static IIO_DEV_ATTR_CH_OFF(2, 0644,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_read_8bit,<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7759_write_8bit,<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7759_CH2OS);<br class=3D"">+<br class=3D"">+static =
IIO_DEVICE_ATTR(choff_1, 0644,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_read_8bit,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7759_write_8bit,<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7759_CH1OS);<br class=3D"">+<br class=3D"">+static =
IIO_DEVICE_ATTR(choff_2, 0644,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ade7759_read_8bit,<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ade7759_write_8bit,<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ADE7759_CH2OS);<br class=3D""><br class=3D"">static int =
ade7759_set_irq(struct device *dev, bool enable)<br class=3D"">{ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br class=3D""></blockquote><br =
class=3D""></blockquote>--<br class=3D"">To unsubscribe from this list: =
send the line "unsubscribe linux-iio" in<br class=3D"">the body of a =
message to <a href=3D"mailto:majordomo@vger.kernel.org" =
class=3D"">majordomo@vger.kernel.org</a><br class=3D"">More majordomo =
info at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.html" =
class=3D"">http://vger.kernel.org/majordomo-info.html</a> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br class=3D""></blockquote><br =
class=3D"">_______________________________________________<br =
class=3D"">devel mailing list<br class=3D""><a =
href=3D"mailto:devel@linuxdriverproject.org" =
class=3D"">devel@linuxdriverproject.org</a><br =
class=3D"">http://driverdev.linuxdriverproject.org/mailman/listinfo/driver=
dev-devel =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</blockquote></blockquote></blockquote></blo=
ckquote></blockquote></blockquote></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_26FE8CBF-2E74-449F-9637-902B29F073EA--
