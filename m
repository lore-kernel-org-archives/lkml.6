Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeEQNHG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:07:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33191 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752328AbeEQNHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:07:01 -0400
From: Olivier MOYSAN <olivier.moysan@st.com>
To: Mark Brown <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>,
        "jsarha@ti.com" <jsarha@ti.com>
Subject: Re: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
Thread-Topic: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
Thread-Index: AQHTuugk+f/v2G3G5kiIINnSVNO0DaQEtPsAgAAvCoCAL0OagA==
Date: Thu, 17 May 2018 13:03:44 +0000
Message-ID: <dcd08b5c-fc92-4b5d-6950-45afe9db3317@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
 <20180417111733.GG8973@sirena.org.uk>
In-Reply-To: <20180417111733.GG8973@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B86C931B4FF4BD45AA64B0F90C3B2626@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi,

On 04/17/2018 01:17 PM, Mark Brown wrote:
> On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:
> 
>> I guess the blocking patch in this patchset is the patch "add IEC958
>> channel status control helper". This patch has been reviewed several
>> times, but did not get a ack so far.
>> If you think these helpers will not be merged, I will reintegrate the
>> corresponding code in stm driver.
>> Please let me know, if I need to prepare a v2 without helpers, or if we
>> can go further in the review of iec helpers patch ?
> 
> I don't mind either way but you're right here, I'm waiting for Takashi
> to review the first patch.  I'd probably be OK with it just integrated
> into the driver if we have to go that way though.
> 

Kind reminder.
Would you have some comments on this patchset ?

Thanks
olivier
