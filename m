Return-Path: <miltonm@us.ibm.com>
X-Google-Smtp-Source: AG47ELvJIMuHUm2pDpuYJVh6BKiW2Ijrk2KertLJZFkWrDbTiegTH2cjpJgLntK9pHbSQtsEV34T
ARC-Seal: i=1; a=rsa-sha256; t=1520638874; cv=none;
        d=google.com; s=arc-20160816;
        b=GTG5Pi2mCHknDASyOvJoEHW21tA5T0PSlzaL8heYhWd+Pf01zfPQ/NmvEhutU4x9Po
         vlZTdaf99tEGdogM/oS6SSrLF0J1tYG+Ehb5qCutlg2IRMiZP5MBVM6SeU3sIlEb6J2J
         mbqWFKP87Rhrv9HVRJLmywn36YtMh2m1gvUNsW+deO3+DzuWGzFfXuOTS8yZU1Yj5Zx0
         yecnaRxAEhMF5tkZh6m/Cky2AnvcDbYr42AZJFlT3B6tbF2+IpcNfG8x1/U3FrA+K4GJ
         fRrEBJ6TbX6jNw7vhov6YylYViwj/u1QdAUSDkhCrjrio7cC0u1tNKmc5No46YRGmvUr
         kJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:references:importance
         :sensitivity:mime-version:date:cc:to:from:subject:in-reply-to
         :arc-authentication-results;
        bh=B46xkz2+JrpuGSL/ykQj1/4dY5sBvbMqXovHLroitMs=;
        b=yVf8/nvjMT8S3e7ATl5+LjqS0dGJvZOaf1vf/6+K8xIutr4G7eGAWbm536xvSJA/dJ
         SI6gaAZHPtMPI8FzPmZixDQeLD/vtYrkc3a0JIZUSLYe8WTZ0vYuYdg10j0uz6h9/XGc
         qflmYBdAG+IX6VR9rBSLqsb7FFBvWhlh6EQTmSi5z3cGtL/QwOls72tL3Q2XynP/QUtz
         bS1nYGcuHVRZZXhlol8EsHDV2LHKXG5FXm/N/NpoJtovPTGfBCkBpKJ2iUP06nkSZ3zr
         BPNWwRTfvgSCqsklSGRwx73DyUePcH4EGO4ATJdiUAJVz3aOBkL47bcGIOlPvuP97C27
         bv9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of miltonm@us.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=miltonm@us.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of miltonm@us.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=miltonm@us.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
In-Reply-To: <20180307221124.GD10438@amd>
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a document
 of PECI adapter driver for Aspeed AST24xx/25xx SoCs
From: "Milton Miller II" <miltonm@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jae Hyun Yoo
 <jae.hyun.yoo@linux.intel.com>, linux-hwmon@vger.kernel.org,
        andrew@lunn.ch, jdelvare@suse.com, arnd@arndb.de,
        linux-doc@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net,
        linux-arm-kernel@lists.infradead.org
Date: Fri, 9 Mar 2018 23:41:00 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20180307221124.GD10438@amd>,<20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
 <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
X-Mailer: IBM iNotes ($HaikuForm 1010) | IBM Domino Build
 SCN1805107_20180220T0755_FP2 March 05, 2018 at 08:20
X-LLNOutbound: False
X-Disclaimed: 47211
X-TNEFEvaluated: 1
X-LLNXfer: False
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 18030923-3721-0000-0000-000002A5D22F
X-IBM-SpamModules-Scores: BY=0.037583; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.391525; ST=0; TS=0; UL=0; ISC=; MB=0.198820
X-IBM-SpamModules-Versions: BY=3.00008643; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000735; UDB=6.00509053; IPR=6.00780065;
 BA=6.00005858; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019947; XFM=3.00000015;
 UTC=2018-03-09 23:41:09
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2018-03-09 19:50:14 - 6.00008166
x-cbparentid: 18030923-3722-0000-0000-0000B0C9D624
Message-Id: <OF08D8261E.8F72E5DC-ON0025824B.008218BB-0025824B.008218C6@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1594505428376033354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

About  03/07/2018 04:12PM in some time zone, Pavel Machek wrote:
>Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings:
>Add a document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
>
>Hi!
>
>> >Are these SoCs x86-based?
>>=20
>> Yes, these are ARM SoCs. Please see Andrew's answer as well.
>
>Understood, thanks.
>
>> >>+	Read sampling point selection. The whole period of a bit time
>will be
>> >>+	divided into 16 time frames. This value will determine which
>time frame
>> >>+	this controller will sample PECI signal for data read back.
>Usually in
>> >>+	the middle of a bit time is the best.
>> >
>> >English? "This value will determine when this controller"?
>> >
>>=20
>> Could I change it like below?:
>>=20
>> "This value will determine in which time frame this controller
>samples PECI
>> signal for data read back"
>
>I guess... I'm not native speaker, I guess this could be improved
>some
>more.
>

I agree this wording is still confusing.=20

The problem is that the key subject, the time of the sampling, is in the de=
scriptive clause "in which time frame".

"This value will determine the time frame in which the controller will samp=
le"

or perhaps phrase it as saving a specific sample from the over-clock, or a =
phase of the clock.

>Best regards,
>									Pavel
>
>--=20
>(english) http://www.livejournal.com/~pavelmachek
>(cesky, pictures)
>http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>

milton
--
Speaking for myself not IBM.
