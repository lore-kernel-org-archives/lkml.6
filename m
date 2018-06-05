Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeFEP4a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:56:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9402 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751539AbeFEP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:56:28 -0400
Subject: Re: [PATCH 2/3] ASoC: stm32: sai: add iec958 controls support
To: Olivier MOYSAN <olivier.moysan@st.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>,
        "jsarha@ti.com" <jsarha@ti.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <1520958428-10930-3-git-send-email-olivier.moysan@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <3fd2e41a-c9d8-8667-f74a-ceff7b641823@st.com>
Date: Tue, 5 Jun 2018 17:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1520958428-10930-3-git-send-email-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

On 03/13/2018 05:27 PM, Olivier MOYSAN wrote:
> Add support of iec958 controls for STM32 SAI.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  sound/core/pcm_iec958.c       |   1 +
>  sound/soc/stm/Kconfig         |   1 +
>  sound/soc/stm/stm32_sai_sub.c | 101
> +++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 91 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
> index aba1f522e98a..c34735ac3c48 100644
> --- a/sound/core/pcm_iec958.c
> +++ b/sound/core/pcm_iec958.c
> @@ -19,6 +19,7 @@ static int snd_pcm_iec958_info(struct snd_kcontrol
> *kcontrol,
>  {
>          uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
>          uinfo->count = 1;
> +
>          return 0;
>  }
Seems that this should be part of your patch 1/3

Regards,

Arnaud
>  
> diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
> index 48f9ddd94016..9b2681397dba 100644
> --- a/sound/soc/stm/Kconfig
> +++ b/sound/soc/stm/Kconfig
> @@ -6,6 +6,7 @@ config SND_SOC_STM32_SAI
>          depends on SND_SOC
>          select SND_SOC_GENERIC_DMAENGINE_PCM
>          select REGMAP_MMIO
> +       select SND_PCM_IEC958
>          help
>            Say Y if you want to enable SAI for STM32
>  
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index cfeb219e1d78..c2e487e133aa 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -26,6 +26,7 @@
>  #include <sound/asoundef.h>
>  #include <sound/core.h>
>  #include <sound/dmaengine_pcm.h>
> +#include <sound/pcm_iec958.h>
>  #include <sound/pcm_params.h>
>  
>  #include "stm32_sai.h"
> @@ -96,7 +97,7 @@
>   * @slot_mask: rx or tx active slots mask. set at init or at runtime
>   * @data_size: PCM data width. corresponds to PCM substream width.
>   * @spdif_frm_cnt: S/PDIF playback frame counter
> - * @spdif_status_bits: S/PDIF status bits
> + * @snd_aes_iec958: iec958 data
>   */
>  struct stm32_sai_sub_data {
>          struct platform_device *pdev;
> @@ -125,7 +126,7 @@ struct stm32_sai_sub_data {
>          int slot_mask;
>          int data_size;
>          unsigned int spdif_frm_cnt;
> -       unsigned char spdif_status_bits[SAI_IEC60958_STATUS_BYTES];
> +       struct snd_aes_iec958 iec958;
>  };
>  
>  enum stm32_sai_fifo_th {
> @@ -184,10 +185,6 @@ static bool stm32_sai_sub_writeable_reg(struct
> device *dev, unsigned int reg)
>          }
>  }
>  
> -static const unsigned char
> default_status_bits[SAI_IEC60958_STATUS_BYTES] = {
> -       0, 0, 0, IEC958_AES3_CON_FS_48000,
> -};
> -
>  static const struct regmap_config stm32_sai_sub_regmap_config_f4 = {
>          .reg_bits = 32,
>          .reg_stride = 4,
> @@ -619,6 +616,59 @@ static void stm32_sai_set_frame(struct snd_soc_dai
> *cpu_dai)
>          }
>  }
>  
> +static void stm32_sai_set_channel_status(struct stm32_sai_sub_data *sai,
> +                                        struct snd_pcm_runtime *runtime)
> +{
> +       if (!runtime)
> +               return;
> +
> +       /* Force the sample rate according to runtime rate */
> +       switch (runtime->rate) {
> +       case 22050:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_22050;
> +               break;
> +       case 44100:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_44100;
> +               break;
> +       case 88200:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_88200;
> +               break;
> +       case 176400:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_176400;
> +               break;
> +       case 24000:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_24000;
> +               break;
> +       case 48000:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_48000;
> +               break;
> +       case 96000:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_96000;
> +               break;
> +       case 192000:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_192000;
> +               break;
> +       case 32000:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_32000;
> +               break;
> +       default:
> +               sai->iec958.status[3] = IEC958_AES3_CON_FS_NOTID;
> +               break;
> +       }
> +}
> +
> +static int stm32_sai_iec958_set(struct snd_pcm_iec958_params *iec_param)
> +{
> +       struct stm32_sai_sub_data *sai = iec_param->private_data;
> +
> +       if (!sai->substream)
> +               return 0;
> +
> +       stm32_sai_set_channel_status(sai, sai->substream->runtime);
> +
> +       return 0;
> +}
> +
>  static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
>                                       struct snd_pcm_hw_params *params)
>  {
> @@ -709,7 +759,11 @@ static int stm32_sai_hw_params(struct
> snd_pcm_substream *substream,
>  
>          sai->data_size = params_width(params);
>  
> -       if (!STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
> +       if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
> +               /* Rate not already set in runtime structure */
> +               substream->runtime->rate = params_rate(params);
> +               stm32_sai_set_channel_status(sai, substream->runtime);
> +       } else {
>                  ret = stm32_sai_set_slots(cpu_dai);
>                  if (ret < 0)
>                          return ret;
> @@ -789,6 +843,28 @@ static void stm32_sai_shutdown(struct
> snd_pcm_substream *substream,
>          sai->substream = NULL;
>  }
>  
> +static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
> +                            struct snd_soc_dai *cpu_dai)
> +{
> +       struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
> +       struct snd_pcm_iec958_params *iec_param;
> +
> +       if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
> +               dev_dbg(&sai->pdev->dev, "%s: register iec controls",
> __func__);
> +               iec_param = devm_kzalloc(&sai->pdev->dev,
> sizeof(*iec_param),
> +                                        GFP_KERNEL);
> +               iec_param->ctrl_set = stm32_sai_iec958_set;
> +               iec_param->private_data = sai;
> +               iec_param->cs = sai->iec958.status;
> +               iec_param->cs_len = 5;
> +               return snd_pcm_add_iec958_ctl(rtd->pcm, 0,
> +                                             SNDRV_PCM_STREAM_PLAYBACK,
> +                                             iec_param);
> +       }
> +
> +       return 0;
> +}
> +
>  static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
>  {
>          struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
> @@ -809,6 +885,10 @@ static int stm32_sai_dai_probe(struct snd_soc_dai
> *cpu_dai)
>          else
>                  snd_soc_dai_init_dma_data(cpu_dai, NULL, &sai->dma_params);
>  
> +       /* Next settings are not relevant for spdif mode */
> +       if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
> +               return 0;
> +
>          cr1_mask = SAI_XCR1_RX_TX;
>          if (STM_SAI_IS_CAPTURE(sai))
>                  cr1 |= SAI_XCR1_RX_TX;
> @@ -820,10 +900,6 @@ static int stm32_sai_dai_probe(struct snd_soc_dai
> *cpu_dai)
>                                       sai->synco, sai->synci);
>          }
>  
> -       if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
> -               memcpy(sai->spdif_status_bits, default_status_bits,
> -                      sizeof(default_status_bits));
> -
>          cr1_mask |= SAI_XCR1_SYNCEN_MASK;
>          cr1 |= SAI_XCR1_SYNCEN_SET(sai->sync);
>  
> @@ -861,7 +937,7 @@ static int stm32_sai_pcm_process_spdif(struct
> snd_pcm_substream *substream,
>                  /* Set channel status bit */
>                  byte = frm_cnt >> 3;
>                  mask = 1 << (frm_cnt - (byte << 3));
> -               if (sai->spdif_status_bits[byte] & mask)
> +               if (sai->iec958.status[byte] & mask)
>                          *ptr |= 0x04000000;
>                  ptr++;
>  
> @@ -888,6 +964,7 @@ static int stm32_sai_pcm_process_spdif(struct
> snd_pcm_substream *substream,
>  static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
>  {
>                  .probe = stm32_sai_dai_probe,
> +               .pcm_new = stm32_sai_pcm_new,
>                  .id = 1, /* avoid call to fmt_single_name() */
>                  .playback = {
>                          .channels_min = 1,
> -- 
> 1.9.1
> 
