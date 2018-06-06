Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6CC160555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeFFJe1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:34:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43694 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932381AbeFFJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:34:24 -0400
Subject: Re: [alsa-devel] [PATCH 0/3] ASoC: stm32: sai: add support of iec958
 controls
To: Takashi Iwai <tiwai@suse.de>
CC: Mark Brown <broonie@kernel.org>,
        Olivier MOYSAN <olivier.moysan@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
 <20180417111733.GG8973@sirena.org.uk>
 <2ae6c5b6-872a-9aaa-6ca4-e29adb7c8bc0@st.com> <s5hpo15xf1q.wl-tiwai@suse.de>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <c4b2d22f-320d-a415-6328-b33f9c03aafe@st.com>
Date: Wed, 6 Jun 2018 11:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5hpo15xf1q.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/05/2018 08:29 PM, Takashi Iwai wrote:
> On Tue, 05 Jun 2018 17:50:57 +0200,
> Arnaud Pouliquen wrote:
>> 
>> Hi Takashi,
>> 
>> On 04/17/2018 01:17 PM, Mark Brown wrote:
>> > On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:
>> > 
>> >> I guess the blocking patch in this patchset is the patch "add IEC958 
>> >> channel status control helper". This patch has been reviewed several 
>> >> times, but did not get a ack so far.
>> >> If you think these helpers will not be merged, I will reintegrate the 
>> >> corresponding code in stm driver.
>> >> Please let me know, if I need to prepare a v2 without helpers, or if we 
>> >> can go further in the review of iec helpers patch ?
>> > 
>> > I don't mind either way but you're right here, I'm waiting for Takashi
>> > to review the first patch.  I'd probably be OK with it just integrated
>> > into the driver if we have to go that way though.
>> 
>> Gentlemen reminder for this patch set. We would appreciate to have your
>> feedback on iec helper.
>> From our point of view it could be useful to have a generic management
>> of the iec controls based on helpers instead of redefining them in DAIs.
>> Having the same behavior for these controls could be useful to ensure
>> coherence of the control management used by application (for instance
>> Gstreamer uses it to determine iec raw mode capability for iec61937 streams)
> 
> Oh sorry for the late reply, I've totally overlooked the thread.
> 
> And, another sorry: the patchset doesn't look convincing enough to
> me.
> 
> First off, the provided API definition appears somewhat
> unconventional, the mixture of the ops, the static data and the
> dynamic data.
Sorry i can't figure out your point. I suppose that you speak about the
snd_pcm_iec958_params.
what would be a more conventional API?

> 
> Moreover, this is only for your driver, ATM.  
It is also compatible with the sound/sti driver, even if we does not
propose patch yet. We also plan to propose an implementation, for the
HDMI_codec that would need to export a control to allow none-audio mode.

>If it were an API that
> does clean up the already existing usages, I'd happily apply it. There
> are lots of drivers creating and controlling the IEC958 ctls even
> now.
> 
> Also, the patchset requires more fine-tuning, in anyways.  The changes
> in create_iec958_consumre() are basically irrelevant, should be split
> off as an individual fix.  it is linked to the control, as not possible in existing implementation
(rate and width are get from hwparam or runtime). But no problem we can
split it in a separate patch.

Also, the new function doesn't create the
> "XXX Mask" controls.  And the byte comparison should be replaced with
> memcmp(), etc, etc.
Yes mask are missing, can be added. For the rest could you comment
directly in code? i suppose that you want to replace the for loops by
memcmp, memcpy...
> 
> So, please proceed rather with the open codes for now.  If you can
> provide a patch that cleans up the *multiple* driver codes, again,
> I'll happily take it.  But it can be done anytime later, too.
Not simple to clean up the other drivers as this control is a PCM
control, that is mainly implemented as a mixer or card control.
This means that it should be registered on the pcm_new in CPU DAI or in
the DAI codec, to be able to bind it to the PCM device.
Inpact is not straigthforward as this could generate regression on driver.

For now We can add the clean up on the sti driver based on this helper,
and we are working on the HDMI_codec, we could also use this helper to
export the control....

So if you estimate that it is interesting to purchase on this helper we
can try to come back with a patch set that implements the helper for
the 3 drivers.

The other option, is that we drop the helpers, and implement the control
directly in our drivers.

Please just tell us if we should continue to propose the helpers or not.

Thanks,
Arnaud

> 
> 
> thanks,
> 
> Takashi
