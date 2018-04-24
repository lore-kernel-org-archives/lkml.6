Return-Path: <matthias.bgg@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524563181; cv=none;
        d=google.com; s=arc-20160816;
        b=PsGFtSd2IDw1zm7AiasmujC4IwMXN8gCxGfdEa/oKGaCOhAwJbm7XSoet/kdQa/97R
         aM0IBpKxPhGsYXJHxz69l16c0uWCzrqWAiWlSFr5PebqAa+H+gwib+GZGtTaMSidcoYJ
         3yTb3im8eymEmbJ9b2EECMI8OKI0c1+9n50gsOk951JYBBHZsz41nAg81FXIEmMDYgHa
         04G4kCvA2Ilh1jaxTY1TG6UWeoBVXlQNhdb6+DKBlXKH3UhrjR7iSoHrzzYQqoznn6kQ
         lmHbmcYkUvN7qfFIbKtZcGhr098jVIgG3adeOGG0K/M9eySuhU4zYH9XhQQ5En9NHPgR
         kUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=jrWmmd48yNbxroai4XxrPpPaG8v/B4QGPVnbM1dwLMY=;
        b=alZeOaSumiFwxZWnzC0paeaebUFT73prpfXH8Xc6ybgZ5kM2QHkvQm78VaQmL1c1Zh
         aBdlolbM5OlpK3KqcUPcbIGb8H70AZ39RdsabTvuLBH9yCIT1+QgJvkvOdfBM0cC4KFH
         Ztbtk/S64B4POjRRU1cLLTmfQkOiXN7m59bAQUy7EMLU5BO5xW/icQJ021GcIG4L8FbA
         iegAhcrYACi77RQsfIeusRpE3L2ATpNBn7ZYk2BHEzfsdmxhluzD85ZkJl4TkFp8QRu8
         VtsDn0eOXzOC3gfQFdF19i+6Z8vnxk/s6Z+asMXcAGmAXerGdWQ97nOmu5HtnB21rRRf
         9Shw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=THBaV1ZX;
       spf=pass (google.com: domain of matthias.bgg@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=matthias.bgg@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=THBaV1ZX;
       spf=pass (google.com: domain of matthias.bgg@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=matthias.bgg@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+3c0TIIMCQq0UYFSbMAjuG6sJyRCpYyzAcZcGjJb+TtW+X9OFlqZlAYECs8N3+35FbBnioPQ==
Subject: Re: [v2 00/10] arm/arm64: mediatek: Fix mmsys device probing
To: Lee Jones <lee.jones@linaro.org>, matthias.bgg@kernel.org
Cc: ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
 ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
 robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
 sboyd@codeaurora.org, davem@davemloft.net, gregkh@linuxfoundation.org,
 mchehab@kernel.org, rdunlap@infradead.org, pi-cheng.chen@linaro.org,
 sean.wang@mediatek.com, linux-clk@vger.kernel.org, linux@armlinux.org.uk,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
 <20180424054854.bpd6h3imazhqnuy3@dell>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <723392d5-ee51-d49b-050b-db4f9709e6bf@gmail.com>
Date: Tue, 24 Apr 2018 11:46:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424054854.bpd6h3imazhqnuy3@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551533402013398?=
X-GMAIL-MSGID: =?utf-8?q?1598620362330243690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Lee,

On 04/24/2018 07:48 AM, Lee Jones wrote:
> On Mon, 23 Apr 2018, matthias.bgg@kernel.org wrote:
> 
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Changes since v1:
>> - add binding documentation
>> - ddp: use regmap_update_bits
>> - ddp: ignore EPROBE_DEFER on clock probing
>> - mfd: delete mmsys_private
>> - add Reviewed-by and Acked-by tags
> 
> I'm confused by the double submission.
> 
> Please can you send it again completely detached from the first and
> the second submissions please?
> 

I had some problems with my mailclient. I'll resend as 'v2 resend'.

Sorry for that.
Matthias

>> ---
>>
>> MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
>> used in the clk driver) and some registers to set the routing and enable
>> the differnet blocks of the display subsystem.
>>
>> Up to now both drivers, clock and drm are probed with the same device tree
>> compatible. But only the first driver get probed, which in effect breaks
>> graphics on mt8173 and mt2701.
>>
>> This patch set introduces a new mfd device, which binds against the mmsys
>> compatible and takes care of probing the needed devices. It was tested on the
>> bananapi-r2 and the Acer R13 Chromebook.
>>
>>
>> Matthias Brugger (10):
>>   dt-bindings: mediatek: mmsys: Add support for mfd
>>   drm/mediatek: Use regmap for register access
>>   mfd: mtk-mmsys: Add mmsys driver
>>   drm/mediatek: mt2701: switch to mfd probing.
>>   clk: mediatek: mt2701-mm: switch to mfd device
>>   mfd: mtk-mmsys: Add mt8173 nodes
>>   drm/mediatek: Add mfd support for mt8173
>>   clk: mediatek: mt8173-mm: switch to mfd device
>>   drm: mediatek: Omit warning on probe defers
>>   MAINTAINERS: update Mediatek Soc entry
>>
>>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 -
>>  .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
>>  .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 +++++++
>>  MAINTAINERS                                        |  2 +
>>  drivers/clk/mediatek/clk-mt2701-mm.c               | 10 +--
>>  drivers/clk/mediatek/clk-mt8173.c                  | 17 +++-
>>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  4 +-
>>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 41 ++++------
>>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  4 +-
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 33 ++++----
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |  2 +-
>>  drivers/mfd/Kconfig                                |  9 +++
>>  drivers/mfd/Makefile                               |  2 +
>>  drivers/mfd/mtk-mmsys.c                            | 93 ++++++++++++++++++++++
>>  14 files changed, 189 insertions(+), 59 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
>>  create mode 100644 drivers/mfd/mtk-mmsys.c
>>
> 
