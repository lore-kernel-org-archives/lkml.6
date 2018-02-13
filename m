Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934622AbeBMJSM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:18:12 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33406 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933805AbeBMJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:13:37 -0500
X-Google-Smtp-Source: AH8x22787XEPJ30BcZf0CRdiTC10suTxBeMbCJV2x4/Wx32r89RdDESpmrboEwAlrkQIKRev7ugirg==
Subject: Re: [PATCH v3 1/5] clk: mediatek: update missing clock data for
 MT7622 audsys
To: Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
 <ee93f496edb238935940233d88f5548940b53b6a.1518424204.git.ryder.lee@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8af9dd65-13da-299d-fb38-fe2da4685e1a@gmail.com>
Date: Tue, 13 Feb 2018 10:13:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ee93f496edb238935940233d88f5548940b53b6a.1518424204.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2018 12:28 PM, Ryder Lee wrote:
> Add missing clock data 'CLK_AUDIO_AFE_CONN' for MT7622 audsys.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/clk/mediatek/clk-mt7622-aud.c  | 1 +
>  include/dt-bindings/clock/mt7622-clk.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
> index fad7d9f..13f752d 100644
> --- a/drivers/clk/mediatek/clk-mt7622-aud.c
> +++ b/drivers/clk/mediatek/clk-mt7622-aud.c
> @@ -106,6 +106,7 @@
>  	GATE_AUDIO1(CLK_AUDIO_INTDIR, "audio_intdir", "intdir_sel", 20),
>  	GATE_AUDIO1(CLK_AUDIO_A1SYS, "audio_a1sys", "a1sys_hp_sel", 21),
>  	GATE_AUDIO1(CLK_AUDIO_A2SYS, "audio_a2sys", "a2sys_hp_sel", 22),
> +	GATE_AUDIO1(CLK_AUDIO_AFE_CONN, "audio_afe_conn", "a1sys_hp_sel", 23),
>  	/* AUDIO2 */
>  	GATE_AUDIO2(CLK_AUDIO_UL1, "audio_ul1", "a1sys_hp_sel", 0),
>  	GATE_AUDIO2(CLK_AUDIO_UL2, "audio_ul2", "a1sys_hp_sel", 1),
> diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
> index 3e514ed..e9d77f0 100644
> --- a/include/dt-bindings/clock/mt7622-clk.h
> +++ b/include/dt-bindings/clock/mt7622-clk.h
> @@ -235,7 +235,8 @@
>  #define CLK_AUDIO_MEM_ASRC3		43
>  #define CLK_AUDIO_MEM_ASRC4		44
>  #define CLK_AUDIO_MEM_ASRC5		45
> -#define CLK_AUDIO_NR_CLK		46
> +#define CLK_AUDIO_AFE_CONN		46
> +#define CLK_AUDIO_NR_CLK		47
>  
>  /* SSUSBSYS */
>  
> 
