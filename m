Return-Path: <john3909@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522010213; cv=none;
        d=google.com; s=arc-20160816;
        b=h8J8nJOisDAN35tNGssPyu4VG8vE8m0CY0sQ/Rvwja5WZCtUU+xm/DxiN1wb5JSQ6m
         GrjI9zkUA/pgWB3OmunX0Jx2Nu86VOp+IsKjK8E+YGGUqnn1cSbPxUfpFho6I4Gdcv0R
         y0WM9SD7MzFaOnSEStXs8v2JUAnjxcXjoInWMBSOrmvUHH2Ur6Z9xbybIkEyrpIVwX9G
         fMXePGNaBQoPT47vx6oclczPg7LWdP6/AvijbQJ1zXzn+8U2XSZAv3aGZ4ajwsDKb2Vm
         KNVtHsMXpDr4CQqwxcDHaylvRWE5cESGDK0e+e++YoYE8Yl8uy7MyX/FPM+aHCn3c/FF
         9CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=x+NQkA453I7j7Y8IniTUVQ+wVulIyq4O21XSq77PLtE=;
        b=h5tWWBy9uvqlc6X5I5cjq8R87Buschhjnm9B0oX8mpmlqIy0+bthqnVJ/GOBKbiFuX
         oa6muDOmRPuLIf5QiwnTxhffW6gGyDpgYvyMhGXnEVBYKKbEekOPj7kruTSiVFeza/FE
         3hQQsFYLBBnPgoQHqvs3+34rfwAFQR+AlhN1y+mKlvUffndEJtjgKy5+gtaexo8Pr8wA
         0q1McDy1pd4tYL65EYVW/5TTqzSKl+0hgsbEprQGqS6l5THgo2wIfXTON/swYmoRF8IU
         xyL9y9yR58krrQ+pQ2zx1UiTfWJC6yMZGdB9bvfXHOiXEdOzluj7Gw3Lyp0fi3PYGf+y
         Xx9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ym98lzMf;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ym98lzMf;
       spf=pass (google.com: domain of john3909@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=john3909@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvLbdc34TZXO9BUU8QXPrly3Rg80MWh53cJmDAwZYafl0bSOkXVaiFN0+45K+XSCcqbSMUf+Q==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180325172911.39c0e42f@archlinux>
Date: Sun, 25 Mar 2018 13:36:40 -0700
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 devel@driverdev.osuosl.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com,
 Michael Hennerich <michael.hennerich@analog.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA2E74B3-EA99-46F7-9FC8-29C8FE6CDC14@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
 <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
 <20180317203037.1093cc11@archlinux>
 <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
 <20180318122312.0d395367@archlinux>
 <C4AC18E6-E89B-4915-9B71-09EFC09B490D@gmail.com>
 <20180324150205.709aa211@archlinux>
 <D48DD58E-EB75-48F4-8E34-69D619206BA1@gmail.com>
 <20180325172911.39c0e42f@archlinux>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595278152164006674?=
X-GMAIL-MSGID: =?utf-8?q?1595943381527736087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Mar 25, 2018, at 9:29 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>=20
> On Sat, 24 Mar 2018 15:45:21 -0700
> John Syne <john3909@gmail.com> wrote:
>=20
>>> On Mar 24, 2018, at 8:02 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>>>=20
>>> On Mon, 19 Mar 2018 22:57:16 -0700
>>> John Syne <john3909@gmail.com> wrote:
>>>=20
>>>> Hi Jonathan,
>>>>=20
>>>> Thank you for all your hard work. Your feedback is really helpful. =
I=E2=80=99m surprised that no one from Analog Device has offered any =
suggestions.
>>>>=20
>>>=20
>>> Sadly those active in the mainline linux kernel from ADI are focused =
in
>>> other areas currently :( =20
>> Good point. I will reach out to Analog Devices and get a name of =
someone=20
>> who is knowledgeable in this area. Perhaps Lars-Peters has a =
suggestion.=20
> Yes, Lars or Michael Hennerich (+CC) are my normal contact points.
> I believe this is outside both of their areas, but they may be able to
> put you in contact with the right person.  If nothing else it would be
> good to make someone in ADI aware that people care about linux support =
for
> these parts!
I sent in a request to ADI for a contact person to help with the review.
>=20
>>>> Anyway, please see my comments inline below
>>>>=20
>>>> Regards,
>>>> John
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>> On Mar 18, 2018, at 5:23 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>>>>>=20
>>>>> On Sat, 17 Mar 2018 23:11:45 -0700
>>>>> John Syne <john3909@gmail.com> wrote:
>>>>>=20
>>>>>> Hi Jonathan,   =20
>>>>> Hi John and All,
>>>>>=20
>>>>> I'd love to get some additional input on this from anyone =
interested.
>>>>> There are a lot of weird and wonderful derived quantities in an =
energy
>>>>> meter and it seems we need to make some fundamental changes to =
support
>>>>> them - including potentially a userspace breaking change to the =
event
>>>>> code description.
>>>>>=20
>>>>>>=20
>>>>>> Here is the complete list of registers for the ADE7878 which I =
copied from the data sheet. I added a column =E2=80=9CIIO Attribute=E2=80=9D=
 which I hope follows your IIO ABI. Please make any changes you feel are =
incorrect. BTW, there are several registers that cannot be generalized =
and are used purely for chip configuration. I think we should add a new =
naming convention, namely {register}_{<chip-register-name>}. Also, I see =
in the sys_bus_iio doc =20
>=20
> No, registers can always be broken up in to real meaningful values if
> they are exposed to userspace and userspace has a reason to tweak
> them.
>=20
> We never expose raw registers to userspace except through
> debugfs and the clue is in the name - purely for debug.
OK
>=20
>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>>>> in_accel_x_peak_raw
>>>>>>=20
>>>>>> so shouldn=E2=80=99t the phase be represented as follows:
>>>>>>=20
>>>>>> in_current_A_scale   =20
>>>>> I'm still confused.  What does A represent here?  I assumed that =
was a wild
>>>>> card for the channel number before but clearly not.
>>>>>=20
>>>>> Ah, you are labelling the 3 separate phases as A, B and C. Hmm.
>>>>> I guess they sort of look like axis, and sort of like independent =
channels.
>>>>> So could be indexed or done via modifiers depending on how you =
look at it.   =20
>>>> In metering terminology, the three phases are commonly referred to =
as RED, GREEN, BLUE or PhaseA, PhaseB, PhaseC and Neutral. Analog =
Devices uses the ABCN nomenclature so anyone using this driver will =
probably have referenced the Analog Devices datasheet so this =
terminology should be familiar.  =20
>>> Which is more commonly used in general?  We are designing what we =
hope
>>> will be a general interface and last thing we want is to have =
everyone
>>> not using ADI parts confused!  Personally not assigning 'colours' =
makes
>>> more sense to me. =20
>> I did a little research and here is the naming used by vendor:
>>=20
>> ST Microelectronics: P1, P2, P3, N
>> =
http://www.st.com/content/ccc/resource/technical/document/application_note=
/5e/f4/22/4d/90/96/4c/c4/CD00153264.pdf/files/CD00153264.pdf/jcr:content/t=
ranslations/en.CD00153264.pdf
>>=20
>> Teridian: ABCN
>> https://www.mouser.com/ds/2/256/71M6513-71M6513H-22603.pdf
>>=20
>> Maxim Integrated: ABCN
>> https://datasheets.maximintegrated.com/en/ds/78M6631.pdf
>>=20
>> Microchip: ABCN
>> http://ww1.microchip.com/downloads/en/DeviceDoc/51643b.pdf
>>=20
>> NXP: L1, L2, L3, N
>> =
https://www.nxp.com/support/developer-resources/reference-designs/kinetis-=
km3x-256-mcu-three-phase-metering-reference-design:RD-KM3x-256-3PH-METERIN=
G
>>=20
>> Renesas: ABCN
>> =
https://www.renesas.com/en-us/solutions/home/metering/power-meter-three.ht=
ml
>>=20
>> So the most consistent would be ABCN
> Cool.   Makes sense to go with that.  Thanks for checking this out.
>=20
>>=20
>>=20
>> All vendor providing three phase energy metering ICs use the ABCN =
terminology.=20
>>>=20
>>> (btw please wrap any lines that don't need to be long to around 80 =
characters).
>>>=20
>>>>>=20
>>>>> Hmm. With neutral in there as well I guess we need to make them
>>>>> modifiers (but might change my mind later ;)
>>>>>=20
>>>>> Particularly as we are using the the modifier for RMS under the =
previous
>>>>> plan... It appears we should treat that instead like we did for =
peak
>>>>> and do it as an additional info mask element.  The problem with =
doing that
>>>>> on a continuous measurement is that we can't treat it as a channel =
to
>>>>> be output through the buffered interface.   =20
>>>> I=E2=80=99ve changed the layout of the spreadsheet to breakout the =
Direction, Type, Index, Modifier and Info Mask to make sure there is no =
miss-understanding and will help identify all the items we need to add.
>>>>=20
>>>> The ADE7878 channels that will use the buffer are IAWV, VAWV, IBWV, =
VBWV, ICWV, VCWV, INWV, AVA, BVA, CVA, AWATT, BWATT, CWATT, AVAR, BVAR, =
and CVAR. So I guess we have to add an index =20
>>> Probably a good idea anyway, we are sort of slowly moving away
>>> from index less channels.  The ABI always allowed index assignment
>>> and it makes for easier userspace code.
>>>=20
>>>>=20
>>>> Address Register 	IIO Attribute						=
	Dir	Type		Index 	Modifier	Info Mask	=
R/W	Bit		Bit Length	Type	Default	Description=20
>>>> 										=
										=
					Length 	During Comm			=
Value=09
>>>> 0xE50C	IAWV	in_current0_phaseA_instantaneous		=
in	current			0	phaseA	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase A current. =20
>>>=20
>>> I'm unconvinced by "instantaneous".  That is the default assumption =
that you are
>>> measuring current at this point in time.  I'm still confused on what =
this actually
>>> is. Is it effectively the DC current? I.e. the wave form value for =
current?=20
>>> You answer this below.  They are DC measurements.. =20
>> No, they are the output of the ADC at a point in time. The ADC =
samples=20
>> continuous at 8,000 samples per second, so when you read this =
register
>> you are getting the sample measured just before your read. I don=E2=80=99=
t know
>> why anyone would read this register. The samples are streamed via
>> the SPI interface, with IAWV, VAWV, IBWV, VBWV, ICWV, VCWV, INWV,=20
>> AVA, BVA, CVA, AWATT, BWATT, CWATT, AVAR, BVAR, and CVAR transmitted=20=

>> every 125uS. Probably better not to expose these registers to user =
space.
> I'm happy not to expose them, but if they are the instantaneous values
> they are what I mean by DC values, literally the number you would
> see on an oscilloscope if you were to probe them.
If you could read the instantaneous register after each sample, then you=20=

would get an oscilloscope display of a sine wave. However, since a user=20=

space app cannot read this on each sample, the output would look pretty
random. Certainly not a DC value, which is much more consistent.=20
>=20
>>=20
>>=20
>>>=20
>>> Which actually raises a point I'd forgotten.  We have an explicit =
type=20
>>> for altvoltage (defined for DDS devices as the waveform amplitude =
IIRC).
>>> We should be consistent with that if possible.
>>>=20
>>> So I think this should be.
>>> in_current0_phaseA_raw =20
>> Yeah, that sounds correct, which reminds me of another issue that =
does not make
>> sense. To me, gain is something that is hardware related and is used =
to magnify=20
>> an input signal or is used to calibrate a measurement. Scale on the =
other had is=20
>> something that is used to convert a raw measurement into something =
that is more=20
>> meaningful, such as 0x820000 =3D 220V. So everywhere we have used =
scale and gain=20
>> interchangeable is confusing.
>=20
> Agreed - up to a point.  If you have a hardware gain control which for =
whatever
> reason results in a different scaling needing to be applied to go from =
userspace
> value to real world value (sometimes happens with multi range devices) =
then we
> expose it only once - as scale.
>=20
> We have hardwaregain and calibgain for tweaking the gain to account =
for cases
> where it isn't apparent in the output value (hardware gain - normally =
used
> when we are measuring something about the signal that isn't it's =
magnitude),
> or is compensating for inaccuracies in the circuitry or sensor =
(calibgain)
That is what we have, the ADE7854 has a hardwaregain before the ADC to =
allow
various input voltage and current ranges: 0-250mV, 0-0.5V, etc. Also, we =
have
calibgain, which is used to compensate for the selected current =
transformer or=20
rogowski coil and the termination resistors.=20

Maybe we should add additional attributes for scale and the real world =
values?
The scale attribute would convert the raw value to real world value =
(220V, 100A
25KWh, etc)
>>=20
>>> etc
>>> A channel can be uniquely identified using index and modifier as as =
pair (if we add
>>> the new field for computation applied that will also allow separate =
identification).
>>> So the later channels can be.
>>>=20
>>> in_current0_phaseB_raw etc
>>>=20
>>> Indexes can be shared by different types as well.  Often done to =
associate
>>> different measurements of the same signal (though the ABI doesn't =
specify
>>> that).
>>>=20
>>>> 0xE50D	IBWV	in_current1_phaseB_instantaneous		=
in	current			1	phaseB	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase B current.
>>>> 0xE50E	ICWV	in_current2_phaseC_instantaneous		=
in	current			2	phaseC	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase C current.
>>>> 0xE50F	INWV	in_current3_phaseN_instantaneous		=
in	current			3	neutral	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of neutral current (ADE7868 and ADE7878 only). =20
>>> in_voltage0_phaseA_raw
>>>=20
>>>> 0xE510	VAWV	in_voltage4_phaseA_instantaneous		=
in	voltage			4	phaseA	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase A voltage.
>>>> 0xE511	VBWV	in_voltage5_phaseB_instantaneous		=
in	voltage			5	phaseB	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase B voltage.
>>>> 0xE512	VCWV	in_voltage6_phaseC_instantaneous		=
in	voltage			6	phaseC	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase C voltage.
>>>> 0xE513	AWATT	in_power7_phaseA_instantaneous			=
in	power			7	phaseA	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase A total active power.
>>>> 0xE514	BWATT	in_power8_phaseB_instantaneous			=
in	power			8	phaseB	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase B total active power.
>>>> 0xE515	CWATT	in_power9_phaseC_instantaneous			=
in	power			9	phaseC	instantaneous	R	=
24		32 SE		S		N/A		=
Instantaneous value of Phase C total active power. =20
>>> in_power0_phaseC_raw
>>>=20
>>>> 0xE516	AVAR	in_powerreactive10_phaseA_instantaneous	in	=
powerreactive		10	phaseA	instantaneous	R	24		=
32 SE		S		N/A		Instantaneous value of =
Phase A total reactive power (ADE7858, ADE7868, and ADE7878 only). =20
>>> in_powerreactive0_phaseA_raw etc =20
>>>> 0xE517	BVAR	in_powerreactive11_phaseB_instantaneous	in	=
powerreactive		11	phaseB	instantaneous	R	24		=
32 SE		S		N/A		Instantaneous value of =
Phase B total reactive power (ADE7858, ADE7868, and ADE7878 only).
>>>> 0xE518	CVAR	in_powerreactive12_phaseC_instantaneous	in	=
powerreactive		12	phaseC	instantaneous	R	24		=
32 SE		S		N/A		Instantaneous value of =
Phase C total reactive power (ADE7858, ADE7868, and ADE7878 only).
>>>> 0xE519	AVA		in_powerapparent13_phaseA_instantaneous	=
in	powerapparent	13	phaseA	instantaneous	R	24		=
32 SE		S		N/A		Instantaneous value of =
Phase A apparent power.
>>>> 0xE51A	BVA		in_powerapparent14_phaseB_instantaneous	=
in	powerapparent	14	phaseB	instantaneous	R	24		=
32 SE		S		N/A		Instantaneous value of =
Phase B apparent power.
>>>> 0xE51B	CVA		in_powerappatent15_phaseC_instantaneous	=
in	powerapparent	15	phaseC	instantaneous	R	24		=
32 SE		S		N/A		Instantaneous value of =
Phase C apparent power.
>>>>=20
>>>> The ADE9000 channels that use the buffer are IA, VA, IB, VB, IC, VC =
and IN =20
>>>>>=20
>>>>> So again we have run out of space. It's increasingly looking like =
we need
>>>>> room for another field in the events - to cleanly represent =
computed values.
>>>>>=20
>>>>> Hmm. What is the current usage? - it's been a while so I had to go
>>>>> look in the header.
>>>>>=20
>>>>> 0-15 Channel (lots of channels)
>>>>> 31-16 Channel 2  (36 modifiers - lots of channels)
>>>>> 47-32 Channel Type (31 used so far - this looks most likely to run =
out of
>>>>> space in the long run so leave this one alone).
>>>>> 54-48 Event Direction (4 used)
>>>>> 55 Differential  (1: channel 2 as differential pair 0: as a =
modifier)
>>>>> 63-56 Event Type (6 used)
>>>>>=20
>>>>> So I think we can pinch bit 53 as another flag to indicate we have
>>>>> a computed value or possibly bit 63 as event types are few and
>>>>> far between as well.
>>>>>=20
>>>>> Probably reasonable to assume we never have 16 bits worth
>>>>> of channels and computed channels at the same time?
>>>>> Hence I think we can steal bits off the top of Channel.
>>>>> How many do we need?  Not sure unfortunately but feels like
>>>>> 8 should be plenty.   =20
>>>> When you speak of Channels here, are you referring to measurements =
that will use the buffer? Even when counting all the IIO attributes, the =
ADE9000 has 462 registers, and not all of those would be defined as =
attributes. I think 8 Bits should be more than enough. =20
>>> Not quite.  This is all about allowing us to differentiate between
>>> the actual channels where a channel is a single measurement that we
>>> are interested in.=20
>>> So we care about 256 measurements that are otherwise =
indistinguishable
>>> using combination of index, modifier and our new propose
>>> computedvalue bit. =20
>> Got it.
>>>=20
>>>>>=20
>>>>> The other element of this is we add a new field to iio_chan_spec
>>>>> to contain 'derived_type' or something like that which has
>>>>> rms and sum squared etc. Over time we can move some of those
>>>>> from the modifiers and free up a few entires there.
>>>>> So modifier might be "X and Y and Z" with a derived_type of=20
>>>>> sum_squared to give existing sum_squared_x_y_z but no
>>>>> rush on that.
>>>>>=20
>>>>> Anyhow so now we have an extra element to play that will result
>>>>> in a different channel.
>>>>>=20
>>>>> Whilst here we should think about any other mods needed to
>>>>> that event structure.  It is a little unfortunate that this
>>>>> will be a breaking change for any old userspace code playing
>>>>> with new drivers but it can't be helped as we didn't have
>>>>> reserved values in the original definition (oops).
>>>>>=20
>>>>> At somepoint we may need to add the 'shared by derived_value'
>>>>> info mask but I think we can ignore that for now (seems
>>>>> moderately unlikely to have anything in it!)   =20
>>>>>>=20
>>>>>> But for now, I followed your instructions from your reply.
>>>>>>=20
>>>>>> After finalizing this one, I will work on the ADE9000, which as =
way more registers ;-)
>>>>>>=20
>>>>>> Once we can agree on the register naming, I will update the =
ADE7854 driver for Rodrigo, which will go a long way to getting it out =
of staging.   =20
>>>>> I'll edit to fit with new scheme and insert indexes which I think =
would be
>>>>> preferred though optional under the ABI as we only have one of =
each type/   =20
>>>>>>=20
>>>>>> Address	Register	IIO Attribute	R/W	Bit Length	=
Bit Length During Communications	Type	Default Value	=
Description
>>>>>> 0x4380	AIGAIN	in_current0_phaseA_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase A current gain adjust.   =20
>>>>> A, B, C, N aren't obvious to the lay reader so I suggest we burn a =
few characters and stick phase in for ABC and just have neutral for
>>>>> the neutral one. Not sure about capitalization or not though.
>>>>>=20
>>>>>> 0x4381	AVGAIN	in_voltage0_phaseA_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase A voltage gain adjust.
>>>>>> 0x4382	BIGAIN	in_current0_phaseB_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase B current gain adjust.
>>>>>> 0x4383	BVGAIN	in_voltage0_phaseB_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase B voltage gain adjust.
>>>>>> 0x4384	CIGAIN	in_current0_phaseC_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase C current gain adjust.
>>>>>> 0x4385	CVGAIN	in_voltage0_phaseC_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase C voltage gain adjust.
>>>>>> 0x4386	NIGAIN	in_current0_neutral_scale	R/W	24	=
32 ZPSE	S	0x000000	Neutral current gain adjust (ADE7868 and =
ADE7878 only).
>>>>>> 0x4387	AIRMSOS	in_current0_phaseA_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A current rms offset.
>>>>>> 0x4388	AVRMSOS	in_voltage0_phaseA_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A voltage rms offset.
>>>>>> 0x4389	BIRMSOS	in_current0_phaseB_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B current rms offset.
>>>>>> 0x438A	BVRMSOS	in_voltage0_phaseB_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B voltage rms offset.
>>>>>> 0x438B	CIRMSOS	in_current0_phaseC_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C current rms offset.
>>>>>> 0x438C	CVRMSOS	in_voltage0_phaseC_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C voltage rms offset.
>>>>>> 0x438D	NIRMSOS	in_current0_neutral_rms_offset	R/W	24	=
32 ZPSE	S	0x000000	Neutral current rms offset (ADE7868 and =
ADE7878 only).
>>>>>> 0x438E	AVAGAIN	in_powerapparent0_phaseA_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase A apparent power gain adjust.
>>>>>> 0x438F	BVAGAIN	in_powerapparent0_phaseB_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase B apparent power gain adjust.
>>>>>> 0x4390	CVAGAIN	in_powerapparent0_phaseC_scale	R/W	24	=
32 ZPSE	S	0x000000	Phase C apparent power gain adjust.
>>>>>> 0x4391	AWGAIN	in_power0_phaseA_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase A total active power gain adjust.
>>>>>> 0x4392	AWATTOS	in_power0_phaseA_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase A total active power offset adjust.
>>>>>> 0x4393	BWGAIN	in_power0_phaseB_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase B total active power gain adjust.
>>>>>> 0x4394	BWATTOS	in_power0_phaseB_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase B total active power offset adjust.
>>>>>> 0x4395	CWGAIN	in_power0_PhaseC_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase C total active power gain adjust.
>>>>>> 0x4396	CWATTOS	in_power0_phaseC_offset	R/W	24	32 ZPSE	=
S	0x000000	Phase C total active power offset adjust.
>>>>>> 0x4397	AVARGAIN	in_powerreactive0_phaseA_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase A total reactive power =
gain adjust (ADE7858, ADE7868, and ADE7878).
>>>>>> 0x4398	AVAROS	in_powerreactive0_phaseA_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase A total reactive power offset =
adjust (ADE7858, ADE7868, and ADE7878).
>>>>>> 0x4399	BVARGAIN	in_powerreactive0_phaseB_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase B total reactive power =
gain adjust (ADE7858, ADE7868, and ADE7878).
>>>>>> 0x439A	BVAROS	in_powerreactive0_phaseB_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase B total reactive power offset =
adjust (ADE7858, ADE7868, and ADE7878).
>>>>>> 0x439B	CVARGAIN	in_powerreactive0_phaseC_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase C total reactive power =
gain adjust (ADE7858, ADE7868, and ADE7878).
>>>>>> 0x439C	CVAROS	in_powerreactive0_phaseC_offset	R/W	24	=
32 ZPSE	S	0x000000	Phase C total reactive power offset =
adjust (ADE7858, ADE7868, and ADE7878).
>>>>>> 0x439D	AFWGAIN	in_power0_phaseA_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase A fundamental active power =
gain adjust. Location reserved for ADE7854, ADE7858, and ADE7868.   =20
>>>>> Hmm. fundamental is the oddity here.  I here because  it is sort =
of a derived value
>>>>> and sort of a filter applied.  Can it be sensible combined with =
RMS? probably not but
>>>>> it can be combined with peak for example (which I'd also ideally =
move into
>>>>> the derived representation.).   =20
>>>> Includes only the measurement spectrum at 50Hz or 60Hz and does not =
include harmonic.  =20
>>> I think for that we need to define a different indexed channel and =
define
>>> the filters applied with appropriate values to make it a band pass =
at these
>>> frequencies.  We may need to expand the current filter definitions =
to do this
>>> but that is fine if needed.
>>>=20
>>>=20
>>>>=20
>>>>>=20
>>>>>> 0x439E	AFWATTOS	in_power0_phaseA_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase A fundamental =
active power offset adjust. Location reserved for ADE7854, ADE7858, and =
ADE7868.
>>>>>> 0x439F	BFWGAIN	in_power0_phaseB_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase B fundamental active power =
gain adjust (ADE7878 only).
>>>>>> 0x43A0	BFWATTOS	in_power0_phaseB_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase B fundamental =
active power offset adjust (ADE7878 only).
>>>>>> 0x43A1	CFWGAIN	in_power0_phaseC_fundamental_scale	R/W	=
24	32 ZPSE	S	0x000000	Phase C fundamental active power =
gain adjust.
>>>>>> 0x43A2	CFWATTOS	in_power0_phaseC_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase C fundamental =
active power offset adjust (ADE7878 only).
>>>>>> 0x43A3	AFVARGAIN	=
in_powerreactive0_phaseA_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase A fundamental reactive power gain adjust =
(ADE7878 only).
>>>>>> 0x43A4	AFVAROS	in_powerreactive0_phaseA_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase A fundamental =
reactive power offset adjust (ADE7878 only).
>>>>>> 0x43A5	BFVARGAIN	=
in_powerreactive0_phaseB_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase B fundamental reactive power gain adjust =
(ADE7878 only).
>>>>>> 0x43A6	BFVAROS	in_powerreactive0_phaseB_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase B fundamental =
reactive power offset adjust (ADE7878 only).
>>>>>> 0x43A7	CFVARGAIN	=
in_powerreactive0_phaseC_fundamental_scale	R/W	24	32 ZPSE	=
S	0x000000	Phase C fundamental reactive power gain adjust =
(ADE7878 only).
>>>>>> 0x43A8	CFVAROS	in_powerreactive0_phaseC_fundamental_offset	=
R/W	24	32 ZPSE	S	0x000000	Phase C fundamental =
reactive power offset adjust (ADE7878 only).
>>>>>> 0x43A9	VATHR1	regiister_VATHR1	R/W	24	32 ZP	=
U	0x000000	Most significant 24 bits of VATHR[47:0] =
threshold used in phase apparent power datapath.   =20
>>>>> Do not expose these to userspace. Why would it care?   =20
>>>> Brilliant, yes these should be moved the the DeviceTree (DT) =20
>>>=20
>>> Cool
>>>=20
>>>>>=20
>>>>>> 0x43AA	VATHR0	register_VATHR0	R/W	24	32 ZP	U	=
0x000000	Less significant 24 bits of VATHR[47:0] threshold used =
in phase apparent power datapath.
>>>>>> 0x43AB	WTHR1	register_WTHR1	R/W	24	32 ZP	U	=
0x000000	Most significant 24 bits of WTHR[47:0] threshold used in =
phase total/fundamental active power datapath.
>>>>>> 0x43AC	WTHR0	register_WTHR0	R/W	24	32 ZP	U	=
0x000000	Less significant 24 bits of WTHR[47:0] threshold used in =
phase total/fundamental active power datapath.
>>>>>> 0x43AD	VARTHR1	register_VARTHR1	R/W	24	32 ZP	=
U	0x000000	Most significant 24 bits of VARTHR[47:0] =
threshold used in phase total/fundamental reactive power datapath =
(ADE7858, ADE7868, and ADE7878).
>>>>>> 0x43AE	VARTHR0	register_VARTHR0	R/W	24	32 ZP	=
U	0x000000	Less significant 24 bits of VARTHR[47:0] =
threshold used in phase total/fundamental reactive power datapath =
(ADE7858, ADE7868, and ADE7878).
>>>>>> 0x43AF	Reserved		N/A4	N/A4	N/A4	N/A4	=
0x000000	This memory location should be kept at 0x000000 for =
proper operation.
>>>>>> 0x43B0	VANOLOAD	register_VANOLOAD	R/W	24	=
32 ZPSE	S	0x0000000	No load threshold in the apparent power =
datapath.   =20
>>>>> This one is kind of an event parameter, but one that controls =
internal creep prevention.
>>>>> This will be a driver specific attr I think for now. We may add it =
to info_mask
>>>>> later if we get lots of meter drivers.=20
>>>>> Something like
>>>>> in_power0_no_load_thresh though I haven't really thought about it =
or looked
>>>>> for similar precedence.   =20
>>>> Again, this is something that would be set and never changed, so I =
think this should be moved to DT. =20
>>>=20
>>> Cool.
>>>=20
>>>>>=20
>>>>>=20
>>>>>> 0x43B1	APNOLOAD	register_APNOLOAD	R/W	24	=
32 ZPSE	S	0x0000000	No load threshold in the =
total/fundamental active power datapath.   =20
>>>>> in_activepower0_no_load_thresh   =20
>>>> DT =20
>>>>>> 0x43B2	VARNOLOAD	register_VARNOLOAD	R/W	24	=
32 ZPSE	S	0x0000000	No load threshold in the =
total/fundamental reactive power datapath. Location reserved for =
ADE7854.   =20
>>>>> in_reactivpower0_no_load_thresh   =20
>>>> DT =20
>>>>>=20
>>>>>> 0x43B3	VLEVEL	register_VLEVEL	R/W	24	32 ZPSE	S	=
0x000000	Register used in the algorithm that computes the =
fundamental active and reactive powers (ADE7878 only).   =20
>>>>> This one looks like a characteristic of the circuit attached.  So =
should be devicetree
>>>>> or similar and not exposed to userspace.   =20
>>>> DT =20
>>>>>=20
>>>>>> 0x43B5	DICOEFF	register_DICOEFF	R/W	24	32 ZPSE	=
S	0x0000000	Register used in the digital integrator =
algorithm. If the integrator is turned on, it must be set at 0xFF8000. =
In practice, it is transmitted as 0xFFF8000.   =20
>>>>> no userspace interface.   =20
>>>> DT =20
>>>>>=20
>>>>>> 0x43B6	HPFDIS	register_HPFDIS	R/W	24	32 ZP	U	=
0x000000	Disables/enables the HPF in the current datapath (see =
Table 34).   =20
>>>>> We have controls for high pass filters, you'll need to map on to =
them.
>>>>> Disable is usually setting 3DB point to 0 IIRC.   =20
>>>> DT =20
>>>>>=20
>>>>>> 0x43B8	ISUMLVL	register_ISUMLVL	R/W	24	32 ZPSE	=
S	0x000000	Threshold used in comparison between the sum of =
phase currents and the neutral current (ADE7868 and ADE7878 only).   =20
>>>>> This is an event threshold so needs to map to the events =
infrastructure
>>>>> as best we can.  It's actually a pain to describe so may be device =
specific ABI.   =20
>>>> DT. I=E2=80=99m not sure why this would be mapped to the events =
infrastructure? There is no event generated by this register. =20
>>> Control parameter of an event I think?
>>> So the event description is separate from that of the channels and =
has it's
>>> own extended ABI to describe this sort of value. =20
>> Do you have an example where a control parameter is used with an =
event?=20
>> I have not seen this anywhere.
>=20
> Sure in the abi docs these are easy to find as they have
> the type of event in the name.
>=20
> Taking a few relevant entries...
>=20
> /sys/.../events/in_accel_thresh_rising_en
> /sys/.../events/in_accel_thresh_rising_value
> /sys/.../events/in_accel_x_thresh_rising_hysteresis
> /sys/.../events/in_accel_x_thresh_rising_period
> /sys/.../events/in_accel_thresh_rising_low_pass_filter_3db
>=20
> Grep for iio_event_spec to find how they are defined.  It's pretty
> similar to a channel and they are associated with a particular =
channel.
I=E2=80=99ll take a look.
>=20
>>>=20
>>>>>=20
>>>>>> 0x43BF	ISUM	register_ISUM	R	28	32 ZP	S	=
N/A4	Sum of IAWV, IBWV, and ICWV registers (ADE7868 and ADE7878 =
only).   =20
>>>>> So this would be using a modifier for AandBandC phases (similar to =
the XandYanZ ones for mems devices and
>>>>> a derived value of sum I think So would look something like.
>>>>> in_current0_phaseA&phaseB&phaseC_sum and yet another channel
>>>>>=20
>>>>>> 0x43C0	AIRMS	in_current0_phaseA_rms	R	24	32 ZP	=
S	N/A4	Phase A current rms value.
>>>>>> 0x43C1	AVRMS	in_voltage0_phaseA_rms	R	24	32 ZP	=
S	N/A4	Phase A voltage rms value.
>>>>>> 0x43C2	BIRMS	in_current0_phaseB_rms	R	24	32 ZP	=
S	N/A4	Phase B current rms value.
>>>>>> 0x43C3	BVRMS	in_voltage0_phaseB_rms	R	24	32 ZP	=
S	N/A4	Phase B voltage rms value.
>>>>>> 0x43C4	CIRMS	in_current0_phaseC_rms	R	24	32 ZP	=
S	N/A4	Phase C current rms value.
>>>>>> 0x43C5	CVRMS	in_voltage0_phaseC_rms	R	24	32 ZP	=
S	N/A4	Phase C voltage rms value.
>>>>>> 0x43C6	NIRMS	in_current0_neutral_rms	R	24	32 ZP	=
S	N/A4	Neutral current rms value (ADE7868 and ADE7878 only).
>>>>>> 0xE228	Run	register_Run	R/W	16	16	U	=
0x0000	Run register starts and stops the DSP. See the Digital Signal =
Processor section for more details.   =20
>>>>> Not exposed to userspace.   =20
>>>> DT =20
>>>>>=20
>>>>>> 0xE400	AWATTHR	in_energy0_phaseA_raw	R	32	32	=
S	0x00000000	Phase A total active energy accumulation.
>>>>>> 0xE401	BWATTHR	in_energy0_phaseB_raw	R	32	32	=
S	0x00000000	Phase B total active energy accumulation.
>>>>>> 0xE402	CWATTHR	in_energy0_phaseC_raw	R	32	32	=
S	0x00000000	Phase C total active energy accumulation.
>>>>>> 0xE403	AFWATTHR	in_energy0_phaseA_fundamental_raw	=
R	32	32	S	0x00000000	Phase A fundamental =
active energy accumulation (ADE7878 only).
>>>>>> 0xE404	BFWATTHR	in_energy0_phaseB_fundamental_raw	=
R	32	32	S	0x00000000	Phase B fundamental =
active energy accumulation (ADE7878 only).
>>>>>> 0xE405	CFWATTHR	in_energy0_phaseC_fundamental_raw	=
R	32	32	S	0x00000000	Phase C fundamental =
active energy accumulation (ADE7878 only).
>>>>>> 0xE406	AVARHR	in_energyreactive0_phaseA_raw	R	32	=
32	S	0x00000000	Phase A total reactive energy =
accumulation (ADE7858, ADE7868, and ADE7878 only).
>>>>>> 0xE407	BVARHR	in_energyreactive0_phaseB_raw	R	32	=
32	S	0x00000000	Phase B total reactive energy =
accumulation (ADE7858, ADE7868, and ADE7878 only).
>>>>>> 0xE408	CVARHR	in_energyreactive0_phaseC_raw	R	32	=
32	S	0x00000000	Phase C total reactive energy =
accumulation (ADE7858, ADE7868, and ADE7878 only).
>>>>>> 0xE409	AFVARHR	in_energyreactive0_phaseA_fundamental_raw	=
R	32	32	S	0x00000000	Phase A fundamental =
reactive energy accumulation (ADE7878 only).
>>>>>> 0xE40A	BFVARHR	in_energyreactive0_phaseB_fundamental_raw	=
R	32	32	S	0x00000000	Phase B fundamental =
reactive energy accumulation (ADE7878 only).
>>>>>> 0xE40B	CFVARHR	in_energyreactive0_phaseC_fundamental_raw	=
R	32	32	S	0x00000000	Phase C fundamental =
reactive energy accumulation (ADE7878 only).
>>>>>> 0xE40C	AVAHR	in_energyapparent0_phaseA_raw	R	32	=
32	S	0x00000000	Phase A apparent energy accumulation.
>>>>>> 0xE40D	BVAHR	in_energyapparent0_phaseB_raw	R	32	=
32	S	0x00000000	Phase B apparent energy accumulation.
>>>>>> 0xE40E	CVAHR	in_energyapparent0_phaseC_raw	R	32	=
32	S	0x00000000	Phase C apparent energy accumulation.
>>>>>> 0xE500	IPEAK	in_current0_peak	R	32	32	=
U	N/A	Current peak register. See Figure 50 and Table 35 for =
details about its composition.   =20
>>>>> Oh goody. I have no idea how we expose the which phase element of =
this
>>>>> cleanly.  One option I suppose is to have in_current0_phaseA_peak =
etc
>>>>> and have all but the current peak return an error when read? It is =
a bit
>>>>> nasty but only so much we can do and keep with a consistent =
interface.
>>>>>=20
>>>>>> 0xE501	VPEAK	in_voltage_peak	R	32	32	U	=
N/A	Voltage peak register. See Figure 50 and Table 36 for details =
about its composition.   =20
>>>>> Same as peak.
>>>>>=20
>>>>>> 0xE502	STATUS0	register_STATUS0	R/W	32	32	=
U	N/A	Interrupt Status Register 0. See Table 37.
>>>>>> 0xE503	STATUS1	register_STATUS1	R/W	32	32	=
U	N/A	Interrupt Status Register 1. See Table 38.   =20
>>>>> No userspace interface except via events interface or error =
reports.   =20
>>>> Isn=E2=80=99t this tied to the event framework? My thinking is the =
user interface should be notified when certain conditions occur. =20
>>>=20
>>> Probably depending on the condition.  If it looks like a threshold =
on something
>>> it can go through as an event.  If it is a 'fault' detection in the =
measurement
>>> hardware we need to look at a RAS type notification. This is always =
a tricky
>>> topic and the upshot is we normally just end up dumping them in the =
kernel log
>>> as anything else is hard to do (from a persuading other people of =
it's importance
>>> point of view). =20
>> Let=E2=80=99s take some examples:
>> STATUS0:0	AEHF	Bit set when the Watt hour registers reach =
threshold.
>> This means the Watt hour registers must be read or the watt hour =
register will=20
>> wrap and you will loose the energy accumulated. So I=E2=80=99m not =
sure how IIO handles=20
>> events with user space, but can I assume it is using a poll or select =
to monitor for=20
>> events?
>=20
> Do we get interrupts to indicate a state change in here?  We can poll =
otherwise
> but it's not exactly elegant to do so.  Had a quick look - as this is =
the
> interrupt status register we are fine :)
Yes, there is an interrupt associated with this status register. There =
is also a mask
register to prevent an interrupt from any of these events.=20
>=20
> This would be controlled by something like.
> in_power0_thresh_rising_value
>=20
> =46rom a userspace point of view, there is an ioctl that gets you an =
anonymous
> chardev.  Once you have that you can use poll / select to monitor for =
events
> and act on them.
Perfect
>=20
> There is example code in the iio_event_monitor program in toos/iio in =
the
> kernel tree.
I=E2=80=99ll take a look
>=20
>=20
>>=20
>> STATUS0:6	REVAPA	ACCMODE has changed sign. Power is exported =
rather
>> than imported. User space application would use this to indicate the =
direction
>> of power flow.
> This is where we start to run into a problem - mostly IIO only allows =
for
> a single threshold for rising and falling on a given channel.  No way =
to
> tell which one triggered in the ABI - even code says what and on what =
channel
> it doesn't distinguish multiple levels.
Yeah, there is no threshold here. It occurs with the phase exceeds 90 =
deg,
which indicates that the power is now being exported to the grid.
>=20
> We can play games with defining additional channels but it isn't that =
elegant.
> Now assuming we want to do both directions of change..
Correct, we need to know when the power is flowing from the power grid =
or
flowing to the power grid. This is common with Distributed Energy =
Resources
(DER) such as solar panels or wind farms.=20
>=20
> in_power0_thresh_either_value =3D 0
> (to indicate a transition across 0 power - I assume the other =
direction is
> negative?)
> and associated event code.
>=20
>>=20
>> STATUS1:0	NLOAD	At least one phase has entered no load =
condition. User=20
>> space app would probably alert the user of a faulty condition.
> Not sure what this maps to - but would be based on how it was =
detected.
> Is this effectively 0 current?
The ADC is noisy and doesn=E2=80=99t output 0x000 when the current is =
0A, so anything=20
below a defined threshold is considered to be NoLoad.
>=20
>>=20
>> STATUS1:3	ZXTOVA	Indicates Phase A voltage zero crossing is =
missing. This=20
>> is another fault condition.
>=20
> Similar to the rate of change detection in some ways, but only =
explicitly looks
> at the 0 point.  We would need something new to represent this I =
think=E2=80=A6
This occurs when we have a phase failure (transformer failure, etc) or a =
sensor=20
failure (wiring failure, etc). If phase failure occurs, it could cause =
damage to=20
equipment like a motor.
>=20
>>=20
>> STATUS1:16	SAG	This indicates a sag occurred on one of the =
phases. User=20
>> space appmight signal the user and record this condition to a log =
file.
> This is effectively a measurement of our AC voltage dropping?  Simple =
threshold
> event on the phase voltage I think.
>>=20
>> STATUS1:17	OV		This indicates that an over voltage =
event occurred and a=20
>> user space app would signal the user and record this to a log file.
> Voltage threshold.
>=20
>>=20
>> All of these conditions can be masked via the MASK0 and MASK1 =
registers.
>>=20
>> Not sure how IIO would handle this?
> Masking is handled via the relevant *_en attributes for the events.
Nice
>=20
>>=20
>>>=20
>>>=20
>>>>>=20
>>>>>> 0xE504	AIMAV	in_currentA_mav	R	20	32 ZP	U	=
N/A	Phase A current mean absolute value computed during PSM0 and =
PSM1 modes (ADE7868 and ADE7878 only).   =20
>>>>> Probably a longer name as mav is cryptic.
>>>>> in_current0_phaseA_meanabs_raw - it could have a scale and all =
sorts of fun.
>>>>> So I think this needs to be using the new derived infrastructure =
proposed here
>>>>> rather than being an info_mask element.   =20
>>>> The same way a knowledgeable person understands what RMS means, so =
they should also understand what MAV means.  =20
>>> hehe. I know RMS and not MAV so I suspect it a bit dependent on =
where exactly you came across
>>> the terms ;) =20
>> MAV is just another way to calculate RMS, but is not as accurate. It =
is just a statistical term,=20
>> Mean Absolute Value (MAV).
> Sure.
>=20
>>>=20
>>>>>=20
>>>>>> 0xE505	BIMAV	in_currentB_mav	R	20	32 ZP	U	=
N/A	Phase B current mean absolute value computed during PSM0 and =
PSM1 modes (ADE7868 and ADE7878 only).
>>>>>> 0xE506	CIMAV	in_currentC_mav	R	20	32 ZP	U	=
N/A	Phase C current mean absolute value computed during PSM0 and =
PSM1 modes (ADE7868 and ADE7878 only).
>>>>>> 0xE507	OILVL	register_OILVL	R/W	24	32 ZP	U	=
0xFFFFFF	Overcurrent threshold.
>>>>>> 0xE508	OVLVL	register_OVLVL	R/W	24	32 ZP	U	=
0xFFFFFF	Overvoltage threshold.   =20
>>>>> These presumably result in interrupts? (I'm running out of time so =
not checking)
>>>>> In which case standard event interface should work.
>>>>>=20
>>>>>> 0xE509	SAGLVL	register_SAGLVL	R/W	24	32 ZP	U	=
0x000000	Voltage SAG level threshold.   =20
>>>>> That's another event I think=E2=80=A6    =20
>>>> Again, this is only setting the threshold, not generating any =
event. =20
>>>=20
>>> What does the threshold result it?  Presumably an event so this is =
exposed as a
>>> control parameter of the event.  There is a whole set of ABI for =
that=E2=80=A6 =20
>> Where can I read about this. Are there any good implementations to =
help me understand?
> In a simple case see something like adc/max1363.c
>=20
> There are more complex cases - just grep iio_event_spec.
I=E2=80=99ll take a look
>=20
>>>=20
>>>=20
>>>>>=20
>>>>>> 0xE50A	MASK0	register_MASK0	R/W	32	32	U	=
0x00000000	Interrupt Enable Register 0. See Table 39.
>>>>>> 0xE50B	MASK1	register_MASK1	R/W	32	32	U	=
0x00000000	Interrupt Enable Register 1. See Table 40.   =20
>>>>>=20
>>>>>> 0xE50C	IAWV	in_currentA_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A current.
>>>>>> 0xE50D	IBWV	in_currentB_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B current.
>>>>>> 0xE50E	ICWV	in_currentC_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C current.
>>>>>> 0xE50F	INWV	in_currentN_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of neutral current (ADE7868 =
and ADE7878 only).
>>>>>> 0xE510	VAWV	in_voltageA_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A voltage.
>>>>>> 0xE511	VBWV	in_voltageB_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B voltage.
>>>>>> 0xE512	VCWV	in_voltageC_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C voltage.   =20
>>>>> OK, this is getting silly.  I presume this means the values above =
are filtered and these
>>>>> aren't?  If so you need to have channels for both and different =
filter values.   =20
>>>> These are the actual samples from the ADC and not a calculated =
measurement over 10/12 cycles. These are the samples that are placed in =
the buffer. =20
>>> OK, so DC values which answers my question above.
>>> So this is the 'normal' measurement.  For the multi cycle ones we =
need to
>>> represent them as additional measurements using the index and =
describe the
>>> filtering applied to them (or use altvoltage etc to say we are =
looking
>>> at measurements related to the fact they are alternating rather than =
DC. =20
>> I answered this above. I think we should remove these registers as I =
cannot see how anyone would use=20
>> them
> Cool. Even easier.   Though if we have a device that will allow us to =
push these
> through the buffered interface (rather than the SPI master stuff on =
here)
> then we would have the channels, but not export the _RAW attribute - =
thus
> making them readable only as a stream of data.
There is no way to read all these instantaneous registers every 125uS. =
The=20
SPI master interface is the only way to retrieve these measurements,=20
running at about 4Mbps.=20
>=20
>>>=20
>>>>>=20
>>>>>> 0xE513	AWATT	in_powerA_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase A total active power.
>>>>>> 0xE514	BWATT	in_powerB_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase B total active power.
>>>>>> 0xE515	CWATT	in_powerC_instantaneous	R	24	32 SE	=
S	N/A	Instantaneous value of Phase C total active power.
>>>>>> 0xE516	AVAR	in_powerreactiveA_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>>>>>> 0xE517	BVAR	in_powerreactiveB_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>>>>>> 0xE518	CVAR	in_powerreactiveC_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C total reactive =
power (ADE7858, ADE7868, and ADE7878 only).
>>>>>> 0xE519	AVA	in_powerapparentA_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase A apparent power.
>>>>>> 0xE51A	BVA	in_powerapparentB_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase B apparent power.
>>>>>> 0xE51B	CVA	in_powerappatentC_instantaneous	R	24	=
32 SE	S	N/A	Instantaneous value of Phase C apparent power.   =
=20
>>>>> Same for all of these.
>>>>>=20
>>>>>> 0xE51F	CHECKSUM	register_CHECKSUM	R	32	=
32	U	0x33666787	Checksum verification. See the Checksum =
Register section for details.   =20
>>>>> Not exposed to userspace.   =20
>>>> Yeah, this is only used to check the communication for errors. =20
>>>>>=20
>>>>>> 0xE520	VNOM	in_voltage_rms_nominal	R/W	24	32 ZP	=
S	0x000000	Nominal phase voltage rms used in the =
alternative computation of the apparent power. When the VNOMxEN bit is =
set, the applied voltage input in the corresponding phase is ignored and =
all corresponding rms voltage instances are replaced by the value in the =
VNOM register.   =20
>>>>> Why would this be done?  Sounds like something that is a circuit =
design time
>>>>> decision so a job for DT to me.   =20
>>>> Yeah, I agree. =20
>>>>>=20
>>>>>> 0xE600	PHSTATUS	in_current_phase_peak	R	16	=
16	U	N/A	Phase peak register. See Table 41.
>>>>>> 0xE601	ANGLE0	register_ANGLE0	R	16	16	U	=
N/A	Time Delay 0. See the Time Interval Between Phases section for =
details.
>>>>>> 0xE602	ANGLE1	register_ANGLE1	R	16	16	U	=
N/A	Time Delay 1. See the Time Interval Between Phases section for =
details.
>>>>>> 0xE603	ANGLE2	register_ANGLE2	R	16	16	U	=
N/A	Time Delay 2. See the Time Interval Between Phases section for =
details.   =20
>>>>> Hmm. More fun.  These are derived values between to phase =
measurements.=20
>>>>> The phase as a modifier falls down a bit here - if we had just =
treated
>>>>> them as channels we could have done this a differential angle =
channel.
>>>>> Right now I'm not sure how we do this, could do it as a derived =
values so something like
>>>>> in_angle0_phaseA&phaseB_diff_raw etc but that feels odd.
>>>>> This one needs more thought.
>>>>>=20
>>>>>> 0xE604 to 0xE606	Reserved						=
	These addresses should not be written for proper operation.
>>>>>> 0xE607	PERIOD	register_PERIOD	R	16	16	U	=
N/A	Network line period.   =20
>>>>> Superficially this sounds like a channel free element so =
shared_by_all.
>>>>>=20
>>>>>> 0xE608	PHNOLOAD	register_PHNOLOAD	R	16	=
16	U	N/A	Phase no load register. See Table 42.   =20
>>>>> Hmm. So this is kind of a set of events with but without I think =
an interrupt.
>>>>> Odd.
>>>>>=20
>>>>>> 0xE60C	LINECYC	register_LINECYC	R/W	16	16	=
U	0xFFFF	Line cycle accumulation mode count.   =20
>>>>> in_count0_raw probably though it's a bit of a stretch.
>>>>>=20
>>>>>> 0xE60D	ZXTOUT	register_ZXTOUT	R/W	16	16	U	=
0xFFFF	Zero-crossing timeout count.   =20
>>>>> This is going to be another top level one I think and device =
specific for now.
>>>>>=20
>>>>>> 0xE60E	COMPMODE	register_COMPMODE	R/W	16	=
16	U	0x01FF	Computation-mode register. See Table 43.   =20
>>>>> If there is stuff to control in here it need breaking out.
>>>>>=20
>>>>>> 0xE60F	Gain	register_Gain	R/W	16	16	U	=
0x0000	PGA gains at ADC inputs. See Table 44.   =20
>>>>> Oh goody another scale value. Needs breaking up into separate =
controls.
>>>>> Do these directly effect the measured output voltage etc? If they =
do then
>>>>> I'm not sure how to separate the two gains, there ought to be a =
'right'
>>>>> answer.  If this is about matching to the circuit present then =
they
>>>>> should probably be coming from DT or simillar.
>>>>>=20
>>>>>=20
>>>>>> 0xE610	CFMODE	register_CFMODE	R/W	16	16	U	=
0x0E88	CFx configuration register. See Table 45.
>>>>>> 0xE611	CF1DEN	register_CF1DEN	R/W	16	16	U	=
0x0000	CF1 denominator.
>>>>>> 0xE612	CF2DEN	register_CF2DEN	R/W	16	16	U	=
0x0000	CF2 denominator.
>>>>>> 0xE613	CF3DEN	register_CF3DEN	R/W	16	16	U	=
0x0000	CF3 denominator.   =20
>>>>> Are these things that should be in DT?  Look very quickly like =
they are todo with other circuits nearby.   =20
>>>> Agreed =20
>>>>>=20
>>>>>> 0xE614	APHCAL	register_APHCAL	R/W	10	16 ZP	S	=
0x0000	Phase calibration of Phase A. See Table 46.
>>>>>> 0xE615	BPHCAL	register_BPHCAL	R/W	10	16 ZP	S	=
0x0000	Phase calibration of Phase B. See Table 46.
>>>>>> 0xE616	CPHCAL	register__CPHCAL	R/W	10	16 ZP	=
S	0x0000	Phase calibration of Phase C. See Table 46.   =20
>>>>> I'm not actually sure how you would set these.  Per circuit =
design?   =20
>>>> There should be some base calibration stored in DT and fine tuned =
calibration stored in an INI file or custom eeprom of nvram.  =20
>>> Hmm. Then we need to expose them to userspace to allow that INI to =
be applied.
>>>=20
>>> Lets deal with the rest first and come back to these. May well need
>>> some device specific ABI which is always annoying.. =20
>> Agreed
>>>=20
>>>>>=20
>>>>>> 0xE617	PHSIGN	register_PHSIGN	R	16	16	U	=
N/A	Power sign register. See Table 47.
>>>>>> 0xE618	CONFIG	register_CONFIG	R/W	16	16	U	=
0x0000	ADE7878 configuration register. See Table 48.
>>>>>> 0xE700	MMODE	register__MMODE	R/W	8	8	U	=
0x1C	Measurement mode register. See Table 49.
>>>>>> 0xE701	ACCMODE	register__ACCMODE	R/W	8	8	=
U	0x00	Accumulation mode register. See Table 50.
>>>>>> 0xE702	LCYCMODE	register_LCYCMODE	R/W	8	=
8	U	0x78	Line accumulation mode behavior. See Table 52.   =
=20
>>>> All to DT =20
>>>>>> 0xE703	PEAKCYC	register_PEAKCYC	R/W	8	8	=
U	0x00	Peak detection half line cycles.
>>>>>> 0xE704	SAGCYC	register_SAGCYC	R/W	8	8	U	=
0x00	SAG detection half line cycles.   =20
>>>>> Some of these are event controls. Map them as such.   =20
>>>> Agreed =20
>>>>>=20
>>>>>> 0xE705	CFCYC	register_CFCYC	R/W	8	8	U	=
0x01	Number of CF pulses between two consecutive energy latches. See =
the Synchronizing Energy Registers with CFx Outputs section.
>>>>>> 0xE706	HSDC_CFG	register_HSDC_CFG	R/W	8	=
8	U	0x00	HSDC configuration register. See Table 53.   =20
>>>> DT =20
>>>>>> 0xE707	Version	register_Version	R	8	8	=
U		Version of die.   =20
>>>> Might want to expose this to User Space as there could be =
differences between die version
>>>> in_version0_raw =20
>>>>>> 0xEBFF	Reserved			8	8			=
This address can be used in manipulating the SS/HSA pin when SPI is =
chosen as the active port. See the Serial Interfaces section for =
details.
>>>>>> 0xEC00	LPOILVL	register_LPOILVL	R/W	8	8	=
U	0x07	"Overcurrent threshold used during PSM2 mode (ADE7868 =
and ADE7878
>>>>>> only). See Table 54 in which the register is detailed."
>>>>>> 0xEC01	CONFIG2	register_CONFIG2	R/W	8	8	=
U	0x00	Configuration register used during PSM1 mode. See Table =
55.   =20
>>>> All to DT =20
>>>>>=20
>>>>> As you can guess I was running out of stamina towards the end of =
that.
>>>>>=20
>>>>> I'm not totally sure of the answer I provided. It may take some =
more thought.
>>>>> Ideally some others will give input on this question.   =20
>>>>=20
>>>> Thank you again for all your feedback. I=E2=80=99ll generate a new =
list and send it next. =20
>>> Cool.
>>>=20
>>> Jonathan
>>>=20
>>>>=20
>>>> Regards,
>>>> John =20
>>>>>=20
>>>>> Jonathan   =20
>>>>>>=20
>>>>>> Regards,
>>>>>> John
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On Mar 17, 2018, at 1:30 PM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>>>>>>>=20
>>>>>>> On Wed, 14 Mar 2018 23:12:02 -0700
>>>>>>> John Syne <john3909@gmail.com> wrote:
>>>>>>>=20
>>>>>>>> Hi Jonathan,
>>>>>>>>=20
>>>>>>>> I have been looking at the IIO ABI docs and if I understand
>>>>>>>> correctly, the idea is to use consistent naming conventions? So =
for
>>>>>>>> example, looking at the ADE7854 datasheet, the naming matching =
the
>>>>>>>> ADE7854 registers would be as follows:     =20
>>>>>>>=20
>>>>>>> Welcome to one of the big reasons no one tidied these drivers
>>>>>>> up originally.  Still we have moved on somewhat since then
>>>>>>> so similar circumstances have come up in other types of sensor.
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> {direction}_{type}_{index}_{modifier}_{info_mask}
>>>>>>>>=20
>>>>>>>> AIGAIN	-	In_current_a_gain     =20
>>>>>>> Other than the fact that gain isn't an ABI element and that =
index
>>>>>>> doesn't have
>>>>>>> _ before it that is right.
>>>>>>> in_voltageA_scale
>>>>>>>=20
>>>>>>> That was a weird quirk a long time back which we should probably
>>>>>>> not have done (copied it from hwmon)
>>>>>>>=20
>>>>>>>> AVGAIN	-	in_voltage_a_gain
>>>>>>>> BIGAIN	-	in_current_b_gain
>>>>>>>> BVGAIN	-	in_voltage_b_gain
>>>>>>>> =E2=80=94
>>>>>>>> How do we represent the rms and offset
>>>>>>>> AIRMSOS	-	in_current_a_rmsoffset
>>>>>>>> AVRMSOS	-	in_voltage_a_rmsoffset     =20
>>>>>>>=20
>>>>>>> Right now we can't unfortunately though this one is easier to =
fix.
>>>>>>> We already have modifiers for multi axis devices doing =
sum_squared
>>>>>>> so add one of those for root_mean_square - this one is well =
known
>>>>>>> enough that rms is fine in the string.
>>>>>>>=20
>>>>>>> It's a effectively a different channel be it one derived from a =
simple
>>>>>>> one.  This is going to get tricky however as we would normally =
use
>>>>>>> modifier to specialise a channel type - thoughts on this below.
>>>>>>>=20
>>>>>>>> =E2=80=94
>>>>>>>> Here I don=E2=80=99t understand how to represent both the phase =
and the active/reactive/apparent power components. Do we combine the =
phase and quadrature part like this
>>>>>>>> AVAGAIN		-	in_power_a_gain				=
/* apparent power */
>>>>>>>> =E2=80=94
>>>>>>>> AWGAIN		-	in_power_ai_gain				=
/* active power */     =20
>>>>>>> And that is the problem.  How do we represent the various power =
types.
>>>>>>> Hmm. We could do it with modifiers but above we show that we =
have already used them.
>>>>>>>=20
>>>>>>> It would be easy enough to add yet another field to the channel =
spec to specify
>>>>>>> this but there is a problem - Events.  The event format is =
already pretty full
>>>>>>> so where do we put this extra element if we need to define a =
channel separated
>>>>>>> only by it.
>>>>>>>=20
>>>>>>> One thought is we could instead define these as different top =
level
>>>>>>> IIO_CHAN_TYPES in a similar fashion to we do for relative =
humidity vs
>>>>>>> the proposed absolute humidity.
>>>>>>>=20
>>>>>>> in_powerreactiveA_scale
>>>>>>> in_poweractivceA_scale
>>>>>>> (or in_powerrealA_scale to match with what I got taught years =
ago?)
>>>>>>>=20
>>>>>>> I presume we keep in_powerA_scale etc for the apparent power and
>>>>>>> modify any docs to make that clear.
>>>>>>>=20
>>>>>>>> =E2=80=94
>>>>>>>> AVARGAIN	-	in_power_aq_gain				=
/* reactive power */
>>>>>>>> =E2=80=94
>>>>>>>> Now here it becomes more complicated. Not sure how this gets =
handled.=20
>>>>>>>> AFWATTOS	-	in_power_a_active/fundamental/offset     =
=20
>>>>>>> Yeah, some of these are getting odd.
>>>>>>> If I read this correctly this is the active power estimate based =
on only
>>>>>>> the fundamental frequency - so no harmonics?
>>>>>>>=20
>>>>>>> Hmm.  This then becomes a separate channel with additional =
properties
>>>>>>> specifying it is only the fundamental.  This feels a bit like a =
filter
>>>>>>> be it an unusual one?  Might just be necessary to add a =
_fundamental_only
>>>>>>> element on the end (would be info_mask if this is common enough =
to
>>>>>>> justify that rather than using the extended methods to define =
it.).
>>>>>>>=20
>>>>>>>=20
>>>>>>>> =E2=80=94
>>>>>>>> AWATTHR	-	in_energy_ai_accumulation     =20
>>>>>>> Great, just when I thought we had gone far enough they define =
reactive
>>>>>>> energy which is presumably roughly the same as reactivepower * =
time?
>>>>>>> In that case we need types for that as well.
>>>>>>> in_energyreactiveA_*
>>>>>>> in_energyactiveA_*
>>>>>>>=20
>>>>>>>> =E2=80=94
>>>>>>>> AVARHR		-	in_energy_aq_accumulation
>>>>>>>> =E2=80=94
>>>>>>>> IPEAK		-	in_current_peak     =20
>>>>>>> That one is easy as we have an info_mask element for peak and =
one
>>>>>>> for peak_scale that has always been a bit odd but was needed =
somewhere.
>>>>>>>=20
>>>>>>>> =E2=80=94
>>>>>>>>=20
>>>>>>>> I=E2=80=99ll leave it there, because there are some even more =
complicated register naming issues.     =20
>>>>>>> Something to look forward to.  Gah, I always hated power =
engineering
>>>>>>> though I taught it very briefly (I really pity those students :(
>>>>>>>=20
>>>>>>> Jonathan
>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Regards,
>>>>>>>> John
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> On Mar 10, 2018, at 7:10 AM, Jonathan Cameron =
<jic23@kernel.org> wrote:
>>>>>>>>>=20
>>>>>>>>> On Thu, 8 Mar 2018 21:37:33 -0300
>>>>>>>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>>>>>>>>>=20
>>>>>>>>>> On 03/07, Jonathan Cameron wrote:       =20
>>>>>>>>>>> On Tue, 6 Mar 2018 21:43:47 -0300
>>>>>>>>>>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>>>>>>>>>>>=20
>>>>>>>>>>>> The macro IIO_DEV_ATTR_CH_OFF is a wrapper for =
IIO_DEVICE_ATTR, with a
>>>>>>>>>>>> tiny change in the name definition. This extra macro does =
not improve
>>>>>>>>>>>> the readability and also creates some checkpatch errors.
>>>>>>>>>>>>=20
>>>>>>>>>>>> This patch fixes the checkpatch.pl errors:
>>>>>>>>>>>>=20
>>>>>>>>>>>> staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal =
(0777) not
>>>>>>>>>>>> decimal permissions
>>>>>>>>>>>> staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal =
(0777) not
>>>>>>>>>>>> decimal permissions
>>>>>>>>>>>> staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal =
(0777) not
>>>>>>>>>>>> decimal permissions
>>>>>>>>>>>> staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal =
(0777) not
>>>>>>>>>>>> decimal permissions
>>>>>>>>>>>>=20
>>>>>>>>>>>> Signed-off-by: Rodrigo Siqueira =
<rodrigosiqueiramelo@gmail.com>         =20
>>>>>>>>>>>=20
>>>>>>>>>>> Hmm. I wondered a bit about this one. It's a correct patch =
in of
>>>>>>>>>>> itself but the interface in question doesn't even vaguely =
conform
>>>>>>>>>>> to any of defined IIO ABI.  Anyhow, it's still and =
improvement so
>>>>>>>>>>> I'll take it.         =20
>>>>>>>>>>=20
>>>>>>>>>> I am not sure if I understood the comment about the ABI. The =
meter
>>>>>>>>>> interface is wrong because it uses things like =
IIO_DEVICE_ATTR? It
>>>>>>>>>> should use iio_info together with *write_raw and *read_raw. =
Right? Is it
>>>>>>>>>> the ABI problem that you refer?       =20
>>>>>>>>> The ABI is about the userspace interface of IIO.  It is =
defined
>>>>>>>>> in Documentation/ABI/testing/sysfs-bus-iio*
>>>>>>>>> So this documents the naming of sysfs attributes and (more or =
less)
>>>>>>>>> describes a consistent interface to userspace across lots of =
different
>>>>>>>>> types of devices.
>>>>>>>>>=20
>>>>>>>>> A lot of these older drivers in staging involve a good deal of =
ABI that
>>>>>>>>> was not reviewed or discussed.  That is one of the biggest =
reasons we
>>>>>>>>> didn't take them out of staging in the first place.
>>>>>>>>>=20
>>>>>>>>> In order for generic userspace programs to have any idea what =
to do
>>>>>>>>> with these devices this all needs to be fixed.
>>>>>>>>>=20
>>>>>>>>> There may well be cases where we need to expand the existing =
ABI to
>>>>>>>>> cover new things.   That's fine, but it has to be done with =
full
>>>>>>>>> review of the relevant documentation patches.
>>>>>>>>>=20
>>>>>>>>> Incidentally if you want an easy driver to work on moving out =
of staging
>>>>>>>>> then first thing to do is to compare what it shows to =
userspace with these
>>>>>>>>> docs.  If it's totally different then you have a big job on =
your hands
>>>>>>>>> as often ABI can take a lot of discussion and a long time to =
establish
>>>>>>>>> a consensus.
>>>>>>>>>=20
>>>>>>>>> Jonathan
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> Thanks :)
>>>>>>>>>>=20
>>>>>>>>>>> Applied to the togreg branch of iio.git and pushed out as =
testing
>>>>>>>>>>> for the autobuilders to play with it.
>>>>>>>>>>>=20
>>>>>>>>>>> I also added the removal of the header define which is no
>>>>>>>>>>> longer used.
>>>>>>>>>>>=20
>>>>>>>>>>> Please note, following discussions with Michael, I am going =
to send
>>>>>>>>>>> an email announcing an intent to drop these meter drivers =
next
>>>>>>>>>>> cycle unless someone can provide testing for any attempt to
>>>>>>>>>>> move them out of staging.  I'm still taking patches on the =
basis
>>>>>>>>>>> that 'might' happen - but I wouldn't focus on these until we
>>>>>>>>>>> have some certainty on whether they will be around long =
term!
>>>>>>>>>>>=20
>>>>>>>>>>> Jonathan
>>>>>>>>>>>=20
>>>>>>>>>>>> ---
>>>>>>>>>>>> drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
>>>>>>>>>>>> drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
>>>>>>>>>>>> 2 files changed, 20 insertions(+), 16 deletions(-)
>>>>>>>>>>>>=20
>>>>>>>>>>>> diff --git a/drivers/staging/iio/meter/ade7753.c =
b/drivers/staging/iio/meter/ade7753.c
>>>>>>>>>>>> index c44eb577dc35..275e8dfff836 100644
>>>>>>>>>>>> --- a/drivers/staging/iio/meter/ade7753.c
>>>>>>>>>>>> +++ b/drivers/staging/iio/meter/ade7753.c
>>>>>>>>>>>> @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
>>>>>>>>>>>> 		ade7753_read_16bit,
>>>>>>>>>>>> 		NULL,
>>>>>>>>>>>> 		ADE7753_PERIOD);
>>>>>>>>>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>>>>>>>>>> -		ade7753_read_8bit,
>>>>>>>>>>>> -		ade7753_write_8bit,
>>>>>>>>>>>> -		ADE7753_CH1OS);
>>>>>>>>>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>>>>>>>>>> -		ade7753_read_8bit,
>>>>>>>>>>>> -		ade7753_write_8bit,
>>>>>>>>>>>> -		ADE7753_CH2OS);
>>>>>>>>>>>> +
>>>>>>>>>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>>>>>>>>>> +			ade7753_read_8bit,
>>>>>>>>>>>> +			ade7753_write_8bit,
>>>>>>>>>>>> +			ADE7753_CH1OS);
>>>>>>>>>>>> +
>>>>>>>>>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>>>>>>>>>> +			ade7753_read_8bit,
>>>>>>>>>>>> +			ade7753_write_8bit,
>>>>>>>>>>>> +			ADE7753_CH2OS);
>>>>>>>>>>>>=20
>>>>>>>>>>>> static int ade7753_set_irq(struct device *dev, bool enable)
>>>>>>>>>>>> {
>>>>>>>>>>>> diff --git a/drivers/staging/iio/meter/ade7759.c =
b/drivers/staging/iio/meter/ade7759.c
>>>>>>>>>>>> index 1decb2b8afab..c078b770fa53 100644
>>>>>>>>>>>> --- a/drivers/staging/iio/meter/ade7759.c
>>>>>>>>>>>> +++ b/drivers/staging/iio/meter/ade7759.c
>>>>>>>>>>>> @@ -328,14 +328,16 @@ static =
IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>>>>>>>>>>>> 		ade7759_read_16bit,
>>>>>>>>>>>> 		ade7759_write_16bit,
>>>>>>>>>>>> 		ADE7759_APGAIN);
>>>>>>>>>>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>>>>>>>>>>> -		ade7759_read_8bit,
>>>>>>>>>>>> -		ade7759_write_8bit,
>>>>>>>>>>>> -		ADE7759_CH1OS);
>>>>>>>>>>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
>>>>>>>>>>>> -		ade7759_read_8bit,
>>>>>>>>>>>> -		ade7759_write_8bit,
>>>>>>>>>>>> -		ADE7759_CH2OS);
>>>>>>>>>>>> +
>>>>>>>>>>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
>>>>>>>>>>>> +			ade7759_read_8bit,
>>>>>>>>>>>> +			ade7759_write_8bit,
>>>>>>>>>>>> +			ADE7759_CH1OS);
>>>>>>>>>>>> +
>>>>>>>>>>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
>>>>>>>>>>>> +			ade7759_read_8bit,
>>>>>>>>>>>> +			ade7759_write_8bit,
>>>>>>>>>>>> +			ADE7759_CH2OS);
>>>>>>>>>>>>=20
>>>>>>>>>>>> static int ade7759_set_irq(struct device *dev, bool enable)
>>>>>>>>>>>> {         =20
>>>>>>>>>>>=20
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe =
linux-iio" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  =
http://vger.kernel.org/majordomo-info.html       =20
>>>>>>>>>=20
>>>>>>>>> _______________________________________________
>>>>>>>>> devel mailing list
>>>>>>>>> devel@linuxdriverproject.org
>>>>>>>>> =
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel =
      =20
