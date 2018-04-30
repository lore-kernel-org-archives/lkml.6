Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeD3JOQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:14:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35278 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbeD3JOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:14:12 -0400
X-Google-Smtp-Source: AB8JxZouVaUUoaMV0gUzAj4HKmJ+9zCreKnvtqYKc1chOGlicHWN2suirOW1YWzafKvrye20iK5i0Q==
Subject: Re: [PATCH V3 3/4] soc: mediatek: pwrap: add mt6351 for mt6797 SoCs
To: Argus Lin <argus.lin@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, wsd_upstream@mediatek.com,
        henryc.chen@mediatek.com, flora.fu@mediatek.com,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "shailendra . v" <shailendra.v@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20180323083238.13569-1-argus.lin@mediatek.com>
 <20180323083238.13569-4-argus.lin@mediatek.com>
 <427130f0-9f7e-22cc-3679-2a8d22124515@gmail.com>
 <1525074821.22276.6.camel@mtkswgap22>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <531656de-b5bd-1b7a-2321-32c70aa8349c@gmail.com>
Date: Mon, 30 Apr 2018 11:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525074821.22276.6.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2018 09:53 AM, Argus Lin wrote:
> On Tue, 2018-04-17 at 23:10 +0200, Matthias Brugger wrote:
>> Please update the subject line, we don't add mt5797 here.
> 
> Dear matthias:
> I can't find where I wrote mt5797 at this patch.
>> 
>> More comments below.
>> 
>> On 03/23/2018 09:32 AM, argus.lin@mediatek.com wrote:
>> > From: Argus Lin <argus.lin@mediatek.com>
>> > 
>> > mt6351 is a new power management IC and it is
>> > used for mt6797 SoCs. We need to add mt6351_regs for
>> > pmic register mapping and pmic_mt6351 for
>> > register accessing by regmap.
>> > 
>> > Signed-off-by: Argus Lin <argus.lin@mediatek.com>
>> > ---
>> >  drivers/soc/mediatek/mtk-pmic-wrap.c | 31 +++++++++++++++++++++++++++++--
>> >  1 file changed, 29 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > index d0a0a3d7e88d..d81a585fadf5 100644
>> > --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > @@ -153,6 +153,21 @@ static const u32 mt6397_regs[] = {
>> >  [PWRAP_DEW_CIPHER_SWRST] =0xbc24,
>> >  };
>> >  
>> > +static const u32 mt6351_regs[] = {
>> > +[PWRAP_DEW_DIO_EN] =0x02F2,
>> > +[PWRAP_DEW_READ_TEST] =0x02F4,
>> > +[PWRAP_DEW_WRITE_TEST] =0x02F6,
>> > +[PWRAP_DEW_CRC_EN] =0x02FA,
>> > +[PWRAP_DEW_CRC_VAL] =0x02FC,
>> > +[PWRAP_DEW_CIPHER_KEY_SEL] =0x0300,
>> > +[PWRAP_DEW_CIPHER_IV_SEL] =0x0302,
>> > +[PWRAP_DEW_CIPHER_EN] =0x0304,
>> > +[PWRAP_DEW_CIPHER_RDY] =0x0306,
>> > +[PWRAP_DEW_CIPHER_MODE] =0x0308,
>> > +[PWRAP_DEW_CIPHER_SWRST] =0x030A,
>> > +[PWRAP_DEW_RDDMY_NO] =0x030C,
>> > +};
>> > +
>> >  enum pwrap_regs {
>> >  PWRAP_MUX_SEL,
>> >  PWRAP_WRAP_EN,
>> > @@ -721,6 +736,7 @@ static int mt8135_regs[] = {
>> >  
>> >  enum pmic_type {
>> >  PMIC_MT6323,
>> > +PMIC_MT6351,
>> >  PMIC_MT6380,
>> >  PMIC_MT6397,
>> >  };
>> > @@ -1179,8 +1195,6 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>> >  pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x0);
>> >  pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], 0x1);
>> >  pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0x2);
>> > -pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD], 0x1);
>> > -pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START], 0x1);
>> 
>> That might break the driver for other devices. You can't just delete these lines
>> without explanation. If you think these lines are not needed, then please put
>> the deletion in another patch explaining why.
>> 
> 
> Dear matthias:
> It is really a bug here. Below is the comment from you by patch V1.
> The register of PWRAP_DEW_CIPHER_LOAD and PWRAP_DEW_CIPHER_START only
> exist at mt6397.
> But I think I can still separate those lines to another patch and
> declare the reason.

You are right I didn't remember. Sorry.
Ok, can you please put this in a seperate patch and add stable@kernel.org as CC.
Also please add a "Fixes" tag so that third parties can quickly see which commit
the fix is for.

Thanks,
Matthias

>>       }
>>  
>>       /* Config cipher mode @PMIC */
>> @@ -1080,8 +1158,6 @@ static int pwrap_init_cipher(struct pmic_wrapper
> *wrp)
>>       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST],
> 0x0);
>>       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL],
> 0x1);
>>       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL],
> 0x2);
>> -     pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD],
> 0x1);
>> -     pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START],
> 0x1);
>>  
> 
> Ok, it looks like these two lines are actually a bug, which shouldn't be
> here.
> Adding John, as he added these calls twice in
> 5ae48040aa47 ("soc: mediatek: PMIC wrap: add mt6323 slave support")
> 
> @John, this is an oversight in your commit, right?
> 
> If so, we should fix this in a separate patch, concerning to send it to
> stable
> as well.
> 
>> Other then these two comments, patch looks fine.
>> 
>> Regards,
>> Matthias
> 
> 
> ************* Email Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>  
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank
>  you!
> 
