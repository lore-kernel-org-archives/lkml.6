Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FMovGxAnHlueAgAAmS7hNA
	; Mon, 11 Jun 2018 07:38:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 502C2606FA; Mon, 11 Jun 2018 07:38:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 73543602FC;
	Mon, 11 Jun 2018 07:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73543602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754094AbeFKHix (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:38:53 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:55282 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753955AbeFKHiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:38:52 -0400
Received: from [IPv6:2001:983:e9a7:1:7ce8:99dc:ae9f:cb92] ([IPv6:2001:983:e9a7:1:7ce8:99dc:ae9f:cb92])
        by smtp-cloud7.xs4all.net with ESMTPA
        id SHPTfrK4RxiYrSHPUfdfOd; Mon, 11 Jun 2018 09:38:50 +0200
Subject: Re: [PATCH v2 1/2] media: v4l2-ctrl: Add control for VP9 profile
To: Keiichi Watanabe <keiichiw@google.com>, nicolas@ndufresne.ca
Cc: stanimir.varbanov@linaro.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        matthias.bgg@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        tom.saeger@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20180530071613.125768-1-keiichiw@chromium.org>
 <20180530071613.125768-2-keiichiw@chromium.org>
 <a16dca32-4198-72c1-cf22-83f18a8cfcb6@xs4all.nl>
 <bd56e330-91d2-dfde-4cfb-40b466953dad@linaro.org>
 <CAKQmDh8MnArB1jCD6STh9FgLX+H4ZsEnH+coOJe-4A=FNPGshA@mail.gmail.com>
 <CANb2CJFXhY+mzEV7AnM5EQcvqyeAH7G=t3Bi_9_d9_+_Kce9RQ@mail.gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <cdd4046d-b043-4189-15a3-4654a0803f3c@xs4all.nl>
Date: Mon, 11 Jun 2018 09:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANb2CJFXhY+mzEV7AnM5EQcvqyeAH7G=t3Bi_9_d9_+_Kce9RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOhQ6ZNJkENmssdWNTmYKuAaLOWqETsyQuXFgjsbm3l11niV2SY+tj6KN51+cJosmNBFtteuIZEszspAXbV+N1cXRK+zJt6aPg4M6fTr96hXQ4NT0Hfk
 /1NeCeCNjbf/pvGlP0q+aTVAbS8VQi2tvqOEx1YKK00zKHffCJTyT0446hB4ouadWNjuIRLKdORg2suEiiJqvuNVQNyL8ijpvTqDzAZRz/y9mYn/bTLBp85L
 jYk+vkpm7V4Fd2p2HgDNFKZoEnoDCast0XJEetAntFTFytr9TigWNrt8+jPMFnu8g+4kbOgQvnuJKHdFKYSr4Svl3FHZyP8qbI6p5uc5oSDl8wCpK5w9nYCG
 cpHrNidGNvuI1cPOrRN3XKU/brcFdwIv5d9s6jinZhRXZywDfjhEPXXJeYPcAtmOI0oaGFT1YDy/xPhuUpUbd8UDO/Z9AeakEerImtsTxeXEd8n77INFJNQ2
 t3PaoKmXcx4WjZAOMu4szaIuC/jdbBb61CkoiA/nKtLOhnH3DXewajBS7NjhIpyJdnehsSrkaw8m4r7Qmbo8vo2hTB9SKpL0xWEsmrRjiCU78m6Z/UbTwzpG
 ii+9DVY+c06XqtSRPa6ucaYxrAP36XTaRlrKt2eXEO7L3ERAgWFcIVtwM9IEVUv40xGqAUBOyvBCh2MtCCPY/EZz1Yq2A/0VMYMi6/GUoikqRoB4oGQ3SpB7
 i57D692NAc2/GChmNMY8BnG18Or/v58SCJxe7HG+kp0yb9d4A63RWLfpnzi1W1SAzxynAy+u1lA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/18 08:44, Keiichi Watanabe wrote:
> Hi, Hans.
> Thank you for the review.
> Your idea sounds good.
> 
> However, I think that changing V4L2_CID_MPEG_VIDEO_VPX_PROFILE to an enum
> breaks both of s5p-mfc and venus drivers.  This is because they call
> 'v4l2_ctrl_new_std' for it.  For menu controls,
> 'v4l2_ctrl_new_std_menu' must be used.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c#L2678
> https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/qcom/venus/vdec_ctrls.c#L133
> 
> I can fix them within the commit for adding VP8_PROFILE control, but
> cannot confirm that it works on real devices since I don't have them.
> What should I do?

Fix it in both drivers with a Cc to stanimir.varbanov@linaro.org (venus) and
s.nawrocki@samsung.com (s5p) to let them test/ack the patch.

Venus is no problem, the s5p driver can decide to keep the old INT control
since it has been in use for such a long time, but that is up to Sylwester to
decide.

Regards,

	Hans

> 
> Best regards,
> Keiichi
> On Fri, Jun 8, 2018 at 10:00 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>
>>
>>
>> Le ven. 8 juin 2018 08:56, Stanimir Varbanov <stanimir.varbanov@linaro.org> a écrit :
>>>
>>> Hi Hans,
>>>
>>> On 06/08/2018 12:29 PM, Hans Verkuil wrote:
>>>> On 05/30/2018 09:16 AM, Keiichi Watanabe wrote:
>>>>> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for selecting desired
>>>>> profile for VP9 encoder and querying for supported profiles by VP9 encoder
>>>>> or decoder.
>>>>>
>>>>> An existing control V4L2_CID_MPEG_VIDEO_VPX_PROFILE cannot be
>>>>> used for querying since it is not a menu control but an integer
>>>>> control, which cannot return an arbitrary set of supported profiles.
>>>>>
>>>>> The new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE is a menu control as
>>>>> with controls for other codec profiles. (e.g. H264)
>>>>
>>>> Please ignore my reply to patch 2/2. I looked at this a bit more and what you
>>>> should do is to change the type of V4L2_CID_MPEG_VIDEO_VPX_PROFILE to enum.
>>>>
>>>> All other codec profile controls are all enums, so the fact that VPX_PROFILE
>>>> isn't is a bug. Changing the type should not cause any problems since the same
>>>> control value is used when you set the control.
>>>>
>>>> Sylwester: I see that s5p-mfc uses this control, but it is explicitly added
>>>> as an integer type control, so the s5p-mfc driver should not be affected by
>>>> changing the type of this control.
>>>>
>>>> Stanimir: this will slightly change the venus driver, but since it is a very
>>>> recent driver I think we can get away with changing the core type of the
>>>> VPX_PROFILE control. I think that's better than ending up with two controls
>>>> that do the same thing.
>>>
>>> I agree. Actually the changes shouldn't be so much in venus driver.
>>
>>
>> Also fine on userspace side, since profiles enumeration isn't implemented yet in FFMPEG, GStreamer, Chrome
>>
>>
>>>
>>> --
>>> regards,
>>> Stan
